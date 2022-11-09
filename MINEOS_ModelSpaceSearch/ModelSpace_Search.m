%% Predict Group Velocities for Different Earth Models
% 

clear; clc; close all;
CleanWorkingFolder
LayerEdges=linspace(30,300,10);
NLayers_Model = length(LayerEdges)-1;
Perturb_VeloList = [4000:250:4800];
NumModels = length(Perturb_VeloList)^NLayers_Model
StoreCounter=1;

card=read_model_card('Card_Files/prem_35.card');
StartingModel=card;
jnkjnk=card.z;
Counter = 0;
for Velo1 = Perturb_VeloList
for Velo2 = Perturb_VeloList
for Velo3 = Perturb_VeloList
for Velo4 = Perturb_VeloList
for Velo5 = Perturb_VeloList
for Velo6 = Perturb_VeloList
for Velo7 = Perturb_VeloList
for Velo8 = Perturb_VeloList
for Velo9 = Perturb_VeloList

Velolist = [Velo1 Velo2 Velo3 Velo4 Velo5 Velo6 Velo7 Velo8 Velo9]

CurrentModel = StartingModel;
for ijk = 1:length(Velolist)
curr_NewVs=Velolist(ijk);
depthdx = find(CurrentModel.z>LayerEdges(ijk) & CurrentModel.z<LayerEdges(ijk+1));
VpVsRatio = 1./(CurrentModel.vsv(depthdx)./CurrentModel.vpv(depthdx));
CurrentModel.vsh(depthdx) = curr_NewVs;
CurrentModel.vsv(depthdx) = curr_NewVs;
CurrentModel.vpv(depthdx) = curr_NewVs.*VpVsRatio;
CurrentModel.vph(depthdx) = curr_NewVs.*VpVsRatio;
CurrentModel.eta(depthdx) = 1;
end

write_MINEOS_mod(CurrentModel,['Card_Files/GridSearchModel.card'])
Counter = Counter +1;


mode=2; ParamFname='ParamFile_TempMod';
Ascname = 'GridSearchTempMod.asc';
Eigname = 'GridSearchTempMod.eig';
[ParamFname] = Write_Param_File(ParamFname,'GridSearchModel.card',...
Ascname,Eigname,mode,2);
[String] = Run_Mineos(ParamFname,'minos_bran_moreknot');
 [ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = Read_MINEOS_asc_File(['asc_Files/' Ascname]);


GridSearchOutput(Counter).Model = CurrentModel.vsh;
GridSearchOutput(Counter).Depth = CurrentModel.z;
GridSearchOutput(Counter).Periods = tsecs;
GridSearchOutput(Counter).GrpVel = grpvel;
GridSearchOutput(Counter).Nlist = nlist;
GridSearchOutput(Counter).PhVel = phvel;




if rem(Counter,500) == 0
save(['ModelSpace_OvertoneInterference/GridSearchOutput.mat'],'GridSearchOutput','-mat')
end


end
end
end
end
end
end
end
end
end

