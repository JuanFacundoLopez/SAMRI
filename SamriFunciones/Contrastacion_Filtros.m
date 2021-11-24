%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Contrastacion_Filtros                                          *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%% Calcula la potencia por bandas con una señal de ruido generada para luego contrastar.

% Variables globales
orden_filtro    = 12;
bandas_octava   = 1;
fs              = 48000;
fft_d           = 16;

% Generación de ruido blanco y rosa, grabación en .wav
x = wavread('ruido_blanco');
y = wavread('ruido_rosa');

ruido_blanco = samdirAudio;
ruido_rosa = samdirAudio;
ruido_blanco.samplingRate = fs;              
ruido_rosa.samplingRate = fs; 
ruido_blanco.timeData = x;
ruido_rosa.timeData = y;

maximo1  = max(abs(ruido_blanco.timeData));
maximo2  = max(abs(ruido_rosa.timeData));


% Creación de los filtros
[filtros, frec_nominal] = samdir_banco_filtros(bandas_octava,orden_filtro);

% Filtrado y calculo de densidad de potencia espectral ruido blanco
hp = spectrum.welch;
blanco_filt = zeros(length(ruido_blanco.timeData),length(frec_nominal));

for i=1:length(frec_nominal),
    blanco_filt(:,i) = filter(filtros(i),ruido_blanco.timeData);
    Pyyw(i) = avgpower(psd(hp,blanco_filt(:,i),'Fs',fs));
end
pot_bandas = 10*log10(Pyyw);

% Gráfico de barras por octavas
figure (1)
bar(pot_bandas,0.9,'r');
set(gca,'XTickLabel',frec_nominal)
title('Potencia espectral de Ruido Blanco')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]')

% Normalizando al máximo valor como hace Dirac (0dB)
pot_bandas_mod = pot_bandas-max(pot_bandas);
figure (2)
bar(pot_bandas_mod,0.9,'g');
set(gca,'XTickLabel',frec_nominal)
title('Potencia espectral de Ruido Blanco')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]')

% Filtrado y calculo de densidad de potencia espectral ruido blanco
hp = spectrum.welch;
rosa_filt = zeros(length(ruido_rosa.timeData),length(frec_nominal));

for i=1:length(frec_nominal),
    rosa_filt(:,i) = filter(filtros(i),ruido_rosa.timeData);
    Pyyw(i) = avgpower(psd(hp,rosa_filt(:,i),'Fs',fs));
end
pot_bandas = 10*log10(Pyyw);

% Gráfico de barras por octavas
figure (3)
bar(pot_bandas,0.9,'r');
set(gca,'XTickLabel',frec_nominal)
title('Potencia espectral de Ruido Rosa')
xlabel('Frecuencia [Hz]');
ylabel('Potencia [dB]')
