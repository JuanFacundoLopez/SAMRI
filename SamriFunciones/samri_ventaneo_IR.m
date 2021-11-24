%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_ventaneo_IR.m                                            *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_ventaneo_IR(varargin)
%   samdir_ventaneo - Multiplica la IR por una ventana de tiempo
%   determinada, ubicando el máximo en el centro de la señal final.
%
%   Sintaxis: samdirAudio = samdir_ventaneo_IR('tipo',samdirAudio)
%   
%   a = samdir_ventaneo_IR('hann',x)
%   
%   tipo:           ventana
%   samdirAudio:    señal del tipo samdirAudio (IR)
%   
%% Inicialización  

tipo_ventana    = varargin{1};      
audioObj        = varargin{2};

%Guarda la posición del máximo, puede ser un valor negativo asi que pasar a
%valores de energía!
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

% Normalización
audioObj.timeData=audioObj.timeData(1:1:end)./maximo;
varargout(1) = {audioObj};

end

