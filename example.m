%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clean the house
clc
clear var;

% Path to the DNN
DNNPath=[pwd '/final.nnet'];
nnet=readkaldiNNet(DNNPath);

% Path to config file
FTFilePath=[pwd '/final.feature_transform'];
config=readkaldiFTFile(FTFilePath);

% Path to prior Info 
priorPath= [pwd '/ali_train_pdf.counts'];
prior=readkaldiPriors(priorPath);

% Path to an ARK feature file
featName='exp1';
featPath=[pwd '/' featName '.ark'];
% Read Features
featsSingle=readkaldiArkFile(featPath);
[D,T]= size(featsSingle);
% Add Context
feats=nnet_applyContext(featsSingle,config);

% Feed forward neural network
[logPosteriors,Posteriors]=nnet_forward(nnet,feats);

% % Feed forward neural network with UP and PIE approx.
% [propMean, propVar]=nnet_PIE_propagate(nnet,feats,uncert);
% 
% % Feed forward neural network with UP and UT approx.
% [propMean, propVar]=nnet_UT_propagate(nnet,feats,uncert);

% Compute psudo log likelihoods
PseudoLL=logPosteriors-repmat(log(prior),[1,T]);

% Write Pseudo LLs to an ark file 
PLL.utt={featName};
PLL.feature={PseudoLL};
writekaldifeatures(PLL,[pwd '/' featName '_ll.ark']);
