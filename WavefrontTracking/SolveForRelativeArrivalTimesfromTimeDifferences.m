function [ UniqueStalon,UniqueStalat,reltt,Nobs,Ntts,TtdiffPred,Sta1Lon,Sta1Lat,Sta2Lon,Sta2Lat,TtDifference  ] = SolveForRelativeArrivalTimesfromTimeDifferences( Sta1Lon,Sta1Lat,Sta2Lon,Sta2Lat,TtDifference )
% Given ttime differences between pairs of stations for the same event,
% solve for the arrivaltime surface that best explains the variance
% See algorithm in appendix, Jin and Gaherty 2015
% ttime difference is station B minus station A in seconds.



% Get unique stations 
LonLat(:,1) = [Sta1Lon; Sta2Lon];
LonLat(:,2) = [Sta1Lat; Sta2Lat];

[uniquerows,idx]=unique(LonLat,'rows');
UniqueStalon=LonLat(idx,1);
UniqueStalat=LonLat(idx,2);



%% First get rid of stations not well sampled by pairwise measurements

Idx2remove = [];
for ijk = 1:length(UniqueStalat)

idx = find(LonLat(:,1) == UniqueStalon(ijk) & LonLat(:,2) == UniqueStalat(ijk));
    if length(idx) < 6
    % eliminate these stations from the group of measurements
        Sta1dx = find(Sta1Lon == UniqueStalon(ijk) & Sta1Lat == UniqueStalat(ijk));
        Sta2dx = find(Sta2Lon == UniqueStalon(ijk) & Sta2Lat == UniqueStalat(ijk));
        
        Idx2remove = [Idx2remove; Sta1dx; Sta2dx];

    end



end

Sta1Lon2use = Sta1Lon;
Sta1Lat2use = Sta1Lat;
Sta2Lon2use = Sta2Lon;
Sta2Lat2use = Sta2Lat;
TtDifference2use = TtDifference;

Sta1Lon2use(Idx2remove) = [];
Sta1Lat2use(Idx2remove) = [];
Sta2Lon2use(Idx2remove) = [];
Sta2Lat2use(Idx2remove) = [];
TtDifference2use(Idx2remove) = [];



 Sta1Lon = Sta1Lon2use;
 Sta1Lat=Sta1Lat2use;
 Sta2Lon=Sta2Lon2use;
 Sta2Lat=Sta2Lat2use;
 TtDifference=TtDifference2use;
%%%5

clear LonLat

% Get unique stations 
LonLat(:,1) = [Sta1Lon; Sta2Lon];
LonLat(:,2) = [Sta1Lat; Sta2Lat];

[uniquerows,idx]=unique(LonLat,'rows');
UniqueStalon=LonLat(idx,1);
UniqueStalat=LonLat(idx,2);



Nobs = length(TtDifference);
Ntts=length(UniqueStalat);

% For each one check if there is a match with all the others
% If so store in matix

% The G matrix should have as many rows are there are time delays
Gmat = zeros(Nobs,Ntts);

for ijk = 1:length(TtDifference)
    % which stations are involved in this measurement?
    StationALongitude = Sta1Lon(ijk);
    StationALatitude = Sta1Lat(ijk);
   
    
    StationBLongitude = Sta2Lon(ijk);
    StationBLatitude = Sta2Lat(ijk);   
    
    
    % which indices do these stations correspond to?
    
    StationA_dx = find(UniqueStalon == StationALongitude & ...
        UniqueStalat == StationALatitude);
    StationB_dx = find(UniqueStalon == StationBLongitude & ...
        UniqueStalat == StationBLatitude);
    
    
    Gmat(ijk,StationB_dx) = 1;
    Gmat(ijk,StationA_dx) = -1;
    
    
    
end
% assume the first station has zero phase; 
TtDifference = [TtDifference; 0];
%TtDifference(length(TtDifference)+1) = 0;
    Gmat(ijk+1,1) = 1;
reltt = inv(Gmat'*Gmat)*Gmat'*TtDifference;


TtdiffPred = Gmat*reltt;
end

