%% MATLAB script to download receiver functions by station for the earthscope EARS
% # Usage: 1. on the EARS main page, search for the desired stations using the search form on the 
% #          left panel. and save the "network,station" pairs as "stationList.csv" file.
% #
% #        2. run this MATLAB script in the same directory as the stationList.csv file. 
% #           The script will print one wget command per event to download a zip file of 
% #           all receiver functions . 
% #
% This is a MATLAB port of the Python script on the EARS website
% Anant Hariharan, 2022 


clear; clc; close all;
%% EDIT PARAMETERS BELOW HERE
OutputDir = ['EARS_Output'];
CSV_Name = ['stationList_TA.csv'];
Percent_Threshold = 80;

%% DO NOT EDIT ANYTHING BELOW HERE

info =readtable(CSV_Name,'NumHeaderLines',0)
Nets = table2cell(info(:,1));
StaName = table2cell(info(:,2));

for ijk=1:length(Nets)
   disp(['Percent Complete:' num2str(100*ijk/length(Nets))] )
currNet=Nets{ijk}; currSta=StaName{ijk};
outdir = [OutputDir '/' currNet '_' currSta];
outfile = [outdir '/' currNet '_' currSta '.zip'];

mkdir(outdir)
url2use= ['http://ears.iris.washington.edu/receiverFunction.zip?netCode=' ...
    currNet '&stacode=' currSta ''...
    '&minPercentMatch=' num2str(Percent_Threshold) '&sgaussian=2.5']
websave(outfile,url2use)

end