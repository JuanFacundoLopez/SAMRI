%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_ventaneo_IR.m                                            *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_ventaneo_IR(varargin)
%   samdir_ventaneo - Multiplica la IR por una ventana de tiempo
%   determinada, ubicando el m�ximo en el centro de la se�al final.
%
%   Sintaxis: samdirAudio = samdir_ventaneo_IR('tipo',samdirAudio)
%   
%   a = samdir_ventaneo_IR('hann',x)
%   
%   tipo:           ventana
%   samdirAudio:    se�al del tipo samdirAudio (IR)
%   
%% Inicializaci�n  

tipo_ventana    = varargin{1};      
audioObj        = varargin{2};

%Guarda la posici�n del m�ximo, puede ser un valor negativo asi que pasar a
%valores de energ�a!
maximo = find(abs(audioObj.timeData) == max(abs(audioObj.timeData)));   

%Quiero 8192 muestras en total y 0.01 segundos de ventana hann a cada lado 
samp=8192;
inicio= maximo-samp/2;
final= maximo+samp/2-1;
if (inicio<0)
    audioObj.timeData=audioObj.timeData(1:1:samp);
else
    audioObj.timeData=audioObj.timeData(inicio:1:final);
    audioObj = samdir_ventaneo('hann',0.01,0.01,audioObj);
end

% Normalizaci�n
audioObj.timeData=audioObj.timeData(1:1:end)./maximo;
varargout(1) = {audioObj};

end

