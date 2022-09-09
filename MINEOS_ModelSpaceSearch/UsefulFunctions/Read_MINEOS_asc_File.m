function [ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = Read_MINEOS_asc_File(fname)
% Reads mineos asc file
% AH 
% Format of ModelMat is 
%   level radius  rho  vpv  vph   vsv vsh eta  qmu   qkap

%fname = ['TAYAK_Toroidal_B010.asc'];

fid = fopen(fname);
while  ~feof(fid)
    tmp = fgetl(fid);
    Strings=strsplit(tmp,' ');

    if strcmp(Strings{1},'integration')
        clear counter
    end

    if  exist('counter') & length(tmp)>0
        Strings=Strings(2:end);
        counter=counter+1;
        
        for ijk = 1:length(Strings)
        tmpparr(ijk) = str2num(Strings{ijk});

        end

        ModelMat(counter,:) = tmpparr;
        
    end



    if  exist('modecounter') & length(tmp)>0
        modecounter=modecounter+1;
                Strings=Strings(2:end);

        nlist(modecounter) = str2num(Strings{1});
        llist(modecounter) = str2num(Strings{3});
  phvel(modecounter)    = str2num(Strings{4});    
  wmhz(modecounter)   = str2num(Strings{5});       
  tsecs(modecounter)   = str2num(Strings{6});  
  grpvel(modecounter)   = str2num(Strings{7});   
  q(modecounter)  = str2num(Strings{8});
  raylquo(modecounter)= str2num(Strings{9});

        
    end





    if strcmp(Strings{end},'qkap')
    counter=0;

    end

if length(Strings)>1
    if strcmp(Strings{end},'raylquo')
    modecounter=0;

    end
end

end

fclose(fid)

end