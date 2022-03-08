function [OutStructure] = Predict_LoveWave_GrpArrivalTimes_FMandN1(inputfname,periodlist)
% Predicts Love Wave Arrival Times for the FM and First Overtone
% Requires an input file formatted as follows:
% first column EQ Lat
% second column EQ Lon
% third column Sta Lat
% fourth column Sta Lon
% requires mapping toolbox
% AH 2022 

EQ_STAnfo = load(inputfname);
Elat = EQ_STAnfo(:,1);
Elon = EQ_STAnfo(:,2);
Stalat = EQ_STAnfo(:,3);
Stalon = EQ_STAnfo(:,4);
Pathlengths_deg = distance(Elat,Elon,Stalat,Stalon);
Pathlengths_km = deg2km(Pathlengths_deg);
pcounter=0;
for period = periodlist
    pcounter=pcounter+1;
    Outputfname = [inputfname 'ttimepredicted_n0n1_' num2str(period)];

    % Load Group velocity maps
    n0GrpVelName = ['Lon_Lat_n0_U' num2str(period) 's'];
    n1GrpVelName = ['Lon_Lat_n1_U' num2str(period) 's'];
    
    n0Uinfo = load(n0GrpVelName);
    n1Uinfo = load(n1GrpVelName);
    
    lonlist = n0Uinfo(:,1);
    latlist = n0Uinfo(:,2);
    U0 = n0Uinfo(:,3);
    U1 = n1Uinfo(:,3);

    PathIntegratedU0 = zeros(size(Stalat));
    PathIntegratedU1 = zeros(size(Stalat));


    % now do the ray tracing 
    % crude ray tracing algorithm

    for jkl = 1:length(Elat)
        100*jkl/length(Elat)
        current_elat = Elat(jkl);
        current_elon = Elon(jkl);
        current_slat = Stalat(jkl);
        current_slon = Stalon(jkl);

        [LAT_track,LON_track] = track2(current_elat,current_elon,...
            current_slat,current_slon,[],[],50);

          % now, average along this path using GDM52
          path_grpvels_U0=[];
          path_grpvels_U1=[];
         
          for iuiu = 1:length(LAT_track)   

              alen=distance(LAT_track(iuiu),LON_track(iuiu),...
                  latlist,lonlist);
              [mindist,mindx]=min(alen);
              path_grpvels_U0=[path_grpvels_U0 U0(mindx)];    
              path_grpvels_U1=[path_grpvels_U1 U1(mindx)];    

          end        
    
          PathIntegratedU1(jkl) = mean(path_grpvels_U1);
          PathIntegratedU0(jkl) = mean(path_grpvels_U0);



    end

    Predicted_U1ttime = Pathlengths_km./PathIntegratedU1;
    Predicted_U0ttime = Pathlengths_km./PathIntegratedU0;
    zzz(:,1)=Predicted_U0ttime;
    zzz(:,2)=Predicted_U1ttime;
    zzz(:,3)=PathIntegratedU0;
    zzz(:,4)=PathIntegratedU1;
    zzz(:,5)=Pathlengths_km;

    dlmwrite(Outputfname,zzz,'delimiter','\t','precision','%.9f')

    

    OutStructure(pcounter).summary = zzz;
%
end




end