% Load updated CMT Catalog file until 2020

CMTInfo_2020 = load('global_1977_2020_foranant');
Catalog_Year = CMTInfo_2020(:,1);
Catalog_month=CMTInfo_2020(:,2); 
Catalog_day=CMTInfo_2020(:,3);
Catalog_hr=CMTInfo_2020(:,4); 
Catalog_min=CMTInfo_2020(:,5); 
Catalog_s = CMTInfo_2020(:,6); 
Catalog_et = CMTInfo_2020(:,7); 
Catalog_en =CMTInfo_2020(:,8); 
Catalog_dep = CMTInfo_2020(:,9); 
Catalog_Mrr = CMTInfo_2020(:,10); 
Catalog_Mtt = CMTInfo_2020(:,11); 
Catalog_Mpp = CMTInfo_2020(:,12); 
Catalog_Mrt = CMTInfo_2020(:,13); 
Catalog_Mrp = CMTInfo_2020(:,14); 
Catalog_Mtp = CMTInfo_2020(:,15); 
Catalog_y =  CMTInfo_2020(:,16);  
Catalog_r = Catalog_Mrr.^2 + Catalog_Mtt.^2 +Catalog_Mpp.^2 ...
+ Catalog_Mrt.^2 + Catalog_Mrp.^2 + Catalog_Mtp.^2;
Catalog_MO=(10.^Catalog_y).*sqrt(Catalog_r)/sqrt(2); 
Catalog_MW=(2/3)*(log10(Catalog_MO)-16.1);

%% Verify events by showing gutenberg-richter for GCMT cat
histogram(Catalog_MW)
set(gca,'YScale','log');
