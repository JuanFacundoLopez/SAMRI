%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_resp_frec_tonos.m                                       *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%   samdir_resp_frec_tonos - Grafica la respuesta en frecuencia medida con
%   el m�todo de tonos puros, en forma de barras. Como argumento es
%   necesario ingresarle el vector de potencias en dB.
%
%   Sintaxis: samdir_resp_frec_tonos(vector);
%
%   samdir_resp_frec_tonos(pot_dB_0�);
%
function varargout = samdir_resp_frec_tonos(varargin)
%% Inicializaci�n de variables
pot     = varargin{1}; 
oct     = varargin{2}; 
% Variables globales de la GUI
label_oct   = {'31.5','63','125','250','500','1k','2k','4k','8k','16k'};
label_ter   = {'20','25','31.5','40','50','63','80','100','125','160','200',...
'250','315','400','500','630','800','1k','1.25k','1.6k','2k',... 
'2.5k','3.15k','4k','5k','6.3k','8k','10k','12.5k','16k','20k'};


% Normalizaci�n al valor m�ximo, s�lo para graficar
pot_max     = max(pot);
pot_norm    = pot-pot_max;
disp(oct)
% Gr�fica
if (oct==1)
    samdir_plot_barras(pot_norm,label_oct);
else
    samdir_plot_barras(pot_norm,label_ter);
end

end
