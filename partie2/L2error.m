function error = L2error(node, elem, uexact, uh)
%==========================================================================
% Calcul de l erreur L2. Approximation element fini P1, 
% L erreur L2 est en $O(h^2)$, 
%
% Appel : error = L2error(node,elem,@uexact,uh)
%
% Input
% =====
%    node,elem : noeuds et elements du maillage
%    uexact    : solution exacte
%    uh        : fonction elements finis (solution discrete)
%
%==========================================================================
%
% Aires des Triangles
% -------------------
ve2  = node(elem(:,1),:)-node(elem(:,3),:);
ve3  = node(elem(:,2),:)-node(elem(:,1),:);
area = 0.5*abs(-ve3(:,1).*ve2(:,2)+ve3(:,2).*ve2(:,1));
%
% Valeurs aux Milieux des Aretes
% ------------------------------
u1 = uexact((node(elem(:,2),:)+node(elem(:,3),:))/2);
u2 = uexact((node(elem(:,3),:)+node(elem(:,1),:))/2);
u3 = uexact((node(elem(:,1),:)+node(elem(:,2),:))/2);
%
uh1 = (uh(elem(:,2)) + uh(elem(:,3)))/2;
uh2 = (uh(elem(:,3)) + uh(elem(:,1)))/2;
uh3 = (uh(elem(:,1)) + uh(elem(:,2)))/2;
%
% Calcul de l'Erreur avec une Quadrarure a 3 points
% -------------------------------------------------
error = ((u1-uh1).^2 + (u2-uh2).^2 + (u3-uh3).^2)/3;
%
% singular point is excluded
% --------------------------
error(isnan(error)) = 0; 
error = sqrt(sum(area.*error));
%
end
