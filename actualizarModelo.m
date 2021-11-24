function [ modelo ] = actualizarModelo( samriModelo, samriGUI )

    TipoBarridoStr  = {'impulse';'impulsetrain';'sine';'whitenoise';'pinknoise';'expsweep';'linsweep';};
    TipoBarridoVal  = get(samriGUI.pmTipo,'Value');
    DuracionNum     = str2double(get(samriGUI.edDura,'String'));
    
    Sfs         = get(samriGUI.pmMues,'String');
    Vfs         = get(samriGUI.pmMues,'Value');
    
    EntradaStr      = get(samriGUI.pmEntr,'String');
    SalidaStr       = get(samriGUI.pmSali,'String');
    EntradaNum      = get(samriGUI.pmEntr,'Value');
    SalidaNum       = get(samriGUI.pmSali,'Value');
    chEntrada       = EntradaStr{EntradaNum};
    chSalida        = SalidaStr{SalidaNum};
    
    TipoBarrido         = TipoBarridoStr{TipoBarridoVal};
    Duracion            = DuracionNum;
    Frecuencia          = str2double(get(samriGUI.edFrec, 'String'));
    FrecuenciaInicial   = str2double(get(samriGUI.edFreI, 'String'));
    FrecuenciaFinal     = str2double(get(samriGUI.edFreF, 'String'));
    Silencio            = str2double(get(samriGUI.edSile, 'String'));
    Repeticion          = str2double(get(samriGUI.edRepe, 'String'));
    Volumen             = str2double(get(samriGUI.edVolu, 'String'))/100;
    EntradaAudio        = str2double(chEntrada(4:5));
    SalidaAudio         = str2double(chSalida(4:5));
    Muestreo            = str2double(Sfs{Vfs});
    Resolucion          = 16;
    
    samriModelo.setTipoExcitacion(TipoBarrido)      % Tipo de barrido.
    samriModelo.setDuracion(Duracion)               % Duracion.
    samriModelo.setFrecuencia(Frecuencia)           % Frecuencia de tono
    samriModelo.setFrecInicial(FrecuenciaInicial)   % Frecuencia Inicial.
    samriModelo.setFrecFinal(FrecuenciaFinal)       % Frecuencia Final.
    samriModelo.setSilencio(Silencio)               % Silencio.
    samriModelo.setRepeticion(Repeticion)           % Repeticion.
    samriModelo.setAmplitud(Volumen)                % Volumen.
	samriModelo.setDispEntradaNum(EntradaAudio)     % Entrada de audio.
    samriModelo.setDispSalidaNum(SalidaAudio)       % Salida de audio.
    samriModelo.setSamplingRate(Muestreo)           % Muestreo.
    samriModelo.setNBits(Resolucion)                % Resolucion.
    
    
modelo = samriModelo;
end

