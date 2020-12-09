## ---- echo=FALSE--------------------------------------------------------------
library(knitr)
library(kableExtra)
library(NNbenchmark)


## ---- echo=FALSE--------------------------------------------------------------
#check
dimNNdata <- t(sapply(NNdatasets, function(x) dim(x$Z)))
sumNNdata <- NNbenchmark::NNdataSummary(NNbenchmark::NNdatasets)
colnames(sumNNdata) <- c("Dataset", "Row nb.", "Input nb.", "Neuron nb.", "Param. nb.")
kableExtra::kable(sumNNdata, 
                  format = "latex", booktabs = TRUE, centering = TRUE, align="lcccc",
                  caption="Datasets' summary") %>%
  pack_rows("Multivariate", 1, 4) %>% 
  pack_rows("Univariate", 5, 12) %>%
  kable_styling(font_size=7)


## ----echo=FALSE, message=FALSE------------------------------------------------
options(knitr.kable.NA = '')

if(file.exists("./tables/Table1.csv")) {  
  Table1 <- read.table("./tables/Table1-final.csv", sep = ";", dec=".",
                       header=TRUE)
  Table1 <- Table1[Table1[,2] != "", ]
}else 
   Table1 <- rbind(rep("missing",6))

colnames(Table1) <- c("Package", "Algorithm", "Time", "RMSE",
                    "Util", "Doc", "Call")

pkg.name <- Table1$Package[Table1$Package != ""]
idx.pkg.name <- (1+0:NROW(Table1))[Table1$Package != ""]
Table1$Doc <- floor(Table1$Doc)

#repeat value
Table1$Package <- rep(pkg.name, times=diff(idx.pkg.name))
Table1$Util <- rep(Table1$Util[!is.na(Table1$Util)], times=diff(idx.pkg.name))
Table1$Doc <- rep(Table1$Doc[!is.na(Table1$Doc)], times=diff(idx.pkg.name))
Table1$Call <- rep(Table1$Call[!is.na(Table1$Call)], times=diff(idx.pkg.name))

#convert to stars
cvt2star <- function(j)
{
  switch(as.character(j), "0" = " ", "1"="*", "2"="**", "3"="***", "4"="****")
}
Table1$Doc <- unlist(sapply(Table1$Doc, cvt2star))
Table1$Util <- unlist(sapply(Table1$Util, cvt2star))
Table1$Call <- unlist(sapply(Table1$Call, cvt2star))

#reorder columns
Table1 <- Table1[, c(1, 5:7, 2:4)]
#get the min RMSE by pkg
pkgRkbyRMSE <- sort(tapply(Table1$RMSE, Table1$Package, min))
#create new index
n <- NROW(Table1)
getorderbypkg <- function(p)
{
  idx <- (1:n)[Table1$Package == p]
  if(length(idx) > 1)
    return(idx[order(Table1[idx, "RMSE"])])
  else
    return(idx)
}
idxRk <- unlist(sapply(names(pkgRkbyRMSE), getorderbypkg))
Table1rk <- Table1[idxRk, ]
rownames(Table1rk) <- 1:n

kableExtra::kable(Table1rk, format = "latex", booktabs = TRUE, 
                  centering = TRUE, align="lccclcc",
                  caption="Result from Tested Packages") %>%
  add_header_above(c(" "=1, "Individual rating"=3, " "=1,  "Global score"=2)) %>%
  column_spec(c(1, 7), bold = TRUE) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign ="middle") %>%
  kable_styling(font_size=7) %>%
  footnote(general="Statistics over 10 runs.", footnote_as_chunk=TRUE)


## ----echo=FALSE, message=FALSE------------------------------------------------
options(knitr.kable.NA = '')

if(file.exists("./tables/Table2-UTF8-cleaned.csv")) {  
#  Table2 <- read.csv("./tables/Table2.csv", sep = ";", encoding="latin1")
  Table2 <- read.csv("./tables/Table2-UTF8-cleaned.csv")
  Table2 <- Table2[Table2[,3] != "", ]
  Table2 <- Table2[,c("Package", "Category", "Reason.to.Discard..Where.")]
}else
 Table2 <- rep("missing", 3)
colnames(Table2) <- c("Package", "Category", "Reason to Discard (File(s) and/or function(s))")



kableExtra::kable(Table2, booktabs = TRUE, centering = TRUE, longtable = TRUE,
                  caption="Review of Discarded Packages") %>%
  kable_styling(font_size=7, latex_options = c("repeat_header")) %>%
  column_spec(3, width = "10cm") %>%
  footnote(general="AP=Application, CL=Classification, RE=Regression, RE*=?, TS=Time serie, UT=Utility, XX=Other.", 
           footnote_as_chunk=TRUE)


## ----echo=FALSE, message=FALSE------------------------------------------------
options(knitr.kable.NA = '')

if(file.exists("./tables/Table3.csv")) {  
  Table3 <- read.csv("./tables/Table3.csv")
}else
 Table3 <- rep("missing", 7)
colnames(Table3) <- c("Package::algorithm", "RMSE min", "RMSE median", "RMSE D51", 
                      "MAE median", "WAE median", "Time median")

TOP5algo <- subset(Table1rk, RMSE %in% 1:5)[, c("Package", "Algorithm")]
rownames(TOP5algo)  <- subset(Table1rk, RMSE %in% 1:5)[, "Package"]

Table3$Package <- sapply(strsplit(Table3[, "Package::algorithm"], "::"), head, n=1)
Table3$Algorithm <- TOP5algo[Table3$Package, "Algorithm"]
idx2shorten <- grep("(BFGS)", Table3$Algorithm)
Table3$Algorithm[idx2shorten] <- substr(Table3$Algorithm[idx2shorten], 1, nchar(Table3$Algorithm[idx2shorten])-6)
Table3 <- Table3[, c("Package", "Algorithm", "RMSE min", "RMSE median", 
                     "RMSE D51", "MAE median", "WAE median", "Time median")]
Table3[, c("RMSE min", "RMSE median", "RMSE D51", "MAE median", "WAE median", "Time median")] <- apply(Table3[, c("RMSE min", "RMSE median", 
                     "RMSE D51", "MAE median", "WAE median", "Time median")],
      2, signif, digits=4)

kableExtra::kable(Table3, booktabs = TRUE, centering = TRUE, 
                  caption="Performance on bWoodN1 dataset",
                  align="llcccccc") %>%
  kable_styling(font_size=7) %>%
  column_spec(c(1, 8), bold = TRUE) %>%
  footnote(general="statistics taken over 20 runs; time in seconds.", footnote_as_chunk=TRUE)


## ---- fig.width=6, fig.height=3, fig.align='center', message=FALSE------------
library(NNbenchmark)
nrep <- 3       
odir <- tempdir()

library(nnet)
nnet.method <- "BFGS"
hyperParams.nnet <- function(...) {
    return (list(iter=200, trace=FALSE))
}
NNtrain.nnet <- function(x, y, dataxy, formula, neur, method, hyperParams, ...) {
    
    hyper_params <- do.call(hyperParams, list(...))
    
    NNreg <- nnet::nnet(x, y, size = neur, linout = TRUE, 
                        maxit = hyper_params$iter, trace=hyper_params$trace)
    return(NNreg)
}
NNpredict.nnet  <- function(object, x, ...) { predict(object, newdata=x) }
NNclose.nnet    <- function() {  if("package:nnet" %in% search())
                                detach("package:nnet", unload=TRUE) }
nnet.prepareZZ  <- list(xdmv = "d", ydmv = "v", zdm = "d", scale = TRUE)


## ---- fig.width=6, fig.height=3, fig.align='center', fig.cap="Example of nnet on mRef153", message=FALSE----
res <- trainPredict_1pkg(4, pkgname = "nnet", pkgfun = "nnet", nnet.method,
  prepareZZ.arg = nnet.prepareZZ, nrep = nrep, doplot = TRUE,
  csvfile = FALSE, rdafile = FALSE, odir = odir, echo = FALSE)


## ---- fig.width=6, fig.height=3, fig.align='center', fig.cap="Example of nnet on uDmod1", message=FALSE----
res <- trainPredict_1pkg(5, pkgname = "nnet", pkgfun = "nnet", nnet.method,
  prepareZZ.arg = nnet.prepareZZ, nrep = nrep, doplot = TRUE,
  csvfile = FALSE, rdafile = FALSE, odir = odir, echo = FALSE)


## ----echo=FALSE, message=FALSE------------------------------------------------
if(file.exists("./tables/TableAppendixC.csv")) {  
  Table1SupplApp <- read.csv("./tables/TableAppendixC.csv", sep = ";") 
}else 
  Table1SupplApp <- rep("missing",8)
colnames(Table1SupplApp) <- c("Num", "Input format", "Maxit", "Learn. rate", "median",
                    "d51", "MAE", "WAE")
#Table1SupplApp[, "Package:Algorithm"] <- paste0(Table1[Table1SupplApp$Num, "Package"], ":",
#                        substr(Table1[Table1SupplApp$Num, "Algorithm"], 4, nchar(Table1[Table1SupplApp$Num, "Algorithm"])))
#Table1SupplApp <- Table1SupplApp[, c("Num", "Package:Algorithm", "Input format", "Maxit", "Learn. rate", "median",
#                    "d51", "MAE", "WAE")]

Table1SupplApp[, "Package"] <- Table1[Table1SupplApp$Num, "Package"]
Table1SupplApp[, "Algorithm"] <- Table1[Table1SupplApp$Num, "Algorithm"]

Table1SupplApp <- Table1SupplApp[, c("Package","Algorithm", "Input format", "Maxit", "Learn. rate", "median",
                    "d51", "MAE", "WAE")]

#use idxRk as for Table1rk
if(all(Table1SupplApp[, "Algorithm"] == Table1$Algorithm))
{
  Table1SupplApp <- Table1SupplApp[idxRk, ]
  rownames(Table1SupplApp) <- 1:NROW(Table1SupplApp)
}

TOP5pkg <- head(unique(Table1rk$Package), 5)
TOP5algo <- head(Table1rk$Algorithm[order(Table1rk$RMSE)], 5)
TOP5algo <- substr(TOP5algo, 5, nchar(TOP5algo))
TOP5sentence <- paste0("TOP5 are ", paste(paste(TOP5pkg, TOP5algo, sep=":"), collapse=", "), ".")      

kableExtra::kable(Table1SupplApp, format = "latex", booktabs = TRUE, 
                  centering = TRUE, align="llcllcccc",
                  caption="All convergence scores per package:algorithm sorted by minimum RMSE") %>%
  add_header_above(c(" "=2, "Input parameter"=3, "RMSE Score"=2, "Other score"=2)) %>%
  column_spec(1, bold = TRUE) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign ="middle") %>%
  kable_styling(font_size=7) %>%
  footnote(general=TOP5sentence, footnote_as_chunk=TRUE)

