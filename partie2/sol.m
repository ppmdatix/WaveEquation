function Uh = sol(Npt, X, Nddl)
%
for No=1:Npt;
    i = Nddl(No);
    if( i > 0 )
        Uh(No) = X(i);
    elseif ( i < 0 )
        Uh(No) = 0;
    end;
end;
