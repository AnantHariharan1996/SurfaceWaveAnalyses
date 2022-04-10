function [nval lval period cv gv q]=read_dotqfile(filename)
% from Colleen Dalton

format='%s %s %s %s %s %s %s';
[sn,sl,sw,sq,sx,scv,sgv]=textread(filename,format,20000);

n=0;
startnum=16;
if strcmp(filename(1:6),'STW105')
    startnum=19;
end
for i=startnum:length(sn)
    n=n+1;
    period(n)=2*pi/str2num(char(sw(i)));
    cv(n)=str2num(char(scv(i)));
    gv(n)=str2num(char(sgv(i)));
    q(n)=str2num(char(sq(i)));
    nval(n)=str2num(char(sn(i)));
    lval(n)=str2num(char(sl(i)));    
end



