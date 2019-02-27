function SHOWMESH(CONNEC,COORD)
hold off
trisurf(CONNEC,COORD(:,1),COORD(:,2))
hold on
view(-67.5,30);
title('Maillage')
