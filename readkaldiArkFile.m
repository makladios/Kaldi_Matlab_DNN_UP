function [feat]= readkaldiArkFile(arkPath)
% [feat]= readkaldiArkFile(arkPath) returns a matrix including features or
% posteriors transformed from a Kaldi ark file
% Input arguments:
% arkPath --> Path to a Kaldi ark file 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert ark file to txt 
system(['copy-feats'...
        ' ark:' arkPath...
        ' ark,t:temp.txt']);

% Open text file
fidFeats=fopen('temp.txt','r');
FeatsChar=fscanf(fidFeats,'%c');
fclose(fidFeats);

% Convert text to matrix of entries of double percision 
start=strfind(FeatsChar,'[');
ende=strfind(FeatsChar,']');
fidFeats2=fopen('temp2.txt','w');
fwrite(fidFeats2,FeatsChar(start+1:ende-1));
fclose(fidFeats2);
feat=dlmread('temp2.txt')';
