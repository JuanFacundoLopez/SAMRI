function varargout = samri_deconv_lineal_FFT(varargin)
%   samdir_deconv_lineal - Realiza la deconvoluci�n lineal, mediante la
%   multiplicaci�n de la FFT de la se�al grabada y la FFT del filtro 
%   inverso de la se�al de excitaci�n.
%
%   Sintaxis: samdirAudio = samdir_deconv_lineal_FFT(samdirAudio, samdirAudio)
%
%   c = samdir_deconv_lineal_FFT(a,b)
%

%% Inicializaci�n
grab    = varargin{1}; 
inv     = varargin{2}; 
fs      = varargin{3};
%% Convoluci�n FFT
audioObj = samriAudio;
audioObj.samplingRate = fs;

% Antes de multiplicar, se deben crear dos vectores de 2*n-1 samples para
% evitar convoluci�n circular, se rellenan con ceros.
% inv.nSamples(1)
% grab.nSamples
inv_mod     = [inv.timeData; zeros(length(grab.timeData)-1,1)];%zeros retorna un vector de 0
grab_mod    = [grab.timeData; zeros(length(inv.timeData)-1,1)]; % No entiendo para que es?? preguntar a seba, incluso si deberia tener un numero n^2

INV     = fft (inv_mod);
GRAB    = fft (grab_mod);

IR      = INV.*GRAB; 
ir      = ifft (IR); % Respuesta impulsiva
audioObj.timeData = ir;

% Si las se�ales ten�an una longitud de 2^N, la IR tiene una longitud de
% 2^(N+1)-1 muestras, por lo que se agrega un sample. Tambi�n se camb�a el
% tipo de se�al de potencia a energ�a y el 'comment'.

audioObj.timeData(audioObj.nSamples+1) = 0;
audioObj.comment = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end