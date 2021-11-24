function preferencias_definidas = samdir_preferencias_definidas()
%% En esta funci�n se van a setear todas las preferencias que se van a usar
%en todo el programa SAMDir.
%La forma en que se van a grabar es la siguente:
%nombrevariable %defaultvalor %tipo %Nombre mostrado en GUI %texto de ayuda % tabnumero en el que aparece

preferencias_definidas = {...
        'usuario','','char','Usuario','Usuario que ejecuto las pruebas',0;...
        'equipos','','char','Equipos','Nombre de los equipos utilizados para la medici�n',0;...        
        'comentarios','','char','Comentario','Datos adicionales de la medici�n',0;...
        'tipo', '', 'char', 'Tipo', 'Tipo de Se�al de excitaci�n', 1;...
        'duracion', 0, 'int', 'Duraci�n', 'Duraci�n de la se�al de excitaci�n',1;...
        'defaultPath',pwd,'*path','None','Este path es donde se buscar�n los archivos',0;...
        'freqInicial',20,'int', 'Frecuencia Inicial','Frecuencia Inicial que define el rango de frecuencia',1;
        'freqFinal',20000,'int', 'Frecuencia Final','Frecuencia Final que define el rango de frecuencia',1;
        'samplingRate', 48000, 'int', 'Frecuencia de Muestreo', 'Frecuencia de Muestreo de la medici�n', 2;
        'stopMargin', 0, 'int', 'Tiempo de Silencio', 'Es el stop Margin de la se�al', 1;
        'repeticiones', 1, 'int', 'Repeticiones', 'Cantidad de repeticiones de la se�al de excitaci�n', 1;
        'tipoVentana', 'Blackman', 'char', 'Tipo de Ventana', 'Ventana en el Tiempo que se le aplica a la se�al de excitaci�n',1;
        'inicioVentana', 0.1, 'int', 'Inicio', 'Inicio de la Ventana en el tiempo', 1;
        'finVentana', 0.1, 'int', 'Fin', 'Fin de la Ventana en el tiempo', 1;
        'inputDeviceName', '', 'char', 'Dispositivo de Entrada','Dispositivo de entrada de la placa de sonido', 2;
        'inputDeviceID', 0, 'int', 'ID Dispositivo de Entrada','Dispositivo de entrada de la placa de sonido', 2;
        'outputDeviceName', '', 'char', 'Dispositivo de Salida','Dispositivo de salida de la placa de sonido', 2;
        'outputDeviceID', 0, 'int', 'ID Dispositivo de Salida','Dispositivo de salida de la placa de sonido', 2;
        'nBits', 16, 'int', 'Resoluci�n', 'Resolucion de la placa de sonido', 2;
        'nChannels', 1, 'int', '', 'Numero de Canales de la placa de sonido', 0;
        'nivel', 0, 'int', 'Nivel de Entrada', 'Nivel de entrada de la se�al', 3;
        'resolucionDirectividad', 30, 'int', 'Resoluci�n(res)', 'Resoluci�n en angulo de la Directividad', 0;
        'medicionInicial', 0, 'int', 'inicial', 'Angulo de apertura inicial para medir la Directividad', 0;
        'medicionFinal', 360, 'int', 'final', 'Angulo de apertura final para medir la Directividad', 0;
        'planoDirectividad', 'planoHorizontal', 'char', 'Plano', 'Plano en el que se va a realizar la Medici�n', 0;
        'resolucionFiltro', '1/1 Octava', 'char', 'Resoluci�n', 'Resoluci�n del Filtro para aplicar a la respuesta impulsiva', 0;
        'tipoFiltro', 'butter', 'char', 'Tipo de Filtro', 'Tipo de Filtro para aplicar a la respuesta impulsiva', 0;
        'ordenFiltro', 2, 'int', 'Orden del Filtro', 'Orden del Filtro para aplicar a la respuesta impulsiva' ,0;
        'guardarResultados', 0, 'int', 'Guardar respuesta impulsiva', 'Indica si es necesario guardar los resultados' , 0;
        'directorioResultados', '', 'char', 'Directorio', 'Es el path de donde se guardar�n los resultados', 0;
        };
end