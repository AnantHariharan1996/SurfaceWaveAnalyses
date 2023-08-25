% D_Search Grid
MisfitStore = zeros([1,length(Model(:,1))]);

for modelnum = 1:length(Model(:,1))

    currmodel = Model(modelnum,:);
    [New_Likelihood,New_MisfitSm,PredictedPhvel,FM_Periods,FM_Phvel] = ...
    Get_Likelihood_Misfit_LoveWavePhvel(Periods2Use,Data2Match,Model_Depths,currmodel);
    
    MisfitStore(modelnum) = New_MisfitSm;
    InformationStore(modelnum).Periodout = FM_Periods;
    InformationStore(modelnum).Phvelout = FM_Phvel;
    InformationStore(modelnum).modelout = currmodel;
    InformationStore(modelnum).modeldepths = Model_Depths;
    
    if rem(modelnum,1000) == 0
        save('GridSearchOutput.mat','InformationStore')
        save('MisfitVec.mat','MisfitStore')

    end
end
