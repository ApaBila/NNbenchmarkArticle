library(RWsearch)
crandb_down()

fullNNlist <- setdiff(s_crandb("neural", "network", mode="and"), "NNbenchmark")
fullNNdep <- lapply(p_deps(fullNNlist, recursive = TRUE), sort)

fullNNdep[["yager"]]

primaryNNlist <- c("ANN2", "automl", "Buddle", "brnn", "CaDENCE", "deep", "deepdive",
                   "deepnet", "deepNN","ELMR", "elmNNRcpp", "h2o",
                "keras", "monmlp",
                "neuralnet", "nnet", "nnlib2Rcpp", "RSNNS", "simpleMLP", "simpleNeural", 
                "tensorflow", "torch", "validann")
secondaryNNlist <- c("aifeducation", "cito", "DamiaNN", "fastai", "innsight", "janus",
                     "MachineShop", "NeuralNetTools", "NeuralSens", "nndiagram", "tfestimators")
toospecific <- c("appnn", "cld2", "cld3", "ConvertPar", "cpfa", "deeptrafo", "deepregression", 
                 "digitalDLSorteR", "DNMF", "DMLLZU", "edl", "EMDANNhybrid", "epicasting", 
                 "evclust", "evclass", "evreg", "FWRGB",
                 "ganDataModel", "GMDH2", "GRNNs", "grnn", "image.libfacedetection",
                 "ImNN", "isingLenzMC", "leabRa", "learNN",
                 "LilRhino", "lilikoi", "MARSANNhybrid", "MBMethPred", "ML2Pvae", "mrbin",
                 "onnx", "passt", "qrnn",
                 "quarrint", "rasclass", "reservr", "Rstg", "RTextTools", "rTG",
                 "scapGNN", "shattering", "SignacX", "sjSDM", "snap", "Sojourn.Data",
                 "soundClass", "SpatialDDLS", "sr", "survivalmodels", "TeachNet", "trackdem",
                 "TrafficBDE", "transformer", "vmdTDNN", "WaveletML", "yager")
timeserieNN <- c("AriGaMyANNSVR", "ARIMAANN", "CEEMDANML", "ECTTDNN", "eemdTDNN",
                 "GMDH", "hybridts", "LDNN", "long2lstmarray", "NlinTS", "nnfor", 
                 "OptiSembleForecasting", "rnn", "sits", "stlTDNN", "TSANN", 
                 "tsensembler", "tsfgrnn", "TSLSTM", "TSLSTMplus", "WaveletLSTM")
multiModelist <- c("BayesFluxR", "caret", "EnsembleBase", "FuncNN", "gamlss.add", 
                   "glmnetr", "GMDHreg", "gnn", "ModTools", "neuralGAM", 
                   "predictoR", "ProcData", 
                             "radiant.model", "regressoR", "RGAN", "rMIDAS", "rminer", 
                             "spnn", "studyStrap", "traineR")


setdiff(fullNNlist, c(primaryNNlist, secondaryNNlist, toospecific, timeserieNN, multiModelist))
