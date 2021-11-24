%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_resol_frec.m                                             *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_resol_frec(varargin)
%   samdir_resol_frec - Calcula la resolución en frecuencia posible de
%   acuerdo a la longitud de la señal y su frecuencia de muestreo. Recibe
%   como argumentos la Fs y el grado de la señal (2^n)
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

%% Cálculo de resolución en frecuencia
resolucion  = fs/2^grado;
% Redondeo a dos cifras significativas
resolucion  = roundn(resolucion, -2);

varargout(1) = {resolucion};
end
 