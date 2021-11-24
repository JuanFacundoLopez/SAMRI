%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Contrastacion_Filtros2                                         *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%% Calcula la potencia por bandas con una señal de ruido generada para luego contrastar.

% Variables globales
orden_filtro    = 6;
bandas_octava   = 3;
fs              = 48000;

% Carga de ruido blanco y rosa de los .wav
x = wavread('ruido_blanco');
y = wavread('ruido_rosa');

ruido_blanco = samdirAudio;
ruido_rosa = samdirAudio;
ruido_blanco.samplingRate = fs;              
ruido_rosa.samplingRate = fs; 
ruido_blanco.timeData = x;
ruido_rosa.timeData = y;

% Creación de los filtros
[filtros, frec_nominal] = samdir_banco_filtros(bandas_octava,orden_filtro);

% Filtrado y calculo de densidad de potencia espectral ruido blanco
[pot, pot_dB]= samdir_potencia_bandas(filtros, ruido_blanco);

% Gráfico de barras por octavas
figure (1)
samdir_plot_barras (pot_dB,frec_nominal);
title('Potencia espectral de ruido_blanco.wav')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]');

% Filtrado y calculo de densidad de potencia espectral ruido rosa
[pot2, pot_dB2]= samdir_potencia_bandas(filtros, ruido_rosa);

% Gráfico de barras por octavas
figure (2)
samdir_plot_barras (pot_dB2,frec_nominal);
title('Potencia espectral de ruido_rosa.wav')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]')


a = wavread('excitacion');
b = wavread('excitacion_grab');

excitacion = samdirAudio;
excitacion_grab = samdirAudio;
excitacion.samplingRate = fs;              
excitacion_grab.samplingRate = fs; 
excitacion.timeData = a;
excitacion_grab.timeData = b;

% Creación de los filtros
[filtros, frec_nominal] = samdir_banco_filtros(bandas_octava,orden_filtro);

% Filtrado y calculo de densidad de potencia espectral señal de excitacion
[pot3, pot_dB3]= samdir_potencia_bandas(filtros, excitacion);

% Gráfico de barras por octavas
figure (3)
samdir_plot_barras (pot_dB3,frec_nominal);
title('Potencia espectral de señal excitacion.wav')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]');

% Filtrado y calculo de densidad de potencia espectral señal grabada
[pot4, pot_dB4]= samdir_potencia_bandas(filtros, excitacion_grab);

% Gráfico de barras por octavas
figure (4)
samdir_plot_barras (pot_dB4,frec_nominal);
title('Potencia espectral de excitacion_grab.wav')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]')

c = wavread('excitacion_grab_sinnorm');

excitacion_grab_sinnorm = samdirAudio;
excitacion_grab_sinnorm.samplingRate = fs;              
excitacion_grab_sinnorm.timeData = c;

% Creación de los filtros
[filtros, frec_nominal] = samdir_banco_filtros(bandas_octava,orden_filtro);

% Filtrado y calculo de densidad de potencia espectral señal de excitacion
[pot5, pot_dB5]= samdir_potencia_bandas(filtros, excitacion_grab_sinnorm);

% Gráfico de barras por octavas
figure (5)
samdir_plot_barras (pot_dB5,frec_nominal);
title('Potencia espectral de señal excitacion.wav')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]');
