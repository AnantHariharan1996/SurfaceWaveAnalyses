function [Rads2Plot,VelocityVals2Plot] = Get_Layered_Model_For_Plotting(m,layeredges)
% Converts from layer edges format to layer values for plotting. 
VelocityVals2Plot=[];
Rads2Plot=[];
for ijk = 1:length(m)

    currvshval = m(ijk);
    VelocityVals2Plot=[VelocityVals2Plot currvshval currvshval];
    Rads2Plot = [Rads2Plot layeredges(ijk) layeredges(ijk+1)];

end

end