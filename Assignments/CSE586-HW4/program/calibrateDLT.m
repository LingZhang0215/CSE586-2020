function [K,Pose]=calibrateDLT(Pworldpts, Pimagepts)
mat = [];
%U,V,W ->Col 1, 2 ,3


for i = 1: size(Pworldpts,2)
    col_1 = [Pworldpts(1,i) Pworldpts(2,i) Pworldpts(3,i) 1 0 0 0 0 -Pworldpts(1,i)*Pimagepts(1,i)... 
        -Pworldpts(2,i)*Pimagepts(1,i) -Pworldpts(3,i)*Pimagepts(1,i) -Pimagepts(1,i)];
    col_2 = [0 0 0 0 Pworldpts(1,i) Pworldpts(2,i) Pworldpts(3,i) 1 -Pworldpts(1,i)*Pimagepts(2,i)...
        -Pworldpts(2,i)*Pimagepts(2,i) -Pworldpts(3,i)*Pimagepts(2,i) -Pimagepts(2,i)];
    mat = [mat;col_1 ; col_2];
end
[U,S,V] = svd(mat);
xmat = V(:,12);
%%
Pmat = [(xmat(1:4))';(xmat(5:8))';(xmat(9:12))'];
%% Verify one of the world point
point = Pworldpts(:,2);
point = [point;1];
P = Pmat*point;
if P(3)<0
    Pmat = -Pmat;
end
%% Separate K and Pose
Pa = Pmat(:,1:3);
Pb = Pmat(:,4);
[K,R] = rq(Pa);
t = K\Pb;
Pose = [R t];





