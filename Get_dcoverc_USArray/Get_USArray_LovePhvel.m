function [periodlist,PhVelList] = Get_USArray_LovePhvel(pixlon,pixlat,USE_ALLUSANTData,periodlist)
% Gets phvel as a function of period

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

     vq = griddata(lon,lat,phasevelo,pixlon,pixlat);

    PhVelList(pcounter) = vq; 
    
    else
      if period <35
            fname = ['L' periodstr '_USANT15.pix'];
            [ lon,lat,phasevelo ] = Read_USANT_File( fname );
            
        else
            fname = ['Love_phvel_' num2str(period) 's'];
            info =load(fname);
            lon = info(:,1);
            lat = info(:,2);
            phasevelo = info(:,3); 
        end
    
     vq = griddata(lon,lat,phasevelo,pixlon,pixlat);
    PhVelList(pcounter) = vq; 
   
    end
end