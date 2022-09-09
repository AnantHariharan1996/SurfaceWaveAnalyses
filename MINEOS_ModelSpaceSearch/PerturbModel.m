%% Perturb_Model


%Vsh_Prior_Edges = [3700 4700];
NewModel=CurrentModel;
for curr_layer = 1:NLayers_Model
    
    Curr_LayerEdges = LayerEdges(curr_layer,:);
    Curr_VsBounds = Vsh_Prior_Edges(curr_layer,:);
    depthdx = find(NewModel.z>min(LayerEdges) & NewModel.z<max(LayerEdges) );

    current_depthvs = median(CurrentModel.vsh(depthdx));
    curr_NewVs = (rand(1,1)-0.5)*Perturb_VeloList(curr_layer)+current_depthvs;
    curr_NewVs
  while curr_NewVs>max(Vsh_Prior_Edges) | curr_NewVs<min(Vsh_Prior_Edges)
    %
    curr_NewVs = (rand(1,1)-0.5)*Perturb_VeloList(curr_layer)+current_depthvs;
    end
        NewModel.vsh(depthdx) = curr_NewVs;
    write_MINEOS_mod(NewModel,['Card_Files/TempMod.card'])

end

mode=2; ParamFname='ParamFile_TempMod';
Ascname = 'prem_35_TempMod.asc';
Eigname = 'prem_35_TempMod.eig';
[ParamFname] = Write_Param_File(ParamFname,'TempMod.card',...
Ascname,Eigname,mode,1);
[String] = Run_Mineos(ParamFname,'minos_bran_moreknot');
[ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = ...
Read_MINEOS_asc_File(['asc_Files/' Ascname]);
FMdx = find(nlist == 0 & tsecs>30 & tsecs < 170);
FM_Ttim = tsecs(FMdx);
FM_phvel = phvel(FMdx);

curr_FMPeriod = FM_Ttim;
curr_FMPhvel= FM_phvel;
InterpedPhvels = interp1(curr_FMPeriod,curr_FMPhvel,Data2Use_Period);
% Get Misfit and Likelihood, etc.
New_MisfitSm = sum((InterpedPhvels-Data2Use_Phvel).*DataCovariance.*(InterpedPhvels-Data2Use_Phvel));
New_Likelihood = exp(-0.5*New_MisfitSm)

