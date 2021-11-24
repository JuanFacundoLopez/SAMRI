%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_extender.m                                               *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_extender(varargin)
%   samdir_extender - Extiende la longitud de la señal ingresada como
%   argumento hasta el grado del otro argumento deseado, donde
%   samples = 2^grado.
%
%   Sintaxis: samdirAudio = samdir_extender(samdirAudio,grado)
%   Sintaxis: samdirAudio = samdir_extender(samdirAudio,grado, logger)
%
%   samdirAudio:    objeto a extender longitud
%   grado:          longitud deseada en potencia de 2
%
%   ir_ext = samdir_extender(ir_vent,16)
%
%% Variables de la GUI  

audioObj    = varargin{1};
grado       = varargin{2};  

%% Extensión de la longitud de la señal con ceros a ambos lados de la original
result  = samdirAudio;
result.samplingRate = audioObj.samplingRate;
result.timeData     = audioObj.timeData;

samples         = 2^grado;
if (samples > result.nSamples)

        fprintf('\nExtendiendo IR ...\n');
   
    vect_ceros      = zeros ((samples-result.nSamples)/2,1);
    result.timeData = [vect_ceros;result.timeData;vect_ceros];
    result.comment  = 'Respuesta al Impulso extendida';
else
        fprintf('\n¡Error! La longitud de la señal es mayor al valor ingresado\n');
    % Se devuelve la señal original
    result = audioObj;
end

varargout(1) = {result};
end
 