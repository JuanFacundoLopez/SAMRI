function varargout = samri_banco_filtros(varargin)
%   samdir_banco_filtros - Genera el banco de filtros de acuerdo a los
%   argumentos de entrada y lo devuelve como salida. Además devuelve un
%   vector con las frecuencias nominales de los filtros.
%
%   Sintaxis: struct_filtros = samdir_banco_filtros(bandas_por_octava, orden)
%
%   filtros = samdir_banco_filtros(3,8)
%
%% Variables Globales
fs = 48000; 
% Frecuencias nominales según norma IRAM 4081:1977
% 10 frecuencias para banda de octava completa, 31 para tercios de octava.

%% Inicialización
BandsPerOctave  = varargin{1}; % Bandas por octava
N               = varargin{2}; % Orden del filtro
NClase           = varargin{3}; % Numero de clase

Class           = {'Class 0','Class 1','Class 2'};
% Frecuencias nominales según norma IRAM 4081:1977
% 10 frecuencias para banda de octava completa, 31 para tercios de octava.

%% Diseño del banco de filtros
F0      = 1000;  % Frecuencia central

% Devuelve las especificaciones para diseñar el filtro con los argumentos
% ingresados, en este caso son filtros de octava completa o fracción de
% octava. El primer argumento es la cantidad de bandas por octava, luego la
% clase, despues el campo correspondiente a la especificación, el orden del
% mismo y la frecuencia central. Por último, la frecuencia de muestreo
f       = fdesign.octave(BandsPerOctave, Class{NClase},'N,F0',N,F0,fs);
% Se obtiene un vector con todas las frecuencias del rango de audio
F0      = validfrequencies(f);
Nfc     = length(F0);

% Se diseña el banco de filtros. En este caso con las especificaciones
% guardadas en f, del tipo Butterworth
for i=1:Nfc
    f.F0 = F0(i);
    Hd(i) = design(f,'butter');
end
% Devuelve los filtros creados y las frecuencias nominales
varargout(1) = {Hd};
varargout(2) = {F0};
          
end

