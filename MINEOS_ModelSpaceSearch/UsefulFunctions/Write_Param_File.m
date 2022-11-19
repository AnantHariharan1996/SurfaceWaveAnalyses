function [ParamFname] = Write_Param_File(ParamFname,Cardname,Ascname,Eigname,mode,nmax)
%% examples:
%Cardname='prem_35.card';
%Ascname='prem_35.asc'
%Eigname='prem_35.eig';
%(1=rad;2=tor;3=sph;4=ictor)
%lmin lmax wmin wmax nmin nmax

line1=['Card_Files/' Cardname '\n'];
line2=['asc_Files/' Ascname '\n'];
line3=['eig_Files/' Eigname '\n'];
line4=['1e-10 10' '\n'];
line5=[num2str(mode) '\n'];
line6=['0 1800 10 200.05 0 ' num2str(nmax) '\n'];

fid=fopen(ParamFname,'w')

fprintf(fid,line1)
fprintf(fid,line2)
fprintf(fid,line3)
fprintf(fid,line4)
fprintf(fid,line5)
fprintf(fid,line6)

fclose(fid)

end