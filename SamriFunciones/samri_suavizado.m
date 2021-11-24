%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_suavizado                                               *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%% Suavizado de una FT con ruido

[x, Fs] = wavread('IR_prueba');
a = samdirAudio();
a.samplingRate = Fs;
a.timeData = x;
figure(1)
a.plot
figure(2)
a.plot_freq

%% Opciones
%Opcion 1, smooth()
b = samdirAudio();
c = samdirAudio();

b.timeData =smooth(a.timeData,'sgolay');
figure(3)
b.plot_freq

%Opcion 2, filtros de 1/6 octava
[filtros, frec_nominal] = samdir_banco_filtros(6,6);
[pot, pot_dB]= samdir_potencia_bandas(filtros, a);
figure(4)
semilogx(frec_nominal,pot_dB)
grid on

%Opcion 3, filtros de 1/12 octava
[filtros, frec_nominal] = samdir_banco_filtros(12,6);
[pot2, pot_dB2]= samdir_potencia_bandas(filtros, a);
figure(5)
semilogx(frec_nominal,pot_dB2)
grid on
