function [h]=softmax(z)
% [h]=softmax(z) applies the softmax function to the input matrix z
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=exp(z)./repmat(sum(exp(z),1),[size(z,1),1]);