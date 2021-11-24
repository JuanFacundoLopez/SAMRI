%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_grabar_wav.m                                             *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_grabar_wav(varargin)
%   samdir_grabar_wav - Graba la se�al ingresada como argumento en un
%   archivo .wav. Lo normaliza si sobrepasa el nivel de full scale.
%
%   Sintaxis: samdir_grabar_wav(samdirAudio, samplingRate, nBits)
%
%   samdirAudio:    se�al a grabar
%

%% Variables de la GUI
audioObj    = varargin{1}; 
fs          = varargin{2};
nBits       = varargin{3};

%% Normalizaci�n y grabado en .wav
maximo          = find(abs(audioObj.timeData) == max(abs(audioObj.timeData)));

if (abs(audioObj.timeData(maximo)) > 1)
    result.timeData = audioObj.timeData(1:1:end)./abs(audioObj.timeData(maximo));
end

wavwrite(0.9999*audioObj.timeData,fs,nBits,uiputfile({'*.wav'},'Guardar como'));

end