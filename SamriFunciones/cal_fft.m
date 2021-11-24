%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  cal_fft.m                                                       *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = cal_fft(varargin)
% Sirve para asegurar que las dimensiones de entrada y salida coincidan

for ind = 1:numel(varargin{1})
    varargin{1}(ind) = samri_fft(varargin{1}(ind));
end
varargout{1} = varargin{1};