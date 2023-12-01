# NNbenchmarkArticle

This repo was made to contain the code for the article 
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

**Question 1 - which package to study?** 

Good news: `AMORE`, `snnR` are archived.

Searching on CRAN via RWsearch, I found new packages.
We need to consider different list of packages.
The primary list contains core NN packages really implementing NN
```
 [1] "ANN2"         "automl"       "brnn"         "CaDENCE"      "deep"        
 [6] "deepNN"       "elmNNRcpp"    "h2o"          "keras"        "neuralnet"   
[11] "nnet"         "nnlib2Rcpp"   "RSNNS"        "simpleNeural" "tensorflow"  
[16] "torch"        "validann"  
```
The secondary list use at least one the primary NN package and provide additional functionality
```
 [1] "aifeducation"   "cito"           "DamiaNN"        "fastai"        
 [5] "innsight"       "janus"          "MachineShop"    "NeuralNetTools"
 [9] "NeuralSens"     "tfestimators"  
```
We should probably dedicate a section to time serie NN 
```
[1] "hybridts"       "long2lstmarray" "NlinTS"         "nnfor"         
[5] "sits"           "tsensembler"    "WaveletLSTM"
```
and also `TSLSTM`, `TSLSTMplus`, `LDNN`, `rnn`.

Finally, we must list advantages of packages providing an interface to a wide set of model
```
 [1] "BayesFluxR"    "caret"         "FuncNN"        "gamlss.add"    "GMDHreg"      
 [6] "gnn"           "ModTools"      "neuralGAM"     "predictoR"     "ProcData"     
[11] "radiant.model" "regressoR"     "RGAN"          "rMIDAS"        "rminer"       
[16] "spnn"          "studyStrap"    "traineR"  
```


**Question 2 - do we need to benchmark classification?** 

No. Classification is different. Here, training sets and test sets are recommended to ovoid overfitting.
There are plenty of classification dataset. But studying classification is like writing a second paper 
as it requires separate tables to report the results. 
An alternative solution is to say that the benchmark of classification algorithm will be in a second paper.

**Question 3 - how to justify hyperparameter tuning?**

To which extent, we must tune hyperparameter. Check that the paper mention this issue.
For the hyperparameters, testing and giving results for the default parameters is mandatory 
as 99% of users will use the default. 
Then we can add a new column with the question « Did we find better hyperparameters? » and answer « yes/no ». We may automate a grid-search.


**Question 4 - justify no validation split or do training-validation split?**

Previous reviewer's comment `"Comparing the performance only on the training data is rather unrelated to common appli- cations and does not indicate how well the network generalizes."`.

When finding a minimum, this is not necessary. But to anticipate reviewers' questions, we need to find few well-known datasets with trainng sets and test sets on regression. 


**Question 5 - should we consider other datasets?**

Previous reviewer's comment `"For a benchmark paper, the number of included datasets is quite low, and the chosen datasets are very simple. Given that collections such as OpenML100 are readily available, a benchmark should be based on more and more complex data."`
We must keep our 4 multivariate and 8 univariate datasets, find 4 real (multi) datasets with train/split for the full ranking. Still we have the Simon Wood's dataset for TOP5 or TOP10.


**Question 6 - do we automate the benchmark on a server?**

there are plenty of resources in LJK, Grenoble. we must find the easiest way:
- either run R scripts parallely to produce csv outputs or even Rdata files ; make Rmd file to analyze individual outputs.
- or run Rmd files to produce csv, html outputs


**CREDITS**  
Students: 
Akshaj Verma | 
Salsabila Mahdi
Mentors:   
Christophe Dutang |
John Nash |
Patrice Kiener 
