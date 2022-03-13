clear
close all
eventlist = dir('*_cs_LHZ.mat');

periods = [20 40 50 60 80 100]; % this combination so far only used for the measurements in checks_parallel_ekstrom

for ii = 1:length(periods)
    iper = ii;


    for i = 1:length(eventlist)

        load(eventlist(i).name);
        evla=eventcs.evla;
        evlo=eventcs.evlo;
        sta1 = extractfield(eventcs.CS,'sta1');
        sta2 = extractfield(eventcs.CS,'sta2');
        staall=[sta1; sta2];
        [u,ia,ib]=unique(staall);

        u=unique([sta1; sta2]);
        gmat = zeros(length(sta1),length(u));
        dmat = zeros(length(sta1),1);
        allamp=[eventcs.autocor.amp];
        amp=sqrt(allamp(iper:length(periods):length(allamp)));
        amp=amp(staall(ia));
        stalat=eventcs.stlas(staall(ia));
        stalon=eventcs.stlos(staall(ia));
        for k = 1:length(eventcs.CS)
                b1 = find(u==sta1(k));
                b2 = find(u==sta2(k));
                gmat(k,b1) = 1;
                gmat(k,b2) = -1;
                dmat(k) = eventcs.CS(k).dtp(iper);
        end
        %Method 1
        tabs=lsqr(gmat,dmat,[],1000); % Using 200 iterations is necessary to converge to the right phvels... 
        %Method 2
        %tabs=inv(gmat'*gmat)*(gmat'*dmat);
        %Method 4
        %tabs = pinv(gmat)*dmat;
        %Method 5
        %tabs=gmat\dmat;

        nsamp=sum(abs(gmat));
        clear z
        if(length(tabs)~=length(amp))
            error('stopping')
        else
            z(:,1)=evla*ones(length(tabs),1);
            z(:,2)=evlo*ones(length(tabs),1); 
            z(:,3)=stalat;
        z(:,4)=stalon;
            z(:,5)=tabs;
            z(:,6)=nsamp;
            z(:,7)=amp;
            outfile=strcat('dtpamp_',num2str(periods(iper)),'s_',eventcs.id);
            dlmwrite(outfile,z,'delimiter','\t','precision','%.9f') % Option so that don't need to deal with scientific notation with awk
            %save(outfile,'z','-ascii');
            disp(strcat('finished event',{' '},eventlist(i).name))
        end
    end
end



