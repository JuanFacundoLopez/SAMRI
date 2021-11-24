%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_ventaneo_aplicar.m                                       *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_ventaneo_aplicar(varargin)
%   samdir_ventaneo_aplicar - Luego de confirmada la ventana con la función
%   samdir_ventaneo_ver(), se aplica multiplicando la misma por la IR
%   normalizada en el dominio del tiempo. Esta IR se encuentra en otra
%   variable para poder deshacer el efecto en caso de errores.
%
%   Sintaxis: samdirAudio = samdir_ventaneo_aplicar(samdirAudio,samdirAudio)
%
%   samdirAudio:    IR a ventanear
%   samdirAudio:    Ventana ya confirmada
%
%   ir_vent = samdir_ventaneo_aplicar(ir_mod,vent,vector)
%
%% Variables de la GUI  
audioObj    = varargin{1};
ventana     = varargin{2};  
datos       = varargin{3};     

%% Aplicación de la ventana a la IR
inicio  = datos(1);
final   = datos(2);
result  = samdirAudio;
result.samplingRate = audioObj.samplingRate;
result.timeData     = audioObj.timeData(inicio:1:final).*ventana.timeData(inicio:1:final);
result.comment      = 'Respuesta al Impulso limpia';

% Extensión de la señal hasta un múltiplo de 2^n
samples         = 2^nextpow2(result.nSamples);
vect_ceros      = zeros (samples-result.nSamples,1);
result.timeData = [result.timeData;vect_ceros];

varargout(1) = {result};
end
 