% /* ==============================================================
% //Module:back_softmax.m
% //
% //Input Variables:
% //x: m*1 matrix
% //dzdy: m*1 matrix
% //
% //Returned Results:
% //dzdx
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/
function dzdx = back_softmax(x,y,dzdy)
dydx = zeros(size(dzdy,1),size(dzdy,1));
for i = 1: size(dzdy,1)
    for j = 1:size(dzdy,1)
        if i == j 
           dydx(i,j) = y(j)*(1-y(j));
        else
           dydx(i,j) = -y(j)*y(i);
        end
    end
end
dzdx = dydx.'*dzdy;
return 
    