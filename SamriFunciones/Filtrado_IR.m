%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Filtrado_IR                                                    *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%% Filtrado de IR con filtros de bandas de octava, orden y tipo seleccionables

% Variables globales
orden_filtro    = 6;
bandas_octava   = 1;
fs              = 48000;

% Carga la IR previamente grabada
[x, Fs] = wavread('ruido_blanco');
%a = samdirAudio();
%maximo  = max(abs(x));
m       = length(x); 

% Carga los filtros de acuerdo a las especificaciones
[filtros, frec_nominal] = samdir_banco_filtros(bandas_octava,orden_filtro);

for i=1:length(frec_nominal)
    a(i).timeData   = filter(filtros(i),x);
  %  a(i).comment    = ['Filtro pasa banda - Frec. central ' num2str(frec_nominal(i),'%.1f') 'Hz'];
    %wavwrite(0.9999*a(i).timeData/max(abs(y)),Fs,16,'exp_2_97seg_44100_filtrada_num2str(i)');
    P(i) = sum(a(i).timeData.^2)/m;
end

% primer metodo
 Pref = 1; 				% Reference level for dB scale.  
 idx = (P>0);
 P(idx) = 10*log10(P(idx)/Pref);
 P(~idx) = NaN*ones(sum(~idx),1);
 figure (1)
 bar(P);
 set(gca,'XTickLabel',{'31.5','63','125','250','500','1k','2k', '4k', '8k','16k'})
 title('Forma de Couvreur')
xlabel('Frecuencia [Hz]');ylabel('Potencia [dB]')


% segundo metodo
hp = spectrum.welch;
msPyyw = msspectrum(hp,x,'Fs',Fs);
yw = zeros(length(x),length(frec_nominal));
for i=1:length(frec_nominal),
    yw(:,i) = filter(filtros(i),x);
    Pyyw(i) = avgpower(psd(hp,yw(:,i),'Fs',Fs));
end
 figure (2)
bar(10*log10(Pyyw),1,'r');
%set(gca,'XTickLabel',{'31.5','63','125','250','500','1k','2k', '4k', '8k','16k'})
set(gca,'XTickLabel',frec_nominal)
title('Forma de matlab')
xlabel('Frecuencia [Hz]');ylabel('Potencia [dB]')

