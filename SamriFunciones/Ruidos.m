%Generación de ruido blanco y rosa para hacer pruebas
fs      = 44100;
fft_d   = 16;

a = samdir_generate('whitenoise',1,fs,fft_d);
b = samdir_generate('pinknoise',1,fs,fft_d);

maximo1  = max(abs(a.timeData));
maximo2  = max(abs(b.timeData));

wavwrite(0.9999*a.timeData/maximo1,fs,16,'ruido_blanco');
wavwrite(0.9999*b.timeData/maximo2,fs,16,'ruido_rosa');