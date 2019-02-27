function error = H1error(node, elem, uex_x, uex_y, uh)
%==========================================================================
% Calcul de l'erreur en semi-norme H1 : $\|\nabla u - \nabla u_h\|$. 
% Approximation element fini P1, 
% L'erreur H1 est en $O(h)$, 
%
% Appel : error = computeH1error(node,elem,@u_x,@u_y,uh);
%
% Input
% =====
%    node,elem : noeuds et elements du maillage
%    u_x, u_y  : derivees partielles de la solution exacte exact u
%    uh        : fonction elements finis (solution discrete)
%
%==========================================================================
%
% Gradient de la solution discrete
% ================================
[Duh,area] = gradient(node,elem,uh);
%
% Barycentres des elements
% ========================
centroid = (node(elem(:,1),:)+node(elem(:,2),:)+node(elem(:,3),:))/3;
%
% Gradient au Barycentre
% ======================
Du = [uex_x(centroid),uex_y(centroid)];
%
error = sum([area,area].*(Du-Duh).^2,2);
%
% exclude singular point
% ----------------------
error(isnan(error)) = 0; 
error = sqrt(sum(error));
%
end