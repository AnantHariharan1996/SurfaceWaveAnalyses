%% Interrogate output

clear; clc; close all 
load('GridSearchOutput.mat')
incr=20;
 for ijk = 1:incr:length(GridSearchOutput)

     figure(1)
     idx = find(GridSearchOutput(ijk).Nlist == 1);
          idx0 = find(GridSearchOutput(ijk).Nlist == 0);

scatter(GridSearchOutput(ijk).Periods(idx),GridSearchOutput(ijk).GrpVel(idx),10,[1 0 0],'filled','MarkerFaceAlpha',0.01,'MarkerEdgeAlpha',0.01)
hold on
scatter(GridSearchOutput(ijk).Periods(idx0),GridSearchOutput(ijk).GrpVel(idx0),10,[0 0 1],'filled','MarkerFaceAlpha',0.01,'MarkerEdgeAlpha',0.01)


 end


  for ijk = 1:incr:length(GridSearchOutput)

     figure(2)
     plot(GridSearchOutput(ijk).Model,GridSearchOutput(ijk).Depth,'linewidth',0.5,'color',[0 0 0 0.5])
hold on
set(gca,'ydir','reverse')

  end
