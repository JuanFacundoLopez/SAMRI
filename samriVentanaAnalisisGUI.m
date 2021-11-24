function samriVentanaAnalisisGUI(Modelo, Controlador)

AnalF.Config.ModoTiempo           = {'Filtro 1/1 Octava', 'Filtro 1/3 Octava'};
AnalF.Config.Filtros.Octava.Str   = {'31.5','63','125','250','500','1000','2000','4000','8000','16000'};
AnalF.Config.Filtros.TerOct.Str   = {'20','25','31.5','40','50','63','80','100','125','160','200','250','315','400','500','630','800','1000','1250','1600','2000','2500','3150','4000','5000','6300','8000','10000','12500','16000','20000'};
AnalF.Config.Ventana              = {'Rectangular','Hanning','Blackman - Harris','Flat top'};
AnalF.Config.Class.Str            = {'Clase 0', 'Clase 1', 'Clase 2'};
AnalF.Config.Ord.Str              = {'8','10','12','16','20','26','50','80','100'};
AnalF.Config.Met.Str              = {'IRR','FIR'}; 
filtroAplico                      = [];
filtroAplico.FPB.hab              = 0;
filtroAplico.FPA.hab              = 0;
Hd                                = [];

% Crea una figura nueva

AnalF.hFig = figure( 'Name','Ventana de Analisis en el tiempo',...
                    'NumberTitle','off',...
                    'Visible','on',...
                    'Color','w',...
                    'Position',[100,50,1500,900],...
                    'Toolbar','none',...
                    'Menu', 'none');

%% Agrego los uimenu FILE

AnalF.menu(1) = uimenu(AnalF.hFig,'Label','Archivo');                                                       %CREO EL MENU

AnalF.subMenuArchivo(1) = uimenu(AnalF.menu(1),'Label','Abrir','Accelerator','O');                          %CREO LOS SUBMENU
AnalF.subMenuArchivo(2) = uimenu(AnalF.menu(1),'Label','Guardar','Accelerator','S');                        %
AnalF.subMenuArchivo(3) = uimenu(AnalF.menu(1),'Label','Guardar como...');                                  %
AnalF.subMenuArchivo(4) = uimenu(AnalF.menu(1),'Label','Cerrar');  

% Agrego los uimenu HERRAMIENTAS       
AnalF.menu(2) = uimenu(AnalF.hFig,'Label','Herramientas');                                                  %CREO EL MENU

AnalF.subMenuHerrami(1) = uimenu(AnalF.menu(2),'Label','Aplicar filtros','Accelerator','F');                    %CREO LOS SUBMENU

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE SEÑALES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AnalF.panel(1)  = uipanel(  'Parent', AnalF.hFig, 'Title','Señales', 'FontSize',12,...                  %entradas salidas
                            'BackgroundColor','w','Position',[.82 .71 .175 .29]);        

AnalF.SenialExi = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [20 212 270 25],...
                                'String','Señal de exitacion', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);

AnalF.RespueExi = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [20 182 270 25],...
                                'String','Respuesta a la exitacion', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                            
AnalF.FiltroInv = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [20 152 270 25],...
                                'String','Filtro inverso', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                            
AnalF.RespImpul = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [20 122 270 25],...
                                'String','Respuesta impulsiva', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                           
AnalF.ETC       = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [20 92 270 25],...
                                'String','Curva Energia - Tiempo', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);                            
                            
AnalF.ETCI      = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [20 62 270 25],...
                                'String','Curva Energia - Tiempo Integrada', 'FontSize', 10,...
                                'BackgroundColor','w', 'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);                            

AnalF.cbXGrid     = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [20 22 100 25],...
                                'String','X Grilla', 'FontSize', 10, 'BackgroundColor','w', ...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);  
                            
AnalF.cbYGrid     = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [120 22 100 25],...
                                'String','Y Grilla', 'FontSize', 10, 'BackgroundColor','w', ...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);  
                                                         
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE FILTROS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                    % Defino el PANEL
AnalF.panel(2) = uipanel('Parent', AnalF.hFig,'Title','Filtros', 'FontSize',12,...%Info secundaria
                               'BackgroundColor','w','Position',[.82 .18 .175 .52]);    

                           % Agrego el PM del MODO       
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 407 70 30], 'String','Modo:',...
            'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');                            

AnalF.pmModo = uicontrol(       AnalF.panel(2),'Style','popupmenu', 'Position', [80 370 120 70],...
                                'String', AnalF.Config.ModoTiempo, 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fCambiarOctava);

AnalF.chModo = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 413 25 25],...
                                'Value', 0,'Callback',@(h,e)fCambiarOctava);
                            
                            % Agrego la opcion de la FRECUENCIA
                            
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 357 70 30], 'String','Frec [Hz]:',...
            'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');  
                            
AnalF.pmFrec = uicontrol(       AnalF.panel(2),'Style','popupmenu', 'Position', [80 320 120 70],...
                                'String', AnalF.Config.Filtros.Octava.Str, 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fActualizarSeniales);

AnalF.chFrec = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 363 25 25],...
                                'Value', 0,'Callback',@(h,e)fActualizarSeniales);

                            % Agrego la opcion de el ORDEN
                            
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 307 70 30],'String','Orden:',...
            'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');
                    
AnalF.pmOrde = uicontrol(       AnalF.panel(2),'Style','popupmenu', 'Position', [80 270 120 70],...
                                'String', AnalF.Config.Ord.Str, 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fActualizarSeniales);
                                            
AnalF.chOrde = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 313 25 25],...
                                'Value', 0,'Callback',@(h,e)fActualizarSeniales);  
                            
                            % Agrego la opcion de la LONGITUD
                            
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 257 70 30],'String','Clase:',...
            'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');
                    
AnalF.pmClas = uicontrol(       AnalF.panel(2),'Style','popupmenu', 'Position', [80 220 120 70],...
                                'String', AnalF.Config.Class.Str, 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fActualizarSeniales);
                                            
AnalF.chClas = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 266 25 25],...
                                'Value', 0,'Callback',@(h,e)fActualizarSeniales);                           
                           
                            % Agrego  la opcion de la VENTANA
                            
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 207 70 30], 'String','Ventana:', ...
            'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');
                    
AnalF.pmTipo = uicontrol(       AnalF.panel(2),'Style','popupmenu', 'Position', [80 170 120 70],...
                                'String', AnalF.Config.Ventana, 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fActualizarSeniales);
 
AnalF.chTipo = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 216 25 25],...
                                'Value', 0,'Callback',@(h,e)fActualizarSeniales);                            
                         
                            % Agrego la opcion del METODO
                            
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 157 70 30],'String','Metodo:',...
            'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');
                    
AnalF.pmMeto = uicontrol(       AnalF.panel(2),'Style','popupmenu', 'Position', [80 120 120 70],...
                                'String', AnalF.Config.Met.Str, 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fActualizarSeniales);
                                            
AnalF.chMeto = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 166 25 25],...
                                'Value', 0,'Callback',@(h,e)fActualizarSeniales);   
                            
                            % Agrego la opcion de la GANANCIA
                            
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 113 70 30],'String','Ganancia:',...
            'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');
                    
AnalF.pmGain = uicontrol(       AnalF.panel(2),'Style','edit', 'Position', [80 120 120 25],...
                                'String', '1', 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fActualizarSeniales);
                                            
AnalF.chGain = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 122 25 25],...
                                'Value', 0,'Callback',@(h,e)fActualizarSeniales);  
                            
                            % Agrego la opcion de la FPB
                            
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 63 70 30],'String','P. Bajos:',...
            'FontSize', 10,'BackgroundColor','w','FontWeight','bold');
                    
AnalF.edFPB  = uicontrol(       AnalF.panel(2),'Style','edit', 'Position', [80 70 120 25],...
                                'String', '20000', 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fActualizarSeniales);
                                            
AnalF.chFPB  = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 72 25 25],...
                                'Value', 0,'Callback',@(h,e)fActualizarSeniales);                            
                            
                            % Agrego la opcion de la FPA
                            
uicontrol(  AnalF.panel(2),'Style','text', 'Position', [3 13 70 30],'String','P. Altos:',...
            'FontSize', 10,'BackgroundColor','w','FontWeight','bold');
                    
AnalF.edFPA  = uicontrol(       AnalF.panel(2),'Style','edit', 'Position', [80 20 120 25],...
                                'String', '20', 'FontSize', 10,'BackgroundColor','w',...
                                'Callback',@(h,e)fActualizarSeniales);
                                            
AnalF.chFPA  = uicontrol(       AnalF.panel(2),'Style','checkbox', 'Position', [220 22 25 25],...
                                'Value', 0,'Callback',@(h,e)fActualizarSeniales);       
                            
%% Importar - Exportar señales
                            
AnalF.btImport = uicontrol( 'Style','pushbutton', 'Units','normalized','Position', [.82 .05 .08 .05],...
                            'String', 'Importar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fImportSeniales);


AnalF.btExport = uicontrol( 'Style','pushbutton', 'Units','normalized','Position', [.91 .05 .08 .05],...
                            'String', 'Exportar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fExportSeniales);
                            
                            
                    
  %% Ploteo las señales en el grafico en comun                          
fActualizarSeniales                            

function fActualizarSeniales(h,e)

    SE  = Modelo.getSenialExcitacion;
    RE  = Modelo.getRespuestaExcitacion;
    FI  = Modelo.getFiltroInverso;
    RI  = Modelo.getRespuestaImpulsiva;
    ETC = Modelo.getCurvaEnergiaTiempo;
    ETCI= Modelo.getCurvaEnergiaTiempoIntegrada;

filtrosCaract = [];
filtrosCaract.Modo      = get(AnalF.pmModo,'Value');
filtrosCaract.FPB       = str2double(get(AnalF.edFPB,'String'));
filtrosCaract.FPA       = str2double(get(AnalF.edFPA,'String'));
filtrosCaract.Clase     = get(AnalF.pmClas,'Value');
filtrosCaract.orden     = str2double(AnalF.Config.Ord.Str{get(AnalF.pmOrde,'Value')});
filtrosCaract.ventana   = str2double(AnalF.Config.Ventana{get(AnalF.pmTipo,'Value')});
filtrosCaract.ganancia  = str2double(get(AnalF.pmGain,'String'));
filtrosCaract.metodo    = AnalF.Config.Met.Str{get(AnalF.pmMeto,'Value')};

BandsPerOctave = [1,3];

[Hd ,F0] = samri_banco_filtros(BandsPerOctave(filtrosCaract.Modo),filtrosCaract.orden ,filtrosCaract.Clase);

if get(AnalF.pmModo,'Value')==1
    filtrosCaract.frecNorm  = AnalF.Config.Filtros.Octava.Str{get(AnalF.pmFrec,'Value')};
else
    filtrosCaract.frecNorm  = AnalF.Config.Filtros.TerOct.Str{get(AnalF.pmFrec,'Value')};
end

LP = filtrosCaract.FPB;
HP = filtrosCaract.FPA;
Orden = filtrosCaract.orden;
Fs = 44100;   

    if get(AnalF.chFrec, 'Value') == 1
        filtroAplico.Octavas.Hab = 1;
    else
        filtroAplico.Octavas.Hab = 0;
    end

    if get(AnalF.pmMeto,'Value') == 2
        if get(AnalF.chFPB,'Value')
            FPB = designfilt( 'lowpassfir','PassbandFrequency',LP,...
                              'StopbandFrequency',LP*1.1,...
                              'SampleRate',Fs,'FilterOrder',Orden);
            filtroAplico.FPB.filter = FPB;
            filtroAplico.FPB.hab = 1;
        else 
            filtroAplico.FPB.hab = 0;
        end

        if get(AnalF.chFPA, 'Value')
            FPA = designfilt( 'highpassfir','PassbandFrequency',HP,...
                              'StopbandFrequency',HP*0.9,...
                              'SampleRate',Fs,'FilterOrder',Orden);
            filtroAplico.FPA.filter = FPA;
            filtroAplico.FPA.hab = 1;
        else 
            filtroAplico.FPA.hab = 0;
        end
     else
        if get(AnalF.chFPB, 'Value')
            FPB = designfilt( 'lowpassiir','PassbandFrequency',LP,...
                              'SampleRate',Fs,'FilterOrder',Orden);
            filtroAplico.FPB.filter = FPB;
            filtroAplico.FPB.hab = 1;
        else 
            filtroAplico.FPB.hab = 0;
        end

        if get(AnalF.chFPA, 'Value')
            FPA = designfilt( 'highpassiir','PassbandFrequency',HP,...
                              'SampleRate',Fs,'FilterOrder',Orden);
            filtroAplico.FPA.filter = FPA;
            filtroAplico.FPA.hab = 1;
        else 
            filtroAplico.FPA.hab = 0;
        end

    end

j=0;

    SumVec = get(AnalF.SenialExi,'Value') + get(AnalF.RespueExi,'Value') + get(AnalF.FiltroInv,'Value') + ...
              get(AnalF.RespImpul,'Value') + get(AnalF.ETC,'Value') + get(AnalF.ETCI,'Value');

    cla; %clear axis

    x = 0.04;
    width = 0.76;
    
    switch SumVec
        case 1
             height = 0.9;
        case 2
             height = 0.39;
        case 3
             height = 0.253;
        case 4
             height = 0.183;
        case 5
             height = 0.133;
        case 6
             height = 0.108;
     end

    if get(AnalF.SenialExi,'Value')
        if filtroAplico.Octavas.Hab == 1
           SE.timeData = filter(Hd(get(AnalF.pmFrec,'Value')),SE.timeData);
        end
        if filtroAplico.FPB.hab == 1
           SE.timeData = filter(filtroAplico.FPB.filter,SE.timeData);   
        end
        if filtroAplico.FPA.hab == 1
           SE.timeData = filter(filtroAplico.FPA.filter,SE.timeData); 
        end

        j=j+1;
        y = 0.942 - (0.922*j/SumVec) + 0.07;
        pos = [x y width height];
        subplot('Position', pos);
        plot(SE.timeVector,SE.timeData);
        legend('Señal de exitacion');
        ylabel('Amplitud','FontSize',9);
        xlabel('Tiempo [s]','FontSize',9);
        fAxesAnal
        
    end

    if get(AnalF.RespueExi,'Value')
        if filtroAplico.Octavas.Hab == 1
            RE.timeData = filter(Hd(get(AnalF.pmFrec,'Value')),RE.timeData);
        end
        if filtroAplico.FPB.hab == 1
            RE.timeData = filter(filtroAplico.FPB.filter,RE.timeData);   
        end
        if filtroAplico.FPA.hab == 1
            RE.timeData = filter(filtroAplico.FPA.filter,RE.timeData); 
        end

        j=j+1;
        y = 0.942 - (0.922*j/SumVec) + 0.07;
        pos = [x y width height];
        subplot('Position', pos);
        plot(RE.timeVector, RE.timeData);
        legend('Respuesta a la exitacion');
        ylabel('Amplitud','FontSize',9);
        xlabel('Tiempo [s]','FontSize',9);
        fAxesAnal
    end
    
    if get(AnalF.FiltroInv,'Value')
        if filtroAplico.Octavas.Hab == 1
            FI.timeData = filter(Hd(get(AnalF.pmFrec,'Value')),FI.timeData);
        end
        if filtroAplico.FPB.hab == 1
            FI.timeData = filter(filtroAplico.FPB.filter,FI.timeData);   
        end
        if filtroAplico.FPA.hab == 1
            FI.timeData = filter(filtroAplico.FPA.filter,FI.timeData); 
        end
        j=j+1;
        y = 0.942 - (0.922*j/SumVec) + 0.07;
        pos = [x y width height];
        subplot('Position', pos);

        plot(FI.timeVector,FI.timeData)
        legend('Filtro inverso de la señal de exitacion');
        ylabel('Amplitud','FontSize',9);
        xlabel('Tiempo [s]','FontSize',9);
        fAxesAnal
    end
    
    if get(AnalF.RespImpul,'Value')
        if filtroAplico.Octavas.Hab == 1
            RI.timeData = filter(Hd(get(AnalF.pmFrec,'Value')),RI.timeData);
        end
        if filtroAplico.FPB.hab == 1
            RI.timeData = filter(filtroAplico.FPB.filter,RI.timeData);   
        end
        if filtroAplico.FPA.hab == 1
            RI.timeData = filter(filtroAplico.FPA.filter,RI.timeData); 
        end
        j=j+1;
        y = 0.942 - (0.922*j/SumVec) + 0.07;
        pos = [x y width height];
        subplot('Position', pos);

        plot(RI.timeVector, RI.timeData)
        legend('Respuesta impulsiva');
        ylabel('Amplitud','FontSize',9);
        xlabel('Tiempo [s]','FontSize',9);
        fAxesAnal
    end

    if get(AnalF.ETC,'Value')
        j=j+1;
        y = 0.942 - (0.922*j/SumVec) + 0.07;
        pos = [x y width height];
        subplot('Position', pos);

        plot(ETC.timeVector,ETC.timeData)
        legend('Curva de energia tiempo');
        ylabel('Magnitud','FontSize',9);
        xlabel('Tiempo [s]','FontSize',9);
        fAxesAnal
    end

    if get(AnalF.ETCI,'Value')
        j=j+1;
        y = 0.942 - (0.922*j/SumVec) + 0.07;
        pos = [x y width height];
        subplot('Position', pos);

        plot(ETCI.timeVector, ETCI.timeData)
        legend('Curva de energia tiempo integrada');
        ylabel('Magnitud','FontSize',9);
        xlabel('Tiempo [s]','FontSize',9);
        fAxesAnal
    end
end
function fCambiarOctava(h,e)
    
    if get(AnalF.pmModo,'Value') == 1 
        set(AnalF.pmFrec,'String',AnalF.Config.Filtros.Octava.Str );
    else
        set(AnalF.pmFrec,'String',AnalF.Config.Filtros.TerOct.Str );
    end
    fActualizarSeniales
end
                     
function fImportSeniales(h,e)
    samriImportSenialesGUI(Modelo);   
    fActualizarSeniales % no actualiza, hay que saber porcua
end

function fAxesAnal()
    ax = gca;
    axtoolbar(ax,{'export','pan','zoomin','zoomout','restoreview'});        
   
    if get(AnalF.cbXGrid,'Value'), ax.XGrid = 'on'; else, ax.XGrid = 'off'; end
    if get(AnalF.cbYGrid,'Value'), ax.YGrid = 'on'; else, ax.YGrid = 'off'; end 
end

function fExportSeniales(h,e)
    fActualizarSeniales
    [Nombre, Directorio] = uiputfile('*.wav;*.mp3','Guardar archivos de audio');

    if get(AnalF.SenialExi,'Value')
        NombreSE = ['Señal de exitacion - ',Nombre];
        audiowrite([Directorio, NombreSE],SE.timeData,SE.samplingRate)% guardo señal de exitacion filename, y, fs
    end
  
    if get(AnalF.RespueExi,'Value')
        NombreRE = ['Respuesta a la exitacion - ',Nombre];
        audiowrite([Directorio, NombreRE],RE.timeData,RE.samplingRate)% guardo respuesta a la exitacion filename, y, fs
    end
    
    if get(AnalF.RespImpul,'Value')
        NombreRI = ['Respuesta a impulsiva - ',Nombre];
        RespImpuls = RI.timeData/max(abs(RI.timeData));
        audiowrite([Directorio, NombreRI],RespImpuls,RI.samplingRate)% guardo respuesta impulsiva
    end
   
end

end