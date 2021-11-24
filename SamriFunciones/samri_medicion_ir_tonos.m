%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_medicion_ir_tonos.m                                     *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************
%   samdir_medicion_ir_tonos - Realiza la medición de la respuesta en 
%  	frecuencia del sistema mediante tonos simples. Como argumento se
%   ingresa si la medición es de octava o tercios de octava.
%
%   Sintaxis: samdirAudio = samdir_medicion_ir_tonos(samdirAudio)
%
%  	rf = samdir_medicion_ir(excitacion)
%***************************************************************************************
function varargout = samdir_medicion_ir_tonos(varargin)

%% Inicialización
audioObj    = varargin{1}; 
input       = varargin{2};
output      = varargin{3};
% Variables globales
oct     = 1;

% Reproducción y grabación de las señales
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

% De la longitud total, tomo la mitad de las muestras de la porción central
long    = grab(1).nSamples/4;
for i=1:length(grab),
    grab(i).timeData = grab(i).timeData(long:1:long*3-1);
end

varargout(1) = {grab};
end
