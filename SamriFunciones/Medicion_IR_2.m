%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Medicion_IR                                                    *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%% Ejemplo Medicion IR con grabación y deconvolución lineal

% Variables para ser obtenidas de la GUI
f0      = 22;
f1      = 22000;
fft_d   = 17;
nivel   = 0;
Fs      = 44100;
nBits   = 16;

a = samdir_generate('expsweep',[f0 f1],Fs,fft_d);
% Multiplica la señal por el nivel indicado, por ej: -3dB.
amp = samdir_nivel(nivel);
a.timeData=a.timeData.*amp;

b = samdir_ventaneo('hann',0.05,0.05,a);
c = samdir_inverso(b,[f0 f1]);
d = samdir_reproduce_graba(b);
e = samdir_deconv_lineal(d,c);

% Ventaneo la IR en 8192 muestras - 0.1857seg y luego relleno con ceros
% hasta el tamaño original de la excitación 32768 muestras

f = samdir_ventaneo_IR('hann',e);
g = samdir_rellenar(f,17);

% Luego guarda el archivo .wav para poder ser leido por otros soft
filename = 'IR_prueba.wav';
wavwrite(0.9999*g.timeData/max(abs(g.timeData)),Fs,nBits,uiputfile({'*.wav'},'Guardar como'));

