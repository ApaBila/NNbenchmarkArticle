library(RWsearch)
crandb_down()

fullNNlist <- setdiff(s_crandb("neural", "network", mode="and"), "NNbenchmark")
fullNNdep <- lapply(p_deps(fullNNlist, recursive = TRUE), sort)

fullNNdep[["gnn"]]

primaryNNlist <- c("ANN2", "automl", "Buddle", "brnn", "CaDENCE", "deep", "deepdive",
                   "deepnet", "deepNN","ELMR", "elmNNRcpp", "h2o",
                "keras", "monmlp",
                "neuralnet", "nnet", "nnlib2Rcpp", "RSNNS", "simpleMLP", "simpleNeural", 
                "tensorflow", "torch", "validann")
secondaryNNlist <- c("aifeducation", "cito", "DamiaNN", "fastai", "innsight", "janus",
                     "MachineShop", "NeuralNetTools", "NeuralSens", "nndiagram", "tfestimators")
toospecific <- c("appnn", "BayesFluxR",
                 "cld2", "cld3", "ConvertPar", "cpfa", "deeptrafo", "deepregression", 
                 "digitalDLSorteR", "DNMF", "DMLLZU", "edl", "EMDANNhybrid", "epicasting", 
                 "evclust", "evclass", "evreg", "FWRGB", "FuncNN", 
                 "ganDataModel", "glmnetr", "GMDHreg", "GMDH2", "gnn", 
                 "GRNNs", "grnn", "image.libfacedetection",
                 "ImNN", "isingLenzMC", "leabRa", "learNN",
                 "LilRhino", "lilikoi", "MARSANNhybrid", "MBMethPred", "ML2Pvae", "mrbin",
                 "neuralGAM", "onnx", "passt", "predictoR", "ProcData", "qrnn",
                 "quarrint", "rasclass", "regressoR", "reservr","RGAN",  "rMIDAS",
                 "Rstg", "RTextTools", "rTG",
                 "scapGNN", "shattering", "SignacX", "sjSDM", "snap", "Sojourn.Data",
                 "soundClass", "SpatialDDLS", "spnn", "sr", "studyStrap", 
                 "survivalmodels", "TeachNet", "trackdem",
                 "TrafficBDE", "transformer", "vmdTDNN", "WaveletML", "yager")
timeserieNN <- c("AriGaMyANNSVR", "ARIMAANN", "CEEMDANML", "ECTTDNN", "eemdTDNN",
                 "GMDH", "hybridts", "LDNN", "long2lstmarray", "NlinTS", "nnfor", 
                 "OptiSembleForecasting", "rnn", "sits", "stlTDNN", "TSANN", 
                 "tsensembler", "tsfgrnn", "TSLSTM", "TSLSTMplus", "WaveletLSTM")
multiModelist <- c("caret", "EnsembleBase", "gamlss.add", "ModTools", 
                             "radiant.model",  "rminer",  "traineR")


setdiff(fullNNlist, c(primaryNNlist, secondaryNNlist, toospecific, timeserieNN, multiModelist))
