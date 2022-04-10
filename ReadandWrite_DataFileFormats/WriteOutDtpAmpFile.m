function [ zz,outfnamepath ] = WriteOutDtpAmpFile( outfnamepath,elat,elon,slats,slons,tts,amps )
% Write out dtpamp files in the format that is useful for the lap_sc codes
% assumes all inputs are 1d vectors or scalars in the case of evla or evlo

zz(:,1) = elat(1)*ones(size(tts));
zz(:,2) = elon(1)*ones(size(tts));
zz(:,3) = slats;
zz(:,4) = slons;
zz(:,5) = tts;
zz(:,6) = ones(length(tts),1);
zz(:,7) = amps;

dlmwrite(outfnamepath,zz,'delimiter','\t','precision','%.6f')

end

