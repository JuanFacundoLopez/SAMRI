classdef SamRiControlador < handle
    
    properties
        mModelo
        mVista
        mVistaSamRi
    end    
    properties(Access = private, Hidden = true)
        mTipoSenial                = 'sweep';      % 'sweep' / 'lineal'     
        mSeleccionExcitacion       = false;
    end    
    properties(Dependent = true, Hidden = false)
        tipoSenial 
        seleccionExcitacion
    end

    methods
        
        function obj = SamRiControlador(modelo)
            obj.mModelo = modelo;
            obj.mVista = SamRiVista(obj);
%             
        end % Constructor
        
        %% Geters
        function result = getTipoSenial(this)
            result = this.mTipoSenial;
        end
        function result = getSeleccionExcitacion(this)
            result = this.mSeleccionExcitacion;
        end
        
        %% Seters
        function setSeleccionExcitacion(this, value)
            this.mSeleccionExcitacion = value;
        end
        
        %% 
        function calculate(obj)
            obj.mModelo.calculate()
        end
        function reset(obj)
            obj.mModelo.reset()
        end       
        function guardarDatosAudio(this, audioData, fs)
            this.mModelo.setSenialExcitacion(audioData)
            this.mModelo.setSamplingRate(fs)
        end        
        function seleccionMedicion(this, tipo)
            this.tipoMedicion = tipo;
        end
        function crearExcitacion(obj)
%            obj.inicializacion();
           if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.crearExcitacionSweep();
                samri_gui_graficarExcitacionSweep(obj.mVista.mGui.axTop,obj.mModelo.senialExcitacion);
                set(obj.mVista.mGui.graficoBarrasMenu, 'Enable', 'off');
           else
                obj.mModelo.crearExcitacionTonoPuro();
                samri_gui_graficarExcitacionTono(obj.mVista.mGui.axTop,obj.mModelo.senialExcitacionTono);
                obj.mVista.mGui.ftRadiobutton.setSelected(false);
                obj.mVista.mGui.dirRadiobutton.setSelected(true);
           end
           samri_gui_confAxTop(obj.mVista.mGui.axTop);
           obj.seleccionExcitacion = true;

           set(obj.mVista.mGui.excitacionVerMenu, 'Enable', 'on');
           set(obj.mVista.mGui.excitacionEspecVerMenu, 'Enable', 'on');
           
        end

%% Ploters
        function verMenuRespuestaEnFrecuencia(this, signal)
               switch(signal)
                    case 'excitacion'
                        if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                            this.mModelo.verExcitacionSweep;
                        else
                            this.mModelo.verExcitacionTono;
                        end
                    case 'grabada'
                        if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                            this.mModelo.verGrabacionSweep;
                        else
                            this.mModelo.verGrabacionTono;
                        end
                    case 'ir'
                        this.mModelo.verIR();
                    
               end
        end
        function verExcitacion(obj)
            if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.verExcitacionSweep();
            else
                obj.mModelo.verExcitacionTono();
            end
        end    
        function verGrabacion(obj)
            if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.verGrabacionSweep();
            else
                obj.mModelo.verGrabacionTono();
            end
        end
        
%% Players
        function escucharGrabacion(obj)
            if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.escucharGrabacionSweep();
            else
                obj.mModelo.escucharGrabacionTono();
            end
        end
        function escucharExcitacion(obj)
            if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.escucharExcitacionSweep();
            else
                obj.mModelo.escucharExcitacionTono();
            end
        end        
 %% Facu desarrollo
 
function fimportarPrevisual(this, GUI)
    
    this.mModelo = actualizarModelo( this.mModelo, GUI ); % Actualizo modelo de las modificaciones de la GUI
    
    Amplitud     = this.mModelo.getAmplitud();
    
    if(get(GUI.rbInterna,'Value'))
        Frec        = this.mModelo.getFrecuencia();
        FInicial    = this.mModelo.getFrecInicial();
        FFinal      = this.mModelo.getFrecFinal();
        fs          = this.mModelo.getSamplingRate();      
        Exitacion   = this.mModelo.getTipoExcitacion();
        Duracion    = this.mModelo.getDuracion();
        Silen       = this.mModelo.getSilencio;
        Repet       = this.mModelo.getRepeticion;
        
        if strcmp(Exitacion,'linsweep') || strcmp(Exitacion,'expsweep') 
            ObjAudio = samri_generate(Exitacion, FInicial, FFinal, Duracion, fs, Silen, Repet);
        end
        if strcmp(Exitacion, 'sine')
            ObjAudio = samri_generate(Exitacion, Frec,...
                                      Duracion, fs);
        end
        ObjAudio.samplingRate = fs;
    end
    
    if(get(GUI.rbExterna,'Value'))
        ObjAudio    = this.mModelo.getSenialExcitacion(); 
    end
    
    % Grafico la señal previsualizada 
    plot(GUI.axVisua, ObjAudio.timeVector, (ObjAudio.timeData * Amplitud));
    
    GUI.axVisua.Position        = [0.6 0.05 0.385 0.68];
    GUI.axVisua.YLim            = [-1.2 1.2];
    GUI.axVisua.XLim            = [0 ObjAudio.trackLength];
    GUI.axVisua.XAxisLocation   = 'origin';
    GUI.axVisua.Box             = 'off';
    GUI.axVisua.Title.String    = 'Señal previsualizada';
    GUI.axVisua.Title.FontWeight= 'bold';
    GUI.axVisua.XLabel.String   = 'Tiempo [s]';
    GUI.axVisua.YLabel.String   = 'Amplitud normalizada';
    GUI.axVisua.XAxis.Color     = 'k';
    this.mModelo.setSenialExcitacion(ObjAudio);         %Guardo la señal de exitacion original y modificada
    this.mModelo.setAmplitud(Amplitud);

end
function fImportSignal(this,GUI)
    ObjAudio = samriAudio();
    [nombre, path] = uigetfile('*.wav');        % Levanto la señal de un archivo, se debe depurar si no levanto ninguna señal
    [audiodata, fs] = audioread([path, nombre]);% Cargo la señal al proyecto
    set(GUI.LabPath,'String',[path, nombre]);   
    set(GUI.LabPath,'ForegroundColor',[0.1 0.1 0.1]);
    ObjAudio.timeData       = audiodata;
    ObjAudio.samplingRate   = fs;
    this.mModelo.setSenialExcitacion(ObjAudio);
    this.fimportarPrevisual(GUI)

end
function fMedir(this, GUI) %%%%%%%%%-------------MEDIR-----------%%%%%%%
    clc
    cla(GUI.DomTiemp.axSenialTiem)
    cla(GUI.DomFrec.axEspecFrec)
    cla(GUI.Espectro.axSenialTiem)
    cla(GUI.DomCept.axEspecFrec)
    cla(GUI.DomHilb.axEspecFrec)
    hWB = waitbar(0,'Realizando medición');
    this.mModelo    = actualizarModelo( this.mModelo, GUI ); % Actualizo modelo con los cambios de gui
    IndexInput      = this.mModelo.getDispEntradaNum(); IndexOutput= this.mModelo.getDispSalidaNum();    
    fs              = this.mModelo.getSamplingRate(); 
    FI              = this.mModelo.getFrecInicial();    FF         = this.mModelo.getFrecFinal(); 
    SenialExitacion = this.mModelo.getSenialExcitacion();
    Tipo            = this.mModelo.getTipoExcitacion();
    amplitud        = this.mModelo.getAmplitud();
    SenialExitacion.timeData = SenialExitacion.timeData * amplitud;
    inv             = samri_inverso(SenialExitacion,[FI,FF]);
    
    waitbar( 0.2, hWB, 'Realizando medición');
    
    switch Tipo
        case 'linsweep'
            RespExitacion   = samri_reproduce_graba(SenialExitacion.timeData, IndexInput, IndexOutput, fs);
            waitbar(0.4 ,hWB,  'Realizando medición');
            ir_cruda        = samri_deconv_lineal_FFT(RespExitacion, inv, fs);
            waitbar(0.5 ,hWB,  'Realizando calculos');
            waitbar(0.6 , hWB, 'Calculando energia');
            [ETC, ETCI] = samri_energia(ir_cruda); % cargo energia y energia integrada
            waitbar(0.7 , hWB, 'Calculando fft'); 
            SEFFT       = samri_fft(SenialExitacion);% calculo el espectro de la exitacoin
            REFFT       = samri_fft(RespExitacion); % calculo el especto de la respusta
            waitbar(0.75 , hWB, 'Calculando fft');
            SEPDS       = samri_PSD(SenialExitacion); % calculo el psd de la señal 
            REPSD       = samri_PSD(RespExitacion); % calculo el psd de la respuesta

            waitbar(0.75 , hWB, 'Calculando Cepstrum');
            %Calculo cepstrum
            CSenialExitacion = samriCeptrum( SenialExitacion );
            CRespesExitacion = samriCeptrum( RespExitacion );
            CRespuestImpulsi = samriCeptrum( ir_cruda );

            waitbar(0.8 , hWB, 'Calculando Hilbert');
            %Calculo Hilbert
            HSenialExitacion = samriHilbert( SenialExitacion );
            HRespesExitacion = samriHilbert( RespExitacion );
            HRespuestImpulsi = samriHilbert( ir_cruda );
            % Guardo todas las señales procesadas
            waitbar(0.9 , hWB, 'Guardando archivos');

            %guardo señales en el timepo
            this.mModelo.setRespuestaExcitacion     (RespExitacion);
            this.mModelo.setRespuestaImpulsiva      (ir_cruda);
            this.mModelo.setCurvaEnergiaTiempo      (ETC);
            this.mModelo.setCurvaEnergiaTiempoIntegrada(ETCI);
            this.mModelo.setFiltroInverso           (inv);

            % Guardo espectros procesados
            this.mModelo.setEspectroExcitacion      ( SEFFT );
            this.mModelo.setEspectroRespExitac      ( REFFT );
            this.mModelo.setPSDExitacion            ( SEPDS );
            this.mModelo.setPSDRespExitac           ( REPSD );

            % Guardo señales 
            this.mModelo.setCeptSenialExcitacion    (CSenialExitacion);
            this.mModelo.setCeptRespuestaExcitacion (CRespesExitacion);
            this.mModelo.setCeptRespuestaImpulsiva  (CRespuestImpulsi);

            % Guardo señales de hilbert

            this.mModelo.setHilbSenialExcitacion    (HSenialExitacion);
            this.mModelo.setHilbRespuestaExcitacion (HRespesExitacion);
            this.mModelo.setHilbRespuestaImpulsiva  (HRespuestImpulsi);
        case 'expsweep'
            RespExitacion   = samri_reproduce_graba(SenialExitacion.timeData, IndexInput, IndexOutput, fs);
            waitbar( 0.4 , hWB,'Realizando medición');
            ir_cruda        = samri_deconv_lineal_FFT(RespExitacion, inv, fs);
            waitbar( 0.5 , hWB, 'Realizando calculos');
            waitbar(0.6 , hWB, 'Calculando energia');
            [ETC, ETCI] = samri_energia(ir_cruda); % cargo energia y energia integrada
            waitbar(0.7 , hWB, 'Calculando fft'); 
            SEFFT       = samri_fft(SenialExitacion);% calculo el espectro de la exitacoin
            REFFT       = samri_fft(RespExitacion); % calculo el especto de la respusta
            waitbar(0.75 , hWB, 'Calculando fft');
            SEPDS       = samri_PSD(SenialExitacion); % calculo el psd de la señal 
            REPSD       = samri_PSD(RespExitacion); % calculo el psd de la respuesta

            waitbar(0.75 , hWB, 'Calculando Cepstrum');
            %Calculo cepstrum
            CSenialExitacion = samriCeptrum( SenialExitacion );
            CRespesExitacion = samriCeptrum( RespExitacion );
            CRespuestImpulsi = samriCeptrum( ir_cruda );

            waitbar(0.8 , hWB, 'Calculando Hilbert');
            %Calculo Hilbert
            HSenialExitacion = samriHilbert( SenialExitacion );
            HRespesExitacion = samriHilbert( RespExitacion );
            HRespuestImpulsi = samriHilbert( ir_cruda );
            % Guardo todas las señales procesadas
            waitbar(0.9 , hWB, 'Guardando archivos');

            %guardo señales en el timepo
            this.mModelo.setRespuestaExcitacion     (RespExitacion);
            this.mModelo.setRespuestaImpulsiva      (ir_cruda);
            this.mModelo.setCurvaEnergiaTiempo      (ETC);
            this.mModelo.setCurvaEnergiaTiempoIntegrada(ETCI);
            this.mModelo.setFiltroInverso           (inv);

            % Guardo espectros procesados
            this.mModelo.setEspectroExcitacion      ( SEFFT );
            this.mModelo.setEspectroRespExitac      ( REFFT );
            this.mModelo.setPSDExitacion            ( SEPDS );
            this.mModelo.setPSDRespExitac           ( REPSD );

            % Guardo señales 
            this.mModelo.setCeptSenialExcitacion    (CSenialExitacion);
            this.mModelo.setCeptRespuestaExcitacion (CRespesExitacion);
            this.mModelo.setCeptRespuestaImpulsiva  (CRespuestImpulsi);

            %Guardo señales de hilbert

            this.mModelo.setHilbSenialExcitacion    (HSenialExitacion);
            this.mModelo.setHilbRespuestaExcitacion (HRespesExitacion);
            this.mModelo.setHilbRespuestaImpulsiva  (HRespuestImpulsi);
        case 'impulse'
            % se puede obtener RI
        case 'pinknoise'
            % se puede obtener RI
        case 'whitenoise'
            % se puede obtener RI
        case 'impulsetrain'
            % se puede obtener RI
        case 'sine' 
            waitbar( 0.4 , hWB,'Realizando medición');
            RespExitacion   = samri_reproduce_graba(SenialExitacion.timeData, IndexInput, IndexOutput, fs);
            waitbar(0.7 , hWB, 'Calculando fft'); 
            SEFFT           = samri_fft(SenialExitacion);   % calculo el espectro de la exitacoin
            REFFT           = samri_fft(RespExitacion);     % calculo el especto de la respusta
            waitbar(0.75 , hWB, 'Calculando fft');
            SEPDS           = samri_PSD(SenialExitacion);   % calculo el psd de la señal 
            REPSD           = samri_PSD(RespExitacion);     % calculo el psd de la respuesta
            waitbar(0.75 , hWB, 'Calculando Cepstrum');
            
            %Calculo cepstrum
            CSenialExitacion = samriCeptrum( SenialExitacion );
            CRespesExitacion = samriCeptrum( RespExitacion );
            waitbar(0.8 , hWB, 'Calculando Hilbert');
            
            %Calculo Hilbert
            HSenialExitacion = samriHilbert( SenialExitacion );
            HRespesExitacion = samriHilbert( RespExitacion );
            
            % Guardo todas las señales procesadas
            waitbar(0.9 , hWB, 'Guardando archivos');

            %guardo señales en el timepo
            this.mModelo.setRespuestaExcitacion     (RespExitacion);

            % Guardo espectros procesados
            this.mModelo.setEspectroExcitacion      ( SEFFT );
            this.mModelo.setEspectroRespExitac      ( REFFT );
            this.mModelo.setPSDExitacion            ( SEPDS );
            this.mModelo.setPSDRespExitac           ( REPSD );

            % Guardo señales 
            this.mModelo.setCeptSenialExcitacion    (CSenialExitacion);
            this.mModelo.setCeptRespuestaExcitacion (CRespesExitacion);

            %Guardo señales de hilbert
            this.mModelo.setHilbSenialExcitacion    (HSenialExitacion);
            this.mModelo.setHilbRespuestaExcitacion (HRespesExitacion);
            
    end
    
    HabilitoBotones( GUI ); % Habilito los botones
    
    waitbar(1 , hWB, 'Calculos terminados');
    pause(0.2);
    close(hWB);
        
end
function result = fActualizarDispAudio(this, val)
     [ EntradaAudio, SalidaAudio, Serv, SamplingRate, mObjTARS ] = ConsulDisp(); %Deberia ir en el controlador
     this.mModelo.setDispEntradaStr(EntradaAudio.Str(1));
     this.mModelo.setDispEntradaNum(EntradaAudio.Num(1));
     this.mModelo.setDispSalidaStr(SalidaAudio.Str(1));
     this.mModelo.setDispSalidaNum(SalidaAudio.Num(1));
     this.mModelo.setFrecMuestre(SamplingRate(1));
     this.mModelo.setTARSObj(mObjTARS);
     
     obj.Entrada = EntradaAudio.Str;
     obj.Salida  = SalidaAudio.Str;
     obj.Muestr  = SamplingRate;
     
     switch val
         case 'Entrada'
             result = EntradaAudio
         case 'Salida'
             result = SalidaAudio
         case 'Muestreo'
             result = SamplingRate;
         case 'Servidor'
             result = Serv;
         case 'Todo'
             result = obj;
        
         otherwise
             result = mObjTARS;
     end 
end    % Actualiza ante una peticion y al inicializar la GUI

function fServidor(this,GUI)

        pmInd = get(GUI.pmSerA,'Value');
        pmStr = get(GUI.pmSerA,'String');
        pmSer = pmStr{pmInd};
        auxEnt= {};
        auxSal= {};
        GUI.Config.Entrada.Ser
        GUI.Config.Salida.Ser  
        
        for i = 1:length(GUI.Config.Entrada.Ser)
            if strcmp(pmSer,GUI.Config.Entrada.Ser(i))
                auxEnt = [auxEnt(:); GUI.Config.Entrada.Str(i);];
            end
        end
        for i = 1:length(GUI.Config.Salida.Ser)
            if strcmp(pmSer,GUI.Config.Salida.Ser(i))
                auxSal = [auxSal(:); GUI.Config.Salida.Str(i);];
            end
        end
        set(GUI.pmEntr,'String',auxEnt);
        set(GUI.pmSali,'String',auxSal);
end

%% Ventanas de analisis de las señales 
function fbtAnalisis(this, GUI)
    samriVentanaAnalisisGUI(this.mModelo, this)
end
function fbtFrecAnalisis(this, GUI)
    samriVentanaAnalisisFrecGUI(this.mModelo, this)
end
function fETFFrecAnalisis(this,GUI)
    samriETFFrecVentanaAnalisisGUI(this.mModelo, this)
end
function fCeptrumAnalisis(this,GUI)
     samriCeptrumVentanaAnalisisGUI(this.mModelo, this)    
end
function fETFHHTAnalisis(this,GUI)
    samriHHTVentanaAnalisisGUI(this.mModelo, this)           
end
    
%% Interaccion con la TARS
function fReproduceSenial(this)
        ObjAudio = this.mModelo.getSenialExcitacion();
        amplitud = this.mModelo.getAmplitud();
        samri_reproduce(ObjAudio,amplitud);

end                      % Actualiza ante una peticion y al inicializar la GUI
function fbtReproducirRespuestaImpulsiva(this, GUI)
    ObjAudio = this.mModelo.getRespuestaExcitacion();
    amplitud = this.mModelo.getAmplitud();
    samri_reproduce(ObjAudio,amplitud);
end

%% Exposicion de curvas en el dominio del tiempo
function fbtMostrarSenialExitacion(this,GUI)            % Muestra respuesta a la exitacion
    SE = this.mModelo.getSenialExcitacion();
    Ax = GUI.DomTiemp.axSenialTiem;
    
    plot(Ax, SE.timeVector, SE.timeData);
    
    maxV = max(abs(SE.timeData))*1.2;
    minV = maxV*(-1);
    
    Ax.YLim     = [minV maxV];
    Ax.YLabel.String    = 'Amplitud';
    Ax.Title.String     = 'Señal de exitacion';
    Ax.XAxisLocation    = 'origin';
    Ax.XGrid            = 'on';
    Ax.YGrid            = 'on';
    Ax.Toolbar.Visible  = 'on';
    salida = 1;
end
function fbtMostrarRespuestaExitacion(this,GUI)         % Muestra respuesta a la exitacion
    RE = this.mModelo.getRespuestaExcitacion();
    Ax = GUI.DomTiemp.axSenialTiem; 
    
    plot(Ax, RE.timeVector, RE.timeData);

    maxV = max(abs(RE.timeData))*1.2;
    minV = maxV*(-1);
    
    Ax.YLim = [minV maxV];
    Ax.YLabel.String    = 'Amplitud';
    Ax.Title.String     = 'Respuesta a la exitacion';
    Ax.XAxisLocation    = 'origin';
    Ax.XGrid            = 'on';
    Ax.YGrid            = 'on';
    Ax.Toolbar.Visible  = 'on';

    salida = 2; 
end
function fbtMostrarFiltroInverso(this,GUI)              % Muestra el filtro inverso
    FI = this.mModelo.getFiltroInverso();
    Ax = GUI.DomTiemp.axSenialTiem; 
    
    plot(Ax, FI.timeVector, FI.timeData);

    
    maxV = max(abs(FI.timeData))*1.2;
    minV = maxV*(-1);
    Ax.YLim = [minV maxV];
    Ax.YLabel.String    = 'Amplitud';
    Ax.Title.String     = 'Representacion del filtro inverso';
    Ax.XAxisLocation    = 'origin';
    Ax.XGrid    = 'on';
    Ax.YGrid     = 'on';
    Ax.Toolbar.Visible  = 'on';
    
    salida = 3; 
end
function fbtMostrarRespuestaImpulsiva(this,GUI)         % Muestra respuesta impulsiva 
    RI = this.mModelo.getRespuestaImpulsiva();
    Ax = GUI.DomTiemp.axSenialTiem; 
    
    plot(Ax, RI.timeVector, RI.timeData);

    Ax.YLabel.String    = 'Amplitud';
    Ax.Title.String     = 'Representacion de la respuesta impulsiva';
    Ax.XAxisLocation    = 'origin';
    Ax.XGrid    = 'on';
    Ax.YGrid     = 'on';
    Ax.Toolbar.Visible  = 'on';
   
    salida = 4;
end
function fbtMostrarCurvaEnergiaTiempo(this,GUI)         % Muestra la curva energia tiempo
    ETC = this.mModelo.getCurvaEnergiaTiempo();
    VectorSenial = ETC.timeData;
    Ax = GUI.DomTiemp.axSenialTiem; 
    PicoAmp = max(VectorSenial);
    for i = 1:length(VectorSenial)
        if VectorSenial(i) == PicoAmp
           PicoTie = i;
           break;
        end
    end
    VectorSenial(1:PicoTie)=PicoAmp;
    plot(Ax, ETC.timeVector, VectorSenial);
    Ax.YLabel.String = 'Magnitud';
    Ax.Title.String = 'Representacion de la curva Energia - Tiempo';
    Ax.XGrid    = 'on';
    Ax.YGrid     = 'on';
    Ax.Toolbar.Visible  = 'on';
    
    salida = 5;
end
function fbtMostrarCurvaEnergiaTiempoIntegrada(this,GUI)% Muestra la curva energia tiempo integrada
    ETCI = this.mModelo.getCurvaEnergiaTiempoIntegrada();
    VectorSenial = ETCI.timeData;
    Ax = GUI.DomTiemp.axSenialTiem; 
    PicoAmp = max(VectorSenial);
    for i = 1:length(VectorSenial)
        if VectorSenial(i) == PicoAmp
           PicoTie = i;
           break;
        end
    end
    VectorSenial(1:PicoTie)=PicoAmp;
    plot(Ax, ETCI.timeVector, VectorSenial);
    Ax.YLabel.String = 'Magnitud';
    Ax.Title.String = 'Representacion de la curva Energia - Tiempo Integrada';
    Ax.XGrid    = 'on';
    Ax.YGrid     = 'on';
    Ax.Toolbar.Visible  = 'on';
    
    salida = 6;
end

%% Exposicion de curvas en el dominio de la frecuencia
function fbtMostrarEspectroExitacion(this, GUI)
    SExitacion          = this.mModelo.getEspectroExcitacion;
    VectorSenial        = db(abs(real(SExitacion.freqData)),'power');
    VectorFrec          = SExitacion.freqVector;
    axtoolbar(GUI.DomFrec.axEspecFrec,{'zoomin','zoomout','restoreview','rotate'});

    plot(GUI.DomFrec.axEspecFrec, VectorFrec, VectorSenial);
    GUI.DomFrec.axEspecFrec.YLabel.String    = 'Magnitud';
    GUI.DomFrec.axEspecFrec.Title.String     = 'Representacion de la señal de exitacion';
    output_args = 1;
    GUI.DomFrec.axEspecFrec.Position = [0.04 0.06 0.81 0.9];
    GUI.DomFrec.axEspecFrec.Title.FontWeight = 'bold';
    GUI.DomFrec.axEspecFrec.XLabel.String        = 'Frecuencia [Hz]';
    GUI.DomFrec.axEspecFrec.XLim     = [1 30000];
    GUI.DomFrec.axEspecFrec.XGrid    = 'on';
    GUI.DomFrec.axEspecFrec.YGrid    = 'on';
    GUI.DomFrec.axEspecFrec.XScale   = 'log';
end 
function fbtMostrarEspectroResExitac(this, GUI)
    RExitacion          = this.mModelo.getEspectroRespExitac;
    VectorSenial        = db(abs(real(RExitacion.freqData)),'power');
    VectorFrec          = RExitacion.freqVector;
    axtoolbar(GUI.DomFrec.axEspecFrec,{'zoomin','zoomout','restoreview','rotate'});

    plot(GUI.DomFrec.axEspecFrec, VectorFrec, VectorSenial);
    GUI.DomFrec.axEspecFrec.YLabel.String    = 'Magnitud';
    GUI.DomFrec.axEspecFrec.Title.String     = 'Representacion de la respuesta a la exitacion';

    output_args = 2;
    GUI.DomFrec.axEspecFrec.Position = [0.04 0.06 0.81 0.9];
    GUI.DomFrec.axEspecFrec.Title.FontWeight = 'bold';
    GUI.DomFrec.axEspecFrec.XLabel.String        = 'Frecuencia [Hz]';
    GUI.DomFrec.axEspecFrec.XLim     = [1 30000];
    GUI.DomFrec.axEspecFrec.XGrid    = 'on';
    GUI.DomFrec.axEspecFrec.YGrid    = 'on';
    GUI.DomFrec.axEspecFrec.XScale   = 'log';
end  
function fbtMostrarPSDSenialExitacion(this, GUI)
    PSDSExitacion       = this.mModelo.getPSDExitacion();
    VectorSenial        = db(abs(real(PSDSExitacion.freqData)),'power');
    VectorFrec          = PSDSExitacion.freqVector;
    axtoolbar(GUI.DomFrec.axEspecFrec,{'zoomin','zoomout','restoreview','rotate'});
    
    plot(GUI.DomFrec.axEspecFrec, VectorFrec, VectorSenial);
    GUI.DomFrec.axEspecFrec.YLabel.String    = 'Magnitud';
    GUI.DomFrec.axEspecFrec.Title.String     = 'Representacion de la señal de energia de la exitacion';

    output_args = 3;
    GUI.DomFrec.axEspecFrec.Position = [0.04 0.06 0.81 0.9];
    GUI.DomFrec.axEspecFrec.Title.FontWeight = 'bold';
    GUI.DomFrec.axEspecFrec.XLabel.String        = 'Frecuencia [Hz]';
    GUI.DomFrec.axEspecFrec.XLim     = [1 30000];
    GUI.DomFrec.axEspecFrec.XGrid    = 'on';
    GUI.DomFrec.axEspecFrec.YGrid    = 'on';
    GUI.DomFrec.axEspecFrec.XScale   = 'log';
end
function fbtMostrarPSDRespueExitacion(this, GUI)
    PSDRExitacion       = this.mModelo.getPSDRespExitac;
    VectorSenial        = db(abs(real(PSDRExitacion.freqData)),'power');
    VectorFrec          = PSDRExitacion.freqVector;
    axtoolbar(GUI.DomFrec.axEspecFrec,{'zoomin','zoomout','restoreview','rotate'});

    plot(GUI.DomFrec.axEspecFrec, VectorFrec, VectorSenial);
    GUI.DomFrec.axEspecFrec.YLabel.String    = 'Magnitud';
    GUI.DomFrec.axEspecFrec.Title.String     = 'Representacion de la señal de energia de la respuesta a la exitacion';

    output_args = 4;
    GUI.DomFrec.axEspecFrec.Position = [0.04 0.06 0.81 0.9];
    GUI.DomFrec.axEspecFrec.Title.FontWeight = 'bold';
    GUI.DomFrec.axEspecFrec.XLabel.String        = 'Frecuencia [Hz]';
    GUI.DomFrec.axEspecFrec.XLim     = [1 30000];
    GUI.DomFrec.axEspecFrec.XGrid    = 'on';
    GUI.DomFrec.axEspecFrec.YGrid    = 'on';
    GUI.DomFrec.axEspecFrec.XScale   = 'log';
end

%% ***********************************************************************%
%                       Funciones ETF - Fourier
%*******************------------------------------************************%
 
function fETFMostrarEspectroExitacion(this, GUI)
    y = this.mModelo.getSenialExcitacion; 
    axes(GUI.Espectro.axSenialTiem) 
    axtoolbar({'zoomin','zoomout','restoreview','rotate'});
    spectrogram(y.timeData, GUI.EspecParam.Vent, GUI.EspecParam.Ovlp, GUI.EspecParam.TamanioVentana,y.samplingRate,'yaxis')% señal,ventana,divisiones,nfft,fs
    view(-45,65)
    colormap bone
    title('Espectrograma de la Señal de Exitacion');
    xlabel('Tiempo [ms]');
    ylabel('Frecuencia [kHz]');
end
function fETFMostrarEspectroResExitac(this,GUI)
    y = this.mModelo.getRespuestaExcitacion;
    axes(GUI.Espectro.axSenialTiem)  % Grafico que utilizo
    axtoolbar({'zoomin','zoomout','restoreview','rotate'});
    spectrogram(y.timeData, GUI.EspecParam.Vent, GUI.EspecParam.Ovlp, GUI.EspecParam.TamanioVentana,y.samplingRate,'yaxis')% señal,ventana,divisiones,nfft,fs
    view(-45,65)
    colormap bone
    title('Espectrograma de Respuesta a Exitacion');
    xlabel('Tiempo [ms]');
    ylabel('Frecuencia [kHz]');

end
function fETFMostrarRespuestaImpulsiva(this,GUI) 
    y = this.mModelo.getRespuestaImpulsiva; 
    axes(GUI.Espectro.axSenialTiem)  % Grafico que utilizo
    axtoolbar({'zoomin','zoomout','restoreview','rotate'});
    spectrogram(y.timeData, GUI.EspecParam.Vent, GUI.EspecParam.Ovlp, GUI.EspecParam.TamanioVentana,y.samplingRate,'yaxis')% señal,ventana,divisiones,nfft,fs
    view(-45,65)
    colormap bone
    title('Espectrograma de Respuesta Impulsiva');
    xlabel('Tiempo [ms]');
    ylabel('Frecuencia [kHz]');
end

%% ***********************************************************************%
%                       Funciones CEPSTRUM
%*******************------------------------------************************%
function fbtMostrarCeptrumExitacion(this,GUI)
    Ceptrum             = this.mModelo.getCeptExcitacion;
    VectorSenial        = Ceptrum.timeData;
    VectorFrec          = Ceptrum.timeVector;
    axtoolbar(GUI.DomCept.axEspecFrec,{'zoomin','zoomout','restoreview'});
    plot(GUI.DomCept.axEspecFrec, VectorFrec, VectorSenial);
    
    GUI.DomCept.axEspecFrec.YLabel.String        = 'Magnitud';
    GUI.DomCept.axEspecFrec.Title.String         = 'Representacion en el dominio ceptral de la señal de exitacion';
    GUI.DomCept.axEspecFrec.Position             = [0.04 0.06 0.81 0.9];
    GUI.DomCept.axEspecFrec.Title.FontWeight     = 'bold';
    GUI.DomCept.axEspecFrec.XLabel.String        = 'Quefrency';
    GUI.DomCept.axEspecFrec.XGrid                = 'on';
    GUI.DomCept.axEspecFrec.YGrid                = 'on';
    
end
function fbtMostrarCeptrumRespExita(this,GUI)
    Ceptrum             = this.mModelo.getCeptRespExitac;
    VectorSenial        = Ceptrum.timeData;
    VectorFrec          = Ceptrum.timeVector;
    axtoolbar(GUI.DomCept.axEspecFrec,{'zoomin','zoomout','restoreview'});
    plot(GUI.DomCept.axEspecFrec, VectorFrec, VectorSenial);
        
    GUI.DomCept.axEspecFrec.YLabel.String        = 'Magnitud';
    GUI.DomCept.axEspecFrec.Title.String         = 'Representacion en el dominio ceptral de la respuesta a la exitacion';
    GUI.DomCept.axEspecFrec.Position             = [0.04 0.06 0.81 0.9];
    GUI.DomCept.axEspecFrec.Title.FontWeight     = 'bold';
    GUI.DomCept.axEspecFrec.XLabel.String        = 'Quefrency';
    GUI.DomCept.axEspecFrec.XGrid                = 'on';
    GUI.DomCept.axEspecFrec.YGrid                = 'on';
    
end
function fbtMostrarCeptrumRespImpul(this,GUI)
    Ceptrum             = this.mModelo.getCeptRespImpulsiva;
    VectorSenial        = Ceptrum.timeData;
    VectorFrec          = Ceptrum.timeVector;
    axtoolbar(GUI.DomCept.axEspecFrec,{'zoomin','zoomout','restoreview'});
    plot(GUI.DomCept.axEspecFrec, VectorFrec, VectorSenial);
    
    GUI.DomCept.axEspecFrec.YLabel.String        = 'Magnitud';
    GUI.DomCept.axEspecFrec.Title.String         = 'Representacion en el dominio ceptral de la respuesta impulsiva';
    GUI.DomCept.axEspecFrec.Position             = [0.04 0.06 0.81 0.9];
    GUI.DomCept.axEspecFrec.Title.FontWeight     = 'bold';
    GUI.DomCept.axEspecFrec.XLabel.String        = 'Quefrency';
    GUI.DomCept.axEspecFrec.XGrid                = 'on';
    GUI.DomCept.axEspecFrec.YGrid                = 'on';  
end

%% ***********************************************************************%
%                       Funciones HILBERT HUANG
%*******************------------------------------************************%
function fbtMostrarHilbertExitacion(this,GUI)
    Hilbert             = this.mModelo.getHilbExcitacion;
    mesh(GUI.DomHilb.axEspecFrec, seconds(Hilbert.t), Hilbert.f, Hilbert.hs,'EdgeColor','none','FaceColor','interp')
    axtoolbar(GUI.DomHilb.axEspecFrec,{'zoomin','zoomout','restoreview','rotate'});
    GUI.DomHilb.axEspecFrec.YLabel.String    = 'Frecuencia [ Hz  ]';
    GUI.DomHilb.axEspecFrec.XLabel.String    = 'Tiempo [ s ]';
    GUI.DomHilb.axEspecFrec.ZLabel.String    = 'Energia instantanea';
    GUI.DomHilb.axEspecFrec.Title.String     = 'Representacion de la transformada de Hilbert de la señal de exitacion';
    GUI.DomHilb.axEspecFrec.Position         = [0.06 0.06 0.76 0.9];
    GUI.DomHilb.axEspecFrec.Title.FontWeight = 'bold';
%     GUI.DomHilb.axEspecFrec.XGrid            = 'on';
%     GUI.DomHilb.axEspecFrec.YGrid            = 'on';
%     GUI.DomHilb.axEspecFrec.YScale           = 'log';
    
end
function fbtMostrarHilbertRespExita(this,GUI)
    Hilbert             = this.mModelo.getHilbRespExitac;
    mesh(GUI.DomHilb.axEspecFrec, seconds(Hilbert.t),Hilbert.f,Hilbert.hs,'EdgeColor','none','FaceColor','interp')
    axtoolbar(GUI.DomHilb.axEspecFrec,{'zoomin','zoomout','restoreview','rotate'});
    GUI.DomHilb.axEspecFrec.YLabel.String    = 'Frecuencia [ Hz  ]';
    GUI.DomHilb.axEspecFrec.XLabel.String    = 'Tiempo [ s ]';
    GUI.DomHilb.axEspecFrec.ZLabel.String    = 'Energia instantanea';
    GUI.DomHilb.axEspecFrec.Title.String     = 'Representacion de la transformada de Hilbert de la señal de exitacion';
    GUI.DomHilb.axEspecFrec.Position         = [0.06 0.06 0.76 0.9];
    GUI.DomHilb.axEspecFrec.Title.FontWeight = 'bold';
    GUI.DomHilb.axEspecFrec.XGrid            = 'on';
    GUI.DomHilb.axEspecFrec.YGrid            = 'on';
    GUI.DomHilb.axEspecFrec.YScale           = 'log';

end
function fbtMostrarHilbertRespImpul(this,GUI)
    Hilbert             = this.mModelo.getHilbRespImpulsiva;
    mesh(GUI.DomHilb.axEspecFrec,Hilbert.t,Hilbert.f,Hilbert.hs,'EdgeColor','none','FaceColor','interp')
    axtoolbar(GUI.DomHilb.axEspecFrec,{'zoomin','zoomout','restoreview','rotate'});
    GUI.DomHilb.axEspecFrec.YLabel.String    = 'Frecuencia [ Hz  ]';
    GUI.DomHilb.axEspecFrec.XLabel.String    = 'Tiempo [ s ]';
    GUI.DomHilb.axEspecFrec.ZLabel.String    = 'Energia instantanea';
    GUI.DomHilb.axEspecFrec.Title.String     = 'Representacion de la transformada de Hilbert de la señal de exitacion';
    GUI.DomHilb.axEspecFrec.Position         = [0.06 0.06 0.76 0.9];
    GUI.DomHilb.axEspecFrec.Title.FontWeight = 'bold';
    GUI.DomHilb.axEspecFrec.XGrid            = 'on';
    GUI.DomHilb.axEspecFrec.YGrid            = 'on';
    GUI.DomHilb.axEspecFrec.YScale           = 'log';
  
end

%% Cargo señales externas
function fImportarSenExternas(this,GUI)
    %cargar GUI de importar señales
    samriImportSenialesGUI(this.mModelo)
    HabilitoBotones(GUI)
end

%% ***********************************************************************%
%                       Funciones de calibracion
%*******************------------------------------************************%

function fCalibracionGUI(this,GUI)
    refCal = samriCalibracionGUI(this);
    this.mModelo.setReferenciaCalibracion(refCal)
end
% function fCalibracionMed(this,CalGUI)
%     
%     
% end

%% ***********************************************************************%
%                        Guardar Configuracion
%*******************------------------------------************************%
function fGuardarConfg(this,GUI)
    
Config = [];

Config.editUsuario = get(GUI.config.editUsuario, 'String');
Config.editEquipos = get(GUI.config.editEquipos, 'String');
Config.editComenta = get(GUI.config.editComenta, 'String');
Config.pmTipo      = get(GUI.pmTipo, 'Value');
Config.edDura      = get(GUI.edDura, 'String');
Config.edFrec      = get(GUI.edFrec, 'String');
Config.edFreF      = get(GUI.edFreF, 'String');
Config.edFreI      = get(GUI.edFreI, 'String');
Config.edSile      = get(GUI.edSile, 'String');
Config.edRepe      = get(GUI.edRepe, 'String');
Config.edVolu      = get(GUI.edVolu, 'String');
% Config.LabPath     = get(GUI.LabPath,'String');
Config.pmConA      = get(GUI.pmConA, 'Value');
Config.pmNLat      = get(GUI.pmNLat, 'Value');
Config.pmSerA      = get(GUI.pmSerA, 'Value');
Config.pmNCha      = get(GUI.pmNCha, 'Value');
Config.pmEntr      = get(GUI.pmEntr, 'Value');
Config.pmSali      = get(GUI.pmSali, 'Value');
Config.pmReso      = get(GUI.pmReso, 'Value');
Config.pmMues      = get(GUI.pmMues, 'Value');
Config.rbExterna   = get(GUI.rbExterna, 'Value');
data = jsonencode(Config);

[Nombre,path] = uiputfile('*.txt','Guardar Archivo','Medicion1.txt');

if isnumeric(Nombre) || isnumeric(path)
    msgbox('Operacion cancelada', 'Error','warn');
else
    IndId = fopen([path, Nombre],'w');
    fprintf(IndId,data);
    fclose(IndId);
end

end

%% ***********************************************************************%
%                Funciones del panel de medicion
%*************------------------------------------************************%
function fCargarConfg(this,GUI)

fileID = -1;   
[Nombre, path] = uigetfile('*.txt','Cargar Archivo');

if isnumeric(Nombre) || isnumeric(path)
    msgbox('Operacion cancelada', 'Error','warn');
else
    fileID = fopen([path, Nombre],'r');
end

if fileID < 0
    msgbox('No se pudo leer el archivo', 'Error','error');
else
    A = fgets(fileID);
    Config = jsondecode(A);
    fclose(fileID);
    if Config.rbExterna
        set(GUI.rbExterna,          'Value',  1)
%         ObjAudio = samriAudio();
%         set(GUI.LabPath,'String',   Config.LabPath);
        fExterna(GUI)
%         [ObjAudio.dataTime, ObjAudio.samplingRate] = audioread(Config.LabPath);
%         this.mModelo.setSenialExcitacion(ObjAudio);
    else
        set(GUI.rbInterna,          'Value',  1)
        this.fInterna(GUI)
        set(GUI.config.editUsuario, 'String', Config.editUsuario);
        set(GUI.config.editEquipos, 'String', Config.editEquipos);
        set(GUI.config.editComenta, 'String', Config.editComenta);
        set(GUI.pmTipo,             'Value',  Config.pmTipo);
        this.fTipo(GUI)
        set(GUI.edDura,             'String', Config.edDura);
        set(GUI.edFrec,             'String', Config.edFrec);
        set(GUI.edFreF,             'String', Config.edFreF);
        set(GUI.edFreI,             'String', Config.edFreI);
        set(GUI.edSile,             'String', Config.edSile);
        set(GUI.edRepe,             'String', Config.edRepe);
        set(GUI.edVolu,             'String', Config.edVolu);
        set(GUI.pmConA,             'Value',  Config.pmConA);
        set(GUI.pmNLat,             'Value',  Config.pmNLat);
        set(GUI.pmSerA,             'Value',  Config.pmSerA);
        set(GUI.pmNCha,             'Value',  Config.pmNCha);
        set(GUI.pmEntr,             'Value',  Config.pmEntr);
        set(GUI.pmSali,             'Value',  Config.pmSali);
        set(GUI.pmReso,             'Value',  Config.pmReso);
        set(GUI.pmMues,             'Value',  Config.pmMues);
    end
    this.fimportarPrevisual(GUI)
end

end
function fTipo(this, GUI)
    if get(GUI.pmTipo, 'Value') == 3
        set(GUI.edFrec,'Enable','on')
        set(GUI.edFreF,'Enable','off')
        set(GUI.edFreI,'Enable','off')
    end

    if get(GUI.pmTipo, 'Value') == 6 || get(GUI.pmTipo, 'Value') == 7
        set(GUI.edFrec,'Enable','off')
        set(GUI.edFreF,'Enable','on')
        set(GUI.edFreI,'Enable','on')
    end
        
this.fimportarPrevisual(GUI);
end
function fExterna(this, GUI)
    set(GUI.btImpor,'Enable', 'on');
    set(GUI.edFrec, 'Enable', 'off');
    set(GUI.pmTipo, 'Enable', 'off');
    set(GUI.edDura, 'Enable', 'off');
    set(GUI.edFreF, 'Enable', 'off');
    set(GUI.edFreI, 'Enable', 'off');
    set(GUI.edRepe, 'Enable', 'off');
    set(GUI.edSile, 'Enable', 'off');
    Path = get(GUI.LabPath,'String');
    ObjAudio = samriAudio();
    [ObjAudio.timeData, ObjAudio.samplingRate] = audioread(Path);
    this.mModelo.setSenialExcitacion(ObjAudio);
    this.fimportarPrevisual(GUI)

end
function fInterna(this, GUI)
    set(GUI.btImpor,'Enable', 'off');
    set(GUI.pmTipo, 'Enable', 'on');
    set(GUI.edDura, 'Enable', 'on');
    set(GUI.edFreF, 'Enable', 'on');
    set(GUI.edFreI, 'Enable', 'on');
    set(GUI.edRepe, 'Enable', 'on');
    set(GUI.edSile, 'Enable', 'on');
    this.fimportarPrevisual(GUI)

end

%% ***********************************************************************%
%                Panel de configuracion
%*************------------------------------------************************%
function fConfiguracionGUI(this,GUI)
    samriConfiguracionGUI(this.mModelo,GUI);  
end
    end
end