%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_s_n.m                                                    *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_s_n(varargin)
%   samdir_s_n - Mide la relaci�n se�al ruido del sistema de medici�n,
%   grabando primero una se�al de muestra y luego el ruido, por �ltimo
%   realiza la S/N y devuelve este valor en dB.
%
%   Sintaxis: valor_s_n = samdir_s_n()
%   
%   a = samdir_s_n()
%   
%   valor_S_N:    relaci�n se�al/ruido del sistema en dB
%   
%% Variables globales
Fs      = 44100;
nivel   = 0;


%% Generaci�n y grabaci�n de un tono de 1kHz
tono    = samdir_generate('sine',1,1000,44100,17);
amp     = samdir_nivel(nivel);
tono.timeData   = tono.timeData.*amp;
tono_grab       = samdir_reproduce_graba(tono);
% Selecciono solo dos segundos y saco la energ�a
tono_vec        = tono_grab.timeData(end-2*Fs+1:1:end);
energ_tono      = tono_vec.^2;
rms_tono        = 10*log10(sum(energ_tono)/Fs);
% Avisa si los niveles son muy altos
nivel_grab      = max(abs(tono_grab.timeData));
if (nivel_grab > 0.9)
    fprintf ('\nNivel de grabaci�n muy alto: %f', nivel_grab);
end

%% Grabaci�n del ruido
ruido_grab      = samdir_graba(3);
% Selecciono solo un segundo y saco la energ�a
ruido_vec       = ruido_grab.timeData(end-2*Fs+1:1:end);
energ_ruido     = ruido_vec.^2;
rms_ruido       = 10*log10(sum(energ_ruido)/Fs);

%% Relaci�n se�al/ruido obtenida
S_N = rms_tono - rms_ruido;
varargout(1) = {S_N};
varargout(2) = {nivel_grab}; %Este valor puede utilizarse para realizar un v�metro
plot (tono_grab.timeData)
end
