function result = samri_fft(varargin)
%   samdir_fft - Calcula el espectro de una señal dada en el dominio del
%   tiempo. Se descartan las frecuencias negativas ya que no tienen sentido
%   físico
%
%   Sintaxis: samdirAudio = samdir_fft(samdirAudio)
%
%   Este script está basado en ITA-Toolbox, proyecto desarrollado por
%   Institute of Technical Acoustics, RWTH Aachen University.
%   Autor: Pascal Dietrich -- Email: pdi@akustik.rwth-aachen.de

%% Inicialización
error(nargchk(1,2,nargin));

if isa(varargin{1}, 'samriAudio')
    audioObj = varargin{1};
    if audioObj.isFreq          %Verifica si ya está en el dominio de la frecuencia. Si es así, lo retorna
        result = audioObj;
        return;
    end
else
    error('Error: esta función solo trabaja con objetos del tipo samriAudio')
end

% %% VER
% if audioObj.isempty
%    audioObj.domain = 'freq';
%    result = audioObj;
%    return;
% end

%% Realiza la FFT
fftResult = fft(audioObj.timeData);

%% Se descartan las frecuencias negativas
nSamples = audioObj.nSamples;

if audioObj.isEvenSamples
    fftResult = fftResult(1:(nSamples+2)/2,:);
else
    fftResult = fftResult(1:(nSamples+1)/2,:);
end

%% Normalización del espectro de acuerdo a si son señales de potencia o energía (impulsos)

switch audioObj.signalType
    case 'power'
        MulFac = 1/nSamples;
    case 'energy'
        MulFac = 1;
end

% Para obtener la correcta magnitud de las componentes en frecuencia es
% necesario normalizar dividiendo la salida de la FFT entre el valor N del
% total de samples.
% Además, como sólo utilizamos la mitad del espectro (frecuencias
% positivas), las amplitudes deben ser multiplicadas por 2, menos las
% correspondientes a DC y Frecuencia Nyquist (fs/2). A su vez, los valores
% en amplitudes deben ser pasados a valor eficaz, dividiendo por sqrt(2)
% (menos el correspondiente a DC)
% Entonces, DC---> igual,       fs/2 ---> / sqrt(2).
% Las restantes ---> * 2 / sqrt(2) = * sqrt(2)
% Las señales de energía no se modifican.

if audioObj.isPower
    if audioObj.isEvenSamples
        fftResult(end,:) = fftResult(end,:)/sqrt(2);
        fftResult(2:end-1,:) = fftResult(2:end-1,:)*sqrt(2);
    else
        fftResult(2:end,:) = fftResult(2:end,:)*sqrt(2);
    end
end

audioObj.freqData = MulFac * fftResult;
%% Devuelve el valor de salida
result = audioObj;
end
