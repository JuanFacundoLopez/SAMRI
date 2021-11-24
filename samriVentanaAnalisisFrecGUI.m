function samriVentanaAnalisisFrecGUI(Modelo, Controlador)

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

AnalF.hFig = figure( 'Name','Ventana de Analisis en frecuencia',...
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

AnalF.SenialExiM = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [60 170 25 25],...
                                'String','', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);

AnalF.RespueExiM = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [60 130 25 25],...
                                'String','', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                            
AnalF.PSDSenialM = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [60 90 25 25],...
                                'String','', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                            
AnalF.PSDRespueM = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [60 50 25 25],...
                                'String','', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);

AnalF.SenialExiF = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [10 170 25 25],...
                                'String','', 'FontSize', 15,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);

AnalF.RespueExiF = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [10 130 25 25],...
                                'String','', 'FontSize', 15,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                            
                            
uicontrol(AnalF.panel(1),'Style','text','Position', [100 170 150 20],'HorizontalAlignment','left',...
                         'String','Exitacion', 'FontSize', 10,'BackgroundColor','w')     
uicontrol(AnalF.panel(1),'Style','text','Position', [100 130 150 20],'HorizontalAlignment','left',...
                         'String','Respuesta', 'FontSize', 10,'BackgroundColor','w') 
uicontrol(AnalF.panel(1),'Style','text','Position', [100 90 150 20],'HorizontalAlignment','left',...
                         'String','PSD Exitacion', 'FontSize', 10,'BackgroundColor','w') 
uicontrol(AnalF.panel(1),'Style','text','Position', [100 50 150 20],'HorizontalAlignment','left',...
                         'String','PSD Respuesta', 'FontSize', 10,'BackgroundColor','w') 
                     
uicontrol(AnalF.panel(1),'Style','text','Position', [5 200 35 20],...
                         'String','Fase', 'FontSize', 10,'BackgroundColor','w',...
                         'FontWeight','bold') 
uicontrol(AnalF.panel(1),'Style','text','Position', [50 200 35 20],...
                         'String','Mag.', 'FontSize', 10,'BackgroundColor','w',...
                         'FontWeight','bold')    
uicontrol(AnalF.panel(1),'Style','text','Position', [100 200 50 20],...
                         'String','Datos', 'FontSize', 10,'BackgroundColor','w',...
                         'FontWeight','bold')           
                     
AnalF.cbXGrid = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [10 20 100 25],...
                                'String','X Grid', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
   
AnalF.cbYGrid = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [120 20 100 25],...
                                'String','Y Grid', 'FontSize', 10,'BackgroundColor','w',...
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

    j=0;
    SumVec =    max(get(AnalF.SenialExiM,'Value'),get(AnalF.SenialExiF,'Value')) + ...
                max(get(AnalF.RespueExiM,'Value'),get(AnalF.RespueExiF,'Value')) + ...
                get(AnalF.PSDSenialM,'Value') + get(AnalF.PSDRespueM,'Value');
%%--------------------------------------Seccion filtros--------------------------------------------------------------------

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

if get(AnalF.pmModo,'Value') == 1
    filtrosCaract.frecNorm  = AnalF.Config.Filtros.Octava.Str{get(AnalF.pmFrec,'Value')};
else
    filtrosCaract.frecNorm  = AnalF.Config.Filtros.TerOct.Str{get(AnalF.pmFrec,'Value')};
end


LP = filtrosCaract.FPB;
HP = filtrosCaract.FPA;
Orden = filtrosCaract.orden;
Fs = 48000;   
% 
if get(AnalF.chFrec, 'Value')
    filtroAplico.Octavas.Hab = 1;
else
    filtroAplico.Octavas.Hab = 0;
end

if get(AnalF.pmMeto,'Value') == 2               %% Filtro fir pasa bajos
    if get(AnalF.chFPB,'Value')
        FPB = designfilt(   'lowpassfir','PassbandFrequency',LP,...
                            'StopbandFrequency',LP*1.1,...
                            'SampleRate',Fs,'FilterOrder',Orden); 
    end

    if get(AnalF.chFPA, 'Value')                %% Filtro fir pasa alto
        FPA = designfilt(   'highpassfir','PassbandFrequency',HP,...
                            'StopbandFrequency',HP*0.9,...
                            'SampleRate',Fs,'FilterOrder',Orden);
    end
else
    if get(AnalF.chFPB, 'Value')                %% Filtro iir pasa bajos
        FPB = designfilt(   'lowpassiir','PassbandFrequency',LP,...
                            'SampleRate',Fs,'FilterOrder',Orden);
    end
% 
    if get(AnalF.chFPA, 'Value')                %% Filtro irr psa altos
        FPA = designfilt(   'highpassiir','PassbandFrequency',HP,...
                            'SampleRate',Fs,'FilterOrder',Orden); 
    end
end
   
    %   %   %   %   %   %   %   %   %   %   %   %   %    %      %    %
%%-----------------------------------Fin de seccion filtros----------------
SeEx = Modelo.getEspectroExcitacion;
ReEx = Modelo.getEspectroRespExitac;
PSDS = Modelo.getPSDExitacion;
PSDR = Modelo.getPSDRespExitac;

x = 0.04;
width = 0.75;

switch SumVec
    case 1
         height = 0.9;
    case 2
         height = 0.39;
    case 3
         height = 0.253;
    case 4
         height = 0.183;
end
%% ----------------------------------------------------------------------------------     
if get(AnalF.SenialExiM,'Value') || get(AnalF.SenialExiF,'Value')
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.07;
    pos = [x y width height];
    subplot('Position', pos);
        
    if get(AnalF.SenialExiM,'Value') && get(AnalF.SenialExiF,'Value') 
        
        cla reset
        yyaxis left
        
        semilogx(SeEx.freqVector, db(abs(real(SeEx.freqData)),'power'));
        ylabel('Amplitud','FontSize',9);
        yyaxis right
        semilogx(SeEx.freqVector, angle(SeEx.freqData));
        ylabel('Fase','FontSize',9);
        legend({'M. Exitación','F. Exitación'});
    end
    
    if get(AnalF.SenialExiM,'Value')  && ~get(AnalF.SenialExiF,'Value')          %% Magnitud de la Respuesta a exitacion 
        cla reset
        if get(AnalF.chFrec, 'Value')
           frecNorm = freqz(Hd(get(AnalF.pmFrec,'Value')),length(SeEx.freqData));
           SeEx.freqData = frecNorm.*SeEx.freqData;
        end
        if get(AnalF.chFPB, 'Value')
           filtroAplico.FPB = freqz(FPB,length(SeEx.freqData));
           SeEx.freqData = filtroAplico.FPB.*SeEx.freqData; 
        end
        if get(AnalF.chFPA,'Value')
           filtroAplico.FPA = freqz(FPA,length(SeEx.freqData));
           SeEx.freqData = filtroAplico.FPA.*SeEx.freqData; 
        end
            xlim([1 30000]);

        semilogx(SeEx.freqVector, db(abs(real(SeEx.freqData)),'power'));
        ylabel('Magnitud','FontSize',9);
        legend('M. Exitación');
    end

    if get(AnalF.SenialExiF,'Value')   && ~get(AnalF.SenialExiM,'Value')         %% Fase de la Respuesta a exitacion 
        cla reset
        semilogx(SeEx.freqVector, angle(SeEx.freqData));
        ylabel('Fase','FontSize',9);
        legend('F. Exitación');
    end
                xlim([1 30000]);

    xlabel('Frecuencia [Hz]','FontSize',9); 
    fAxesAnal
end
%% --------------------------------------------------------------------------------------
if get(AnalF.RespueExiM,'Value') || get(AnalF.RespueExiF,'Value')
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.07;
    pos = [x y width height];
    
    subplot('Position', pos);

    if get(AnalF.RespueExiM,'Value') && get(AnalF.RespueExiF,'Value') 
        cla reset
        yyaxis left
        semilogx(ReEx.freqVector, db(abs(real(ReEx.freqData)),'power'));
        ylabel('Amplitud','FontSize',9);
        yyaxis right
        semilogx(ReEx.freqVector, angle(ReEx.freqData));
        ylabel('Fase','FontSize',9);
        legend({'M. Respuesta a exitación','F. Respuesta a exitación'});
    end
    
    if get(AnalF.RespueExiM,'Value')  && ~get(AnalF.RespueExiF,'Value')          %% Magnitud de la Respuesta a exitacion 
        cla reset
        if get(AnalF.chFrec, 'Value')
           frecNorm = freqz(Hd(get(AnalF.pmFrec,'Value')),length(ReEx.freqData));
           ReEx.freqData = frecNorm.*ReEx.freqData;
        end
        if get(AnalF.chFPB, 'Value')
           filtroAplico.FPB = freqz(FPB,length(ReEx.freqData));
           ReEx.freqData = filtroAplico.FPB.*ReEx.freqData; 
        end
        if get(AnalF.chFPA,'Value')
           filtroAplico.FPA = freqz(FPA,length(ReEx.freqData));
           ReEx.freqData = filtroAplico.FPA.*ReEx.freqData; 
        end

        semilogx(ReEx.freqVector, db(abs(real(ReEx.freqData)),'power'));
        ylabel('Magnitud','FontSize',9);
        legend('M. Respuesta a exitación');
    end

    if get(AnalF.RespueExiF,'Value')   && ~get(AnalF.RespueExiM,'Value')         %% Fase de la Respuesta a exitacion 
        cla reset
        semilogx(ReEx.freqVector, angle(ReEx.freqData));
        ylabel('Fase','FontSize',9);
        legend('F. Respuesta a exitación');
    end
                xlim([1 30000]);

    xlabel('Frecuencia [Hz]','FontSize',9); 
    fAxesAnal
end
%% --------------------------------------------------------------------------------------
if get(AnalF.PSDSenialM,'Value') 
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.07;
    pos = [x y width height];
    subplot('Position', pos);
    cla reset
    if get(AnalF.chFrec, 'Value')
       frecNorm = freqz(Hd(get(AnalF.pmFrec,'Value')),length(PSDS.freqData));
       PSDS.freqData = frecNorm.*PSDS.freqData;
    end
    if get(AnalF.chFPB, 'Value')
       filtroAplico.FPB = freqz(FPB,length(PSDS.freqData));
       PSDS.freqData = filtroAplico.FPB.*PSDS.freqData; 
    end
    if get(AnalF.chFPA,'Value')
       filtroAplico.FPA = freqz(FPA,length(PSDS.freqData));
       PSDS.freqData = filtroAplico.FPA.*PSDS.freqData; 
    end
    semilogx(PSDS.freqVector, db(abs(real(PSDS.freqData)),'power'));
    xlim([1 30000]);
    ylabel('Amplitud','FontSize',9);
    legend('M. Respuesta a exitación');
    xlabel('Frecuencia [Hz]','FontSize',9); 
    fAxesAnal 
end
%% --------------------------------------------------------------------------------------
if get(AnalF.PSDRespueM,'Value') 
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.07;
    pos = [x y width height];
    subplot('Position', pos);
    cla reset
    if get(AnalF.chFrec, 'Value')
       frecNorm = freqz(Hd(get(AnalF.pmFrec,'Value')),length(PSDR.freqData));
       PSDR.freqData = frecNorm.*PSDR.freqData;
    end
    if get(AnalF.chFPB, 'Value')
       filtroAplico.FPB = freqz(FPB,length(PSDR.freqData));
       PSDR.freqData = filtroAplico.FPB.*PSDR.freqData; 
    end
    if get(AnalF.chFPA,'Value')
       filtroAplico.FPA = freqz(FPA,length(PSDR.freqData)); 
       PSDR.freqData = filtroAplico.FPA.*PSDR.freqData; 
    end
    
    semilogx(PSDR.freqVector, db(abs(real(PSDR.freqData)),'power'));
    xlim([1 30000]);
    ylabel('Magnitud','FontSize',9);
    legend('M. Respuesta a exitación');
    xlabel('Frecuencia [Hz]','FontSize',9);
    fAxesAnal
end


end

function fAxesAnal()
    ax = gca;
    axtoolbar(ax,{'export','pan','zoomin','zoomout','restoreview'});        
   
    if get(AnalF.cbXGrid,'Value'), ax.XGrid = 'on'; else, ax.XGrid = 'off'; end
    if get(AnalF.cbYGrid,'Value'), ax.YGrid = 'on'; else, ax.YGrid = 'off'; end 
end

function fCambiarOctava(h,e)
    
    if get(AnalF.pmModo,'Value') == 1
        set(AnalF.pmFrec,'String',AnalF.Config.Filtros.Octava.Str );
    else
        set(AnalF.pmFrec,'String',AnalF.Config.Filtros.TerOct.Str );
    end
%     fActualizarSeniales
end
                     
end