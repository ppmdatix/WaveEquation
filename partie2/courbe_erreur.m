function courbe_erreur
%============================================================
%   Trace d'une courbe                                      =
% Options : ., 0, x, *, +, :, -, -- Pour la forme de Ligne  =
%         : y, m, c, r, g, b, w, k (k=noir)                 =
%============================================================
load err_max.dat; 
x=err_max(:,1);
y=err_max(:,2);
plot(x,y,'r');
TITLE('Graphe');
XLABEL('ln(h)');
YLABEL('ln(Err)');
grid

