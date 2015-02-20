function [Mu_out,Cov_out]=propagate_UT(Mu_in,Cov_in)
% [Mu_out,Cov_out]= propagate_UT(Mu_in,Cov_in) probagates the mean vector 
% Mu_in and the diagonal covariance matrix with diagonal vector  Cov_in 
% through sigmoid function using the unscented transformation [1]. Mu_out is 
% the propagated mean and Cov_out is the diagonal vector of the propagated
% diagonal covariance matrix.
% Input arguments:
% Mu_in --> Mean value of the input distribution
% Cov_in --> Variance of the input distribution
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

n=1;
k=2;
[d,T]=size(Mu_in);

% Choose 3 points
x=zeros(d,T,2*n+1);
x(:,:,1)=Mu_in;
SQ = sqrt((n+k)*Cov_in); 
x(:,:,2)=Mu_in+SQ;
x(:,:,3)=Mu_in-SQ;

% Transfor the points by applying the sigmoid function
y=sigmoid(x);

% Compute the weights
w(:,:,1)=k/(n+k)*ones(d,T);
w(:,:,2:2*n+1)=1/(2*(n+k))*ones(d,T,2*n);

% Compute the mean
Mu_out=sum(y.*w,3);

% Compute the Covariance
MuFreeY=y-repmat(Mu_out,[1,1,2*n+1]);
Cov_out=sum(w.*(MuFreeY.^2),3); 
 