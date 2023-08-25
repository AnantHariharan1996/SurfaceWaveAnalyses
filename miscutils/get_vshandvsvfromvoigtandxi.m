function [Vsv,Vsh] = get_vshandvsvfromvoigtandxi(voigt,xi)
%get vsh and vsv from voigt and xi
Vsv=sqrt((3*(voigt^2))/(2+xi));
Vsh = (sqrt(xi))*Vsv;
end 