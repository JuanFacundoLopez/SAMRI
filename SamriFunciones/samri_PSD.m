function [ audioObjPSD ] = samri_PSD( audioObj )

audioObjPSD = samriAudio;
fs = audioObj.samplingRate;
nfft1   = 2^nextpow2(length(audioObj.timeData));
Pxx1    = abs(fft(audioObj.timeData',nfft1)).^2/length(audioObj.timeData)/fs;

Hxx1= dspdata.psd(Pxx1(1:length(Pxx1)/2),'fs',fs);
audioObjPSD.freqData =Hxx1.Data;


end

