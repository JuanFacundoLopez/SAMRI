%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_deconv_circular.m                                        *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_deconv_circular(varargin)
%   samdir_deconv_circular - Realiza la deconvolución circular, mediante la 
%   división en la frecuencia y realizando luego la transformación al dominio del tiempo.
%
%   Sintaxis: samdirAudio = samdir_deconv_circular(samdirAudio, samdirAudio)
%
%   c = samdir_deconv_circular(a,b)
%
%% Inicialización
grab    = varargin{1}; 
exc     = varargin{2}; 

%% Convolución

Y = fft( grab.timeData, grab.nSamples*2 );  % transformada de Fourier de la grabación
X = fft( exc.timeData, exc.nSamples*2  );  % transformada de Fourier de la excitación

H = Y ./ X;                          % división de espectros
h = ifft( H );                      % se vuelve al dominio del tiempo

audioObj = samdirAudio;
audioObj.timeData = h;

% Si las señales tenían una longitud de 2^N, la IR tiene una longitud de
% 2^(N+1)-1 muestras, por lo que se agrega un sample. También se cambía el
% tipo de señal de potencia a energía y el 'comment'.

%audioObj.timeData(audioObj.nSamples+1) = 0;
audioObj.comment = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end