function [Du,area,normal] = gradient(node,elem,u)
% GRADIENT compute $\nabla u$ for a finite element function u.
%
%   [Du,area] = gradient(node,elem,u);
%   [Du,area,normal] = gradient(node,elem,u);
%
% Output
%   area: are of each triangle
%   normal(1:NT,1:2,1:3): scaled normal vector of each edge. The magnutuide
%    of normal(t,:,i) is the length of i-th edge of t.
%--------------------------------------------------------------------------
% Copyright (C) 2008 Long Chen. See COPYRIGHT.txt for details.
%--------------------------------------------------------------------------

ve1 = node(elem(:,3),:)-node(elem(:,2),:); 
normal(:,:,1) = [-ve1(:,2), ve1(:,1)];
ve2 = node(elem(:,1),:)-node(elem(:,3),:); 
normal(:,:,2) = [-ve2(:,2), ve2(:,1)];
ve3 = node(elem(:,2),:)-node(elem(:,1),:); 
normal(:,:,3)= [-ve3(:,2), ve3(:,1)];
area = 0.5*abs(-ve3(:,1).*ve2(:,2)+ve3(:,2).*ve2(:,1));
dudx = (u(elem(:,1)).*normal(:,1,1) + u(elem(:,2)).*normal(:,1,2) ...
      + u(elem(:,3)).*normal(:,1,3))./(2*area);
dudy = (u(elem(:,1)).*normal(:,2,1) + u(elem(:,2)).*normal(:,2,2) ...
      + u(elem(:,3)).*normal(:,2,3))./(2*area);         
Du = [dudx, dudy];
%------------------- End of function GRADIENT -----------------------------
end