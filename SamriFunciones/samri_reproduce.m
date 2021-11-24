function varargout = samri_reproduce(audioObj,amplitud)

%% Variables globales
fs          = audioObj.samplingRate;
nChannels   = 1;
exitacion   = audioObj.timeData * amplitud;
repeticion  = 1; %Modificar
EsperarReproduccion = 1; % el 1 significa que espera 
%% Reproducción

pahandleReproduccion    = PsychPortAudio(  'Open',...      % Open Psych-Audio port, with the follow arguements
                            [],...          % La salida que mas le pinte
                            1,...           % 1 = sound playback only
                            1,...           % 1 = default level of latency
                            fs,...          % Requested frequency in samples per second
                            nChannels);    % 2 = stereo putput
                        
PsychPortAudio('FillBuffer', pahandleReproduccion, exitacion');   % Cargo el vector en el buffer

PsychPortAudio('Start', pahandleReproduccion, repeticion);       % Reproduzco  lo del buffer

PsychPortAudio('Stop',pahandleReproduccion, EsperarReproduccion);
PsychPortAudio('Close',pahandleReproduccion);

end
