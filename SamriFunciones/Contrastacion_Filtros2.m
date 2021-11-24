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
title('Potencia espectral de Ruido Blanco')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]');

% Filtrado y calculo de densidad de potencia espectral ruido rosa
[pot2, pot_dB2]= samdir_potencia_bandas(filtros, ruido_rosa);

% Gráfico de barras por octavas
figure (2)
samdir_plot_barras (pot_dB2,frec_nominal);
title('Potencia espectral de Ruido Rosa')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]')
