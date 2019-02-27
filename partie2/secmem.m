function [b] = secmem(Itest, Aire, Eps, x1, x2, x3)
%============================================================================
%    Calcul du Second Membre
%============================================================================
%
% Coordonnees du Barycentre de T
% ==============================
Xt = (x1(1) + x2(1) + x3(1))/3;
Yt = (x1(2) + x2(2) + x3(2))/3;
%
% Second Membre Elementaire T
% ===========================
%f(Itest, Xt, Yt, Eps, alpha, b1, b2)
b = (Aire/3)*f(Itest, Xt, Yt, Eps).*[1 1 1]';
