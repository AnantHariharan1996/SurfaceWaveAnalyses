function [String] = Run_MineosQ(inputfile,execfname)
%execfname='mineos_q';
%inputfile = 'ParamFile_StartingQ'
String = ['./' execfname ' < ' inputfile];
system(String)
end