%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot.m                                                   *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_plot(varargin)
%   samdir_plot - Grafica la señal en el dominio del tiempo. Utiliza el
%   campo 'comment' para ponerle título a la gráfica, y modifica los ejes
%   para una mejor visualización.
%
%   Sintaxis: samdirAudio.plot

%% Inicialización  
audioObj  = varargin{1}; 

xVec = audioObj.timeVector;

% Busca el maximo valor en Y y grafica con limites mayores
yMax = max(max(abs(audioObj.timeData)));    
if yMax == 0
    yLim = [-1 1];
else
    yLim = yMax * [-1.2 1.2];
end

%% Gráfica
figure;
h = plot(xVec, audioObj.timeData);
xlabel('seg');
ylabel('Amplitud');
set(gca,'XLim', xVec([1 end]));
set(gca,'YLim', yLim);
grid on
title(audioObj.comment);
set(gcf,'Name', audioObj.comment);

end
