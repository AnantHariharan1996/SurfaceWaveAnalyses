function [ Output_Array ] = Read_And_OutputMa2014Measurements( fname,GMAPFname )
% This function 
% reads information from files from Ma 2014, downloaded at 
% https://igppweb.ucsd.edu/~gabi/crust1.html.

% Stores information about Event Lat, Event Long,
% Station Lat, Station Lon, Traveltime, Amplitude, Event depth 
% and outputs it all
% as a .mat file. 

% Dependency: Requires the function Get_StationLatLonfromStationNetwork.m
% Anant Hariharan, 2021.
load coastlines
fid = fopen(fname,'r');
status = feof(fid);
counter=0;

LocalEvID = 0;
while ~feof(fid)
tline = fgetl(fid);
splitline = split(tline);
NumTts = str2num(splitline{2});
Event_Year = str2num(splitline{3}); Event_Day = str2num(splitline{4});
Event_Hr = str2num(splitline{5});
Event_Min = str2num(splitline{6}); Event_Sec = str2num(splitline{7}); 

Event_Colatitude = str2num(splitline{8}); 
Event_Longitude = str2num(splitline{9}); 
Event_Depth = str2num(splitline{10}); 
Event_Latitude = 90-Event_Colatitude;

LocalEvID = LocalEvID+1;

for ijk = 1 :NumTts
     counter=counter+1;
    % read in measurements for each event
  datline = fgetl(fid);
    datlinesplit = split(datline);
    % extract measurements for each event
    Staname = datlinesplit{1};
    tbest = str2num(datlinesplit{2}); % travel time anomaly wrt 1d pred
    terr = str2num(datlinesplit{3});   % error in seconds in tt
    scale = str2num(datlinesplit{4}); %amplitude variation
    scale_se = str2num(datlinesplit{5}); %amplitude variation error
    pol = str2num(datlinesplit{6}); %amplitude variation error
    ravg = str2num(datlinesplit{7}); %avg xcorr coeff
    time = str2num(datlinesplit{8}); %1d reference arrival time
    azisv = str2num(datlinesplit{9}); %azimuth in deg
    distsv = str2num(datlinesplit{10}); %distance in deg
     snr = str2num(datlinesplit{11}); %distance in deg
    ktyp =datlinesplit{13}; %network code
    arrival_time = tbest+time;
    
    % get station lat lon
    EvLatList(counter) = Event_Latitude;
    EvLonList(counter) = Event_Longitude;
    EvDepList(counter) = Event_Depth;
    StanameList{counter} = Staname;
     StanetList{counter} = ktyp;
   LocalEvIDList(counter) = LocalEvID;
    ArrivalTimeList(counter) = arrival_time;
    AmplitudeVariation(counter) = scale;
end
end
 fclose('all')
 
 EvLonList(EvLonList > 180) =  EvLonList(EvLonList > 180) - 360;
 figure()
 scatter(EvLonList,EvLatList,100,EvDepList,'pentagram','filled')
 hold on
 barbar=colorbar;
 ylabel(barbar,'Event Depth (km)')
 colormap(winter)
 plot(coastlon,coastlat,'linewidth',2,'color','k')
title(fname)
ylim([-90 90])
xlim([-180 180])
set(gca,'fontsize',20)
caxis([0 150])
 [ StaLon_Out,StaLat_Out ] = Get_StationLatLonfromStationNetwork( StanameList,StanetList,GMAPFname );
 
 
%  
%  %% Get Unique Stations
%  LonLat(:,1) = StaLon_Out;
%  LonLat(:,2) = StaLat_Out;
%  [uniquevals,uniquedx] = unique(LonLat,'rows');
%  UniqueLons = uniquevals(:,1);
%   UniqueLats = uniquevals(:,2);
%   
%  for ijkl = 1:length(UniqueLats)
%      currstalon = UniqueLons(ijkl)
%      currstalat = UniqueLats(ijkl) 
%      stadx = find(StaLon_Out == currstalon & StaLat_Out == currstalat);
%      nummeasurements(ijkl) = length(stadx);
%      
%  end


zzz(:,1) = EvLatList;
zzz(:,2) = EvLonList;
zzz(:,3) = StaLat_Out;
zzz(:,4) = StaLon_Out;
zzz(:,5) = ArrivalTimeList;
zzz(:,6) = AmplitudeVariation;
zzz(:,7) = EvDepList;
Output_Array=zzz;
 save([fname 'ArrayVersion.mat'],'zzz') 

end

