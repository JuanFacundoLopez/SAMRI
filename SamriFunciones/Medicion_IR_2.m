%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Medicion_IR                                                    *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%% Ejemplo Medicion IR con grabaci�n y deconvoluci�n lineal

% Variables para ser obtenidas de la GUI
f0      = 22;
f1      = 22000;
fft_d   = 17;
nivel   = 0;
Fs      = 44100;
nBits   = 16;

a = samdir_generate('expsweep',[f0 f1],Fs,fft_d);
% Multiplica la se�al por el nivel indicado, por ej: -3dB.
amp = samdir_nivel(nivel);
a.timeData=a.timeData.*amp;

b = samdir_ventaneo('hann',0.05,0.05,a);
c = samdir_inverso(b,[f0 f1]);
d = samdir_reproduce_graba(b);
e = samdir_deconv_lineal(d,c);

% Ventaneo la IR en 8192 muestras - 0.1857seg y luego relleno con ceros
% hasta el tama�o original de la excitaci�n 32768 muestras

f = samdir_ventaneo_IR('hann',e);
g = samdir_rellenar(f,17);

% Luego guarda el archivo .wav para poder ser leido por otros soft
filename = 'IR_prueba.wav';
wavwrite(0.9999*g.timeData/max(abs(g.timeData)),Fs,nBits,uiputfile({'*.wav'},'Guardar como'));

