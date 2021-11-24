% accion        =     2;       %   1- Reproducción : 2-Grabación 3-fullduplex
modo_latencia =     2;       % Control de la libreria al dispositivo de audio
canales = 2;
% [excitacion_mod, fs]= audioread('C:\Users\Facu\Desktop\Audios\IR_prueba.wav');
% plot(excitacion_mod')
% duracion      = length(excitacion_mod)/fs;
fs = 44100;
ID_entrada = 1;
ID_salida = 5;
        
% pahandle_salida = PsychPortAudio('Open', ID_salida, 1, modo_latencia, fs , canales);
%        
%         Preallocate an internal audio recording  buffer with a capacity
%         del tamaño de la señal
%         
% PsychPortAudio('FillBuffer', pahandle_salida,[excitacion_mod'; excitacion_mod']);
% 
%         
phandle_entrada = PsychPortAudio('Open', ID_entrada, 2, modo_latencia, fs , 1);
%        
PsychPortAudio('GetAudioData', phandle_entrada, 1);
recorder = [];

PsychPortAudio('Start', phandle_entrada);

while length(recorder)/fs < 100 % grabo durante 5 segundos
%         Fetch current audiodata:
    audiodata = PsychPortAudio('GetAudioData', phandle_entrada);
    recorder = [recorder audiodata]; 
    plot(audiodata(:))
    drawnow;
end

% PsychPortAudio('Stop', pahandle_entrada,duracion);
% PsychPortAudio('Stop', pahandle_salida, duracion);
PsychPortAudio('Close');