%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_deconv_lineal.m                                          *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_deconv_lineal(varargin)
%   samdir_deconv_lineal - Realiza la deconvoluci�n lineal, mediante la 
%   convoluci�n en el tiempo de la se�al grabada con el filtro inverso de
%   la se�al de excitaci�n.
%
%   Sintaxis: samdirAudio = samdir_deconv_lineal(samdirAudio, samdirAudio)
%
%   c = samdir_deconv_lineal(a,b)
%
%% Variables de la GUI
fs      = 48000;

%% Inicializaci�n
grab    = varargin{1}; 
inv     = varargin{2}; 

%% Convoluci�n
audioObj = samdirAudio;
audioObj.samplingRate = fs;
audioObj.timeData = conv(grab.timeData,inv.timeData);

% Si las se�ales ten�an una longitud de 2^N, la IR tiene una longitud de
% 2^(N+1)-1 muestras, por lo que se agrega un sample. Tambi�n se camb�a el
% tipo de se�al de potencia a energ�a y el 'comment'.

audioObj.timeData(audioObj.nSamples+1) = 0;
audioObj.comment = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end