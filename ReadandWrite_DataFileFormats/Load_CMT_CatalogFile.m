% Load updated CMT Catalog file until 2020


CMTInfo = load('global_1977_2020_foranant');
Catalog_Year = CMTInfo(:,1);
Catalog_month=CMTInfo(:,2); 
Catalog_day=CMTInfo(:,3);
Catalog_hr=CMTInfo(:,4); 
Catalog_min=CMTInfo(:,5); 
Catalog_s = CMTInfo(:,6); 
Catalog_et = CMTInfo(:,7); 
Catalog_en =CMTInfo(:,8); 
Catalog_dep = CMTInfo(:,9); 
Catalog_Mrr = CMTInfo(:,10); 
Catalog_Mtt = CMTInfo(:,11); 
Catalog_Mpp = CMTInfo(:,12); 
Catalog_Mrt = CMTInfo(:,13); 
Catalog_Mrp = CMTInfo(:,14); 
Catalog_Mtp = CMTInfo(:,15); 
Catalog_y =  CMTInfo(:,16);  
Catalog_r = Catalog_Mrr.^2 + Catalog_Mtt.^2 +Catalog_Mpp.^2 ...
+ Catalog_Mrt.^2 + Catalog_Mrp.^2 + Catalog_Mtp.^2;
Catalog_MO=(10.^Catalog_y).*sqrt(Catalog_r)/sqrt(2); 
Catalog_MW=(2/3)*(log10(Catalog_MO)-16.1);
Catalog_t = datetime(Catalog_Year,Catalog_month,Catalog_day,Catalog_hr,Catalog_min,Catalog_s);
%% Verify events by showing gutenberg-richter for GCMT cat
histogram(Catalog_MW)
set(gca,'YScale','log');
xlabel('M')