function [Vel_Out,Lon_Out,Lat_Out] = Get_SLU_Love_Rayleigh_GroupVels(Period,RootFolderName,UorC,RorL)
% First, Download the folder from this link. 
% This contains subfolders LOVEc, LOVEU,RAYLc,RAYLU
% https://www.eas.slu.edu/eqc/eqc_research/SWTOMO/Surface_Wave_Tomography.html#CUS
% RootFolderName should contain the other subfolder RAYLU, LOVEU etc.
% Period is the period you want data at. 


RayleighUFolder = 'RAYLU';
LoveUFolder = 'LOVEU';

RayleighCFolder = 'RAYLc';
LoveCFolder = 'LOVEc';

if RorL == 0
    Wave_U_Folder = LoveUFolder;
    Wave_C_Folder = LoveCFolder;
    
elseif RorL == 1
    Wave_U_Folder = RayleighUFolder;
    Wave_C_Folder = RayleighCFolder;
    
end

if UorC == 0
    Folder = Wave_U_Folder;
elseif UorC == 1
    Folder = Wave_C_Folder;

end

% get closest period number and reference period. 

Reffile_fname = [RootFolderName '/' Folder '/' 'per.uniq.NUM'];

fid = fopen(Reffile_fname,'r');
A = textscan(fid,'%s %f %s');
fclose(fid);
RefPeriodlist = A{2};
Suffices = A{1};
Fnames = A{3};
Difflist = abs(Period-RefPeriodlist);
[mindiff,mindx] = min(Difflist);
Suffix = Suffices{mindx};
Fname = Fnames{mindx};
FullFname = [RootFolderName '/' Folder '/'  Fname];
Info = load(FullFname);

Lon_Out = Info(:,2);
Lat_Out = Info(:,1);
Vel_Out = Info(:,3);

% 
% Repeater=mode(Vel_Out);
% Vel_Out(find(Vel_Out == Repeater)) = NaN;


end