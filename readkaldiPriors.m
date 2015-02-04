function [logPriors] = readkaldiPriors(farme_counts_Path)
% [logPriors] = readkaldiPriors(farme_counts_Path) returns log priors 
% needed for pseudo log-likelihood estimation.   
% Input arguments:
% farme_counts_Path --> path to Kaldi's aligned frame counts "*.counts"
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load file containing aligned frame counts
fid=fopen(farme_counts_Path,'r');
featsChar=fscanf(fid,'%c');
fclose(fid);
frameCounts=eval(featsChar);

% Estimate log-priors
logPriors=log(frameCounts./sum(frameCounts))';
