function [ AmpMeasured ] = Measure_Amplitude_Autocor( velo_lo,velo_hi,t,Amps,X,Period )
    % Measures amplitude from the peak of the autocorrelation spectrum
    % I think the sampling rate is currently hard coded to be 1, oops, my
    % bad, I should be better than that

    tstart=(X)/velo_hi;
    tend=(X)/velo_lo;
    h=find(t>=tstart & t<=tend);
    %[c1,lags1]=xcorr(t(h),Amps(h));
    [c1,lags1]=xcorr(Amps(h),Amps(h));    
    
    
    AmpMeasured=sqrt(max(c1));    
      
end

