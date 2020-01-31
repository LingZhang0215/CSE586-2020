% /* ==============================================================
% //Module:back_relu.m
% //
% //Input Variables:
% //x: m*n matrix
% //dzdy: m*n matrix
% //
% //Returned Results:
% //dzdx
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/
function dzdx = back_relu(x,y,dzdy)
dydx = zeros(size(y,1),size(y,2));
for i = 1:size(y,1)
    for j = 1:size(y,2)
        if x(i,j)>=0
            dydx(i,j) = 1;
        else
            dydx(i,j) = 0;
        end
    end
end
dzdx = dydx.*dzdy;
return
        