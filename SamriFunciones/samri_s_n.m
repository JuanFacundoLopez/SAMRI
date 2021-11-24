%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_s_n.m                                                    *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_s_n(varargin)
%   samdir_s_n - Mide la relación señal ruido del sistema de medición,
%   grabando primero una señal de muestra y luego el ruido, por último
%   realiza la S/N y devuelve este valor en dB.
%
%   Sintaxis: valor_s_n = samdir_s_n()
%   
%   a = samdir_s_n()
%   
%   valor_S_N:    relación señal/ruido del sistema en dB
%   
%% Variables globales
Fs      = 44100;
nivel   = 0;


%% Generación y grabación de un tono de 1kHz
tono    = samdir_generate('sine',1,1000,44100,17);
amp     = samdir_nivel(nivel);
tono.timeData   = tono.timeData.*amp;
tono_grab       = samdir_reproduce_graba(tono);
% Selecciono solo dos segundos y saco la energía
tono_vec        = tono_grab.timeData(end-2*Fs+1:1:end);
energ_tono      = tono_vec.^2;
rms_tono        = 10*log10(sum(energ_tono)/Fs);
% Avisa si los niveles son muy altos
nivel_grab      = max(abs(tono_grab.timeData));
if (nivel_grab > 0.9)
    fprintf ('\nNivel de grabación muy alto: %f', nivel_grab);
end

%% Grabación del ruido
ruido_grab      = samdir_graba(3);
% Selecciono solo un segundo y saco la energía
ruido_vec       = ruido_grab.timeData(end-2*Fs+1:1:end);
energ_ruido     = ruido_vec.^2;
rms_ruido       = 10*log10(sum(energ_ruido)/Fs);

%% Relación señal/ruido obtenida
S_N = rms_tono - rms_ruido;
varargout(1) = {S_N};
varargout(2) = {nivel_grab}; %Este valor puede utilizarse para realizar un vúmetro
plot (tono_grab.timeData)
end
