function varargout = samri_deconv_lineal_FFT(varargin)
%   samdir_deconv_lineal - Realiza la deconvolución lineal, mediante la
%   multiplicación de la FFT de la señal grabada y la FFT del filtro 
%   inverso de la señal de excitación.
%
%   Sintaxis: samdirAudio = samdir_deconv_lineal_FFT(samdirAudio, samdirAudio)
%
%   c = samdir_deconv_lineal_FFT(a,b)
%

%% Inicialización
grab    = varargin{1}; 
inv     = varargin{2}; 
fs      = varargin{3};
%% Convolución FFT
audioObj = samriAudio;
audioObj.samplingRate = fs;

% Antes de multiplicar, se deben crear dos vectores de 2*n-1 samples para
% evitar convolución circular, se rellenan con ceros.
% inv.nSamples(1)
% grab.nSamples
inv_mod     = [inv.timeData; zeros(length(grab.timeData)-1,1)];%zeros retorna un vector de 0
grab_mod    = [grab.timeData; zeros(length(inv.timeData)-1,1)]; % No entiendo para que es?? preguntar a seba, incluso si deberia tener un numero n^2

INV     = fft (inv_mod);
GRAB    = fft (grab_mod);

IR      = INV.*GRAB; 
ir      = ifft (IR); % Respuesta impulsiva
audioObj.timeData = ir;

% Si las señales tenían una longitud de 2^N, la IR tiene una longitud de
% 2^(N+1)-1 muestras, por lo que se agrega un sample. También se cambía el
% tipo de señal de potencia a energía y el 'comment'.

audioObj.timeData(audioObj.nSamples+1) = 0;
audioObj.comment = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end