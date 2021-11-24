%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_barras.m                                            *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_plot_barras(varargin)
%   samdir_plot_barras - Gr�fica de barras de los valores ingresados.
%   Utilizado principalmente para mostrar la potencia por bandas de 
%   frecuencia, relaci�n se�al/ruido, etc.
%
%   Sintaxis: samdir_plot_barras(datos,tick_eje_x)

%% Inicializaci�n  
datos       = varargin{1}; 
tick_eje_x  = varargin{2};

%% L�mites eje Y
yMax = round(max(datos))+10;    
yMin = round(min(datos))-10;
yLim = [yMin yMax];

%% Marcas eje X
% Cuando la cantidad de barras es mayor a 15, las marcas del eje x se
% setean en 0, 5, 10, etc. Para eso, seleccionamos los valores.
if (length(tick_eje_x)>15)
    tick_eje_x = tick_eje_x (5:5:end);
    tick_eje_x = ['0',tick_eje_x];
end
% Los valores mayores a 1000, usan el multiplicador "k" por prolijidad.
% Entonces se pasa el vector de frecuencias a string

%% Gr�fica
figure;
hBars = bar(datos,1,'r','EdgeColor','w','LineWidth',1.5);
set(hBars(1),'BaseValue',yMin);
set(gca,'XTickLabel',tick_eje_x)
set(gca,'YLim', yLim);
grid on

end
