function [coord, connec, codnofr] = meshP1(x0,y0,x1,y1,Nx,Ny)
%================================================================= 
%=  M. Zine (08/05/2008)
%=
%=                  CREATION D UN MAILLAGE P1 
%=
%=  Execution : meshP1(x0,y0,x1,y1,Nx,Ny)
%=  Parametres : Entree : x0,y0,x1,y1 geometrie, 
%                         Nx nbre de points suivant x  
%                         Ny nbre de points suivant y
%
%                Sortie : connec , tableau de connectivite des elements,
%                         coord  , tableau des coordonnees des noeuds,
%                         codnofr, tableau des codes des noeuds
%                         dir    , tableau des aretes de Dirichlet
%             
%================================================================= 
%
hx = (x1-x0)/(Nx-1);
hy = (y1-y0)/(Ny-1); 
%
Npt   = Nx*Ny;
Nelem = 2*(Nx-1)*(Ny-1);
% 
%================================================================= 
%=          Coordonnees des Noeuds 
%================================================================= 
for j=1:Ny; 
    for i=1:Nx; 
        No = (j-1)*Nx + i; 
        coord(No,1) = x0 + (i-1)*hx; 
        coord(No,2) = y0 + (j-1)*hy; 
    end 
end 
% 
%================================================================= 
%=          Connectivite des Elements 
%================================================================= 
for j=1:(Ny-1); 
    for i=1:(Nx-1); 
        K1   = 2*((j-1)*(Nx-1) + i)-1;
        K2   = 2*((j-1)*(Nx-1) + i);
        No1  = (j-1)*Nx + i; 
%        
        connec(K1,1) = No1 + 1;
        connec(K1,2) = connec(K1,1) + Nx; 
        connec(K1,3) = No1; 
%        
        connec(K2,1) = connec(K1,2) - 1; 
        connec(K2,2) = connec(K1,3); 
        connec(K2,3) = connec(K1,2); 
%
    end 
end 
%=================================================================
%=            Aretes de la Frontiere
%=================================================================
codnofr = zeros(1,Npt);
%
%Arete Numero 1
%==============
for i=1:(Nx-1);
    Arete = i;
    No1   = i;
    No2   =  No1 + 1;       
    dir(Arete,1) = No1;
    dir(Arete,2) = No2;
    codnofr(No1) = 1;
    codnofr(No2) = 1;
end
%
%Arete Numero 2
%==============
for i=1:(Ny-1);
    Arete = (Nx - 1) + i;
    No1   = Nx*i;
    No2   = No1 + Nx;      
    dir(Arete,1) = No1;
    dir(Arete,2) = No2;
    codnofr(No1) = 1;
    codnofr(No2) = 1;
end
%
%Arete Numero 3
%==============
for i=1:(Nx-1);
    Arete = Nx + Ny - 2 + i;
    No1   = Nx*Ny - (i-1);
    No2   = No1 - 1;       
    dir(Arete,1) = No1;
    dir(Arete,2) = No2;
    codnofr(No1) = 1;
    codnofr(No2) = 1;
end
%
%Arete Numero 4
%==============
for i=1:(Ny-1);
    Arete =  2*(Nx - 1) + Ny - 1 + i;
    No1   = (Ny-i)*Nx + 1;
    No2   = No1 - Nx;       
    dir(Arete,1) = No1;
    dir(Arete,2) = No2;
    codnofr(No1) = 1;
    codnofr(No2) = 1;
end
%
%================================================================= 
%=             Sauvegarde d'un Maillage 
%================================================================= 
%save coord.dat  -ascii coord ; 
%save connec.dat -ascii connec ; 
%save codnofr.dat -ascii codnofr ; 
%save dir.dat -ascii dir;
%save neum.dat -ascii neum;
%================================================================= 
%=             Visualisation du Maillage 
%================================================================= 
trimesh(connec,coord(:,1),coord(:,2),zeros(Npt,1));
hold on
view(0,90);
%pause;
