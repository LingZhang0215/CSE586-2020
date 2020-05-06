function [r,q]=rq(a)
% RQ [r,q]=rq(a) factorises 3x3 matrix a such that a=rq where r is 
% an upper triangular matrix and q is a rotation matrix.

[m,n]=size(a);
e=eye(m);
p=e(:,[m:-1:1]);
[q0,r0]=qr(p*a(:,1:m)'*p);

r=p*r0'*p;
q=p*q0'*p;

fix=diag(sign(diag(r)));
r=r*fix;
q=fix*q;

return