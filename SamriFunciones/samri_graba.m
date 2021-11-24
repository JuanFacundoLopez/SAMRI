%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_graba.m                                                  *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
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

%% Inicialización
t           = varargin{1}; 
grabacion   = samdirAudio;
grabacion.samplingRate = Fs;

%% Reproducción
if(t<0||t>10)
    fprintf('\nTiempo fuera de rango. Establecido en 5 seg.');
    t=5;
end
    
support_ent = audiodevinfo(1,ID_ent,Fs,nBits,nChannels);

if(support_ent)
    grab    = audiorecorder(Fs,nBits,nChannels,ID_ent);
    recordblocking (grab,t);
else
    fprintf('\nParámetros de configuración incorrectos.');
end

grabacion.timeData = getaudiodata(grab); 
grabacion.comment = ['Grabación disp. entrada'];
varargout(1) = {grabacion};
end



