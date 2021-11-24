%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_freq_mult.m                                         *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function [varargout] = samdir_plot_freq_mult(varargin)
%   samdir_plot_freq - Grafica varias señales en el dominio de la 
%   frecuencia ingresadas en un struct.
%
%   Sintaxis: samdir_plot_freq_mult (samdirAudio)
%
%% Inicialización
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
ylabel('Módulo [dB]');
set(gca,'XLim', [20 max(audioObj(end).freqVector)]);
set(gca,'XTick',[20, 100, 1000, 10000])
set(gca,'YLim', [-70 10]);
grid on
title(titulo);
hold off

end
