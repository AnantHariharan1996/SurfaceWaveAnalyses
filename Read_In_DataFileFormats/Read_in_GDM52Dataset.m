function [ fname,EVID,STAID,EQ_Lat,EQ_Lon,EQ_z,stalat,stalon,distlist,WaveType,dphi,Sigma_1 ] = Read_in_GDM52Dataset( fname )
% Reads in the individual observations from the GDM52 Dataset files
fid = fopen(fname);
A = textscan(fid,'%s %s %f %f %f %f %f %f %s %f %f');
fclose(fid);
EVID = A{1};
STAID = A{2};
EQ_Lat = A{3};
EQ_Lon = A{4};
EQ_z = A{5};
stalat = A{6};
stalon = A{7};
distlist = A{8};
WaveType = A{9};
dphi = A{10};
Sigma_1 = A{11};

end

