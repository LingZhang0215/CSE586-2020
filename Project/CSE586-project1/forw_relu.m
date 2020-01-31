% /* ==============================================================
% //Module:back_relu.m
% //
% //Input Variables:
% //x: m*n matrix
% //
% //Returned Results:
% //y: m*n matrix
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/
function y = forw_relu(x)
y = max(x,0);
return