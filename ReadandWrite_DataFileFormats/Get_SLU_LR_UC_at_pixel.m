function [LoveC,Rayleighc,LoveU,RayleighU] = Get_SLU_LR_UC_at_pixel(periodlist,lon,lat,RootFolderName)
%get ph and grp vels as fn period, location
% interp from 2d maps onto 1D array at pixel
Pcounter=0;
for Period = periodlist
Pcounter=Pcounter+1;

[Vel_Out,Love_Lon_Out_U,Love_Lat_Out_U] = ...
    Get_SLU_Love_Rayleigh_GroupVels(Period,...
    RootFolderName,0,0);

LoveU(Pcounter) = interp2(Love_Lon_Out_U,Love_Lat_Out_U,Vel_Out,lon,lat);


[Vel_Out,Love_Lon_Out_C,Love_Lat_Out_C] = ...
    Get_SLU_Love_Rayleigh_GroupVels(Period,...
    RootFolderName,1,0);

LoveC(Pcounter) = interp2(Love_Lon_Out_C,Love_Lat_Out_C,Vel_Out,lon,lat);

[Vel_Out,Rayleigh_Lon_Out_U,Rayleigh_Lat_Out_U] = ...
    Get_SLU_Love_Rayleigh_GroupVels(Period,...
    RootFolderName,0,1);

RayleighU(Pcounter) = interp2(Rayleigh_Lon_Out_U,Rayleigh_Lat_Out_U,Vel_Out,lon,lat);


[Vel_Out,Rayleigh_Lon_Out_C,Rayleigh_Lat_Out_C] = ...
    Get_SLU_Love_Rayleigh_GroupVels(Period,...
    RootFolderName,1,1);

RayleighC(Pcounter) = interp2(Rayleigh_Lon_Out_C,Rayleigh_Lat_Out_C,Vel_Out,lon,lat);


end


end