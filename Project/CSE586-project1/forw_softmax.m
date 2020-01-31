% /* ==============================================================
% //Module:forw_softmax.m
% //
% //Input Variables:
% //x: m*1 vector
% //
% //Returned Results:
% //y: m*1 vector
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/
function y = forw_softmax(x)
y = zeros(size(x));
for i = 1:size(x,1)
    y(i) = exp(x(i))/sum(exp(x));
end
return