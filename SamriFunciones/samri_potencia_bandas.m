%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_potencia_bandas.m                                        *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_potencia_bandas(varargin)
%   samdir_potencia_bandas - Calcula la potencia para las bandas ingresadas
%   como argumentos en la se�al dada, aplicando la densidad espectral de
%   potencia y luego integrando.
%   Devuelve los valores de potencia en cada banda en forma lineal y dB.
%
%   Sintaxis: [pot_b, pot_b_dB]= samdir_potencia_bandas(filtros,samdirAudio)
%
%   [pot, pot_dB]= samdir_potencia_bandas(filtros, ruido_blanco)
%
%% Variables Globales
fs = 48000; 


%% Inicializaci�n
filtros     = varargin{1}; 
audioObj    = varargin{2};


%% Filtrado de la se�al y calculo de potencia por bandas
% La densidad espectral de potencia(PSD)representa la potencia de una se�al
% en una banda infinitesimal de frecuencia, su unidad es [W/Hz].
% Al integrar la PSD en un rango de frecuencias, se obtiene la potencia
% promedio en esa banda.
% Existen varios m�todos de estimaci�n del espectro, el m�s simple es el
% periodograma. El periodograma no es un estimador consistente, ya que su 
% varianza no tiende a cero cuando la longitud del registro tiende a infinito. 
% Para mejorar esta caracter�stica, Welch propuso un m�todo seg�n el cual 
% se divid�a el registro de N puntos original en segmentos de M puntos 
% solapados entre s� L muestras. Posteriormente se aplica una ventana a cada
% segmento, y finalmente se calcula el periodograma para cada segmento 
% enventanado. El periodograma final se obtiene promediando todos los 
% periodogramas parciales.

% Se crea el objeto tipo spectrum Welch. Por defecto la ventana que se
% utiliza es Hamming, la longitud de los segmentos es 64 muestras y el
% solapamiento del 50%.
hp          = spectrum.welch;

% Vector donde se guardar� la se�al filtrada
result_filt = zeros(length(audioObj.timeData),length(filtros));

% Filtrado, c�lculo de PSD y potencia promedio
for i=1:length(filtros),
    result_filt(:,i) = filter(filtros(i),audioObj.timeData);
    pot(i) = avgpower(psd(hp,result_filt(:,i),'Fs',fs));
end
pot_dB = 10*log10(pot);

varargout(1) = {pot};
varargout(2) = {pot_dB};
end
