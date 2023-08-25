function [periodlist,PhVelList] = Get_USArray_RayleighPhvel(pixlon,pixlat,periodlist)
% Gets phvel as a function of period. Use the USANT data by default. 

pcounter=0;

for period = periodlist
    pcounter=pcounter+1;
    periodstr = num2str(period);
    if length(periodstr) == 1
        periodstr=['0' periodstr];
    end
    

    USANTFname = ['R' periodstr '_USANT15.pix'];
    BD19Fname = ['c_' periodstr 's_BD19'];

    if exist(USANTFname) == 2

            [ lon,lat,phasevelo ] = Read_USANT_File( fname );

    elseif exist(BD19Fname) == 2

            info =load(fname);
            lat = info(:,1);
            lon = info(:,2);
            phasevelo = info(:,3);

    else
          error('Phase Velocity Measurements Not Available at These Periods!')

    end


     vq = griddata(lon,lat,phasevelo,pixlon,pixlat);

    PhVelList(pcounter) = vq; 
    

end