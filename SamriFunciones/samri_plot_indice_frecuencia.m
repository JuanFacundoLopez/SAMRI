%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_factor_q.m                                          *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%   samdir_plot_factor_q - Realiza el gráfico del Indice de Directividad en
%   función de las frecuencias. Recibe como argumento el mismo y el vector de
%   frecuencias.
%
%   samdir_plot_indice_frecuencia(indice,frecuencias)

function varargout = samdir_plot_indice_frecuencia(varargin)
%% Inicialización  
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

%% Gráfica
figure;
h = plot(indiceDirectividad);
xlabel('[Hz]');
ylabel('ID [dB]');
set(gca,'XTickLabel',frecuencias)
set(gca,'YTick',[-10, -5, 0, 5, 10]);
%set(gca,'yLim', yLim);
set(gca,'YLim', [-10 10]);
grid on
title('Indice de directividad en función de la frecuencia');
set(gcf,'Name', 'ID');

end