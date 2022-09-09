clear; clc; close all;
% Explore the impact of adding a low-velocity zone
card=read_model_card('Card_Files/prem_35.card');
LVZ_List = [3500:100:4600];
DepthRangetoPerturb= [50 100];
depthdx = find(card.z>min(DepthRangetoPerturb) & card.z<max(DepthRangetoPerturb) );
tempv = card.vsh;
ncard=card;
mode=2;
nmax=1;
for LVZVal = LVZ_List
    
    Cardname=['prem_35_LVZ' num2str(LVZVal) '.card'];
    Ascname=['prem_35_LVZ' num2str(LVZVal) '.asc'];
    Eigname=['prem_35_LVZ' num2str(LVZVal)  '.eig'];
    ParamFname=['ParamFile_PREMLVZ' num2str(LVZVal)];
    newv=tempv;
    newv(depthdx) = LVZVal;
    ncard.vsh = newv;

    write_MINEOS_mod(ncard,['Card_Files/prem_35_LVZ' num2str(LVZVal) '.card'])
    [ParamFname] = Write_Param_File(ParamFname,Cardname,Ascname,Eigname,mode,nmax)
    [String] = Run_Mineos(ParamFname,'minos_bran_moreknot');
    [ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = Read_MINEOS_asc_File(['asc_Files/' Ascname])


    % Plotting
    figure(1)
    subplot(1,2,1)
    plot(ncard.vsh,card.z,'linewidth',2)
    hold on
    
    n0dx= find(nlist==0);
    subplot(1,2,2)
    plot(tsecs(n0dx),phvel(n0dx),'-o','linewidth',2)
    hold on
  %  xlim([0 150])

end
subplot(1,2,1)
ylim([0 400])

subplot(1,2,2)
%xlim([0 150])
