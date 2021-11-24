%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_grabar_wav.m                                             *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_grabar_wav(varargin)
%   samdir_grabar_wav - Graba la señal ingresada como argumento en un
%   archivo .wav. Lo normaliza si sobrepasa el nivel de full scale.
%
%   Sintaxis: samdir_grabar_wav(samdirAudio, samplingRate, nBits)
%
%   samdirAudio:    señal a grabar
%

%% Variables de la GUI
audioObj    = varargin{1}; 
fs          = varargin{2};
nBits       = varargin{3};

%% Normalización y grabado en .wav
maximo          = find(abs(audioObj.timeData) == max(abs(audioObj.timeData)));

if (abs(audioObj.timeData(maximo)) > 1)
    result.timeData = audioObj.timeData(1:1:end)./abs(audioObj.timeData(maximo));
end

wavwrite(0.9999*audioObj.timeData,fs,nBits,uiputfile({'*.wav'},'Guardar como'));

end