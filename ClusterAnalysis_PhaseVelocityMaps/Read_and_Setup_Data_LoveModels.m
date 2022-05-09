% Read in Phvel Map Data as a Matrix, sampled at the same points

clear; clc; 
addpath('LoveWaveMaps')
periodlist = [35 40 45 50 60 75];
pcounter=0;
MegaLonList = [];
MegaLatList = [];

for period = periodlist
pcounter=pcounter+1;
    fname = ['PhVelOut_' num2str(period) 's'];
    info = load(fname);
    lon = info(:,1);
    lat= info(:,2);
    c = info(:,3);
     K = boundary(lon,lat);

     PhVelStore(pcounter).c = c;
     PhVelStore(pcounter).lon = lon;
     PhVelStore(pcounter).lat = lat;
     MegaLonList = [MegaLonList; lon];
     MegaLatList = [MegaLatList; lat];

end

%% Get Unique Lon Lats

LonLat(:,1) = MegaLonList;
LonLat(:,2) = MegaLatList;
[uniquevals,uniquedx] = unique(LonLat,'Rows');
uniquelons= uniquevals(:,1);
uniquelats= uniquevals(:,2);

% Check if the pixel is sampled at every period
idxkeep = [];

for ijk = 1:length(uniquelons)
100*ijk/length(uniquelons)
currlon = uniquelons(ijk);
currlat = uniquelats(ijk);

checker = 1;
    for pcounter = 1:length(PhVelStore)
    
        idx = find(currlon == PhVelStore(pcounter).lon & ...
            currlat == PhVelStore(pcounter).lat);
        
        if length(idx) == 0
            checker = 0;
        
        
        end
    end

    if checker
        idxkeep = [idxkeep ijk];
    
    
    end


end





CommonLons = uniquelons(idxkeep);
CommonLats = uniquelats(idxkeep);

for jkl = 1:length(CommonLons)
currlon = CommonLons(jkl);
currlat = CommonLats(jkl);
 for pcounter = 1:length(PhVelStore)
    
        idx = find(currlon == PhVelStore(pcounter).lon & ...
            currlat == PhVelStore(pcounter).lat);
        PhVel_SummaryMat(jkl,pcounter) = PhVelStore(pcounter).c(idx);

 end
end



