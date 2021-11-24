%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_deconv_circular.m                                        *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_deconv_circular(varargin)
%   samdir_deconv_circular - Realiza la deconvoluci�n circular, mediante la 
%   divisi�n en la frecuencia y realizando luego la transformaci�n al dominio del tiempo.
%
%   Sintaxis: samdirAudio = samdir_deconv_circular(samdirAudio, samdirAudio)
%
%   c = samdir_deconv_circular(a,b)
%
%% Inicializaci�n
grab    = varargin{1}; 
exc     = varargin{2}; 

%% Convoluci�n

Y = fft( grab.timeData, grab.nSamples*2 );  % transformada de Fourier de la grabaci�n
X = fft( exc.timeData, exc.nSamples*2  );  % transformada de Fourier de la excitaci�n

H = Y ./ X;                          % divisi�n de espectros
h = ifft( H );                      % se vuelve al dominio del tiempo

audioObj = samdirAudio;
audioObj.timeData = h;

% Si las se�ales ten�an una longitud de 2^N, la IR tiene una longitud de
% 2^(N+1)-1 muestras, por lo que se agrega un sample. Tambi�n se camb�a el
% tipo de se�al de potencia a energ�a y el 'comment'.

%audioObj.timeData(audioObj.nSamples+1) = 0;
audioObj.comment = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end