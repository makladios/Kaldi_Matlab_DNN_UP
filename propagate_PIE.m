function [E_h,S2_h]= propagate_PIE(Mu,S2)
% [E_h,S2_h]= propagate_PIE(Mu,S2) probagates the mean vector Mu and the 
% diagonal covariance matrix with diagonal vector S2 through sigmoid 
% function using the PIE approximation [1]. E_h is the propagated
% mean and and S2_h is the diagonal vector of the propagated diagonal 
% covariance matrix.
% Input arguments:
% Mu --> Mean value of the input distribution
% S2 --> Variance of the input distribution
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

S=sqrt(S2);
MuSRatio=Mu./S;

H=2.^(0.5*(2*Mu+log(2)*S2-2)).*normcdf(-MuSRatio-log(2)*S);
I=1-normcdf(-MuSRatio);
J=-2.^(-0.5*(2*Mu-log(2)*S2+2)).*(1-normcdf(-MuSRatio+log(2)*S));

E_h=H+I+J;

A=2.^(2*(Mu+log(2)*S2-1)).*normcdf(-MuSRatio-2*log(2)*S);
B=1-normcdf(-MuSRatio);
C=-2.^(-0.5*(2*Mu-log(2)*S2)).*(1-normcdf(-MuSRatio+log(2)*S));
D=2.^(-2*(Mu-log(2)*S2+1)).*(1-normcdf(-MuSRatio+2*log(2)*S));

S2_h=A+B+C+D-E_h.^2;
