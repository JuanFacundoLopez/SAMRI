%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_freq_mult.m                                         *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function [varargout] = samdir_plot_freq_mult(varargin)
%   samdir_plot_freq - Grafica varias se�ales en el dominio de la 
%   frecuencia ingresadas en un struct.
%
%   Sintaxis: samdir_plot_freq_mult (samdirAudio)
%
%% Inicializaci�n
    audioObj    = varargin{1};           
    titulo      = varargin{2};    
    
%% Usa 3 colores
color = ['b' 'r' 'g'];
for i=1:length(audioObj)
    j = mod (i,3);
    col (i) = color (j+1);
end

%% Recorre el struct
figure;
for i=1:length(audioObj)
    semilogx (audioObj(i).freqVector,audioObj(i).freqData_dB, col(i))
    hold on
end

xlabel('Frecuencia [Hz]');
ylabel('M�dulo [dB]');
set(gca,'XLim', [20 max(audioObj(end).freqVector)]);
set(gca,'XTick',[20, 100, 1000, 10000])
set(gca,'YLim', [-70 10]);
grid on
title(titulo);
hold off

end
