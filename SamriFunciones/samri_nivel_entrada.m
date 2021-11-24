%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_nivel_entrada.m                                          *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%   samdir_nivel_entrada - Compara el nivel máximo de entrada de audio 
%   con el fondo de escala y devuelve este valor en dB, además de un entero
%   que indica cuantos leds del vúmetro prender.
%
%   Sintaxis: [int int] = samdir_nivel_entrada(samdirAudio)
%
%   [nivel_dB led] = samdir_nivel_entrada(excitacion_grab)
%
function varargout = samdir_nivel_entrada(varargin)
%% Inicialización
grab    = varargin{1}; 

%% Cálculo nivel
nivel       = max(abs(grab.timeData));
nivel_dB    = db(nivel);

if (nivel_dB<0)
    if (nivel_dB<-19)
        leds    = 1;
    else
        leds    = 20+ round(nivel_dB);
    end
else
    leds    = 20;
end

varargout(1) = {nivel_dB};
varargout(2) = {leds};
end