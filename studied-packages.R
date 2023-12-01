library(RWsearch)
crandb_down()

fullNNlist <- setdiff(s_crandb("neural", "networks", mode="and"), "NNbenchmark")
fullNNdep <- lapply(p_deps(fullNNlist, recursive = TRUE), sort)

#fullNNdep[["deep"]]

primaryNNlist <- c("ANN2", "automl", "brnn", "CaDENCE", "deep", "deepNN", "elmNNRcpp", "h2o",
                "keras", "neuralnet", "nnet", "nnlib2Rcpp", "RSNNS", "simpleNeural", 
                "tensorflow", "torch", "validann")
secondaryNNlist <- c("aifeducation", "cito", "DamiaNN", "fastai", "innsight", "janus",
                     "MachineShop", "NeuralNetTools", "NeuralSens", "tfestimators")
toospecific <- c("appnn", "ConvertPar", "digitalDLSorteR", "DNMF", "edl", "evclass", 
                 "ganDataModel", "GRNNs", "ImNN", "isingLenzMC", "leabRa", "learNN",
                 "LilRhino", "quarrint", "rasclass", "reservr", "RTextTools", "rTG",
                 "scapGNN", "shattering", "SignacX", "sjSDM", "snap", "Sojourn.Data",
                 "soundClass", "SpatialDDLS", "sr", "survivalmodels", "TeachNet",
                 "TrafficBDE")
timeserieNN <- c("hybridts", "long2lstmarray", "NlinTS", "nnfor", "sits", "tsensembler", "WaveletLSTM")
moregeneralModelinglist <- c("BayesFluxR", "caret", "FuncNN", "gamlss.add", "GMDHreg", 
                             "gnn", "ModTools", "neuralGAM", "predictoR", "ProcData", 
                             "radiant.model", "regressoR", "RGAN", "rMIDAS", "rminer", 
                             "spnn", "studyStrap", "traineR")