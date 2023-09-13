function [Best_Angle,Best_LocalPhVel,Misfitlist] = ...
    GetArrivalAngle_MiniArraySingleStation(lonlist,latlist,stalon,stalat,ttimes,searchaz,Epidist_deg)
% Given traveltime for a mini-array of stations, get best-fitting arrival angle 
% at a single station.
% Uses the approach of Foster 2014.
% Note that stalon and stalat is one of the points in lonlist, latlist,
% which are the stations in the miniarray. 
arclen2use=Epidist_deg;
Mcount=0;
for azcheck =searchaz
    Mcount=Mcount+1;
    % Loop over a trial source that is given by a fixed distance and azimuth
    % from station location
    
    [trialsourcelat,trialsourcelon] = track1(stalat,stalon,azcheck+180,arclen2use);
    trialsourcelat=trialsourcelat(end);
    trialsourcelon=trialsourcelon(end);
    trialsourcelatlist(Mcount)=trialsourcelat;
    trialsourcelonlist(Mcount)=trialsourcelon;
    % first solve for the local phase velocity 
    % by fitting a line, right?
    distlist = deg2km(distance(trialsourcelat,trialsourcelon,latlist,lonlist));
    p = polyfit(ttimes,distlist,1);
    phvelo = p(1);
    phvellist(Mcount)=phvelo;
    
    % Now get the Lij terms
    % Lji is the epicentral dis- tance 
    % for an apparent source location Saj 
    % and receiver ri differenced with the epicentral distance for ra
    
    ra_dx = find(lonlist == stalon & latlist == stalat);
    ttimediffs  = ttimes(ra_dx(1)) - ttimes;
    Lji = distlist(ra_dx(1)) - distlist;

    %eliminate the station itself. 
    Lji(ra_dx) = [];
    ttimediffs(ra_dx) = [];

    % L2 misfit
    Misfit = (ttimediffs - Lji./phvelo).^2;
    Misfitlist(Mcount)=sum(Misfit);

end
% minimize misfit
[minmisfit,mindx]=min(Misfitlist);
Best_Angle=searchaz(mindx);
Best_LocalPhVel=phvellist(mindx);
end