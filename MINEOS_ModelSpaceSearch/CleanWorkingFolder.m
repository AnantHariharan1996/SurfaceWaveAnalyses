%% Clean up working folder
clear;
flist = dir('*.card')
for ijk=1:length(flist)
delete(flist(ijk).name)

end

flist = dir('ParamFile_PREMLVZ*')
for ijk=1:length(flist)
delete(flist(ijk).name)

end

flist = dir('eig_Files/*.eig')
for ijk=1:length(flist)
delete(['eig_Files/' flist(ijk).name])

end

flist = dir('asc_Files/*.asc')
for ijk=1:length(flist)
delete(['asc_Files/' flist(ijk).name])

end
% 
% flist = dir('Card_Files/*.card')
% for ijk=1:length(flist)
% delete(['Card_Files/' flist(ijk).name])
% 
% end