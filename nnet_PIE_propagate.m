function [propMean, propVar]=nnet_PIE_propagate(nnet,feats,uncert)
% [propMean, propVar]=nnet_PIE_propagate(nnet,feats,uncert) propagates  
% uncertain features through nural network till the pre-activation of the 
% soft-max layer using the PIE approximation [1] and returns the propagated 
% mean propMean and the propagated covariance propVar.  
% Input arguments:
% nnet --> Cell array containing neural network parameters. 
% features --> Feature matrix
% uncert --> Uncertainty matrix
%
% [1] Ramon Fernandez Astudillo, João Paulo da Silva Neto, “Propagation 
% of Uncertainty through Multilayer Perceptrons for Robust Automatic Speech
% Recognition, ” in Interspeech, 2011
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmpfeat=feats;
tmpUncert=uncert;

for i=1:2:(numel(nnet)-2)
    % Propagate through the linear part of the hidden layer
    Mu=nnet{i}*tmpfeat+repmat(nnet{i+1}',[1 size(feats,2)]);
    S=nnet{i}.^2*tmpUncert;

    % Propagate through the sigmoid function using the PIE approximation
    [E_h,Var_h]=propagate_PIE(Mu,S);

    tmpfeat=E_h;
    tmpUncert=Var_h;
end

propMean=nnet{end-1}*tmpfeat+repmat(nnet{end}',[1 size(feats,2)]);
propVar=nnet{end-1}.^2*tmpUncert;
