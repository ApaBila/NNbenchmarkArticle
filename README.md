# NNbenchmarkArticle

This repo was made to contain the code for the R Journal article 
based on the work we did during Google Summer of Codes 2019 and 2020.

**IMPORTANT LINKS**  
Call for students                                 : https://www.inmodelia.com/gsoc2019.html   
My project page on Summer of Code website         : https://summerofcode.withgoogle.com/projects/#5795523770974208  
Akshaj's project page on Summer of Code website   : https://summerofcode.withgoogle.com/projects/#6319761942642688  
NNbenchmark package repo                          : https://github.com/pkR-pkR/NNbenchmark  
Companion repo for templates of the packages      : https://github.com/pkR-pkR/NNbenchmarkTemplates  
(my commits done under this username)  
Akshaj's website for NNbenchmark                  : https://theairbend3r.github.io/NNbenchmarkWeb/index.html 

# TODO list

**Question 1 - which package** 

Good news, AMORE, snnR are archived.

Searching on CRAN via RWsearch, I found 32 new packages

 [1] "aifeducation"    "BayesFluxR"      "cito"           
 [4] "ConvertPar"      "digitalDLSorteR" "edl"            
 [7] "fastai"          "FuncNN"          "ganDataModel"   
[10] "GRNNs"           "hybridts"        "innsight"       
[13] "janus"           "long2lstmarray"  "ModTools"       
[16] "reservr"         "RGAN"            "rMIDAS"         
[19] "rTG"             "scapGNN"         "shattering"     
[22] "SignacX"         "sits"            "sjSDM"          
[25] "snap"            "soundClass"      "SpatialDDLS"    
[28] "sr"              "survivalmodels"  "torch"          
[31] "tsensembler"     "WaveletLSTM" 

Good news : however the following ones use directly a tested packages :

ConvertPar      "neuralnet"  
digitalDLSorteR "keras"      
FuncNN          "keras;caret"
janus           "keras"      
ModTools        "nnet"       
reservr         "keras"      
rTG             "brnn"       
SignacX         "neuralnet"  
snap            "keras"      
soundClass      "keras"      
SpatialDDLS     "keras"      
tsensembler     "monmlp"     
WaveletLSTM     "caret" 


So we may discard those.

If we check recursive dependencies, the following packages also depend on tested packages

fastai   "nnet"          
hybridts "nnet;neuralnet"

It remains the following packages

[1] "aifeducation"   "BayesFluxR"     "cito"          
 [4] "edl"            "ganDataModel"   "GRNNs"         
 [7] "innsight"       "long2lstmarray" "RGAN"          
[10] "rMIDAS"         "scapGNN"        "shattering"    
[13] "sits"           "sjSDM"          "sr"            
[16] "survivalmodels" "torch"

Good news: the following depends on torch

 "cito"     "innsight" "RGAN"     "sits"    

So in the end, we have probably 12 packages to look at … probably to test. My ph.d. student knows well torch : he will help us in making the Rmd file and commenting the paper.


**Question 2 - do we need to benchmark classification?** 

If yes, we should add some datasets.
If not, we should comment on this.

**Question 3 - how to justify hyperparameter tuning?**

To which extent, we must tune hyperparameter. Check that the paper mention this issue.

**Question 4 - justify no validation split or do training-validation split?**

Previous reviewer's comment `"Comparing the performance only on the training data is rather unrelated to common appli- cations and does not indicate how well the network generalizes."`   

**Question 5 - should we consider other datasets?**

Previous reviewer's comment `"For a benchmark paper, the number of included datasets is quite low, and the chosen datasets are very simple. Given that collections such as OpenML100 are readily available, a benchmark should be based on more and more complex data."`


**CREDITS**  
Students: 
Akshaj Verma | 
Salsabila Mahdi
Mentors:   
Christophe Dutang |
John Nash |
Patrice Kiener 
