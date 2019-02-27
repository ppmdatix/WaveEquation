function show_sol(connec,coord,u)
display(size(u));
hold on
trisurf(connec,coord(:,1),coord(:,2),u')
view(0,0);
title('Solution Exacte ')
