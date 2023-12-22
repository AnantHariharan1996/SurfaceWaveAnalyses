% Explore an analytic field 
% Consider f = x^3;
% Then nabla f = 3x^2 (i) + 0 (j);
% Then lap(f) = 6x;
close all
X = [-100:1:100];
x_spacing = X(2)-X(1);
Y = [-100:1:100];
y_spacing = Y(2)-Y(1);
[XX,YY] = meshgrid(X,Y);
XXforloop = XX(:);
YYforloop = YY(:);
f = XX.^3;

%%% Gradient

% Analytic
[FX_Analytic] = 3.*XX.^2;
[FY_Analytic] = zeros(size(XX));

% Numerical
[FX_Numerical,FY_Numerical] = gradient(f);

%%% Laplacian
Lap_Numerical = 4.*del2(f);
Lap_Analytical = 6.*XX;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
subplot(2,2,1)
scatter(XX(:),YY(:),5,FX_Analytic(:))
title('X-component of Gradient of f, Analytical')
colorbar
caxis([0 3*10^4])

subplot(2,2,2)
scatter(XX(:),YY(:),5,FY_Analytic(:))
title('Y-component of Gradient of f, Analytical')
colorbar

subplot(2,2,3)
scatter(XX(:),YY(:),5,FX_Numerical(:))
title('X-component of Gradient of f, Numerical')
colorbar
caxis([0 3*10^4])

subplot(2,2,4)
scatter(XX(:),YY(:),5,FY_Numerical(:))
title('Y-component of Gradient of f, Numerical')
colorbar


%%%%
figure(2)
subplot(1,2,1)
scatter(XX(:),YY(:),5,Lap_Numerical(:))
colorbar
title('Numerical Laplacian of f (MATLAB''s del2 function)')
caxis([-600 600])

subplot(1,2,2)
scatter(XX(:),YY(:),5,Lap_Analytical(:))
colorbar
title('Analytical Laplacian of f')
caxis([-600 600])


%%%%% Get laplacian via gauss thm
len=length(XXforloop)
% loop over every point of interest. Let's assume a regularly spaced grid. 

for ijk = 1:len
currX = XXforloop(ijk);
currY = YYforloop(ijk);
% find the closed 'loop' that encloses every point. 
% define loop as right, bottom right, down, bottom left, left, top left,
% top, top right. 

loopX = [currX+x_spacing currX+x_spacing currX currX-x_spacing ...
    currX-x_spacing currX-x_spacing currX currX+x_spacing];

loopY = [currY currY-y_spacing currY-y_spacing currY-y_spacing currY...
    currY+y_spacing currY+y_spacing currY+y_spacing];

% get the values of the gradient that we care about along these paths. 


end