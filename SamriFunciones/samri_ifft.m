function result = samri_ifft(varargin)
%   samri_ifft - Calcula la información en el tiempo de una señal dado su 
%   su espectro normalizado. Se revierte el efecto de la normalización, se 
%   agregan las frecuencias negativas para reconstruir el espectro y luego 
%   se realiza la IFFT, devolviendo el valor en el tiempo.
%
%   Sintaxis: samriAudio = samri_ifft(samriAudio)
%
%   Este script está basado en ITA-Toolbox, proyecto desarrollado por
%   Institute of Technical Acoustics, RWTH Aachen University.
%   Autor: Pascal Dietrich -- Email: pdi@akustik.rwth-aachen.de

%% Inicialización
error(nargchk(1,2,nargin));

if isa(varargin{1},'samriAudio')
    audioObj = varargin{1};
    if audioObj.isTime
        result = audioObj;
        return;
    end
end

%% VER
if audioObj.isempty
   audioObj.domain = 'time';
   result = audioObj;
   return;
end

%% Check for NaN at DC
audioObj.freqData(1,~isfinite(audioObj.freqData(1,:))) = 0;

%% Normalización

switch audioObj.signalType
    case 'power'
        MulFac = 1/audioObj.nSamples;
    case 'energy'
        MulFac = 1;
end

fftResult = audioObj.freqData ./ MulFac; 

if audioObj.isPower
    if audioObj.isEvenSamples
        fftResult(end,:) = fftResult(end,:)*sqrt(2);
        fftResult(2:end-1,:) = fftResult(2:end-1,:)/sqrt(2);
    else
        fftResult(2:end,:) = fftResult(2:end,:)/sqrt(2);
    end
end

% %% Muestra mensaje de aviso si DC o la Frecuencia Nyquist no son reales
% if any(~isreal(fftResult(1,:)))
%     disp('Se usará sólo la parte real del dato complejo correspondiente a DC');
% end
% if any(~isreal(fftResult(end,:)))
%     disp('Se usará sólo la parte real del dato complejo correspondiente a la frecuencia Nyquist');
% end

%% Reconstrucción del espectro completo
if audioObj.isEvenSamples
    fftResult = [real(fftResult(1,:));...
                 fftResult(2:(end-1),:);...
                 real(fftResult(end,:));...
                 conj(fftResult((end-1):-1:2,:))];
else
   disp('Numero impar de samples');
   fftResult = [real(fftResult(1,:));...
                 fftResult(2:end,:);...
                 conj(fftResult(end:-1:2,:))];
end

%% Realiza la FFT
audioObj.timeData = ifft(fftResult,'symmetric');

%% Output
result = audioObj;
end
