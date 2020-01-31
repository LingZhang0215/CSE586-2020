% /* ==============================================================
% //Module:forw_maxpool.m
% //
% //Input Variables:
% //x: 2m*2n matrix
% //
% //Returned Results:
% //y: m*n matrix
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/
function y = forw_maxpool(x)
num_of_row = size(x,1)/2;
num_of_col = size(x,2)/2;
y = zeros(num_of_row,num_of_col);
for i = 1:num_of_row
    for j = 1:num_of_col
        y(i,j) = max([x(2*i-1,2*j-1) x(2*i-1,2*j) x(2*i,2*j-1) x(2*i,2*j)]);
    end
end
return
