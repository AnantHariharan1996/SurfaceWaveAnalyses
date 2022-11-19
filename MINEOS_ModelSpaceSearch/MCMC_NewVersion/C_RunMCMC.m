%% C Run_MCMC

for iter = 1:NumIter

% New model proposal;
NewModel = CurrentModel;
layerdx = randsample(length(Model_Depths),1);
NewModel(layerdx) = (rand(1,1)-0.5)*StepSize+NewModel(layerdx);


% Generate likelihood and misfit
[New_Likelihood,New_MisfitSm,PredictedPhvel] = ...
    Get_Likelihood_Misfit_LoveWavePhvel(Periods2Use,Data2Match,Model_Depths,NewModel);

% acceptance criterion
Accept_Checker=0;
if New_Likelihood < Current_Likelihood

            % Estimate probability of acceptance
            Paccept = New_Likelihood/Current_Likelihood;
             Accepter=rand(1,1);
             if Accepter<Paccept
                 Accept_Checker=1;
             end

elseif New_Likelihood>Current_Likelihood
                 Accept_Checker=1;

end

% store model if it is accepted, etc. 
if Accept_Checker
    
CurrentModel=NewModel;
Acceptance_Counter=Acceptance_Counter+1;
Stored_Model(Acceptance_Counter,:) = CurrentModel;
Stored_Likelihood(Acceptance_Counter) = New_Likelihood;
 Current_Likelihood = New_Likelihood;
 Stored_Data(Acceptance_Counter,:) = PredictedPhvel;
end
% Plotting during the testing phase
%%%%
if Accept_Checker
figure(100)
subplot(1,3,1)
plot(StartingModel,Model_Depths,'-bo','linewidth',2)
hold on
plot(TrueModel_vsh,TrueModel_Depths,'-ro','linewidth',2)
plot(NewModel,Model_Depths,'linewidth',0.01,'color',[0 1 0 0.2])
legend('Starting Model','True Model','Accepted Models','location','southwest')
set(gca,'ydir','reverse','fontsize',16)
xlabel('Vsh(m/s)')
ylabel('Depth(km)')
xlim([0 5000])

subplot(1,3,2)
plot(Periods2Use,StartingModelPhvel,'-ro','linewidth',2)

hold on
plot(Periods2Use,Data2Match,'-bo','linewidth',2)
plot(Periods2Use,PredictedPhvel,'linewidth',0.05,'color',[0 1 0 0.2])
legend('Starting Model','True Model','Accepted Model','location','southeast')
xlabel('Period (s)')
ylabel('Phase Velocity (km/s)')
set(gca,'fontsize',16)

subplot(1,3,3)
plot([1:Acceptance_Counter],Stored_Likelihood,'-o','linewidth',2)
ylabel('Likelihood')
xlabel('Accepted Model #')
set(gca,'fontsize',16)
set(gcf,'position',[15 390 1354 470])
title(['Completed Iterations:' num2str(iter)])

end
%%%%
if rem(iter,1000) == 0
save('Stored_Likelihood','Stored_Likelihood')
save('Stored_Data','Stored_Data')
save('Stored_Model','Stored_Model')
saveas(gcf,['MCMC_Output_Niter' num2str(iter) '.jpg'])

end
end

