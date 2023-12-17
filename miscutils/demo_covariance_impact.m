%% Do some synthetic inversions to solve least-squares under different conditions
clear; close all; clc;

Synthetic_x = [1 2 2 3 3 3];
Synthetic_y = [1 2 3 3 2 2];
% the last three data points are the ones that are outliers.
% Also, the last two data points are duplicates. 

% Make G Matrix. 
for ijk = 1:length(Synthetic_x)
    currx=Synthetic_x(ijk);
G(ijk,:) = [currx 1];
end

%% Now, run the inversion with different covariance matrices!
Cd = zeros([length(Synthetic_y) length(Synthetic_y)]);

% Case with only diagonal weighting
Cd_diagonal_allequalweight = Cd+eye(size(Cd));
We=inv(Cd_diagonal_allequalweight);
m_diagonal_allequalweight = inv(G'*We*G)*G'*We*Synthetic_y';
dpred_diagonal_allequalweight = G*m_diagonal_allequalweight;


% Case with only diagonal weighting, but alternate terms weighted less
Cd_diagonal_unequalweight = Cd+eye(size(Cd));
Cd_diagonal_unequalweight(5,5) = (2);
Cd_diagonal_unequalweight(6,6) = (2);
We=inv(Cd_diagonal_unequalweight);
m_diagonal_unequalweight = inv(G'*We*G)*G'*We*Synthetic_y';
dpred_diagonal_unequalweight = G*m_diagonal_unequalweight;

% Case with only off-diagonal information. 
Cd_offdiagonal = Cd+eye(size(Cd));
Cd_offdiagonal(5,6) = 1;
%Cd_offdiagonal(6,5) = 2;
We=inv(Cd_offdiagonal);
m_offdiagonal =  inv(G'*We*G)*G'*We*Synthetic_y';
dpred_offdiagonal = G*m_offdiagonal;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plotting below here
for ijk = 1:length(Synthetic_x)
currx =Synthetic_x(ijk);
curry =Synthetic_y(ijk);
idx = find(Synthetic_x == currx & Synthetic_y == curry);
if ijk == 1
p1=scatter(currx,curry,250,length(idx),'filled');
else
scatter(currx,curry,250,length(idx),'filled');
end
hold on
end
barbar=colorbar;
xlabel('X (arbitrary units)')
ylabel('Y (arbitrary units)')
ylabel(barbar,'N(points)')
set(gca,'fontsize',20,'fontweight','bold')
grid on; box on;
barbar.Ticks = [1 2]
p2=plot(Synthetic_x,dpred_diagonal_allequalweight,'linewidth',4)
p3=plot(Synthetic_x,dpred_diagonal_unequalweight,'linewidth',4)
p4=plot(Synthetic_x,dpred_offdiagonal,'linewidth',4,'linestyle','--')

legend([p1 p2 p3 p4],'Raw Data','Constant Diagonal Covariance Matrix',...
    'Diagonal Covariance Matrix Terms Upweighted 2x',...
    'Constant Diagonal Terms, NonZero Off-diagonal Term','location','south')


colormap(parula(2))
set(gcf,'position',[228 246 751 579])
saveas(gcf,'Demo_Impact_Different_CovMatrix.jpg')
saveas(gcf,'Demo_Impact_Different_CovMatrix.png')