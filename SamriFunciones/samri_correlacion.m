%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_correlacion.m                                           *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************
%   samdir_correlacion - Realiza la correlación de dos señales ingresadas 
%   como argumento: una es tomada como referencia y la otra es devuelta en
%   fase con la misma. Es necesario ingresar la latencia de la señal referencia.
%
%   Sintaxis: samdirAudio = samdir_correlación(samdirAudio,samdirAudio,int,int)
%
%   [exc grab_fase] = samdir_correlación(excitacion,grabacion,lat1,lat2)
%***************************************************************************************
function varargout = samdir_correlacion(varargin)

%% Inicialización
exc     = varargin{1}; 
grab    = varargin{2}; 
lat1    = varargin{3}; 
lat2    = varargin{4}; 

%% Correlación 
[x lag]     = xcorr(exc,grab,'none');
[mx,ix]     = max(x);
%plot(x)
duracion    = length(grab);
dif         = duracion-ix;
inicio      = dif+lat1;
final       = duracion-lat2+dif-1;

% Debido a errores en la grabación, puede no haber correlación. Entonces se
% estima la latencia.
if (inicio<0 || final>duracion)
    grabacion   = grab(lat1:1:duracion-lat2-1);
else
    grabacion   = grab(inicio:1:final);
end

varargout(1) = {grabacion};
end
