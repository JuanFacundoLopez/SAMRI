%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_potencia_bandas.m                                        *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_potencia_bandas_2(varargin)
%   samdir_potencia_bandas - Calcula la potencia para las bandas ingresadas
%   como argumentos en la señal dada, realizando el filtrado y luego 
%   elevando al cuadrado las muestras y promediando.
%   Devuelve los valores de potencia en cada banda en dB y normalizados al
%   valor máximo.
%
%   Sintaxis: [pot_b_dB]= samdir_potencia_bandas(filtros,samdirAudio)
%
%   [pot_dB]= samdir_potencia_bandas(filtros, ruido_blanco)
%
%% Variables Globales
fs = 48000; 


%% Inicialización
filtros     = varargin{1}; 
audioObj    = varargin{2};


%% Filtrado de la señal y calculo de potencia por bandas
% Vector donde se guardará la señal filtrada
result_filt = zeros(length(audioObj.timeData),length(filtros));

% Filtrado y cálculo de potencia
for i=1:length(filtros),
    result_filt(:,i) = filter(filtros(i),audioObj.timeData);
    pot(i) = sum(result_filt(:,i).^2)/length(result_filt(:,i));
end
pot_dB = 10*log10(pot);
% Normalización
pot_dB_norm  = pot_dB - max(pot_dB);

varargout(1) = {pot_dB};
varargout(2) = {pot_dB_norm};
end
