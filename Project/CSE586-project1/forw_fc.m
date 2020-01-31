% /* ==============================================================
% //Module:forw_fc.m
% //
% //Input Variables:
% //x: m*n matrix
% //w: m*n matrix
% //b: scaler
% //
% //Returned Results:
% //y: scaler
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/
function y = forw_fc(x,w,b)
y = sum(sum(w.*x)) + b;
return