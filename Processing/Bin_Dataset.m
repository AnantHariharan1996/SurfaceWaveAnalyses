function [ Binned_Vector_Median,Binned_Vector_UpperQ,Binned_Vector_LowerQ,lenlist ] = ...
    Bin_Dataset(Xvec,Yvec,XvecBinLocs,BinWidth )
% Takes in a vector of values Yvec, corresponding to the points in Xvec.
% bin this variable using the bin locations in BinWidth.

bcounter=0;
for BinLoc = XvecBinLocs
    bcounter=bcounter+1;    
    idx = find(Xvec > BinLoc-BinWidth & Xvec < BinLoc+BinWidth );
    Binned_Vector_Median(bcounter) = median(Yvec(idx));
   y = quantile(Yvec(idx),[0.25 0.5 0.75]);
   Binned_Vector_LowerQ(bcounter) = y(1);
   Binned_Vector_UpperQ(bcounter) = y(3);
   lenlist(bcounter) = length(idx);
    
    
end
    
    
end

