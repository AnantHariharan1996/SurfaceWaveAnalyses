function [ new_taxis,new_stadata ] = resample_anti_alias( resample_delta,delta,time,stadata )

old_taxis = 0:delta:(length(stadata)-1)*delta;
new_taxis = 0:resample_delta:(length(stadata)-1)*delta;
% apply anti-alias filter
fN = 1/2/delta;
w_c = 1./2/resample_delta/fN;
[b,a] = butter(2,w_c,'low');
stadata = filtfilt(b,a,stadata);
new_stadata = interp1(old_taxis,stadata,new_taxis,'spline');


end

