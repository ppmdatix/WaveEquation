function postproc(connec,coord,u,uexa,erreur)
%
subplot(2,2,1)
trisurf(connec,coord(:,1),coord(:,2),uexa')
hold on
%view(-74,22);
%view(0,90);
title('Solution exacte')
%
subplot(2,2,2)
trisurf(connec,coord(:,1),coord(:,2),u')
hold on
%view(-74,22);
%view(0,90);
title('Solution approchee')
%
subplot(2,2,3)
trisurf(connec,coord(:,1),coord(:,2),erreur')
hold on
%view(-74,22);
%view(0,90);
title('Erreur')
