%% Configuracion audio
fs          = 48000;
% Dispositivos conectados
disp = daqhwinfo('winsound');
% Nombres
disp.BoardNames;
% IDs
disp.InstalledBoardIds;

tic
%% Creación de los objetos de reproducción y grabación
% Entrada
    entrada     = analoginput('winsound', 2);   
    addchannel(entrada, 1);     
    entrada.TriggerType = 'Immediate';
% Salida
    salida      = analogoutput('winsound',0);
    addchannel(salida, 1);    
    salida.TriggerType = 'Immediate'; 
% Seteo de la frecuencia de muestreo
if (daqhwinfo(entrada,'MaxSampleRate')< daqhwinfo(salida,'MaxSampleRate'))
    min_fs = daqhwinfo(entrada,'MaxSampleRate');
else
    min_fs = daqhwinfo(salida,'MaxSampleRate');
end

if (fs>min_fs)
    fprintf('\n Alguno de los dispositivos no soporta esa frecuencia de muestreo');
    entrada.SampleRate  = min_fs;
    salida.SampleRate   = min_fs;
else
    entrada.SampleRate  = fs;
    salida.SampleRate   = fs;
end
toc   
% Bits de resolución, 'winsound' soporta 8 o 16
bits= daqhelp(entrada,'BitsPerSample');
bits= daqhelp(salida,'BitsPerSample');
    
delete ([entrada salida]);