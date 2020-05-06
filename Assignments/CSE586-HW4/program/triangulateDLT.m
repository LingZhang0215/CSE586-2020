function [predicted,distances] = triangulateDLT(K1,Pose1,Pimagepts1,K2,Pose2,Pimagepts2)
R1 = Pose1(:,1:3);
t1 = Pose1(:,4);
R2 = Pose2(:,1:3);
t2 = Pose2(:,4);
%%
add1 = ones(1,size(Pimagepts1,2));
point1 = [Pimagepts1;add1];
% Pw1 = R1'*inv(K1)* point1- R1'*t1;
% 
add2 = ones(1,size(Pimagepts2,2));
point2 = [Pimagepts2;add2];
% Pw2 = R2'*inv(K2)* point2 - R2'*t2;

C1 = -R1'*t1;
C2 = -R2'*t2;
U1 = (R1'*inv(K1)*point1)/norm(R1'*inv(K1)*point1);
U2 = (R2'*inv(K2)*point2)/norm(R2'*inv(K2)*point2);
U1U2 = cross(U1,U2);
U3 = U1U2./sqrt(U1U2.^2);

a = zeros(1,size(Pimagepts1,2));
d = zeros(1,size(Pimagepts1,2));
b = zeros(1,size(Pimagepts1,2));
for i = 1:size(Pimagepts1,2)
    x = [U1(:,i) U3(:,i) U2(:,i)]\(C2-C1);
    a(i) = x(1);
    d(i) = x(2);
    b(i) = -x(3);
end
P1 = C1 + U1.*a;
P2 = C2 + U2.*b;
predicted = (P1+P2)/2;
distances = abs(d);



