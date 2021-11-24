%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  *
%***************************************************************************************
%* Nombre del Archivo:  samdir_disp_audio.m                                            *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************
%%
function varargout = samdir_disp_audio(varargin)
%   samdir_disp_audio - Reconoce los dispositivos de audio disponibles y
%   los muestra en pantalla.
%
%
%% Carga los datos de disp. de audio del sistema
info = audiodevinfo;

%% Entrada
fprintf ('\nDispositivos de entrada disponibles:')
nDevices = audiodevinfo(1);
for i = 1:nDevices
    fprintf ('\n%2d) %s - ID = %d\n', i, info.input.Name, info.input.ID);
end

%% Salida
fprintf ('\nDispositivos de salida disponibles:')
nDevices = audiodevinfo(0);
for i = 1:nDevices
    fprintf ('\n%2d) %s - ID = %d\n', i, info.output.Name, info.output.ID);
end

end