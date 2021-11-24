%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_nivel.m                                                  *                           
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_nivel(varargin)
%   samdir_nivel - Calcula el multiplicador para variar el nivel de la 
%   señal, teniendo como argumento de entrada el valor en dB y su 
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
