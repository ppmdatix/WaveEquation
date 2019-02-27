function [Uh] = fem2D_DiffInst(Nx,Ny)
%===================================================================== 
%    Du/Dt -div(\eps \Grad u ) = f,   dans \Omega,
%                            u = 0, sur \Gamma_D,
%
%      Probleme 2D (Discretisation P1) 
%
%===================================================================== 
%   DONNEES
% 
%   node    : Les coordonnees des Noeuds   
%   elem    : la connectivite des Elements 
%   codnofr : code des noeuds
% 
%   A. Zine (2018)
%
%===================================================================== 
%
figure(1); 
set(gcf,'Units','normal'); 
set(gcf,'Position',[0,0,0.5,0.6]);
%
% Parametres de Diffusion et pas de temps
% ---------------------------------------
x0 = -10; x1 = 10;
y0 = -10; y1 = 10;
eps = 1;
Dt  = 0.05;
theta = 0.25;
c = 1;
%
% Indice du Probleme Test
% -----------------------
Itest = 0;
%
% Maillage du Domaine
% -------------------
[node, elem, codnofr] = meshP1(x0,y0,x1,y1,Nx,Ny);
%
% Initilisation des variables utiles
% ----------------------------------
Nelem = size(elem,1);
Npt   = size(node,1);
%
% Numerotation des DDL
% --------------------
[Nddl, Neq] = numddl(codnofr, Npt);
% 
% Initiation de la Matrice et du Vecteur Globaux
% ----------------------------------------------
Mass = sparse(Neq,Neq);
Raid = sparse(Neq,Neq);
Rhs  = sparse(Neq,1);
%
% Calcul des Tableaux Elementaires et Assemblage
% ----------------------------------------------
for T=1:Nelem
    %
    % Recuperation des Elements du Triangle T (Noeuds et Coordonnees)
    % ---------------------------------------------------------------
    N  = elem(T,:);                 % Liste des trois points
    X1 = node(N(1),:);              % Coordonnees du premier point
    X2 = node(N(2),:);              % Coordonnees du deuxieme point
    X3 = node(N(3),:);              % Coordonnees du troisieme point
    %
    X = [X3(1) - X2(1); X1(1) - X3(1); X2(1) - X1(1)];
    Y = [X2(2) - X3(2); X3(2) - X1(2); X1(2) - X2(2)];
    %
    % Calcul de l'aire de l'elementT
    % ------------------------------
    Aire = 1/2*det([[X(3) -Y(3)];[X(1) Y(2)]]);
    %     
    % Matrices et vecteur Elementaires (Masse, Diffusion, Source)
    % -----------------------------------------------------------
    M  = matmass(Aire);
    D  = matdiff(Aire, X, Y);
    bT = secmem(Itest, Aire, eps, X1, X2, X3);
    % 
    % Assemblage des Matrice (Mass et Raideur) et Source
    % --------------------------------------------------
    Mass = assemb_mat(N, Nddl, M, Mass);
    Raid = assemb_mat(N, Nddl, D, Raid);
    Rhs  = assemb_rhs(N, Nddl, bT, Rhs);
    %
end
%
% Matrice d iteration (A = M + eps*Dt*K) et (Rhs = Dt*Rhs) 
% --------------------------------------------------------
MatrA = Mass + Dt*Dt*theta*c*Raid;
MatrB = 2*Mass-Dt*Dt*(1-2*theta)*Raid;

Rhs  = Dt*Rhs;
%
% Initialisation de la Solution et Debut des Iterations en Temps
% ==============================================================      
Up       = U0(node, Npt, Nddl); 
Up1 = Up;

Maxitert = 100; itert = 0; Tps = 0;
tol      = 0.0001;
Converg  = false;
%
while itert <= Maxitert && ~Converg
      %
      % Mise à jour du second membre ( Vect = Vect + M*Up)
      % --------------------------------------------------
      Vect = MatrB*Up1' - MatrA*Up';
      %
      % Resolution et Calcul de l erreur relative
      % -----------------------------------------
      U     = MatrA\Vect;
      Errel = norm(U - Up')/norm(U);
      %
      % Mise a jour de la solution 
      % --------------------------
      Up = Up1;
      Up1 = U';
      %
      % Test d arret
      % ------------
      if Errel <= tol 
         Converg = true;
      else
         fprintf('\n Err_Rel %f en %4d iterations ',Errel, itert)
         itert = itert + 1;
         Tps   = Tps + Dt;
     end
end
%
% Stockage de la solution
% -----------------------

Uh = sol(Npt, U, Nddl)';
%
%=========================================================================
%             Cas Test : Solution Exacte  et  Calcul de l'Erreur
%=========================================================================
if Itest == 1
   Uexa = solex(node);
   %
   % Calcul de la norme max de l erreur 
   % ----------------------------------
   Err     = Uexa - Uh;
%   Errmax  = norm(Err,inf);
   %
   % Calcul de la norme L2 et H1 de l erreur 
   % ---------------------------------------
   ErrL2 = L2error(node, elem, @solex, Uh);
   ErrH1 = H1error(node, elem, @uex_x, @uex_y, Uh);
   fprintf('Err H1: %4d  Err L2: %4d  \n', ErrH1, ErrL2);
   %
   % Representation Graphique 
   % ------------------------
   postproc(elem, node, Uh, Uexa, Err);
else
%
%=========================================================================
%                       Pas de Solution exatcte
%=========================================================================
   show_sol(elem,node,Uh);
   %
end
