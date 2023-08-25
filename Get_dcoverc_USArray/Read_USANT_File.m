function [ lon,lat,phasevelo ] = Read_USANT_File( fname )
% This function reads in the ambient noise phase velocity information from
% ekstrom 2012.
fid = fopen(fname);
line = fgetl(fid);
line = fgetl(fid);
line = fgetl(fid);
line = fgetl(fid);
line = fgetl(fid);

ReferencePhVel = line(12:end);
ReferencePhVel=str2num(ReferencePhVel);

fclose('all')
fid2 = fopen(fname);
data = textscan(fid2,'%f %f %f %f','HeaderLines',11);
lat = data{1};
lon = data{2};
deltac = data{4};

Deviation = deltac*ReferencePhVel/100;
phasevelo=Deviation+ReferencePhVel;

fclose('all')

end

