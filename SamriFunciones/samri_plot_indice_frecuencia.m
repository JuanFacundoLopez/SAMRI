%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_factor_q.m                                          *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%   samdir_plot_factor_q - Realiza el gr�fico del Indice de Directividad en
%   funci�n de las frecuencias. Recibe como argumento el mismo y el vector de
%   frecuencias.
%
%   samdir_plot_indice_frecuencia(indice,frecuencias)

function varargout = samdir_plot_indice_frecuencia(varargin)
%% Inicializaci�n  
indiceDirectividad  = varargin{1}; 
frecuencias         = varargin{2}; 
disp(frecuencias)

% Busca el maximo valor en Y y grafica con limites mayores
yMax = round (max(indiceDirectividad));   
yMin = 0;    
yLim = [yMin yMax+1];

if (length(frecuencias)>15)
    frecuencias = frecuencias (5:5:end);
    frecuencias = ['0',frecuencias];
end

%% Gr�fica
figure;
h = plot(indiceDirectividad);
xlabel('[Hz]');
ylabel('ID [dB]');
set(gca,'XTickLabel',frecuencias)
set(gca,'YTick',[-10, -5, 0, 5, 10]);
%set(gca,'yLim', yLim);
set(gca,'YLim', [-10 10]);
grid on
title('Indice de directividad en funci�n de la frecuencia');
set(gcf,'Name', 'ID');

end