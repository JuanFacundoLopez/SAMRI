%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_espectrograma.m                                          *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samri_espectrograma(varargin)
%   samri_espectrograma - Realiza el espectrograma de la se�al ingresada
%   como primer argumento. Sus otros argumentos son:
%   - nwin es la cantidad de samples dentro de la ventana, esta cantidad 
%   mejora la resoluci�n en frecuencia, por defecto la elegimos hann; 
%   - nfft
%
%   En el llamado a spectrogram se utilizan otros argumentos, fijos por el
%   momento que son:
%
%   - noverlap es la cantidad de samples superpuestos entre ventanas 
%   (mayor cantidad mejora resoluci�n en el tiempo pero se pone muy lento), 
%   lo fijamos en el 50%;
%   - fs es la frecuencia de muestreo para que los ejes tengan la informaci�n
%   - 'yaxis' indica que el eje horizontal es el tiempo
%
%   Sintaxis: samdir_espectrograma(samdirAudio,nwin,nfft)
%
%   Tambi�n es un m�todo de samdirAudio:
%
%   Sintaxis: samdirAudio.samdir_espectrograma
%
%% Variables globales
fs  = 48000;

%% Variables de la GUI
audioObj    = varargin{1}; 
nwin        = varargin{2}; 
nfft        = varargin{3}; 

%% Gr�fico
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