%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  prueba_correlacion                                             *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%% Ejemplo grabaci�n y correlacion con la se�al de excitaci�n para sincronismo

a = samdir_generate('expsweep',[20 22000],44100,18) 
b = samdir_ventaneo('hann',0.1,0.1,a);
c = samdir_reproduce_graba(b);
figure(3)
b.plot
figure (4)
c.plot
