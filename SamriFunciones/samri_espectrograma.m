%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_espectrograma.m                                          *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samri_espectrograma(varargin)
%   samri_espectrograma - Realiza el espectrograma de la señal ingresada
%   como primer argumento. Sus otros argumentos son:
%   - nwin es la cantidad de samples dentro de la ventana, esta cantidad 
%   mejora la resolución en frecuencia, por defecto la elegimos hann; 
%   - nfft
%
%   En el llamado a spectrogram se utilizan otros argumentos, fijos por el
%   momento que son:
%
%   - noverlap es la cantidad de samples superpuestos entre ventanas 
%   (mayor cantidad mejora resolución en el tiempo pero se pone muy lento), 
%   lo fijamos en el 50%;
%   - fs es la frecuencia de muestreo para que los ejes tengan la información
%   - 'yaxis' indica que el eje horizontal es el tiempo
%
%   Sintaxis: samdir_espectrograma(samdirAudio,nwin,nfft)
%
%   También es un método de samdirAudio:
%
%   Sintaxis: samdirAudio.samdir_espectrograma
%
%% Variables globales
fs  = 48000;

%% Variables de la GUI
audioObj    = varargin{1}; 
nwin        = varargin{2}; 
nfft        = varargin{3}; 

%% Gráfico
noverlap    = nwin/2;
figure;
spectrogram(audioObj.timeData,nwin,noverlap,nfft,fs,'yaxis');
xlabel('seg');
ylabel('Frecuencia');
audioObj.comment = ['Espectrograma - ' audioObj.comment];
title(audioObj.comment);
set(gcf,'Name', audioObj.comment);
colorbar

end