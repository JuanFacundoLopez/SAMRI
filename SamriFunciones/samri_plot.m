%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot.m                                                   *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_plot(varargin)
%   samdir_plot - Grafica la se�al en el dominio del tiempo. Utiliza el
%   campo 'comment' para ponerle t�tulo a la gr�fica, y modifica los ejes
%   para una mejor visualizaci�n.
%
%   Sintaxis: samdirAudio.plot

%% Inicializaci�n  
audioObj  = varargin{1}; 

xVec = audioObj.timeVector;

% Busca el maximo valor en Y y grafica con limites mayores
yMax = max(max(abs(audioObj.timeData)));    
if yMax == 0
    yLim = [-1 1];
else
    yLim = yMax * [-1.2 1.2];
end

%% Gr�fica
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
