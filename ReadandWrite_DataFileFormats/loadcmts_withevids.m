% Load the catalog with event IDs
fnamecatalog = 'global_1977_2016.dms';
fid = fopen(fnamecatalog);
C = textscan(fid, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid); 
Catalog_evid = C{1};
for jkl = 1:length(Catalog_evid)
    % remove the first letter
    tmp = Catalog_evid{jkl};
    Catalog_evid_adjust{jkl} = tmp(2:end);   
end
Catalog_year = C{2}; Catalog_month=C{3}; 
Catalog_dat=C{4}; Catalog_hr=C{5}; Catalog_min=C{6}; Catalog_s = C{7};
Catalog_et = C{8}; Catalog_en = C{9}; Catalog_dep = C{10};
Catalog_Mrr = C{11}; Catalog_Mtt = C{12}; Catalog_Mpp = C{13};
Catalog_Mrt = C{14}; Catalog_Mrp = C{15}; Catalog_Mtp = C{16}; 
Catalog_y = C{18}; 
Catalog_r = Catalog_Mrr.^2 + Catalog_Mtt.^2 +Catalog_Mpp.^2 ...
+ Catalog_Mrt.^2 + Catalog_Mrp.^2 + Catalog_Mtp.^2;
Catalog_MO=(10.^Catalog_y).*sqrt(Catalog_r)/sqrt(2); 
Catalog_MW=(2/3)*(log10(Catalog_MO)-16.1);

%histogram(Catalog_MW)