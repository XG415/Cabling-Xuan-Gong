AA = total_cost_string_structure;
BB = total_cost_ring_structure;
CC = total_cost_multi_loop_structure;
bb = 50;

for i = 1:bb
    for j= 1:bb
   DD = [AA(i,j),BB(i,j),CC(i,j)];
   [aa,cc] = min(DD);
   EE(i,j) = aa;
   if cc==1
   FF(i,j,1) = 0;
   FF(i,j,2) = 1;
   FF(i,j,3) = 0;
   elseif cc==2
   FF(i,j,1) = 1;
   FF(i,j,2) = 1;
   FF(i,j,3) = 0;
   else
       FF(i,j,1) = 1;
       FF(i,j,2) = 0;
       FF(i,j,3) = 0;
   end
       
    end
end 
figure(10)
xx = 0.0008+(0:bb-1) * (0.015-0.0008)/(bb-1);
yy = 30*24 + (0:bb-1) * (3 * 30 * 24-30*24)/(bb-1);
[XX,YY] = meshgrid(xx,yy);
surf(XX,YY,EE,FF);
xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
zlabel('total cost(pound£©')
title('Best choice')

figure(11)
surf(XX,YY,EE,FF);
view(0,90)
xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
title('Best choice')