%% Run Prediction Code
clear
periodlist = [125];

for period = periodlist
    
   inpfname = ['GTRInpFile' num2str(period) '.dat']; 
[OutStructure] = Predict_LoveWave_GrpArrivalTimes_FMandN1(inpfname,period)    
    
end