%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_medicion_ir_tonos.m                                     *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************
%   samdir_medicion_ir_tonos - Realiza la medici�n de la respuesta en 
%  	frecuencia del sistema mediante tonos simples. Como argumento se
%   ingresa si la medici�n es de octava o tercios de octava.
%
%   Sintaxis: samdirAudio = samdir_medicion_ir_tonos(samdirAudio)
%
%  	rf = samdir_medicion_ir(excitacion)
%***************************************************************************************
function varargout = samdir_medicion_ir_tonos(varargin)

%% Inicializaci�n
audioObj    = varargin{1}; 
input       = varargin{2};
output      = varargin{3};
% Variables globales
oct     = 1;

% Reproducci�n y grabaci�n de las se�ales
if (oct==1)
    grab(10)    = samdirAudio;
    for i=1:10,
        grab(i) = samdir_reproduce_graba(audioObj(i), input, output);
    end
else
    grab(31)    = samdirAudio;
    for i=1:31,
        grab(i) = samdir_reproduce_graba(audioObj(i));
    end
end

% De la longitud total, tomo la mitad de las muestras de la porci�n central
long    = grab(1).nSamples/4;
for i=1:length(grab),
    grab(i).timeData = grab(i).timeData(long:1:long*3-1);
end

varargout(1) = {grab};
end
