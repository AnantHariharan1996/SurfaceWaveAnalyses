%% READ AVS INP FILE generated from SPECFEM
% Anant Hariharan, August 2018
plot = 1;
fname = 'AVS_fullmesh.inp'
%% Assigns a coordinate to each cell by taking the coordinate as the mean of all the nodes 
%% that surround it. 

%% Read line 1
fid = fopen(fname,'r')
 line1 = fgets(fid);
C = strsplit(line1,' ');
numnodes = str2num(C{2});
numcells = str2num(C{3});
%% Read node id and coords
nodecoords = textscan(fid,' %f %f %f %f',numnodes);
%% Read cell type and adjacent node ids
celllocinfo = textscan(fid,' %f %f %s %f %f %f %f',numcells);
%% Read Cellvalue
cellproperty = textscan(fid,'%f %f',numcells,'headerlines',3); % Why 3? hmm...

%%%%%% Now process

cellx = zeros([1 numcells]);
celly = cellx;
cellz = celly;


for i = 1:numcells
    100*i/numcells
    tempx = [];
    tempy = [];
    tempz = [];
    for nodenum = 4:7
        currnode = celllocinfo{nodenum}(i);
        idx = find(nodecoords{1} == currnode);
        tempx = [tempx nodecoords{2}(idx)];
        tempy = [tempy nodecoords{3}(idx)];
        tempz = [tempz nodecoords{4}(idx)];
    end
    cellx(i) = mean(tempx);
    celly(i) = mean(tempy);
    cellz(i) = mean(tempz);  
end

[azimuth,elevation,r] = cart2sph(cellx,cellx,cellz)

%%%%% Now make plot if you want
if plot
figure()
scatter3(nodecoords{2},nodecoords{3},nodecoords{4},1,'k')
hold on
%% Plot cell info
scatter3(cellx,celly,cellz,20,cellproperty{2},'filled')
colorbar
colormap(flipud(jet))
xlabel('x')
ylabel('y')
zlabel('z')
end