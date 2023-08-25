% Read in all the kernels 

Periodlist = [5     6     8    10    12    15    20    25    30    35    40    45  50    60    75];
%Periodlist = [5     6     8    10];%    12    15    20    25    30    35    40    45  50    60    75];
%Periodlist = [5 6 8 10 12 15 20 25 30 35 40 45 50 60 75];
% Periodlist = [10   12    15    20    25    30    35    40    45  50    60    75];

for ijk= 1:length(Periodlist)
kernfo = load(['Kernels/FineSampleSL13_lat4000_lon-10075.cardkern' num2str(Periodlist(ijk)) '_sec']);
rad = kernfo(:,1);
kern_use =kernfo(:,3);
kernstore(ijk,:) = kern_use;
end