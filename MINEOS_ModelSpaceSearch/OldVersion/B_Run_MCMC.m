%% Run the MCMC
%
for iternum = 1:NumIter
iternum
    PerturbModel
    % Get Likelihood
    
    Accept_Checker=0;
    
    if New_Likelihood<Current_Likelihood

            % Estimate probability of acceptance
            Paccept = New_Likelihood/Current_Likelihood;
             Accepter=rand(1,1);
             if Accepter<Paccept
                 Accept_Checker=1;
             end

     
    
elseif New_Likelihood>Current_Likelihood
  Accept_Checker=1;
end


            % If we accept the new model, store it as the current model
             if Accept_Checker
                 % Store the current model
                CurrentModel=NewModel;
                Current_Likelihood = New_Likelihood;
                % Stroe the current misfit
                
StoreCounter=StoreCounter+1;
Misfitlist(StoreCounter) =New_MisfitSm;
Likelihoodlist(StoreCounter) =New_Likelihood;
New_PhvelMat(StoreCounter,:)=InterpedPhvels;
StoredModels(StoreCounter,:)=CurrentModel.vsh;

figure(1)
scatter(Data2Use_Period,InterpedPhvels,1,[0 0 0],'filled')
             end


    figure(10)
subplot(1,2,1)
plot([1:StoreCounter],Misfitlist,'linewidth',2)
xlabel('Iteration Number')
ylabel('Misfit ')
hold on
subplot(1,2,2)
plot([1:StoreCounter],log(Likelihoodlist),'linewidth',2)
xlabel('Iteration Number')
ylabel('Likelihood ')

hold on


figure(12)
    plot(CurrentModel.vsh,CurrentModel.z,'--','linewidth',0.5,'color','k')


end

    figure(10)
subplot(1,2,1)
set(gca,'fontsize',16,'fontweight','bold')

subplot(1,2,2)
set(gca,'fontsize',16,'fontweight','bold')
figure(12)
legend('Starting Model','True Model')

figure(1)
plot(NoisyData_Periods,NoisyData,'-ro','linewidth',2)

figure(12)
    plot(card.vsh,card.z,'linewidth',2,'color','m')
