%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_freq.m                                              *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function [varargout] = samdir_plot_freq(varargin)
%   samdir_plot_freq - Grafica la señal en el dominio de la frecuencia. 
%
%   Sintaxis: samdirAudio.samdir_plot_freq
%
%% Inicialización
    audioObj = varargin{1};           

%% Límites de la gráfica

% Omite el bin1(DC) y pone límite inferior, eje horizontal
if (audioObj.freqVector(2)<20)
    xMin= 20;
else
    xMin = audioObj.freqVector(2);
end
xMax = max(audioObj.freqVector);     
xLim = [xMin xMax];

% Pone límite inferior si el mínimo es menor a -100dB, eje vertical
yMax = max(audioObj.freqData_dB);   
if (min(audioObj.freqData_dB)<-90)
    yMin= -100;
else
    yMin = min(audioObj.freqData_dB)-10;
end
yLim = [yMin yMax+10];


%% Gráfica
figure;
h = semilogx(audioObj.freqVector, audioObj.freqData_dB);
xlabel('Frecuencia [Hz]');
ylabel('Módulo [dB]');
set(gca,'XLim', xLim);
set(gca,'XTick',[20, 100, 1000, 10000])
set(gca,'YLim', yLim);
grid on
title(audioObj.comment);
set(gcf,'Name', audioObj.comment);

end
