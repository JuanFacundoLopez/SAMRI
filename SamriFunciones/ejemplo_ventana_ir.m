%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  ejemplo_ventana_ir.m                                            *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%% Ejemplo de ventaneo de una IR con distorsi�n

 ir = samdirAudio();
 [x, Fs] = wavread('IR_sucia');
 ir.samplingRate = Fs;
 ir.timeData = x;
 ir.comment = 'Respuesta al Impulso';
 [ir_mod,vent,datos]= samdir_ventaneo_ver(ir,0.02,0.1,'hann',0.1,'hann',0.1);
 ir_vent = samdir_ventaneo_aplicar(ir_mod,vent,datos);
 resol_ir_vent = samdir_resol_frec(Fs,log2(ir_vent.nSamples))
 ir_ext = samdir_extender(ir_vent,15);
 resol_ir_ext = samdir_resol_frec(Fs,log2(ir_ext.nSamples))
 samdir_grabar_wav(ir_ext);