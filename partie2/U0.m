function Uh = U0(Vect, Npt, Nddl)
%====================================================================================
%
%  solution initiale
%====================================================================================
%X = Vect(:,1);
%Y = Vect(:,2);
%
%Uh = sin(pi*X).*sin(pi*Y);
%
for No=1:Npt;
    i = Nddl(No);
    if( i > 0 )
        Uh(i) = exp(-2*(Vect(No,1)*Vect(No,1) + Vect(No,2)*Vect(No,2)));
    end;
end;

%
%ExactSol = X.^2 + Y.^2;
%r=sqrt(x.^2+y.^2);
%ExactSol  =-log(r)/2/pi;
%ExactSol  = Y.*exp(-X.^4 - Y.^4);
%ExactSol  = (X - 1).^2 + 10*(X.^2 - Y).^2;
%Z = Y.*(Y-1).*(X-1);
%

