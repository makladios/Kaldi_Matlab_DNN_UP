function [feats]=nnet_applyContext(featsSingle,conf)
% feats=nnet_applyContext(featsSingle,conf) appends n frames before and
% after the current frame, rescales, and shifts them. 
% Input arguments:
% featsSingle --> D*T matrix includes T D-dimensional feature vectors. 
% conf --> cell array from final.feature_transform, where 
%          conf{1} includes the number of frames n that should be appended
%          conf{2} shift factors
%          conf{3} rescale factors
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find matrix dimension 
[D,T]=size(featsSingle);

% Initialize the output matrix
feats=zeros(length(conf{1})*D,T);
featsSingle=[repmat(featsSingle(:,1),[1,5]) featsSingle repmat(featsSingle(:,end),[1,5])];

% Append the context frames
for i=1:T
    start=i;
    ende=i+length(conf{1})-1;
    feats(:,i)=reshape(featsSingle(:,start:ende),[D*length(conf{1}),1]);
end

% Shift the features 
feats=feats+repmat(conf{2}',[1,T]);

% rescale the features
feats=feats.*repmat(conf{3}',[1,T]);