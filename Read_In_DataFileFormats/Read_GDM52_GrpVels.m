function [ lon,lat,grpvel ] = Read_GDM52_GrpVels( fname )
% Reads GDM52 Group velocity files from the GDM52 website


% Read reference group velocity
fid=fopen(fname);
linenum=3;
C=textscan(fid,'%s %f',1,'delimiter','\n','headerlines',linenum-1);
GrpvelString=C{1};
GrpvelString=GrpvelString{1};
GrpvelString=GrpvelString(end-7:end)
fclose(fid);
referencegrpvel=str2num(GrpvelString);
% Read information
fid=fopen(fname);
data=textscan(fid,'%f %f %f %f','HeaderLines',6);
fclose(fid);

lat=data{1};
lon=data{2};
grpveldeviation=data{4};

grpvel=referencegrpvel+referencegrpvel*grpveldeviation/100;


end

