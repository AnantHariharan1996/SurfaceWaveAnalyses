function [NewFname] = Interpolate_CardFile_Finer(NewFname,Path2CardFile,discretization_km,discretization_km_limit)
% Takes an existing card file. Reads it in. At depths shallower than
% discretization_km_limit, linearly interpolates between elements to make
% sure the sampling is at least discretization_km.
% Also checks so that this is not performed at discontinuities, where
% interpolation would normally fail. 
[ model,discz ] = read_cardfile( Path2CardFile );
discrows = strsplit(discz,' ');
discretization_m = 1000*discretization_km;
array_to_define = [0:discretization_km:discretization_km_limit];
rhostore = [];
vpvstore = [];
vsvstore = [];
vphstore = [];
vshstore = [];
qkstore=[];
qmstore=[];
etastore=[];
zstore = [];

%%

for ijk = 1:length(model.Z)-1
    currz = model.Z(ijk);
    nextz = model.Z(ijk+1);
    known_zs = [currz nextz];
    % in km
    % check if the space in between the points is greater than the discretization
    zdiff = nextz-currz;
    if zdiff > discretization_km
        % get the points we want to interpolate
        idx2get = find(array_to_define >currz & array_to_define< nextz)
        points2interpon = array_to_define(idx2get);
        %do interpolation now
        % for rho
        curr_rho = model.rho(ijk);
        next_rho = model.rho(ijk+1);
        rhoq = interp1(known_zs,[curr_rho next_rho],points2interpon);
        %for vpv
        curr_vpv = model.Vpv(ijk);
        next_vpv = model.Vpv(ijk+1);
        vpvq = interp1(known_zs,[curr_vpv next_vpv],points2interpon);
        
        %for vsv
        curr_vsv = model.Vsv(ijk);
        next_vsv = model.Vsv(ijk+1);
        vsvq = interp1(known_zs,[curr_vsv next_vsv],points2interpon);
        
        % for vph
        curr_vph = model.Vph(ijk);
        next_vph = model.Vph(ijk+1);
        vphq = interp1(known_zs,[curr_vph next_vph],points2interpon);
        
        % for Vsh
        curr_vsh = model.Vsh(ijk);
        next_vsh = model.Vsh(ijk+1);
        vshq = interp1(known_zs,[curr_vsh next_vsh],points2interpon);
        
        %for Qk
        curr_qk = model.Qk(ijk);
        next_qk = model.Qk(ijk+1);
        Qkq = interp1(known_zs,[curr_qk next_qk],points2interpon);
        
        % for Qm
        curr_qm = model.Qm(ijk);
        next_qm = model.Qm(ijk+1);
        Qmq = interp1(known_zs,[curr_qm next_qm],points2interpon);
        
        % for etaa
        curr_eta = model.eta(ijk);
        next_eta = model.eta(ijk+1);
        etaq = interp1(known_zs,[curr_eta next_eta],points2interpon);
        
        %etaq = (vshq./vsvq).^2;
        % for Vs
        % for Vp
         % store measurements in card file    
        rhostore = [rhostore model.rho(ijk) rhoq];
        vpvstore = [vpvstore model.Vpv(ijk) vpvq];
        vsvstore = [vsvstore model.Vsv(ijk) vsvq];
        vphstore = [vphstore model.Vph(ijk) vphq];
        vshstore = [vshstore model.Vsh(ijk) vshq];
        qkstore=[qkstore model.Qk(ijk) Qkq];
        qmstore=[qmstore model.Qm(ijk) Qmq];
        etastore=[etastore model.eta(ijk) etaq];
        zstore = [zstore model.Z(ijk) points2interpon];
         
    else
         % store measurements in card file    
        rhostore = [rhostore model.rho(ijk)];
        vpvstore = [vpvstore model.Vpv(ijk)];
        vsvstore = [vsvstore model.Vsv(ijk)];
        vphstore = [vphstore model.Vph(ijk)];
        vshstore = [vshstore model.Vsh(ijk)];
        qkstore=[qkstore model.Qk(ijk)];
        qmstore=[qmstore model.Qm(ijk)];
        etastore=[etastore model.eta(ijk)];
        zstore = [zstore model.Z(ijk)];
          
    end

end

% store measurements in card file    
rhostore = [rhostore model.rho(ijk+1)];
vpvstore = [vpvstore model.Vpv(ijk+1)];
vsvstore = [vsvstore model.Vsv(ijk+1)];
vphstore = [vphstore model.Vph(ijk+1)];
vshstore = [vshstore model.Vsh(ijk+1)];
qkstore=[qkstore model.Qk(ijk+1)];
qmstore=[qmstore model.Qm(ijk+1)];
etastore=[etastore model.eta(ijk+1)];
zstore = [zstore model.Z(ijk+1)];
radstore = 6371000-1000.*zstore;
% write out the measurements now! 
fid=fopen(NewFname,'w');
fprintf(fid,'%s\n',NewFname);
fprintf(fid,'1 1.0 1\n');
ntot=length(vpvstore);
fprintf(fid,'%d %d %d\n',[ntot str2num(discrows{3}) str2num(discrows{4})]); % CHANGE THE LAST TWO

fmt='%7.0f.%9.2f%9.2f%9.2f%9.1f%9.1f%9.2f%9.2f%9.5f\n';
for n=ntot:-1:1
fprintf(fid,fmt,[radstore(n)...
   rhostore(n) vpvstore(n) vsvstore(n) ...
   qkstore(n) qmstore(n) vphstore(n) ...
   vshstore(n) etastore(n)]);

end
fclose(fid); 

end