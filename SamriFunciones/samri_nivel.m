%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_nivel.m                                                  *                           
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_nivel(varargin)
%   samdir_nivel - Calcula el multiplicador para variar el nivel de la 
%   se�al, teniendo como argumento de entrada el valor en dB y su 
%   argumento de salida en decimal.
%
%   Sintaxis: nivel_dec = samdir_nivel(nivel_dB)
%
%   b = samdir_nivel(-3)
%
%%
nivel_dB    = varargin{1}; 

exp         = nivel_dB/20;
nivel_dec   = 10^exp;

if(nivel_dec==1)
    nivel_dec=0.999;        %Para prevenir clipping
end

varargout(1) = {nivel_dec};
end
