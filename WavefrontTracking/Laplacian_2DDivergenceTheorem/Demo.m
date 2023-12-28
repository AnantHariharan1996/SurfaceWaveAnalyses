% Explore an analytic field 
% Consider f = x^3;
% Then nabla f = 3x^2 (i) + 0 (j);
% Then lap(f) = 6x;
close all
X = [-50:1:50];
x_spacing = X(2)-X(1);
Y = [-50:1:50];
y_spacing = Y(2)-Y(1);
[XX,YY] = meshgrid(X,Y);
XXforloop = XX(:);
YYforloop = YY(:);
forig =  XX.^3;
f = forig+80*rand(size(forig));

figure(100)
subplot(1,2,1)
scatter(XXforloop,YYforloop,5,forig(:),'filled')
title('Scalar field f')
subplot(1,2,2)
scatter(XXforloop,YYforloop,5,f(:),'filled')
title('Scalar field f with noise')

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
scatter(XX(:),YY(:),5,FX_Analytic(:),'filled')
title('X-component of Gradient of f, Analytical')
colorbar
caxis([0 0.5*10^4])

subplot(2,2,2)
scatter(XX(:),YY(:),5,FY_Analytic(:),'filled')
title('Y-component of Gradient of f, Analytical')
colorbar

subplot(2,2,3)
scatter(XX(:),YY(:),5,FX_Numerical(:),'filled')
title('X-component of Gradient of f, Numerical')
colorbar
caxis([0 0.5*10^4])

subplot(2,2,4)
scatter(XX(:),YY(:),5,FY_Numerical(:),'filled')
title('Y-component of Gradient of f, Numerical')
colorbar




%%%%% Get laplacian via 2D divergence theorem
len=length(XXforloop)
% loop over every point of interest. Let's assume a regularly spaced grid. 
output = NaN*zeros(size(XXforloop));
for ijk = 1:len
    100*ijk/len
currX = XXforloop(ijk);
currY = YYforloop(ijk);

% we want to query the (gradient) vector field at the 4 points
% east,south,west,north of the central point.

East_X = currX+x_spacing;
East_Y = currY;

South_X = currX;
South_Y = currY-y_spacing;

West_X = currX-x_spacing;
West_Y = currY;

North_X = currX;
North_Y = currY+y_spacing;

Edx = find(XXforloop == East_X & YYforloop == East_Y);
Sdx = find(XXforloop == South_X & YYforloop == South_Y);
Wdx = find(XXforloop == West_X & YYforloop == West_Y);
Ndx = find(XXforloop == North_X & YYforloop == North_Y);


if isempty(Edx) || isempty(Sdx) || isempty(Wdx) || isempty(Ndx)
% then there aren't surrounding points and the contour integral is
% undefined.

% do nothing. 
output(ijk) = NaN;

else
% North: Only multiply by the positivit y-component of the field. 
N_int = FY_Numerical(Ndx);
% East: Only multiply by the positive x-component of the field. 
E_int = FX_Numerical(Edx);
% South: Only multiply by the negative y-component of the field. 
S_int = -1*FY_Numerical(Sdx);
% West: Only multiply by the negative x-component of the field. 
W_int = -1*FX_Numerical(Wdx);
PathInt = N_int + E_int + S_int + W_int;
output(ijk) = PathInt/2;
end

end




%%%%
figure(2)
subplot(1,3,1)
scatter(XX(:),YY(:),5,Lap_Numerical(:),'filled')
colorbar
title('Numerical Laplacian of f (MATLAB''s del2 function)')
caxis([-300 300])

subplot(1,3,2)
scatter(XX(:),YY(:),5,Lap_Analytical(:),'filled')
colorbar
title('Analytical Laplacian of f')
caxis([-300 300])

subplot(1,3,3)
scatter(XX(:),YY(:),5,output(:),'filled')
colorbar
title('Numerical Laplacian of f (Contour Integral/Gauss Thm.)')
caxis([-300 300])