function [Nddl, Neq, Nfix] = numddl(codnfr, Npt)
%==============================================================================
%          Numerotation des DDL
%==============================================================================
%
Neq  = 0;
Nfix = 0;
for No=1:Npt
    Icod = codnfr(No);
    if( Icod == 0 ) 
        Neq = Neq + 1;
        Nddl(No) = Neq;
    end;
    if( Icod == 1 )
        Nfix = Nfix - 1;
        Nddl(No) = Nfix;
    end;
end;
