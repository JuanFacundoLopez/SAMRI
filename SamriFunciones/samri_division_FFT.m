
%   samdir_deconv_lineal - Realiza la deconvoluci�n mediante la divisi�n
%   de la FFT de la se�al grabada y la FFT de la se�al de excitaci�n.
%
%   Sintaxis: samdirAudio = samdir_division_FFT(samdirAudio, samdirAudio)
%
%   c = samdir_division_FFT(a,b)
%
function varargout = samri_division_FFT(varargin)

%% Inicializaci�n
grab    = varargin{1}; 
exc     = varargin{2}; 
fs      = varargin{3};
f0      = varargin{4};
f1      = varargin{5};

%% Deconvoluci�n por divisi�n de FFT
audioObj = samriAudio;
audioObj.samplingRate = fs;
GRAB     = fft(grab.timeData');  % Respuesta a la exitacion
EXC      = fft(exc.timeData);  % Se�al de exitacion
figure(2)
plot(GRAB)
absVect = abs(length(EXC)-length(GRAB));

if length(EXC)>length(GRAB)
    GRAB = [GRAB;zeros(absVect,1);];
else
    EXC  = [EXC; zeros(absVect,1);];
end

IR      = GRAB./EXC;

ir      = real(ifft (IR));

% Filtrado
[B,A]               = butter(4,[f0/fs f1/fs]);  
audioObj.timeData   = filter(B,A,ir');

% Como esta IR aparece en el origen, se la centra agregandole ceros al
% inicio.
audioObj.timeData   = [zeros(audioObj.nSamples,1),audioObj.timeData];
audioObj.comment    = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end
