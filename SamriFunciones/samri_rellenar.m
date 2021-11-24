%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_rellenar.m                                               *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_rellenar(varargin)
%   samdir_rellenar - Rellena con ceros hasta la longitud ingresada como
%   parámetro
%
%   Sintaxis: samdirAudio = samdir_rellenar(samdirAudio, fft_degree)
%   
%   a = samdir_rellenar(x,16)
%   
%   samdirAudio:    señal del tipo samdirAudio (IR)
%   fft_degree:     longitud final en samples (2^fft_degree)
%   
%% Inicialización  
   
audioObj        = varargin{1};
fft_degree      = varargin{2};   


dur_ant     = audioObj.nSamples;
dur_post    = 2^fft_degree;

if fft_degree > 20
    error(['samdir_rellenar: La longitud ingresada es muy grande. La longitud máxima es ' num2str(2.^20 ./ audioObj.samplingRate) 's.'])
else
    if (dur_ant > dur_post)
        error(['samdir_rellenar: La longitud ingresada es menor a la longitud original.'])
    else
        dif = dur_post - dur_ant;
        % Los objetos del tipo samdirAudio deberían tener una longitud de
        % samples par. En caso de que no sea así, se toma la siguiente
        % precaución.
        if (round(dif/2)>dif/2)
            inic=zeros(round(dif/2),1);
            final=zeros(round(dif/2)-1,1);
        else
            inic=zeros(dif/2,1);
            final=zeros(dif/2,1);
        end
        audioObj.timeData=[inic ; audioObj.timeData ; final];
    end
end

varargout(1) = {audioObj};

end
