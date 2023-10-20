% test reading in hotspot locations;

Info = readtable("Courtillot_Hotspots.txt");
Latitude=Info.Var2;
Lonlist= Info.Var3;%
for ijk=1:length(Latitude)
currlat=Latitude{ijk}
NS=currlat(end);
if strcmp(NS,'N')
 Factor=1;
elseif strcmp(NS,'S')
 Factor=-1;
elseif strcmp(NS,'0')
  Factor=1;   
end
if length(currlat) == 1
Latlist(ijk)=str2num(currlat)
else
Latlist(ijk)=Factor*str2num(currlat(1:end-1));
end
end
Lonlist = wrapTo180(Lonlist); Lonlist=Lonlist';

