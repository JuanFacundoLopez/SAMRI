%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_potencia_bandas.m                                        *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_potencia_bandas_2(varargin)
%   samdir_potencia_bandas - Calcula la potencia para las bandas ingresadas
%   como argumentos en la se�al dada, realizando el filtrado y luego 
%   elevando al cuadrado las muestras y promediando.
%   Devuelve los valores de potencia en cada banda en dB y normalizados al
%   valor m�ximo.
%
%   Sintaxis: [pot_b_dB]= samdir_potencia_bandas(filtros,samdirAudio)
%
%   [pot_dB]= samdir_potencia_bandas(filtros, ruido_blanco)
%
%% Variables Globales
fs = 48000; 


%% Inicializaci�n
filtros     = varargin{1}; 
audioObj    = varargin{2};


%% Filtrado de la se�al y calculo de potencia por bandas
% Vector donde se guardar� la se�al filtrada
result_filt = zeros(length(audioObj.timeData),length(filtros));

% Filtrado y c�lculo de potencia
for i=1:length(filtros),
    result_filt(:,i) = filter(filtros(i),audioObj.timeData);
    pot(i) = sum(result_filt(:,i).^2)/length(result_filt(:,i));
end
pot_dB = 10*log10(pot);
% Normalizaci�n
pot_dB_norm  = pot_dB - max(pot_dB);

varargout(1) = {pot_dB};
varargout(2) = {pot_dB_norm};
end
