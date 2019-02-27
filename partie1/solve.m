function U = solve(A,B,C,U0,U1);
U = A\(B*U1+C*U0);