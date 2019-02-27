function [Matr] = assemb_mat(N, Nddl, AT, Matr)
%==========================================================================
%  fonctin : assemblage de la matrice globale
%
%==========================================================================
%
% Boucle sur les noeuds de l'Element
% ==================================   
for p=1:3
    i  = Nddl(N(p));
    if( i > 0 )
        for m=1:3
            j=Nddl(N(m));                
            if( j > 0 )
%                    
%...........    Assemblage de la Matrice
%               ========================           
                Matr(i,j) = Matr(i,j) + AT(p,m);
%
            end 
        end    
    end    
end  
 