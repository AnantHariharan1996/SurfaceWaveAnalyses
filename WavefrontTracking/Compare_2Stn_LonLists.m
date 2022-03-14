function [ commonids_list1,commonids_list2 ] = Compare_2Stn_LonLists( lonlist1,latlist1,lonlist2,latlist2 )
% Compares two group of station lat/lon pairs. 
 %to find the common station 'ids' or list indices
 % returns a vector of indices for each list corresponding to common
 % stations
 
 
 % note: list1 lengths and list2 lengths must be the same
 commonids_list1 = [];
  commonids_list2 = [];

 l1 = length(lonlist1);
 l2 = length(lonlist2);
 
 
 for i = 1:l2
     currlon = lonlist2(i);
     currlat = latlist2(i);

     lon_overlap = find(currlon == lonlist1);
     lat_overlap = find(currlat == latlist1);
     
     actual_overlap = intersect(lon_overlap,lat_overlap);
     
     if length(actual_overlap) > 0
     commonids_list2 = [commonids_list2 i];
     end
 end
     
 for i = 1:l1
     currlon = lonlist1(i);
     currlat = latlist1(i);

     lon_overlap = find(currlon == lonlist2);
     lat_overlap = find(currlat == latlist2);
     
     actual_overlap = intersect(lon_overlap,lat_overlap);
     
     if length(actual_overlap) > 0
     commonids_list1 = [commonids_list1 i];
     end
 end
     


end

