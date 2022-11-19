function [FM_Periods,FM_Phvel,ncard] = GetPredPhVel(depths,vsh)
[ncard,premcard] = Generate_VSH_Mineos_Mod_PREMBackground(depths,vsh);
write_MINEOS_mod(ncard,['Card_Files/junk.card'])
mode=2; ParamFname='junk';
Ascname = 'junk.asc';
Eigname = 'junk.eig';
[ParamFname] = Write_Param_File(ParamFname,'junk.card',...
    Ascname,Eigname,2,1);
[String] = Run_Mineos(ParamFname,'minos_bran_moreknot');
[ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = ...
Read_MINEOS_asc_File(['asc_Files/' Ascname]);
FMdx = find(nlist == 0);
FM_Periods = tsecs(FMdx);
FM_Phvel = phvel(FMdx);


end