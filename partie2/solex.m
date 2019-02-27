function ExactSol = solex(vect)
%
X = vect(:,1);
Y = vect(:,2);
ExactSol = sin(pi*X).*sin(pi*Y);
%
%
%ExactSol = X.^2 + Y.^2;
%r=sqrt(x.^2+y.^2);
%ExactSol  =-log(r)/2/pi;
%ExactSol  = Y.*exp(-X.^4 - Y.^4);
%ExactSol  = (X - 1).^2 + 10*(X.^2 - Y).^2;
%Z = Y.*(Y-1).*(X-1);
