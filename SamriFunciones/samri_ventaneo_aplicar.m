%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_ventaneo_aplicar.m                                       *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_ventaneo_aplicar(varargin)
%   samdir_ventaneo_aplicar - Luego de confirmada la ventana con la funci�n
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

%% Aplicaci�n de la ventana a la IR
inicio  = datos(1);
final   = datos(2);
result  = samdirAudio;
result.samplingRate = audioObj.samplingRate;
result.timeData     = audioObj.timeData(inicio:1:final).*ventana.timeData(inicio:1:final);
result.comment      = 'Respuesta al Impulso limpia';

% Extensi�n de la se�al hasta un m�ltiplo de 2^n
samples         = 2^nextpow2(result.nSamples);
vect_ceros      = zeros (samples-result.nSamples,1);
result.timeData = [result.timeData;vect_ceros];

varargout(1) = {result};
end
 