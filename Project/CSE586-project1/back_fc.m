% /* ==============================================================
% //Module:back_fc.m
% //
% //Input Variables:
% //x: m*n matrix
% //w: m*n matrix
% //b: scaler
% //dzdy: scaler
% //
% //Returned Results:
% //dzdx, dzdw and dzdb
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/
function [dzdx, dzdw, dzdb]=back_fc(x,w,b,y,dzdy)
dzdb = dzdy;
dzdx = w*dzdy;
dzdw = x*dzdy;
return
