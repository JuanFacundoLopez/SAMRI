function varargout = samri_medicion_ir_lineal(varargin)
%% Inicializaci�n
audioObj    = varargin{1}; 
input       = varargin{2};
output      = varargin{3};
% Variables para ser obtenidas de la GUI
fs      = audioObj.samplingRate;

% Grabaci�n y deconvoluci�n mediante divisi�n de FFT
grab        = samri_reproduce_graba(audioObj.timeData, input, output,fs);
ir_cruda    = samri_division_FFT(grab,audioObj);

varargout(1) = {ir_cruda};
varargout(2) = {grab};
end

