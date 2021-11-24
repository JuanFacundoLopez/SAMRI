%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_deconv_lineal.m                                          *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_deconv_lineal(varargin)
%   samdir_deconv_lineal - Realiza la deconvolución lineal, mediante la 
%   convolución en el tiempo de la señal grabada con el filtro inverso de
%   la señal de excitación.
%
%   Sintaxis: samdirAudio = samdir_deconv_lineal(samdirAudio, samdirAudio)
%
%   c = samdir_deconv_lineal(a,b)
%
%% Variables de la GUI
fs      = 48000;

%% Inicialización
grab    = varargin{1}; 
inv     = varargin{2}; 

%% Convolución
audioObj = samdirAudio;
audioObj.samplingRate = fs;
audioObj.timeData = conv(grab.timeData,inv.timeData);

% Si las señales tenían una longitud de 2^N, la IR tiene una longitud de
% 2^(N+1)-1 muestras, por lo que se agrega un sample. También se cambía el
% tipo de señal de potencia a energía y el 'comment'.

audioObj.timeData(audioObj.nSamples+1) = 0;
audioObj.comment = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end