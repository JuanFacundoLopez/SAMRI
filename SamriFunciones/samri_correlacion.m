%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_correlacion.m                                           *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************
%   samdir_correlacion - Realiza la correlaci�n de dos se�ales ingresadas 
%   como argumento: una es tomada como referencia y la otra es devuelta en
%   fase con la misma. Es necesario ingresar la latencia de la se�al referencia.
%
%   Sintaxis: samdirAudio = samdir_correlaci�n(samdirAudio,samdirAudio,int,int)
%
%   [exc grab_fase] = samdir_correlaci�n(excitacion,grabacion,lat1,lat2)
%***************************************************************************************
function varargout = samdir_correlacion(varargin)

%% Inicializaci�n
exc     = varargin{1}; 
grab    = varargin{2}; 
lat1    = varargin{3}; 
lat2    = varargin{4}; 

%% Correlaci�n 
[x lag]     = xcorr(exc,grab,'none');
[mx,ix]     = max(x);
%plot(x)
duracion    = length(grab);
dif         = duracion-ix;
inicio      = dif+lat1;
final       = duracion-lat2+dif-1;

% Debido a errores en la grabaci�n, puede no haber correlaci�n. Entonces se
% estima la latencia.
if (inicio<0 || final>duracion)
    grabacion   = grab(lat1:1:duracion-lat2-1);
else
    grabacion   = grab(inicio:1:final);
end

varargout(1) = {grabacion};
end
