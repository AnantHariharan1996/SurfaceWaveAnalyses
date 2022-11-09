function [QParamname] = Write_MineosQParam_File(QParamname,QModname,QOutname,Eigname)
% Write param file for mineos_q
line1=['Card_Files/' QModname '\n'];
line2=['Q_Files/' QOutname '\n'];
line3=['eig_Files/' Eigname '\n'];
line4=['Y' '\n'];
line5=['!'];

fid=fopen(QParamname,'w')

fprintf(fid,line1)
fprintf(fid,line2)
fprintf(fid,line3)
fprintf(fid,line4)
fprintf(fid,line5)

fclose(fid)


end