%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_rellenar.m                                               *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_rellenar(varargin)
%   samdir_rellenar - Rellena con ceros hasta la longitud ingresada como
%   par�metro
%
%   Sintaxis: samdirAudio = samdir_rellenar(samdirAudio, fft_degree)
%   
%   a = samdir_rellenar(x,16)
%   
%   samdirAudio:    se�al del tipo samdirAudio (IR)
%   fft_degree:     longitud final en samples (2^fft_degree)
%   
%% Inicializaci�n  
   
audioObj        = varargin{1};
fft_degree      = varargin{2};   


dur_ant     = audioObj.nSamples;
dur_post    = 2^fft_degree;

if fft_degree > 20
    error(['samdir_rellenar: La longitud ingresada es muy grande. La longitud m�xima es ' num2str(2.^20 ./ audioObj.samplingRate) 's.'])
else
    if (dur_ant > dur_post)
        error(['samdir_rellenar: La longitud ingresada es menor a la longitud original.'])
    else
        dif = dur_post - dur_ant;
        % Los objetos del tipo samdirAudio deber�an tener una longitud de
        % samples par. En caso de que no sea as�, se toma la siguiente
        % precauci�n.
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
