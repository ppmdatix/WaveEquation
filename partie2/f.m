function [b] = f(Itest, x, y, eps)
%
p(:,1) = x;
p(:,2) = y;
%
% Calcul de la fonction source f (deux possibilites)
% --------------------------------------------------
if Itest==1
    %
    % Probleme complet avc solution exacte donnee
    % -------------------------------------------
    b = 2*eps*pi^2*solex(p);
%
elseif Itest==0,
    %
    % Diffusion sans solution exacte
    % ------------------------------
    b = 0;
end,
