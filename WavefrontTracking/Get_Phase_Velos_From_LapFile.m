
function [ lon,lat,HlmholtzPhVel,EikonalPhVel ] = Get_Phase_Velos_From_LapFile( filename,period )
% loads lap file and calculates phase velocities...
    vals = load(filename);
    omega = 2*pi/period;
    lon = vals(:,1);
    lat = vals(:,2);
    Term3 = vals(:,4);
    Term2 = vals(:,3);
    HlmholtzPhVel = HelmholtzPhz( period,Term2,Term3 )/1000;
    EikonalPhVel = sqrt(1./Term2)/1000;

end

