%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_graba.m                                                  *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_graba(varargin)
%   samdir_graba - Graba durante un cierto tiempo que es recibido como 
%   argumento de entrada. Devuelve un objeto de tipo samdirAudio. 
%
%   Sintaxis: samdirAudio = samdir_graba(int)

%% Variables globales
ID_ent      = 1;
Fs          = 48000;
nBits       = 24;
nChannels   = 1;

%% Inicializaci�n
t           = varargin{1}; 
grabacion   = samdirAudio;
grabacion.samplingRate = Fs;

%% Reproducci�n
if(t<0||t>10)
    fprintf('\nTiempo fuera de rango. Establecido en 5 seg.');
    t=5;
end
    
support_ent = audiodevinfo(1,ID_ent,Fs,nBits,nChannels);

if(support_ent)
    grab    = audiorecorder(Fs,nBits,nChannels,ID_ent);
    recordblocking (grab,t);
else
    fprintf('\nPar�metros de configuraci�n incorrectos.');
end

grabacion.timeData = getaudiodata(grab); 
grabacion.comment = ['Grabaci�n disp. entrada'];
varargout(1) = {grabacion};
end



