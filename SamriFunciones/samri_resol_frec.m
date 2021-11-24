%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_resol_frec.m                                             *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_resol_frec(varargin)
%   samdir_resol_frec - Calcula la resoluci�n en frecuencia posible de
%   acuerdo a la longitud de la se�al y su frecuencia de muestreo. Recibe
%   como argumentos la Fs y el grado de la se�al (2^n)
%
%   Sintaxis: resolucion = samdir_resol_frec(fs,grado)
%
%   fs:     frecuencia de muestreo
%   grado:  longitud deseada en potencia de 2
%
%   resolucion = samdir_resol_frec(48000,16)
%
%% Variables de la GUI  
fs      = varargin{1};
grado   = varargin{2};  

%% C�lculo de resoluci�n en frecuencia
resolucion  = fs/2^grado;
% Redondeo a dos cifras significativas
resolucion  = roundn(resolucion, -2);

varargout(1) = {resolucion};
end
 