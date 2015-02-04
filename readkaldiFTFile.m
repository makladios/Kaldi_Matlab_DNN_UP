function [conf]= readkaldiFTFile(feature_transform)
% [conf]= readkaldiFTFile(feature_transform) returns a cell 
% arry conf containing: 
% 1) conf{1} includes the number of frames n that should be appended
% 2) conf{2} shift factors
% 3) conf{3} rescale factors
% Input arguments:
% feature_transform --> Path to Kaldi's feature_transform text file 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load configuration file
fid=fopen(feature_transform,'r');
confChar=fscanf(fid,'%c');
fclose(fid);

starts=strfind(confChar,'[');
ends=strfind(confChar,']');

% Store config in a cell array
conf=cell([1,3]);
for i=1:3
    conf{i}=eval(confChar(starts(i):ends(i)));
end