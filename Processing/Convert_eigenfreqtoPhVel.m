function [c] = Convert_eigenfreqtoPhVel(eigenfreq,l,rad)
% takes in eigenfreqy in hz, l ang order and radius in m. 
c = eigenfreq*rad/(l+0.5); 
% dimensions are m/s if the above units are used
end