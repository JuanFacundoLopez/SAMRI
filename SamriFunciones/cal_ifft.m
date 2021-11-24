%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  cal_ifft.m                                                      *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = cal_ifft(varargin)
% Sirve para asegurar que las dimensiones de entrada y salida coincidan

for ind = 1:numel(varargin{1})
    varargin{1}(ind) = samri_ifft(varargin{1}(ind));
end
varargout{1} = varargin{1};