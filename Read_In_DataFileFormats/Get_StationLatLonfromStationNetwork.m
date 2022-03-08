function [ StaLon_Out,StaLat_Out ] = Get_StationLatLonfromStationNetwork( Stanames,StaNets,GMAPFname )
% Given a 1*N cell array of 4-letter station codes and network, this code can extract station
% latitude and longitude.
% To use this code, supply a file downloaded from the IRIS GMAP service:
% https://ds.iris.edu/gmap/. Download as a 'text' file. Supply the filename
% as the third argument to this code. 
% Anant Hariharan, 2021.
% If can't find a match, fills out NaN. 
% The output StaLon_Out and StaLat_Out are vectors of the same length as
% the input cell arrays, which should both also be the same dimension.


% First, read in the IRIS File

GMAPinfo = readtable(GMAPFname);
Ref_Nets = GMAPinfo(:,1);
Ref_StaName = GMAPinfo(:,2);
Ref_StaLat = GMAPinfo(:,3);
Ref_StaLon = GMAPinfo(:,4);

Ref_Net_Array = table2cell( Ref_Nets );
Ref_StaName_Array = table2cell( Ref_StaName );
Ref_StaLat_Array = table2array( Ref_StaLat );
Ref_StaLon_Array = table2array( Ref_StaLon );



for ijk = 1:length(Stanames)
    100*ijk/length(Stanames)
   Curr_Staname =  Stanames{ijk};
   Curr_Stanet =  StaNets{ijk};
   
   
    Curr_Dx = find(strcmp(Ref_StaName_Array,Curr_Staname) & ...
        strcmp(Ref_Net_Array,Curr_Stanet));
    
    if length(Curr_Dx) == 0
      StaLon_Out(ijk)  = NaN;
       StaLat_Out(ijk)  = NaN;
        disp(['Unable To Find Sta:'  Curr_Staname ', Net:' Curr_Stanet])
    else
    StaLon_Out(ijk) = Ref_StaLon_Array(Curr_Dx(1));
    StaLat_Out(ijk) = Ref_StaLat_Array(Curr_Dx(1));
    end
    
    
end

end

