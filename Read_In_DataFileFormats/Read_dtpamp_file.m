function [ evla,evlo,stalat,stalon,tabs,nsamp,amp ] = Read_dtpamp_file( fname )
% Reads in the dtp files
% lines that generate them are below...
%            z(:,1)=evla*ones(length(tabs),1);
%             z(:,2)=evlo*ones(length(tabs),1); 
%             z(:,3)=stalat;
%         z(:,4)=stalon;
%             z(:,5)=tabs;
%             z(:,6)=nsamp;
%             z(:,7)=amp;

info = load(fname);
evla = info(:,1);
evlo = info(:,2);
stalat = info(:,3);
stalon = info(:,4);
tabs = info(:,5);
nsamp = info(:,6);
amp = info(:,7);



end

