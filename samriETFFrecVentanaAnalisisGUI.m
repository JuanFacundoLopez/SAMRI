function samriETFFrecVentanaAnalisisGUI(Modelo, Controlador)

AnalF.Const.TamVent               = {'- Tamaño FFT -';'256';'512';'1024';'2048';'4096';'8192';'16384';'32768';'65536';};
AnalF.Const.Ventana               = {'- Tipo de ventana -';'Rectangular';'Hanning';'Hamming';'Blackman';'Blackman-Harris';};
AnalF.Const.FrecMax               = {'31.5','63','125','250','500','1000','2000','4000','8000','16000','Frecuencia Maxima'};
AnalF.Const.FrecMin               = {'Frecuencia Minima','31.5','63','125','250','500','1000','2000','4000','8000','16000'};

% Crea una figura nueva

AnalF.hFig = figure( 'Name','Ventana de Analisis ETF - Fourier',...
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
                            'BackgroundColor','w','Position',[.85 .71 .142 .29]);        

AnalF.SenialExi = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [15 170 150 25],...
                                'String','Exitacion', 'FontSize', 12,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);

AnalF.RespueExi = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [15 130 150 25],...
                                'String','Respuesta', 'FontSize', 12,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                            
AnalF.RespImpuls = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [15 90 200 25],...
                                'String','Respuesta Impulsiva', 'FontSize', 12,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                                  
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE Caracteristicas %%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                    % Defino el PANEL
AnalF.panel(2) = uipanel('Parent', AnalF.hFig,'Title','Caracteristicas', 'FontSize',12,...%Info secundaria
                               'BackgroundColor','w','Position',[.85 .18 .142 .52]);    

%                             
AnalF.Espectro.pmTamaVen  = uicontrol(AnalF.panel(2),'Style','popupmenu', 'Position', [10 400 170 25],...
                                'String',AnalF.Const.TamVent, 'FontSize', 10,'BackgroundColor','w',...
                                'Value', 2,'Callback',@(h,e)fActualizarSeniales);
                            
AnalF.Espectro.pmVentana  = uicontrol(AnalF.panel(2),'Style','popupmenu', 'Position', [10 360 170 25],...
                                'String',AnalF.Const.Ventana, 'FontSize', 11,'BackgroundColor','w',...
                                'Value', 2,'Callback',@(h,e)fActualizarSeniales);   
                            
uicontrol(AnalF.panel(2),'Style','text', 'Position', [10 320 60 25],...
                        'String','Div.  :', 'FontSize', 11,'BackgroundColor','w','FontWeight','bold');
                    
uicontrol(AnalF.panel(2),'Style','text', 'Position', [10 280 60 25],...
                        'String','Ovlp. :', 'FontSize', 11,'BackgroundColor','w','FontWeight','bold');
                    
AnalF.Espectro.edDivisiones = uicontrol(AnalF.panel(2),'Style','edit', 'Position', [70 320 110 25],...
                                'FontSize', 11,'BackgroundColor','w','String', '100','Callback',@(h,e)fActualizarSeniales);    
                                                
AnalF.Espectro.edOverlaping = uicontrol(AnalF.panel(2),'Style','edit', 'Position', [70 280 110 25],...
                                'FontSize', 11,'BackgroundColor','w','String', '50','Callback',@(h,e)fActualizarSeniales);   

AnalF.Espectro.pmFrecMin  = uicontrol(AnalF.panel(2),'Style','popupmenu', 'Position', [10 240 170 25],...
                                'String',AnalF.Const.FrecMin, 'FontSize', 11,'BackgroundColor','w',...
                                'Value', 1,'Callback',@(h,e)fActualizarSeniales);
                            
AnalF.Espectro.pmFrecMax  = uicontrol(AnalF.panel(2),'Style','popupmenu', 'Position', [10 200 170 25],...
                                'String',AnalF.Const.FrecMax, 'FontSize', 11,'BackgroundColor','w',...
                                'Value', 11,'Callback',@(h,e)fActualizarSeniales);  




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

SumVec =    get(AnalF.SenialExi,'Value') + get(AnalF.RespueExi,'Value') + get(AnalF.RespImpuls,'Value');

SeEx = Modelo.getSenialExcitacion;
ReEx = Modelo.getRespuestaExcitacion;
ReIm = Modelo.getRespuestaImpulsiva;

AnalF.EspecParam.TamanioVentana = str2double(AnalF.Const.TamVent{get(AnalF.Espectro.pmTamaVen,'Value')}); 
AnalF.EspecParam.Ventana        = get(AnalF.Espectro.pmVentana ,'Value');
AnalF.EspecParam.Divisiones     = str2double(get(AnalF.Espectro.edDivisiones,'String'));
AnalF.EspecParam.FrecMax        = AnalF.Const.FrecMax{get(AnalF.Espectro.pmFrecMax,'Value')-1};
AnalF.EspecParam.FrecMin        = AnalF.Const.FrecMin{get(AnalF.Espectro.pmFrecMin,'Value')+1};
AnalF.EspecParam.Overlaping     = str2double(get(AnalF.Espectro.edOverlaping,'String'))/100;

switch AnalF.EspecParam.Ventana 
    case 1
        AnalF.EspecParam.Vent = rectwin(AnalF.EspecParam.Divisiones);      %ventana rectangular
    case 2
        AnalF.EspecParam.Vent = hann(AnalF.EspecParam.Divisiones);         % ventana hann
    case 3
        AnalF.EspecParam.Vent = hamming(AnalF.EspecParam.Divisiones);      % ventana hamming
    case 4
        AnalF.EspecParam.Vent = blackman(AnalF.EspecParam.Divisiones);     % ventana blackman
    case 5
        AnalF.EspecParam.Vent = blackmanharris(AnalF.EspecParam.Divisiones);% blackman harris
end

AnalF.EspecParam.Ovlp  = AnalF.EspecParam.Divisiones * AnalF.EspecParam.Overlaping ;
        
x = 0.04;
width = 0.78;

switch SumVec
    case 1
         height = 0.9;
    case 2
         height = 0.39;
    case 3
         height = 0.243;
end
    
j=0;    
%% ----------------------------------------------------------------------------------     
if get(AnalF.SenialExi,'Value') 
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.05;
    pos = [x y width height];
    subplot('Position', pos);
    cla reset
    spectrogram(SeEx.timeData, AnalF.EspecParam.Vent, AnalF.EspecParam.Ovlp, AnalF.EspecParam.TamanioVentana,SeEx.samplingRate,'yaxis')% señal,ventana,divisiones,nfft,fs
    ylabel('Frecuencia [ Hz ]','FontSize',9);
    title('Exitación');
    xlabel('Tiempo [ s ]','FontSize',9); 
    fAxesAnal
end
%% --------------------------------------------------------------------------------------
if get(AnalF.RespueExi,'Value')
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.05;
    pos = [x y width height];   
    subplot('Position', pos);
    cla reset
    spectrogram(ReEx.timeData, AnalF.EspecParam.Vent, AnalF.EspecParam.Ovlp, AnalF.EspecParam.TamanioVentana,ReEx.samplingRate,'yaxis')% señal,ventana,divisiones,nfft,fs
    ylabel('Frecuencia [ Hz ]','FontSize',9);
    title('Respuesta a exitación');
    xlabel('Tiempo [ s ]','FontSize',9); 
    fAxesAnal
end
%% --------------------------------------------------------------------------------------
if get(AnalF.RespImpuls,'Value') 
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.05;
    pos = [x y width height];
    subplot('Position', pos);
    cla reset
    spectrogram(ReIm.timeData, AnalF.EspecParam.Vent, AnalF.EspecParam.Ovlp, AnalF.EspecParam.TamanioVentana,ReIm.samplingRate,'yaxis')% señal,ventana,divisiones,nfft,fs
    ylabel('Frecuencia [ Hz ]','FontSize',9);
    title('Respuesta Impulsiva');
    xlabel('Tiempo [ s ]','FontSize',9); 
    fAxesAnal 
end


end

function fAxesAnal()
    ax = gca;
    axtoolbar(ax,{'export','pan','zoomin','zoomout','restoreview'});           
end

                     
end