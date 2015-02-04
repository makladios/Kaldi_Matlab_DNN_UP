function [logPosteriors,Posteriors]=nnet_forward(nnet,features)
% [logPosteriors,Posteriors]=nnet_forward(nnet,features) applies the 
% feed-forward path of the neural network and returns the pre-activation 
% of the softmax layer (logPosteriors) and the output posteriors.
% Input arguments:
% nnet --> cell array containing neural network parameters. 
% features --> Feature matrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmpfeat=features;

for i=1:2:(numel(nnet)-2)
    % Pre-activations
    z=nnet{i}*tmpfeat+repmat(nnet{i+1}',[1 size(features,2)]);
    % Sigmoid Function
    h=sigmoid(z);
    
    tmpfeat=h;
end
% Pre-activation of the softmax layer
logPosteriors=nnet{end-1}*tmpfeat+repmat(nnet{end}',[1 size(features,2)]);
% Apply the softmax function
Posteriors=softmax(logPosteriors);