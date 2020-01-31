% /* ==============================================================
% //Module:back_maxpool.m
% //
% //Input Variables:
% //x: 2m*2n matrix
% //dzdy: m*n matrix
% //
% //Returned Results:
% //dzdx
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/
function dzdx = back_maxpool(x,y,dzdy)

dzdx = zeros(size(x,1),size(x,2));
for i = 1:size(x,1)
    for j = 1:size(x,2)
        if x(i,j) == y(floor((i+1)/2),floor((j+1)/2))
            dzdx(i,j) = dzdy(floor((i+1)/2),floor((j+1)/2));

        end
    end
end
return 
            
        
        