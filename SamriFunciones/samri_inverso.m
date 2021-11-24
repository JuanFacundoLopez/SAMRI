function varargout = samri_inverso(varargin)
%   samdir_inverso - Calcula el filtro seg�n el m�todo de A. Farina 
%   (Simultaneous measurement of impulse response and distortion with a 
%   swept-sine technique, 2000) realizando la inversi�n de las muestras en 
%   el tiempo y aplicando una envolvente exponencial de -10db/decada para 
%   compensar la energ�a.
%
%   Sintaxis: samriAudio = samri_inverso(samriAudio, rangoFrecuencias)
%
%   b = samri_inverso(a,[f0 f1])
%
%% Inicializaci�n
result = varargin{1};   % Se�al de exitacion
f0 = varargin{2}(1);    % Frecuencia inicial
f1 = varargin{2}(2);    % Frecuencia final

%% Inversi�n de las muestras y pendiente -10dB/dec
w1 = 2*pi*f0; % Frecuencia inicial(pulsacion inicial)
w2 = 2*pi*f1; % Frecuencia final (pulsacion final)
L=result.trackLength/log(w2/w1);
result.timeData = result.timeData(end:-1:1);
result.timeData = result.timeData.*exp(-result.timeVector./L);
result.comment  = ['Filtro inverso - ' result.comment];
varargout = {result};
end
