function [L]= Laplace(N);
L=zeros(N+2,N+2);
A=2*ones(1,N+2);
A=diag(A);
B=ones(1,N+1);
B=diag(B,1);
C=ones(1,N+1);
C=diag(C,-1);
L=A-B-C;
