%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_nivel_entrada.m                                          *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%   samdir_nivel_entrada - Compara el nivel m�ximo de entrada de audio 
%   con el fondo de escala y devuelve este valor en dB, adem�s de un entero
%   que indica cuantos leds del v�metro prender.
%
%   Sintaxis: [int int] = samdir_nivel_entrada(samdirAudio)
%
%   [nivel_dB led] = samdir_nivel_entrada(excitacion_grab)
%
function varargout = samdir_nivel_entrada(varargin)
%% Inicializaci�n
grab    = varargin{1}; 

%% C�lculo nivel
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