%% C_Generate Model Suite for Grid search

SuiteCounter=0;
[V1GRD,V2GRD,V3GRD,V4GRD,V5GRD,V6GRD,V7GRD,V8GRD] = ndgrid(GridSearchRanges(1).Vs2Perturb,...
    GridSearchRanges(2).Vs2Perturb,GridSearchRanges(3).Vs2Perturb,GridSearchRanges(4).Vs2Perturb,...
    GridSearchRanges(5).Vs2Perturb,GridSearchRanges(6).Vs2Perturb,GridSearchRanges(7).Vs2Perturb,...
    GridSearchRanges(8).Vs2Perturb);

Model(:,1) = V1GRD(:);
Model(:,2) = V2GRD(:);
Model(:,3) = V3GRD(:);
Model(:,4) = V4GRD(:);
Model(:,5) = V5GRD(:);
Model(:,6) = V6GRD(:);
Model(:,7) = V7GRD(:);
Model(:,8) = V8GRD(:);

% figure()
% plot(Model(1:10:end,:),depths)
% set(gca,'ydir','reverse')
