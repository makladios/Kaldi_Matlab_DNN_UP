function [nnet]=readkaldiNNet(nnetBin)
% [nnet]=readkaldiNNet(nnetBin) transforms neural netwrok in kaldi format 
% to matlab cell array containing the neural network parameters  
% Input arguments:
% nnetBin --> path to the neural network stored in Kaldi format  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                              
% Written by Ahmed Hussen Abdelaziz and Shinji Watanabe  
% Copyright(c) MERL 2014                                  
% Permission is granted for anyone to copy, use, or modify 
% this program for purposes of research or education. This program 
% is distributed without any warranty express or implied.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Store an ASCII version of the neural network in the same folder of the
% binary one
nnetASCI=[fileparts(nnetBin) '/final.txt'];

% Convert the binary network to an ASCII version 
system(['nnet-copy'...
        ' --binary=false'...
        ' ' nnetBin ...
        ' ' nnetASCI]);

fid=fopen(nnetASCI);
nnetChar=fscanf(fid,'%c');
fclose(fid);

starts=strfind( nnetChar , '[' );
ends=strfind( nnetChar , ']' );

% store the weights and the bias parameters of each layer in separate cell
nnet=cell([ 1 length(starts) ]);

for i=1:length(starts)
    fid=fopen('tmpNNet.txt','w');
    fwrite(fid,nnetChar(starts(i)+1:ends(i)-1));
    fclose(fid);
    nnet{i}=dlmread('tmpNNet.txt');
end

