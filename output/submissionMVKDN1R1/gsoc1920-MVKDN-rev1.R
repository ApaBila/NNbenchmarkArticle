## ---- echo=FALSE--------------------------------------------------------------
library(knitr)
library(kableExtra)
library(NNbenchmark)


## ---- echo=FALSE--------------------------------------------------------------
#check
dimNNdata <- t(sapply(NNdatasets, function(x) dim(x$Z)))
sumNNdata <- NNbenchmark::NNdataSummary(NNbenchmark::NNdatasets)
colnames(sumNNdata) <- c("Dataset", "Row nb.", "Input nb.", "Neuron nb.", "Param. nb.")
kableExtra::kable(sumNNdata, label="NNdatasets",
                  format = "latex", booktabs = TRUE, 
                  centering = TRUE, align="lcccc",
                  caption="Datasets' summary") %>%
  pack_rows("Multivariate", 1, 4) %>% 
  pack_rows("Univariate", 5, 12) %>%
  kable_styling(font_size=7)


## ----echo=FALSE, message=FALSE------------------------------------------------
options(knitr.kable.NA = '')

if(file.exists("./tables/Table1-rev-Callrating.csv")) {  
  TablePkgRMSEscore <- read.table("./tables/Table1-rev-Callrating.csv", sep = ";", dec=".",
                       header=TRUE)
  TablePkgRMSEscore <- TablePkgRMSEscore[TablePkgRMSEscore[,2] != "", ]
}else 
   TablePkgRMSEscore <- rbind(rep("missing",6))

colnames(TablePkgRMSEscore) <- c("Package", "Algorithm", "Time", "RMSE",
                    "Util", "Doc", "Call", "Comment")

pkg.name <- TablePkgRMSEscore$Package[TablePkgRMSEscore$Package != ""]
idx.pkg.name <- (1+0:NROW(TablePkgRMSEscore))[TablePkgRMSEscore$Package != ""]
TablePkgRMSEscore$Doc <- floor(TablePkgRMSEscore$Doc)

#repeat value
TablePkgRMSEscore$Package <- rep(pkg.name, times=diff(idx.pkg.name))
TablePkgRMSEscore$Util <- rep(TablePkgRMSEscore$Util[!is.na(TablePkgRMSEscore$Util)], times=diff(idx.pkg.name))
TablePkgRMSEscore$Doc <- rep(TablePkgRMSEscore$Doc[!is.na(TablePkgRMSEscore$Doc)], times=diff(idx.pkg.name))
TablePkgRMSEscore$Call <- rep(TablePkgRMSEscore$Call[!is.na(TablePkgRMSEscore$Call)], times=diff(idx.pkg.name))


#reorder columns
TableScore <- TablePkgRMSEscore[, c(1,2:4)]
#get the min RMSE by pkg
pkgRkbyRMSE <- sort(tapply(TableScore$RMSE, TableScore$Package, min))
#create new index
n <- NROW(TableScore)
getorderbypkg <- function(p)
{
  idx <- (1:n)[TableScore$Package == p]
  if(length(idx) > 1)
    return(idx[order(TablePkgRMSEscore[idx, "RMSE"])])
  else
    return(idx)
}
idxRk <- unlist(sapply(names(pkgRkbyRMSE), getorderbypkg))
TableScorerk <- TableScore[idxRk, ]
rownames(TableScorerk) <- 1:n
# m <- n/2
# TableScorerk2col <- cbind(head(TableScorerk, m), tail(TableScorerk, m))
# 
# kableExtra::kable(TableScorerk2col, format = "latex", booktabs = TRUE, 
#                   centering = TRUE, align="llccllcc",
#                   caption="Results of Tested Packages (sorted by best RMSE score per package)") %>%
#   add_header_above(c(" "=2, "Global score"=2," "=2, "Global score"=2)) %>%
#   column_spec(c(1, 5), bold = TRUE) %>%
#   column_spec(4, border_right = TRUE) %>%
#   collapse_rows(columns = c(1,5), latex_hline = "major", valign ="middle") %>%
#   kable_styling(font_size=7) %>%
#   footnote(general="Statistics over 10 runs.", footnote_as_chunk=TRUE)

m <- 29
TableScoreList <- list(TableScorerk[1:m,], TableScorerk[-(1:m),])
rownames(TableScoreList[[2]]) <- 1:NROW(TableScoreList[[2]])

TScore1 <- capture.output(kableExtra::kable(TableScoreList[[1]], 
                  format = "latex", booktabs = TRUE, 
                  centering = FALSE, align="llcc",
                  label="RMSEscore",
                  caption="Results of Tested Packages (sorted by best RMSE score per package)") %>%
  add_header_above(c(" "=2, "Global score"=2)) %>%
  column_spec(1, bold = TRUE) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign ="middle") %>%
  kable_styling(font_size=7, full_width = FALSE) %>%
  footnote(general="Statistics over 10 runs.", footnote_as_chunk=TRUE))

TScore2 <- capture.output(kableExtra::kable(TableScoreList[[2]], 
                  format = "latex", booktabs = TRUE, 
                  centering = FALSE, align="llcc",
                  caption="Results of Tested Packages (sorted by best RMSE score per package)") %>%
  add_header_above(c(" "=2, "Global score"=2)) %>%
  column_spec(1, bold = TRUE) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign ="middle") %>%
  kable_styling(font_size=7, full_width = FALSE) %>%
  footnote(general="Statistics over 10 runs.", footnote_as_chunk=TRUE))

TScore12 <- c(head(TScore1, -1), tail(TScore2, -4))
cat(TScore12, file = "./tables/Table-RMSEscore.tex", sep="\n")


## ----echo=FALSE, message=FALSE------------------------------------------------
options(knitr.kable.NA = '')

if(file.exists("./tables/TableEaseOfUse.csv")) {  
  TableEaseOfUse <- read.table("./tables/TableEaseOfUse.csv", sep = ";", dec=".",
                       header=TRUE)
  TableEaseOfUse <- TableEaseOfUse[!is.na(TableEaseOfUse[,5]), ]
  rownames(TableEaseOfUse) <- 1:NROW(TableEaseOfUse)
}else 
   TableEaseOfUse <- rbind(rep("missing",10))
colnames(TableEaseOfUse) <-  c("Package", "Algorithm", "Num", "Input",
                    "Util", "Doc", "Call", "Comments","Formula","X Y")
TableEaseOfUse$Doc <- floor(TableEaseOfUse$Doc)

#convert to stars
cvt2star <- function(j)
{
  switch(as.character(j), "0" = " ", "1"="*", "2"="**", "3"="***", "4"="****")
}
TableEaseOfUse$Doc <- unlist(sapply(TableEaseOfUse$Doc, cvt2star))
TableEaseOfUse$Util <- unlist(sapply(TableEaseOfUse$Util, cvt2star))
TableEaseOfUse$Call <- unlist(sapply(TableEaseOfUse$Call, cvt2star))
TableEaseOfUse <- TableEaseOfUse[, c("Package", "Util", "Doc", "Call", 
                                     "Formula", "X Y", "Comments")]

kableExtra::kable(TableEaseOfUse, format = "latex", booktabs = TRUE, 
                  centering = TRUE, align="lcccccl", linesep="",
                  label="EaseOfUse",
                  caption="Ease of Use Scores of Tested Packages") %>%
  add_header_above(c(" "=1, "Individual score"=3,"Input allowed"=2, " "=1)) %>%
  column_spec(1, bold = TRUE) %>%
  column_spec(7, width = "30em") %>% 
  kable_styling(font_size=7, latex_options = "striped")


## ----echo=FALSE, message=FALSE------------------------------------------------
options(knitr.kable.NA = '')

if(file.exists("./tables/TableTOP10.csv")) {  
  TableTOP10 <- read.csv("./tables/TableTOP10.csv")
}else
 TableTOP10 <- rep("missing", 7)
colnames(TableTOP10) <- c("Package::algorithm", "RMSE min", "RMSE median", "RMSE D51", 
                      "MAE median", "WAE median", "Time median")

TOP5algo <- subset(TableScorerk, RMSE %in% 1:5)[, c("Package", "Algorithm")]
rownames(TOP5algo)  <- subset(TableScorerk, RMSE %in% 1:5)[, "Package"]

TableTOP10$Package <- sapply(strsplit(TableTOP10[, "Package::algorithm"], "::"), head, n=1)
TableTOP10$Algorithm <- TOP5algo[TableTOP10$Package, "Algorithm"]
idx2shorten <- grep("(BFGS)", TableTOP10$Algorithm)
TableTOP10$Algorithm[idx2shorten] <- substr(TableTOP10$Algorithm[idx2shorten], 1, nchar(TableTOP10$Algorithm[idx2shorten])-6)
TableTOP10 <- TableTOP10[, c("Package", "Algorithm", "RMSE min", "RMSE median", 
                     "RMSE D51", "MAE median", "WAE median", "Time median")]
TableTOP10[, c("RMSE min", "RMSE median", "RMSE D51", "MAE median", "WAE median", "Time median")] <- apply(TableTOP10[, c("RMSE min", "RMSE median", 
                     "RMSE D51", "MAE median", "WAE median", "Time median")],
      2, signif, digits=4)

kableExtra::kable(TableTOP10, booktabs = TRUE, centering = TRUE, 
                  caption="Performance on bWoodN1 dataset",
                  align="llcccccc", label="TOP10:bWoodN1") %>%
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
if(file.exists("./tables/TableAllScoreInput.csv")) {  
  Table1SupplApp <- read.csv("./tables/TableAllScoreInput.csv", sep = ";") 
}else 
  Table1SupplApp <- rep("missing",8)
colnames(Table1SupplApp) <- c("Num", "Input format", "Maxit", 
                    "Learn. rate", "min", "median", "D51", "MAE", 
                    "WAE", "Package", "Algorithm", "time")

#repeat value
pkg.name <- Table1SupplApp$Package[Table1SupplApp$Package != ""]
idx.pkg.name <- (1+0:NROW(Table1SupplApp))[Table1SupplApp$Package != ""]
Table1SupplApp$Package <- rep(pkg.name, times=diff(idx.pkg.name))

Table1SupplApp <- Table1SupplApp[, c("Package","Algorithm", "Input format", "Maxit", "Learn. rate",  "min", "median",
                    "D51", "MAE", "WAE")]
num2char <- function(x)
  if(x == 0)
  { return(" ")
  }else return(as.character(x))

Table1SupplApp$Maxit <- sapply(Table1SupplApp$Maxit, num2char)
Table1SupplApp$"Learn. rate" <- sapply(Table1SupplApp$"Learn. rate", num2char)

#use idxRk as for TableScorerk
if(all(Table1SupplApp[, "Algorithm"] == TablePkgRMSEscore$Algorithm))
{
  Table1SupplApp <- Table1SupplApp[idxRk, ]
  rownames(Table1SupplApp) <- 1:NROW(Table1SupplApp)
}

TOP5pkg <- head(unique(TableScorerk$Package), 5)
TOP5algo <- head(TableScorerk$Algorithm[order(TableScorerk$RMSE)], 5)
TOP5algo <- substr(TOP5algo, 5, nchar(TOP5algo))
TOP5sentence <- paste0("TOP5 are ", paste(paste(TOP5pkg, TOP5algo, sep=":"), collapse=", "), ".")      

kableExtra::kable(Table1SupplApp, format = "latex", booktabs = TRUE, 
                  centering = TRUE, align="lllllccccc", label="allscore",
                  caption="All convergence scores per package:algorithm sorted by minimum RMSE") %>%
  add_header_above(c(" "=2, "Input parameter"=3, "RMSE score"=3, "Other score"=2)) %>%
  column_spec(1, bold = TRUE) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign ="middle") %>%
  kable_styling(font_size=7, latex_options =c("hold_position")) %>%
  footnote(general=TOP5sentence, footnote_as_chunk=TRUE)


## ----echo=FALSE, message=FALSE------------------------------------------------
options(knitr.kable.NA = '')

if(file.exists("./tables/TableDiscardedPkg.csv")) {  
  TableDiscard <- read.csv("./tables/TableDiscardedPkg.csv")
  TableDiscard <- TableDiscard[TableDiscard[,3] != "", ]
  TableDiscard <- TableDiscard[,c("Package", "Category", "Reason.to.Discard..Where.")]
}else
 TableDiscard <- rep("missing", 3)
colnames(TableDiscard) <- c("Package", "Category", "Reason to Discard (File(s) and/or function(s))")



kableExtra::kable(TableDiscard, booktabs = TRUE, centering = TRUE,
                  longtable = TRUE, label="Discard:Pkg",
                  caption="Review of Discarded Packages") %>%
  kable_styling(font_size=7, latex_options = c("repeat_header", "hold_position")) %>%
  column_spec(3, width = "10cm") %>%
  footnote(general="AP=Application, CL=Classification, RE=Regression, RE*=?, TS=Time serie, UT=Utility, XX=Other.", 
           footnote_as_chunk=TRUE)

