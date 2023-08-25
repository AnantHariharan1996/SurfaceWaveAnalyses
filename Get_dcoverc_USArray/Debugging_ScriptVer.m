%% Get USArray Dispersion up to 75 s 

pixlon = -100;
pixlat = 40;

USE_ALLUSANTData = 1;

periodlist = [5 6 8 10 12 15 20 25 30 35 40 45 50 60 75];
pcounter=0;

for period = periodlist
    pcounter=pcounter+1;
periodstr = num2str(period);
if length(periodstr) == 1
    periodstr=['0' periodstr];
end

if USE_ALLUSANTData
    if period <45
        fname = ['L' periodstr '_USANT15.pix'];
        [ lon,lat,phasevelo ] = Read_USANT_File( fname );
        
    else
           fname = ['Love_phvel_' num2str(period) 's'];
           info =load(fname);
           lon = info(:,1);
           lat = info(:,2);
           phasevelo = info(:,3); 
    end

          dist2grd = distance(pixlat,pixlon,lat,lon);
         [mindist,mindx]=min(dist2grd);
         currphvel = phasevelo(mindx);
         PhVelList(pcounter) = currphvel; 

else



end

end