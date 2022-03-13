function [ ceik,lonout,latout ] = Get_Eikonal_PhVel( eqlat,eqlon,stlat,stlon,ttime )
% Calculate Eikonal phase velocities from an array of traveltime
% measurements
% Copied ffrom Colleen and Estevan's codes, just wrapped into a function

  [d,az]=distance(eqlat,eqlon,stlat,stlon);
  dkm=deg2km(distance(eqlat,eqlon,stlat,stlon));
  p=polyfit(dkm,ttime,1);
    ave_c=1./p(1);
  tp=polyval(p,dkm);
  meanv=mean(abs(tp-ttime));
  h=find(abs(tp-ttime)>(3*meanv)); %remove outlier travel times
  stlat(h)=[];
  stlon(h)=[];
  ttime(h)=[];
  
  %%%
    xmin=min(stlon);
    xmax=max(stlon);
    ymin=min(stlat);
    ymax=max(stlat);
    [xgrid,ygrid] = meshgrid(xmin:0.125:xmax,ymin:0.125:ymax);

  tgrid=griddata(stlon,stlat,ttime,xgrid,ygrid);

  allx=xgrid(:);
  ally=ygrid(:);
  allt=tgrid(:);

  % weighted averaging
  newt=allt;
  num=zeros(length(newt),1);
  for j=1:length(allx)
    d2=distance(ally(j),allx(j),ally,allx);
    h=find(d2<1 & ~isnan(allt));
    num(j)=length(h);
    if (num(j)>0);
        %newt(j)=mean(allt(h));
        %newa(j)=mean(alla(h));
	newt(j)=sum(allt(h)./(d2(h)+0.1).^2)/sum(1./(d2(h)+0.1).^2);
    end
  end
  tgrid2=reshape(newt,[size(xgrid)]);  


  [fx,fy]=gradient(tgrid2,deg2km(0.125),deg2km(0.125)); %dt/dtheta and dt/dphi
sincolat=sind(90-ygrid);
  tgrad=sqrt(fy.^2+(fx./sincolat).^2);
  ceik=1./tgrad;
ceik=1000*ceik(:); %m/s
  lonout=allx;
  latout=ally;
  
  
  idx=find(isnan(ceik)==1);
  ceik(idx)=[];
  latout(idx)=[];
  lonout(idx)=[];
end

