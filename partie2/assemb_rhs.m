function [Vect] = assemb_rhs(N, Nddl, bT, Vect)
%==========================================================================
%  fonctin : assemblage de la matrice globale
%
%==========================================================================
%
% Boucle sur les noeuds de l'Element
% ==================================   
for p=1:3
    i = Nddl(N(p));   
    if( i > 0 )
%
%.......Assemblage du Vecteur
%       ---------------------
        Vect(i) = Vect(i) + bT(p);
%
    end    
end  
 