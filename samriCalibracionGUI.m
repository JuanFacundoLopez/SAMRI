function referencia = samriCalibracionGUI(Controlador)
Modelo = Controlador.mModelo;
CAL = [];
RA = [190,14, 0]./255;
RP = [255, 0, 0]./255;
AA = [200,200,0]./255;
AP = [255,255,0]./255;
VA = [35 ,180,0]./255;
VP = [50 ,255,0]./255;

CAL.Config.Entrada  = Controlador.fActualizarDispAudio('Entrada');
CAL.Config.Salida   = Controlador.fActualizarDispAudio('Salida');

CAL.hFig = findall(0, '-depth',1, 'type','figure', 'Name','Ventana de calibracion');

if isempty(CAL.hFig)
    CAL.hFig = figure(  'Name','Ventana de calibración',...
                        'NumberTitle','off', 'Visible','on',...
                        'Color','w', 'Units', 'normalized',...
                        'Position',[0.35,0.35,0.4,0.3],...
                        'Toolbar','none', 'Menu', 'none');
else
    clf(CAL.hFig);
    hc=findall(gcf); delete(hc(2:end)); 
end
                   %%%%%%%%%%%%% PANEL 1 %%%%%%%%%%%%%%%%%%%
CAL.panel(1) = uibuttongroup('Parent',CAL.hFig,'Title','Señal de exitacion','FontSize',12,...   %señal de exitacion
                               'BackgroundColor','w','Position',[.01 .47 .68 .54]);
  
uicontrol(CAL.panel(1),'Style','text', 'Units', 'normalized', 'Position', [0.01 0.8 0.2 0.15],'BackgroundColor','w',...
                                'String','Entrada', 'FontSize', 10);  
                            
CAL.slVolu = uicontrol(CAL.hFig,'Style','slider', 'Units', 'normalized', 'Position', [0.7 0.47 0.03 0.54],'BackgroundColor','w',...
                                'String','Entrada', 'FontSize', 10, 'Value', 1);   

CAL.pmEntr = uicontrol(CAL.panel(1),'Style','popupmenu', 'Units', 'normalized', 'Position', [0.1 0.68 0.8 0.1],...
                        'String', CAL.Config.Entrada, 'FontSize', 10,'BackgroundColor','w');
                    
uicontrol(CAL.panel(1),'Style','text', 'Units', 'normalized', 'Position', [0.01 0.35 0.18 0.15],'BackgroundColor','w',...
                                'String','Salida', 'FontSize', 10);                            

CAL.pmSali = uicontrol(CAL.panel(1),'Style','popupmenu', 'Units', 'normalized', 'Position', [0.1 0.2 0.8 0.1],...
                        'String', CAL.Config.Salida, 'FontSize', 10,'BackgroundColor','w');
                    
                    
                    %%%%%%%%%%%%% PANEL 2 %%%%%%%%%%%%%%%%%%%
CAL.panel(2) = uibuttongroup('Parent',CAL.hFig,'Title','Información','FontSize',12,...   %señal de exitacion
                               'BackgroundColor','w','Position',[.01 .12 .97 .35]);                    
                    
CAL.pmText = uicontrol(CAL.panel(2),'Style','text', 'Units', 'normalized', 'Position', [0 0 0.99 0.99],...
                        'String', 'Texto informativo', 'FontSize', 10,'BackgroundColor','w'); 
                    
                    %%%%%%%%%%%%% BOTONES %%%%%%%%%%%%%%%%%%%
CAL.btCalibrar =  uicontrol(CAL.hFig,'Style','pushbutton', 'Units', 'normalized', 'Position', [0.65 0.01 0.15 0.1],...
                        'String','Calibrar', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold','Callback',@(h,e)RealizaMedicion);
                    
CAL.btCancelar =  uicontrol(CAL.hFig,'Style','pushbutton', 'Units', 'normalized', 'Position', [0.8 0.01 0.15 0.1],...
                        'String','Cancelar', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold','Callback',@(h,e)Cancelar);                    
                    
                    
                   %%%%%%%%% VUMETRO %%%%%%%%%%%%%
                   
CAL.txEntr = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.93 0.07 0.05],...
                        'String', 'Entrada', 'FontSize', 8,'BackgroundColor','w','FontWeight','bold');                    
                    
CAL.txSali = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.93 0.07 0.05],...
                        'String', 'Salida', 'FontSize', 8,'BackgroundColor','w','FontWeight','bold');
                    
                    %%%%%%% Luces %%%%%%%%
CAL.txVuEntr(8) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.88 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', RA,'FontWeight','bold');                      
CAL.txVuEntr(7) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.83 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', RA,'FontWeight','bold');                      
CAL.txVuEntr(6) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.78 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', AA,'FontWeight','bold');                      
CAL.txVuEntr(5) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.73 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', AA,'FontWeight','bold');  
CAL.txVuEntr(4) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.68 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', AA,'FontWeight','bold');                      
CAL.txVuEntr(3) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.63 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', VA,'FontWeight','bold');                      
CAL.txVuEntr(2) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.58 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', VA,'FontWeight','bold');  
CAL.txVuEntr(1) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.53 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', VA,'FontWeight','bold');                      
CAL.txdbEntr = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.87 0.47 0.07 0.05],...
                        'String', '-Inf [db]', 'FontSize', 8,'BackgroundColor','w','FontWeight','bold');  

CAL.txVuSali(8) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.88 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', RA,'FontWeight','bold');                      
CAL.txVuSali(7) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.83 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', RA,'FontWeight','bold');                      
CAL.txVuSali(6) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.78 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', AA,'FontWeight','bold');                      
CAL.txVuSali(5) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.73 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', AA,'FontWeight','bold');  
CAL.txVuSali(4) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.68 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', AA,'FontWeight','bold');                      
CAL.txVuSali(3) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.63 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', VA,'FontWeight','bold');                      
CAL.txVuSali(2) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.58 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', VA,'FontWeight','bold');  
CAL.txVuSali(1) = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.53 0.07 0.035],...
                        'String', '', 'FontSize', 8,'BackgroundColor', VA,'FontWeight','bold');                        
                    
                    
CAL.txdbSali = uicontrol(CAL.hFig,'Style','text', 'Units', 'normalized', 'Position', [0.75 0.47 0.07 0.05],...
                        'String', '-Inf [db]', 'FontSize', 8,'BackgroundColor','w','FontWeight','bold');                     
                    
    function RealizaMedicion(h,e)                     
clc
    IndexInput      = Modelo.getDispEntradaNum; 
    IndexOutput     = Modelo.getDispSalidaNum;
    fs              = 44100;
    Vol             = get(CAL.slVolu,'Value');
    
    exitacion = MakeBeep(1000,5,fs) .* Vol;
    tiempoGrab  = 2;
    grabacion   = samriAudio();
    grabacion.samplingRate = 44100;
    recordedaudio = [];
    j = 0;
    
    nrchannels = 2;
    repetitions = 1;            %[, deviceid][, mode][, reqlatencyclass][, freq][, channels]

    pahandleReproduccion    = PsychPortAudio(  'Open',...      % Open Psych-Audio port, with the follow arguements
                                IndexOutput,... % Indice de dispositivo de audio
                                1,...           % 1 = sound playback only
                                1,...           % 1 = default level of latency
                                fs,...          % Requested frequency in samples per second
                                nrchannels);    % 2 = stereo putput

    pahandleGrabacion       = PsychPortAudio(  'Open',...      % Open Psych-Audio port, with the follow arguements
                                IndexInput,...  % Indice de dispositivo de audio
                                2,...           % 2 = sound recorder only
                                1,...           % 1 = default level of latency. le meti un 3 para mejorar la respuesta y mejoro
                                fs,...          % Requested frequency in samples per second
                                nrchannels);    % 2 = stereo putput
                            
    
    MaxValRMSOut = VumOutRMS(exitacion);
    set(CAL.txdbSali,'String',[num2str(round(log10(MaxValRMSOut)),3),'[db]']);    

    PsychPortAudio('FillBuffer', pahandleReproduccion, [exitacion; exitacion]);   % Cargo el vector en el buffer
    PsychPortAudio('GetAudioData', pahandleGrabacion, tiempoGrab);                  % Programo la grabacion

    PsychPortAudio('Start', pahandleReproduccion, repetitions);             % Reproduzco  lo del buffer
    PsychPortAudio('Start', pahandleGrabacion, 0, 0, 1);                    % Comienzo la captura
    
    while (length(recordedaudio) / fs) < tiempoGrab
        audiodata = PsychPortAudio('GetAudioData', pahandleGrabacion);
        recordedaudio = [recordedaudio, audiodata];                         
        if length(recordedaudio(1,:)) > 5500 * (j+1)                        
            MaxValRMSIn = [MaxValRMSIn, VumRMS(recordedaudio(1, (j * 5500)+1 : end))];     % se envien al vumetro para que indiquen el LP que muestran 
            j = j + 1;                                                      %
            set(CAL.txdbEntr,'String',[num2str(round(MaxValRMSIn(j),1)),'[db]']);
        end
    end
    
    referencia = 0;
    
    VumRMS(recordedaudio(1, (j * 5500)+1 : end)); 
    VumRMS(0);
    VumOutRMS(0);
    grabacion.timeData = recordedaudio(1,:)';
    PsychPortAudio('Stop',pahandleReproduccion);
    PsychPortAudio('Stop',pahandleGrabacion);
    PsychPortAudio('Close');
    
    end

    function Cancelar(h,e)
       close(CAL.hFig);
    end
    function VumInLog = VumRMS(Data)
        if length(Data) < 5500
            Data = [Data, zeros(1,5500-length(Data))];
        end
        VumIn = rms(Data);
        VumInLog = 10*log10(VumIn);
        
        if VumInLog > -20,  set(CAL.txVuEntr(1),'BackGroundColor', VP);else, set(CAL.txVuEntr(1),'BackGroundColor', VA); end
        if VumInLog > -10,  set(CAL.txVuEntr(2),'BackGroundColor', VP);else, set(CAL.txVuEntr(2),'BackGroundColor', VA); end
        if VumInLog > -7,   set(CAL.txVuEntr(3),'BackGroundColor', VP);else, set(CAL.txVuEntr(3),'BackGroundColor', VA); end
        if VumInLog > -5,   set(CAL.txVuEntr(4),'BackGroundColor', AP);else, set(CAL.txVuEntr(4),'BackGroundColor', AA); end
        if VumInLog > -3,   set(CAL.txVuEntr(5),'BackGroundColor', AP);else, set(CAL.txVuEntr(5),'BackGroundColor', AA); end 
        if VumInLog > -2,   set(CAL.txVuEntr(6),'BackGroundColor', AP);else, set(CAL.txVuEntr(6),'BackGroundColor', AA); end
        if VumInLog > -1,   set(CAL.txVuEntr(7),'BackGroundColor', RP);else, set(CAL.txVuEntr(7),'BackGroundColor', RA); end
        if VumInLog > -0.5, set(CAL.txVuEntr(8),'BackGroundColor', RP);else, set(CAL.txVuEntr(8),'BackGroundColor', RA); end
        pause(0.00001)
    end

    function VumOut = VumOutRMS(Datos)
        VumOut = rms(Datos) * 1.4;                    

        if VumOut > 0.0001, set(CAL.txVuSali(1),'BackGroundColor', VP);else, set(CAL.txVuSali(1),'BackGroundColor', VA); end
        if VumOut > 0.001,  set(CAL.txVuSali(2),'BackGroundColor', VP);else, set(CAL.txVuSali(2),'BackGroundColor', VA); end
        if VumOut > 0.01,   set(CAL.txVuSali(3),'BackGroundColor', VP);else, set(CAL.txVuSali(3),'BackGroundColor', VA); end
        if VumOut > 0.1,    set(CAL.txVuSali(4),'BackGroundColor', AP);else, set(CAL.txVuSali(4),'BackGroundColor', AA); end
        if VumOut > 0.5,    set(CAL.txVuSali(5),'BackGroundColor', AP);else, set(CAL.txVuSali(5),'BackGroundColor', AA); end 
        if VumOut > 0.6,    set(CAL.txVuSali(6),'BackGroundColor', AP);else, set(CAL.txVuSali(6),'BackGroundColor', AA); end
        if VumOut >= 0.7,   set(CAL.txVuSali(7),'BackGroundColor', RP);else, set(CAL.txVuSali(7),'BackGroundColor', RA); end
        if VumOut >= 0.8,   set(CAL.txVuSali(8),'BackGroundColor', RP);else, set(CAL.txVuSali(8),'BackGroundColor', RA); end
        
    end
end