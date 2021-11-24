function varargout = samri_reproduce_graba(varargin)
%   samri_grabar - Reproduce una señal ingresada como argumento y
%   devuelve la grabación.
%
%   Sintaxis: samriAudio = samdir_reproduce_graba(VectorDeAudio,IndexInput,IndexOutput,fs)
%   
%   b = samri_grabar(a)
%   
%% Inicialización  

excitacion  = varargin{1};
IndexInput  = varargin{2};
IndexOutput = varargin{3};
fs          = varargin{4};
% fs = 48000;
tiempoGrab  = length(excitacion)/fs;
grabacion   = samriAudio();
grabacion.samplingRate = fs;
recordedaudio = [];

%%
nrchannels = 2;
repetitions = 1;            %[, deviceid][, mode][, reqlatencyclass][, freq][, channels]

pahandleReproduccion    = PsychPortAudio(  'Open',...      % Open Psych-Audio port, with the follow arguements
                            IndexOutput,... % Indice de dispositivo de audio
                            1,...           % 1 = sound playback only
                            3,...           % 1 = default level of latency
                            fs,...          % Requested frequency in samples per second
                            nrchannels);    % 2 = stereo putput
                        
pahandleGrabacion       = PsychPortAudio(  'Open',...      % Open Psych-Audio port, with the follow arguements
                            IndexInput,...  % Indice de dispositivo de audio
                            2,...           % 2 = sound recorder only
                            3,...           % 1 = default level of latency. le meti un 3 para mejorar la respuesta y mejoro
                            fs,...          % Requested frequency in samples per second
                            nrchannels);    % 2 = stereo putput
                        
                        
                        
PsychPortAudio('FillBuffer', pahandleReproduccion, [excitacion'; excitacion']);   % Cargo el vector en el buffer
PsychPortAudio('GetAudioData', pahandleGrabacion, tiempoGrab);                  % Programo la grabacion

PsychPortAudio('Start', pahandleReproduccion, repetitions);                     % Reproduzco  lo del buffer
PsychPortAudio('Start', pahandleGrabacion, 0, 0, 1);                            % Comienzo la captura

while (length(recordedaudio) / fs) < tiempoGrab   
    audiodata = PsychPortAudio('GetAudioData', pahandleGrabacion);
    recordedaudio = [recordedaudio, audiodata];                                  % concateno el vector. esta buena la recomendacion que me da matlab de prereservar la memoria para mayot velocidad
end

grabacion.timeData = recordedaudio(1,:)';
PsychPortAudio('Stop',pahandleReproduccion);
PsychPortAudio('Stop',pahandleGrabacion);
PsychPortAudio('Close');

varargout(1) = {grabacion};
end