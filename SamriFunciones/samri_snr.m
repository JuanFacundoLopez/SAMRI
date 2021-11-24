%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_snr.m                                                    *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_snr(varargin)
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
nivel   = 0;
f0      = 22;
f1      = 22000;
fs      = 48000;
fft_d   = 16;
nBits       = 16;
orden_filtro    = 6;
bandas_octava   = 1;


excitacion = samdir_generate('expsweep',[f0 f1],fs,fft_d);
amp                 = samdir_nivel(nivel);
excitacion.timeData = excitacion.timeData.*amp;
excitacion_grab     = samdir_reproduce_graba(excitacion);



[filtros, frec_nominal] = samdir_banco_filtros(bandas_octava,orden_filtro);
sin_ruido = samdirAudio();
con_ruido = samdirAudio();
sin_ruido.samplingRate = fs;
con_ruido.samplingRate = fs;

for i=1:length(frec_nominal)
    sin_ruido(i).timeData   = filter(filtros(i),excitacion.timeData);
    con_ruido(i).timeData   = filter(filtros(i),excitacion_grab.timeData);
    DB1(i) = 10*log10(var(con_ruido(i).timeData));
    DB2(i) = 10*log10(var(sin_ruido(i).timeData));
end
SNR = DB2-DB1

varargout(1) = {SNR};
varargout(2) = {frec_nominal};
