function [D] = matdiff(Aire, X, Y)
%=============================================================================
%    Matrice de Diffusion
%=============================================================================
%
D = (0.25/Aire)*(Y*Y' + X*X');
%
