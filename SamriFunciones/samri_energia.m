%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_energia.m                                                *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function [ETC, ETCI] = samri_energia(varargin)
%   samri_potencia_bandas - Calcula la energ�a de la se�al ingresada
%   como argumento, luego realiza el gr�fico con el eje de abcisas en dB.
%
%   Sintaxis: samdir_energia(samdirAudio)
%
%% Inicializaci�n

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
        % Para que no se vea la l�nea en los espacios vac�os
        energia_db(i) = -120;
    end
end

audioObj.comment = ['Energ�a - ' audioObj.comment];

ETC.timeData = energia_db;


% aca hago el vector de energia tiempo integrada
energia_norm_int = energia_norm;

for i = 1:length(energia_norm)
    energia_norm_int(i) = sum(energia_norm_int(end:-1:i));
end
energia_norm_int_db   = db(energia_norm_int,'power');

ETCI.timeData = energia_norm_int_db; %% SE NECESITA PROBAR ESSSSSTO


end
