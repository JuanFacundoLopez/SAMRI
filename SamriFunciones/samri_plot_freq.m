%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_freq.m                                              *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function [varargout] = samdir_plot_freq(varargin)
%   samdir_plot_freq - Grafica la se�al en el dominio de la frecuencia. 
%
%   Sintaxis: samdirAudio.samdir_plot_freq
%
%% Inicializaci�n
    audioObj = varargin{1};           

%% L�mites de la gr�fica

% Omite el bin1(DC) y pone l�mite inferior, eje horizontal
if (audioObj.freqVector(2)<20)
    xMin= 20;
else
    xMin = audioObj.freqVector(2);
end
xMax = max(audioObj.freqVector);     
xLim = [xMin xMax];

% Pone l�mite inferior si el m�nimo es menor a -100dB, eje vertical
yMax = max(audioObj.freqData_dB);   
if (min(audioObj.freqData_dB)<-90)
    yMin= -100;
else
    yMin = min(audioObj.freqData_dB)-10;
end
yLim = [yMin yMax+10];


%% Gr�fica
figure;
h = semilogx(audioObj.freqVector, audioObj.freqData_dB);
xlabel('Frecuencia [Hz]');
ylabel('M�dulo [dB]');
set(gca,'XLim', xLim);
set(gca,'XTick',[20, 100, 1000, 10000])
set(gca,'YLim', yLim);
grid on
title(audioObj.comment);
set(gcf,'Name', audioObj.comment);

end
