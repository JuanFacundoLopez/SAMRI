%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  prueba_correlacion                                             *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%% Ejemplo grabación y correlacion con la señal de excitación para sincronismo

a = samdir_generate('expsweep',[20 22000],44100,18) 
b = samdir_ventaneo('hann',0.1,0.1,a);
c = samdir_reproduce_graba(b);
figure(3)
b.plot
figure (4)
c.plot
