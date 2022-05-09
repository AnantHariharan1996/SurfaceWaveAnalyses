function [ DiffLon,DiffLat,Difference ] = Difference_two_maps( lon1,lat1,c1,lon2,lat2,c2 )
% differences two phvel maps on common indices

[ commonids_list1,commonids_list2 ] = Compare_2Stn_LonLists( lon1,lat1,lon2,lat2 );


c1_common = c1(commonids_list1);
c2_common = c2(commonids_list2);

Difference = c1_common-c2_common;
DiffLon = lon1(commonids_list1);
DiffLat = lat1(commonids_list1);




end

