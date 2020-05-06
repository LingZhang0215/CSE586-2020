
%--------
% Starter code for the applied problems in Homework 4
% You need to write the functions:
%   calibrateDLT
%   triangulateDLT
% And you will need to choose a reasonable value for:
%   USERCHOSENTHRESHOLD
% to filter out bad triangulated points.


clear all; close all
I1 = rgb2gray(imread('rubik1.jpg'));
I2 = rgb2gray(imread('rubik2.jpg'));
load rubikPoints.mat

numpts = size(Pworldpts,2);

[K1,Pose1] = calibrateDLT(Pworldpts,Pimagepts1);
[K2,Pose2] = calibrateDLT(Pworldpts,Pimagepts2);

%% test out the projection
predpts = K1 * Pose1 * [Pworldpts; ones(1,numpts)];
accum = 0;
for i=1:numpts
    predpts(:,i) = predpts(:,i) / predpts(3,i);
    err = norm(predpts(1:2,i)-Pimagepts1(1:2,i));
    accum = accum+err*err;
end
rms = sqrt(accum/numpts);
fprintf('RMS err in image 1 is %.3f\n',rms);
figure(1); colormap(gray); clf; imagesc(I1);
hold on
plot(Pimagepts1(1,:),Pimagepts1(2,:),'yo');
plot(predpts(1,:),predpts(2,:),'b*');
hold off
drawnow

predpts = K2 * Pose2 * [Pworldpts; ones(1,numpts)];
accum = 0;
for i=1:numpts
    predpts(:,i) = predpts(:,i) / predpts(3,i);
    err = norm(predpts(1:2,i)-Pimagepts2(1:2,i));
    accum = accum+err*err;    
end
rms = sqrt(accum/numpts);
fprintf('RMS2 err in image 2 is %.3f\n',rms);
figure(2); colormap(gray); clf; imagesc(I2);
hold on
plot(Pimagepts2(1,:),Pimagepts2(2,:),'yo');
plot(predpts(1,:),predpts(2,:),'b*');
hold off
drawnow

%% --------
%test out triangulation of model points

[predicted, distances] = triangulateDLT(K1,Pose1,Pimagepts1,K2,Pose2,Pimagepts2);

figure(3); clf; 
plot3(Pworldpts(1,:),Pworldpts(2,:)',Pworldpts(3,:)','ro','LineWidth',2);
hold on
plot3(predicted(1,:)',predicted(2,:)',predicted(3,:)','b*','LineWidth',2);
hold off
drawnow
rotate3d on
axis equal

accum = 0;
for i=1:numpts
    err = norm(predicted(1:3,i)-Pworldpts(1:3,i));
    accum = accum+err*err;
end
rms = sqrt(accum/numpts);
fprintf('RMS err for 5(a) is %.3f\n',rms);

% %% --------
% %get data for doing triangulation of new point matches
% 
% %extract keypoints
% points1 = detectKAZEFeatures(I1);
% points2 = detectKAZEFeatures(I2);
% %extract neighborhood feature vectors
% [features1,valid_points1] = extractFeatures(I1,points1);
% [features2,valid_points2] = extractFeatures(I2,points2);
% %initial attempt to match the features.
% indexPairs = matchFeatures(features1,features2);
% %retrieve the locations of the corresponding points for each image.
% matchedPoints1 = valid_points1(indexPairs(:,1),:);
% matchedPoints2 = valid_points2(indexPairs(:,2),:);
% xypoints1 = matchedPoints1.Location;
% xypoints2 = matchedPoints2.Location;
% %Visualize the corresponding points
% redcyan = I1;
% redcyan(:,:,2) = I2;
% redcyan(:,:,3) = I2;
% figure(4); clf; imagesc(redcyan); hold on
% for i=1:size(xypoints1,1)
%     x1 = xypoints1(i,1);
%     y1 = xypoints1(i,2);
%     x2 = xypoints2(i,1);
%     y2 = xypoints2(i,2);    
%     plot([x1 x2],[y1 y2],'-','LineWidth',2,'Color',rand(1,3));
% end
% hold off
% drawnow
% %reshape so each point is a column
% newpoints1 = xypoints1';
% newpoints2 = xypoints2';
% 
% %NOTE: in case you can't run the above feature extraction and matching code
% %(for example if you don't have most recent version of matlab), I have
% %included the arrays newpoints1 and newpoints2 in the rubikPoints.mat file.
% 
% 
% %now do triangulation on the new, matched points
% [predicted, distances] = triangulateDLT(K1,Pose1,newpoints1,K2,Pose2,newpoints2);
% 
% %show all points including outliers
% figure(5); clf; hold on
% plot3(Pworldpts(1,:),Pworldpts(2,:)',Pworldpts(3,:)','ro','LineWidth',2);
% hold on
% plot3(predicted(1,:)',predicted(2,:)',predicted(3,:)','b*','LineWidth',2);
% hold off
% drawnow
% rotate3d on
% axis equal
% 
% %try to filter out outliers by distance between their viewing rays (as 
% %measured in world coordinates). Play around with different threshold 
% %values to get a feel for what a good threshold might be for this data.
% %Alternatively, choose a threshold based on the scale of the model, or as
% %a multiple of the mean distances that were achieved when triangulating 
% %the 37 rubik's cube model points above.
% USERCHOSENTHRESHOLD = Inf;
% goodind = find(distances < USERCHOSENTHRESHOLD);
% figure(6); clf; hold on
% plot3(Pworldpts(1,:),Pworldpts(2,:)',Pworldpts(3,:)','ro','LineWidth',2);
% hold on
% plot3(predicted(1,goodind)',predicted(2,goodind)',predicted(3,goodind)','b*','LineWidth',2);
% hold off
% drawnow
% rotate3d on
% axis equal
% 
% 
% 
% 
% 
% 
% 
%% Calculate X,Y axis for both camera
im = imread('rubik1.jpg');
W = size(im,1);
H = size(im,2);
K1_norm = K1./K1(3,3);
K2_norm = K2./K2(3,3);
fx_1 = K1_norm(1,1);
fy_1 = K1_norm(2,2);
fx_2 = K2_norm(1,1);
fy_2 = K2_norm(2,2);
Fov_x_1 = 2*atan(W/(2*fx_1));
fprintf("field of view of camera1 horizontal is %.3f\n",Fov_x_1);
Fov_y_1 = 2*atan(H/(2*fy_1));
fprintf("field of view of camera1 vertical is %.3f\n",Fov_y_1);

Fov_x_2 = 2*atan(W/(2*fx_2));
fprintf("field of view of camera2 horizontal is %.3f\n",Fov_x_2);
Fov_y_2 = 2*atan(H/(2*fy_2));
fprintf("field of view of camera2 vertical is %.3f\n",Fov_y_2);