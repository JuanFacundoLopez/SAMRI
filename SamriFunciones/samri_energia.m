%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_energia.m                                                *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function [ETC, ETCI] = samri_energia(varargin)
%   samri_potencia_bandas - Calcula la energía de la señal ingresada
%   como argumento, luego realiza el gráfico con el eje de abcisas en dB.
%
%   Sintaxis: samdir_energia(samdirAudio)
%
%% Inicialización

ETC            = samriAudio;
ETCI           = samriAudio;
audioObj       = varargin{1};
ETC.timeData   = audioObj.timeData.^2;
ETCI.timeData  = audioObj.timeData.^2;

% Busca el maximo valor en Y, normaliza y pasa a dB
yMax         = max(ETC.timeData);    
energia_norm = ETC.timeData/yMax;
energia_db   = db(energia_norm,'power');

for i=1:length(ETC),
    if energia_db(i) < -120,
        % Para que no se vea la línea en los espacios vacíos
        energia_db(i) = -120;
    end
end

audioObj.comment = ['Energía - ' audioObj.comment];

ETC.timeData = energia_db;


% aca hago el vector de energia tiempo integrada
energia_norm_int = energia_norm;

for i = 1:length(energia_norm)
    energia_norm_int(i) = sum(energia_norm_int(end:-1:i));
end
energia_norm_int_db   = db(energia_norm_int,'power');

ETCI.timeData = energia_norm_int_db; %% SE NECESITA PROBAR ESSSSSTO


end
