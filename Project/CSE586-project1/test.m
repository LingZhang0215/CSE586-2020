
% /* ==============================================================
% //Module:test.m
% //Test all the functions with simple test case.
% //
% //Author:Ling Zhang//Date:01/29/2020
% // ===============================================================*/


%% Test relu backward
%%%%%% X: m*n matrix 
%%%%%% dzdy: m*n matrix
% Test case:
X = [1 2 3; -1 -2 -3]
dzdy = [1 2 3; 2 3 4]

eps = 1.0e-6;
dzdxnumeric = zeros(size(X,1),size(X,2));
Y = forw_relu(X);
for i=1:size(X,1)
    for j=1:size(X,2)
        newim = X;
        newim(i,j) = newim(i,j)+eps;
        yprime = forw_relu(newim);
        deriv = (yprime-Y)/eps;       
        dzdxnumeric(i,j) = dot(deriv(:),dzdy(:));
    end
end
dzdx = back_relu(X,Y,dzdy);
%we will just compare them by eye
%this could be more fancy, like computing max abs diff between the two
fprintf('comparison of analytic and numerical derivs conv backprop\n');
dzdx
dzdxnumeric



%% Test max_pool backward
%%%%%% X:2m*2n matrix
%%%%%% dzdy:m*n matrix
% Test case:
X =[1 2 3 4; 5 6 7 8]
dzdy = [1 3]
eps = 1.0e-6;
dzdxnumeric = zeros(size(X,1),size(X,2));
Y = forw_maxpool(X);
for i=1:size(X,1)
    for j=1:size(X,2)
        newim = X;
        newim(i,j) = newim(i,j)+eps;
        yprime = forw_maxpool(newim);
        deriv = (yprime-Y)/eps;       
        dzdxnumeric(i,j) = dot(deriv(:),dzdy(:));
    end
end

dzdx = back_maxpool(X,Y,dzdy);
%we will just compare them by eye
%this could be more fancy, like computing max abs diff between the two
fprintf('comparison of analytic and numerical derivs conv backprop\n');
dzdx
dzdxnumeric

%% Test softmax backward
%%%%%% X:m*1 matrix
%%%%%% dzdy:m*1 matrix
% Test case:
X =[1;2;3;6]
dzdy = [2;3;4;5]
eps = 1.0e-6;
dzdxnumeric = zeros(size(X));
Y = forw_softmax(X);
for i=1:size(X,1)
    for j=1:size(X,2)
        newim = X;
        newim(i,j) = newim(i,j)+eps;
        yprime = forw_softmax(newim);
        deriv = (yprime-Y)/eps;
        %similar to above, deriv = dY/dxij, the deriv of all Y  wrt one xij value
        %we dot product that with deriv of z wrt all Y values, thus 
        %summing over all dz/dypq * dypq/dxij , leaving dz/dxij        
        dzdxnumeric(i,j) = dot(deriv(:),dzdy(:));
    end
end
dzdx = back_softmax(X,Y,dzdy);
%we will just compare them by eye
%this could be more fancy, like computing max abs diff between the two
fprintf('comparison of analytic and numerical derivs conv backprop\n');
dzdx
dzdxnumeric


%% Test mean_pool backward
%%%%%% X:2m*2n matrix
%%%%%% dzdy:m*n matrix
% Test case:
X =[1 2 3 4; 5 6 7 8]
dzdy = [1 3]
eps = 1.0e-6;
dzdxnumeric = zeros(size(X,1),size(X,2));
Y = forw_meanpool(X);
for i=1:size(X,1)
    for j=1:size(X,2)
        newim = X;
        newim(i,j) = newim(i,j)+eps;
        yprime = forw_meanpool(newim);
        deriv = (yprime-Y)/eps;
        %similar to above, deriv = dY/dxij, the deriv of all Y  wrt one xij value
        %we dot product that with deriv of z wrt all Y values, thus 
        %summing over all dz/dypq * dypq/dxij , leaving dz/dxij        
        dzdxnumeric(i,j) = dot(deriv(:),dzdy(:));
    end
end
dzdx = back_meanpool(X,Y,dzdy);
%we will just compare them by eye
%this could be more fancy, like computing max abs diff between the two
fprintf('comparison of analytic and numerical derivs conv backprop\n');
dzdx
dzdxnumeric

%% Test fully connected backward
%%%%%% X:m*n matrix
%%%%%% w:m*n matrix
%%%%%% bias:n scaler
%%%%%% dzdy:m*n matrix
% Test case:
X =[1 2 3 4; 5 6 7 8]
w =[9 10 1 2; 3 4 5 6]
bias = 10
dzdy = 2
%numerically compute dz/dw
eps = 1.0e-6;
dzdwnumeric = zeros(size(w));
Y = forw_fc(X,w,bias);
for i=1:size(w,1)
    for j=1:size(w,2)
        filt = w;
        filt(i,j) = filt(i,j)+eps;
        yprime = forw_fc(X,filt,bias);
        deriv = (yprime-Y)/eps;
        %note, deriv = dY/dwij, the deriv of all Y values wrt one wij value
        %we dot product that with deriv of z wrt all Y values, thus 
        %summing over all dz/dypq * dypq/dwij , leaving dz/dwij
        dzdwnumeric(i,j) = dot(deriv(:),dzdy(:));
    end
end

% numerically compute dz/dX
eps = 1.0e-6;
dzdxnumeric = zeros(size(X,1),size(X,2));
Y = forw_fc(X,w,bias);
for i=1:size(X,1)
    for j=1:size(X,2)
        newim = X;
        newim(i,j) = newim(i,j)+eps;
        yprime = forw_fc(newim,w,bias);
        deriv = (yprime-Y)/eps;
        %similar to above, deriv = dY/dxij, the deriv of all Y  wrt one xij value
        %we dot product that with deriv of z wrt all Y values, thus 
        %summing over all dz/dypq * dypq/dxij , leaving dz/dxij        
        dzdxnumeric(i,j) = dot(deriv(:),dzdy(:));
    end
end

% numerically compute dz/db
eps = 1.0e-6;
dzdbnumeric = 0;
Y = forw_fc(X,w,bias);
yprime = forw_fc(X,w,bias+eps);
deriv = (yprime-Y)/eps;
%deriv = dY/db, which we know analytically should be all 1's.
%so really, the answer we get below should just be the sum of 
%all values in dzdy
dzdbnumeric =  dot(deriv(:),dzdy(:));

[dzdx, dzdw, dzdb]=back_fc(X,w,bias,Y,dzdy);
%we will just compare them by eye
%this could be more fancy, like computing max abs diff between the two
fprintf('comparison of analytic and numerical derivs conv backprop\n');
fprintf('comparing dz/db values\n');
dzdb
dzdbnumeric
fprintf('comparing dz/dw values\n');
dzdw
dzdwnumeric
fprintf('comparing dz/dx values\n');
dzdx
dzdxnumeric
