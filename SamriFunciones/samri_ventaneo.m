%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_ventaneo.m                                               *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_ventaneo(varargin)
%   samdir_ventaneo - Multiplica los datos en el tiempo por una ventana especificada.
%
%   Sintaxis: samdirAudio = samdir_ventaneo('tipo',inic,fin,samdirAudio,[stopmargin])
%   
%   a = samdir_ventaneo('hann',0.1,0.1,x)
%   a = samdir_ventaneo('hann',0.1,0.1,y,0.2)
%   
%   tipo:           ventana
%   inic:           cantidad de segundos al inicio
%   fin:            cantidad de segundos al final
%   samdirAudio:    señal del tipo samdirAudio
%   stopmargin:     silencio al final de la señal, si lo tiene.
%   
%% Inicialización  
tipo_ventana  = varargin{1};
inic     = varargin{2};       
fin      = varargin{3};         
audioObj = varargin{4};

Fs=audioObj.samplingRate;
nSamples=audioObj.nSamples;
samp_vent1=Fs*inic;
samp_vent2=Fs*fin;

%% Generación de la ventana
w1_med = samdir_ventana(samp_vent1,tipo_ventana,1);
w2_med = samdir_ventana(samp_vent2,tipo_ventana,0);

%% Multiplicación por la ventana
if nargin == 5                      %con stopmargin
    silencio= varargin{5}; 
    s_orig  = nSamples-samp_vent1-samp_vent2-silencio*Fs;
    w3      = ones(s_orig,1);
    w4      = zeros(silencio*Fs,1);
    vent    = [w1_med;w3;w2_med;w4];
else                                %sin stopmargin
    s_orig  = nSamples-samp_vent1-samp_vent2;
    w3      = ones(s_orig,1);
    vent    = [w1_med;w3;w2_med];
end

audioObj.timeData= audioObj.timeData.*vent;

varargout(1) = {audioObj};

end

