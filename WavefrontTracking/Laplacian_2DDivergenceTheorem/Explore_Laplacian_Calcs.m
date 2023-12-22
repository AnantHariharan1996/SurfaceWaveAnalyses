clear; clc; close all;

%%%%%%%%%%%%%%%%%%%%%%
% SETUP PARAMS HERE
%%%%%%%%%%%%%%%%%%%%%%
phvel=4;
X = [-100:1:100];
Y = [-100:1:100];
sourcex=500;sourcey=0;
%%%%%%%%%%%%%%%%%%%%%%
[XX2,YY2] = meshgrid(X,Y);
XX=XX2(:);
YY=YY2(:);
distlist = sqrt((XX-sourcex).^2+(YY-sourcey).^2);
distlist_2d = sqrt((XX2-sourcex).^2+(YY2-sourcey).^2);
ttime = distlist./phvel;
ttime_2d = distlist_2d./phvel;
Lap_time = del2(ttime_2d,1);

figure(1)
subplot(1,2,1)
scatter(XX,YY,5,distlist,'filled')
title('Distance from source(km)')
colorbar
subplot(1,2,2)
scatter(XX,YY,5,ttime,'filled')
title('Travel time (s)')
colorbar

% Calculate the laplacian
figure(2)
scatter(XX,YY,5,Lap_time(:),'filled')
title('Laplacian of travel time')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[FX,FY] = gradient(ttime_2d);

% loop over points, find the points around each one. 


