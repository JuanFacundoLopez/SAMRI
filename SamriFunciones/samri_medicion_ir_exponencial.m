%***************************************************************************************/
%   samdir_medicion_ir_exponencial() - Realiza la medición de la respuesta 
%   impulsiva del sistema mediante un barrido exponencial que es ingresado 
%   como argumento. Devuelve la IR sin procesar.
%
%   Sintaxis: samdirAudio = samdir_medicion_ir_exponencial(samdirAudio)
%
%   ir = samdir_medicion_ir_exponencial(excitacion)
%
function varargout = samri_medicion_ir_exponencial(varargin)
%% Inicialización
audioObj        = varargin{1}; 
input           = varargin{2}; % Index del dispositivo de entrada
output          = varargin{3}; % Index del dispositivo de salida
rangoFrecuencia = varargin{4};
fs              = varargin{5}; 
% Variables para ser obtenidas de la GUI
%f0      = 22;
%f1      = 22000;

inv     = samri_inverso(audioObj,rangoFrecuencia);
grab    = samri_reproduce_graba(audioObj.timeData, input, output, fs);
ir_cruda= samri_deconv_lineal_FFT(grab,inv,fs);

varargout(1) = {ir_cruda};
varargout(2) = {grab};
end
