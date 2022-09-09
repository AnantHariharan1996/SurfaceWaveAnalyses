function [String] = Run_Mineos(inputfile,execfname)
%execfname='minos_bran_moreknot';
%inputfile = 'Param_Prem_Spheroidal'
String = ['./' execfname ' < ' inputfile];
system(String)
end