clear all;

L = 2;
T = 4;
theta = 1.0;
c = 3 ;
Nx = 100; % nb pas espace
Nt = 1000; % nb pas temps
dt = T/Nt;
dx = 2*L/(Nx+1);
mu = c*(dt/dx);
x=linspace(-L,L,Nx+2); 


%Sans conditions
L = Laplace(Nx);
L(Nx+2,Nx+2)=1;
A = eye(Nx+2) + mu^2*theta*L;
B = 2*eye(Nx+2)-mu^2*(1-2*theta)*L;
C = - A;

%Conditions de Dirichlet
% L = Laplace(Nx);
% L(1,:)=0;
% L(:,1)=0;
% L(Nx+2,:)=0;
% L(:,Nx+2)=0;
% L(1,1)=1;
% L(Nx+2,Nx+2)=1;
% A = eye(Nx+2) + mu^2*theta*L;
% B = 2*eye(Nx+2)-mu^2*(1-2*theta)*L;
% C = - A;

%Conditions de Sommerfeld
% L = Laplace(Nx);
% A = eye(Nx+2) + mu^2*theta*L;
% A(1,1)=1+mu;
% A(1,2)=-mu;
% A(Nx+2,Nx+1)=-mu;
% A(Nx+2,Nx+2)=1+mu;
% B = 2*eye(Nx+2)- mu^2*(1-2*theta)*L;
% B(1,:)=0;
% B(1,1)=1;
% B(1,2)=0;
% B(Nx+2,:)=0;
% B(Nx+2,Nx+2)=1;
% C = - A;
% C(1,:)=0;
% C(Nx+2,:)=0;



% U0 init 
U0 = zeros(1,Nx+2);
for i=1:length(U0)
    if x(i)>-1 && x(i)<1
        U0(i)=exp(-1/(1-x(i)^2));
    end
end;
U0 = transpose(U0);

U1 = U0;

U(:,1)=U0;
U(:,2)=U1;

%Video
for i=1:Nt
    %plot(x,U(:,i));
    U(:,i+2)=solve(A,B,C,U(:,i),U(:,i+1));
    pause(0.1);
end

%Surface
surf(U);

