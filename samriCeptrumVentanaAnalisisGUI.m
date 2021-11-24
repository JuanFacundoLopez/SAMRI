function samriCeptrumVentanaAnalisisGUI(Modelo, Controlador)
%% Crea una figura nueva

AnalF.hFig = figure( 'Name','Ventana de Analisis Cepstral',...
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
                            'BackgroundColor','w','Position',[.85 .71 .144 .25]);        

AnalF.SenialExi = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [10 170 150 25],...
                                'String','Exitacion', 'FontSize', 12,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);

AnalF.RespueExi = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [10 130 150 25],...
                                'String','Respuesta', 'FontSize', 12,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                            
AnalF.RespImpuls = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [10 90 200 25],...
                                'String','Respuesta Impulsiva', 'FontSize', 12,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);

AnalF.cbXGrid = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [10 20 85 25],...
                                'String','X Grid', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
   
AnalF.cbYGrid = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [100 20 100 25],...
                                'String','Y Grid', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
                               
%% Importar - Exportar señales
                            
AnalF.btImport = uicontrol( 'Style','pushbutton', 'Units','normalized','Position', [.82 .04 .08 .05],...
                            'String', 'Importar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fImportSeniales);

AnalF.btExport = uicontrol( 'Style','pushbutton', 'Units','normalized','Position', [.91 .04 .08 .05],...
                            'String', 'Exportar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fExportSeniales);
                        
  %% Ploteo las señales en el grafico en comun                          
fActualizarSeniales                          


function fActualizarSeniales(h,e) 

    j=0;
    SumVec =    get(AnalF.SenialExi,'Value') + get(AnalF.RespueExi,'Value') + ...
                get(AnalF.RespImpuls,'Value');

SeEx = Modelo.getCeptExcitacion;
ReEx = Modelo.getCeptRespExitac;
ReIm = Modelo.getCeptRespImpulsiva;

    x = 0.04;
    width = 0.79;
    
    switch SumVec
        case 1
             height = 0.9;
        case 2
             height = 0.39;
        case 3
             height = 0.243;
    end
%% ----------------------------------------------------------------------------------     
if get(AnalF.SenialExi,'Value')
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.07;
    pos = [x y width height];
    subplot('Position', pos);
    cla reset
    plot(SeEx.timeVector, SeEx.timeData);
    ylabel('Amplitud','FontSize',9);
    legend('Exitación');
    xlabel('Quefrency','FontSize',9); 
    fAxesAnal
end
%% --------------------------------------------------------------------------------------
if get(AnalF.RespueExi,'Value')
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.07;
    pos = [x y width height];    
    subplot('Position', pos);
    cla reset
    plot(ReEx.timeVector, ReEx.timeData);
    ylabel('Amplitud','FontSize',9);
    legend('Respuesta a exitación');  
    xlabel('Quefrency','FontSize',9); 
    fAxesAnal
end
%% --------------------------------------------------------------------------------------
if get(AnalF.RespImpuls,'Value') 
    j=j+1;
    y = 0.942 - (0.922*j/SumVec) + 0.07;
    pos = [x y width height];
    subplot('Position', pos);
    cla reset
    plot(ReIm.timeVector, ReIm.timeData);
    ylabel('Amplitud','FontSize',9);
    legend('Respuesta Impulsiva');
    xlabel('Quefrency','FontSize',9); 
    fAxesAnal 
end


end

function fAxesAnal()
    ax = gca;
    axtoolbar(ax,{'export','pan','zoomin','zoomout','restoreview'});        
   
    if get(AnalF.cbXGrid,'Value'), ax.XGrid = 'on'; else, ax.XGrid = 'off'; end
    if get(AnalF.cbYGrid,'Value'), ax.YGrid = 'on'; else, ax.YGrid = 'off'; end 
end


                     
end