function samriHHTVentanaAnalisisGUI(Modelo, ~)

% Crea una figura nueva

AnalF.hFig = figure( 'Name','Ventana ETF Transformada Hilbert - Huang ',...
                    'NumberTitle','off',...
                    'Visible','on',...
                    'Color','w',...
                    'Position',[100,50,1500,900],...
                    'Toolbar','none',...
                    'Menu', 'none');

%% Agrego los uimenu FILE
IndImfSE = 0;
IndImfRE = 0;
IndImfRI = 0;
axSE = axes;
axRE = axes;
axRI = axes;

SeEx = Modelo.getSenialExcitacion;
ReEx = Modelo.getRespuestaExcitacion;
ReIm = Modelo.getRespuestaImpulsiva;
[imfSE, resudualSE, ~] = emd(SeEx.timeData,'Interpolation','pchip');
[imfRE, resudualRE, ~] = emd(ReEx.timeData,'Interpolation','pchip');
[imfRI, resudualRI, ~] = emd(ReIm.timeData,'Interpolation','pchip');
DataSE = [imfSE';resudualSE'];
DataRE = [imfRE';resudualRE'];
DataRI = [imfRI';resudualRI'];


AnalF.menu(1) = uimenu(AnalF.hFig,'Label','Archivo');                                                       %CREO EL MENU

AnalF.subMenuArchivo(1) = uimenu(AnalF.menu(1),'Label','Abrir','Accelerator','O');                          %CREO LOS SUBMENU
AnalF.subMenuArchivo(2) = uimenu(AnalF.menu(1),'Label','Guardar','Accelerator','S');                        %
AnalF.subMenuArchivo(3) = uimenu(AnalF.menu(1),'Label','Guardar como...');                                  %
AnalF.subMenuArchivo(4) = uimenu(AnalF.menu(1),'Label','Cerrar');  

% establezco los tabs

AnalF.hTabGroup = uitabgroup(AnalF.hFig); 
AnalF.tab(1) = uitab(AnalF.hTabGroup, 'title','Transformada Hilbert-Huang','BackgroundColor','w');
AnalF.tab(2) = uitab(AnalF.hTabGroup, 'title','IMF Señal Exitacion'    ,'BackgroundColor','w');
AnalF.tab(3) = uitab(AnalF.hTabGroup, 'title','IMF Respuesta a Exitacion' ,'BackgroundColor','w');
AnalF.tab(4) = uitab(AnalF.hTabGroup, 'title','IMF Respuesta Impulsiva'   ,'BackgroundColor','w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE SEÑALES HHT %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AnalF.panel(1)  = uipanel(  'Parent', AnalF.tab(1), 'Title','Señales', 'FontSize',12,...                  %entradas salidas
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
                               
%% Importar - Exportar señales
                            
AnalF.btImport = uicontrol( AnalF.tab(1), 'Style','pushbutton', 'Units','normalized','Position', [.82 .04 .08 .05],...
                            'String', 'Importar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fImportSeniales);

AnalF.btExport = uicontrol( AnalF.tab(1), 'Style','pushbutton', 'Units','normalized','Position', [.91 .04 .08 .05],...
                            'String', 'Exportar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fExportSeniales);
                        
AnalF.cbXGrid = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [10 20 100 25],...
                                'String','X Grid', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);
   
AnalF.cbYGrid = uicontrol(AnalF.panel(1),'Style','checkbox', 'Position', [120 20 100 25],...
                                'String','Y Grid', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Value', 1,'Callback',@(h,e)fActualizarSeniales);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE SEÑALES IMF SEÑAL EXITACION %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol( AnalF.tab(2), 'Style','text', 'Units', 'normalized', 'Position', [.34 .938 .35 .05],...
                        'String','Funciones de Modo Intrinceco', 'FontSize', 25,'BackgroundColor','w','FontWeight','bold');

AnalF.IMFSE.txPage = uicontrol( AnalF.tab(2), 'Style','text', 'Units', 'normalized', 'Position', [.8 .91 .05 .05],...
                        'String','1 / 3', 'FontSize', 15,'BackgroundColor','w','FontWeight','bold');

AnalF.IMFSE.btNext = uicontrol( AnalF.tab(2), 'Style','pushbutton', 'Units','normalized','Position', [.94 .92 .05 .05],...
                            'String', '>', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fNextSE);

AnalF.IMFSE.btBack = uicontrol( AnalF.tab(2), 'Style','pushbutton', 'Units','normalized','Position', [.88 .92 .05 .05],...
                            'String', '<', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fBackSE, 'Enable', 'off');
                            
AnalF.IMFSE.btImport = uicontrol( AnalF.tab(2), 'Style','pushbutton', 'Units','normalized','Position', [.82 .04 .08 .05],...
                            'String', 'Importar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fImportSeniales);

AnalF.IMFSE.btExport = uicontrol( AnalF.tab(2), 'Style','pushbutton', 'Units','normalized','Position', [.91 .04 .08 .05],...
                            'String', 'Exportar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fExportSeniales);
                        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE SEÑALES IMF Respuesta EXITACION %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol( AnalF.tab(3), 'Style','text', 'Units', 'normalized', 'Position', [.34 .938 .35 .05],...
                        'String','Funciones de Modo Intrinceco', 'FontSize', 25,'BackgroundColor','w','FontWeight','bold');

AnalF.IMFRE.txPage = uicontrol( AnalF.tab(3), 'Style','text', 'Units', 'normalized', 'Position', [.8 .91 .05 .05],...
                        'String','1 / 3', 'FontSize', 15,'BackgroundColor','w','FontWeight','bold');
 
AnalF.IMFRE.btNext = uicontrol( AnalF.tab(3), 'Style','pushbutton', 'Units','normalized','Position', [.94 .92 .05 .05],...
                            'String', '>', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fNextRE);

AnalF.IMFRE.btBack = uicontrol( AnalF.tab(3), 'Style','pushbutton', 'Units','normalized','Position', [.88 .92 .05 .05],...
                            'String', '<', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fBackRE, 'Enable', 'off');
                        
AnalF.IMFRE.btImport = uicontrol( AnalF.tab(3), 'Style','pushbutton', 'Units','normalized','Position', [.82 .04 .08 .05],...
                            'String', 'Importar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fImportSeniales);

AnalF.IMFRE.btExport = uicontrol( AnalF.tab(3), 'Style','pushbutton', 'Units','normalized','Position', [.91 .04 .08 .05],...
                            'String', 'Exportar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fExportSeniales);
                        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE SEÑALES IMF Respuesta impulsiva %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol( AnalF.tab(4), 'Style','text', 'Units', 'normalized', 'Position', [.34 .938 .35 .05],...
                        'String','Funciones de Modo Intrinceco', 'FontSize', 25,'BackgroundColor','w','FontWeight','bold');

AnalF.IMFRI.txPage = uicontrol( AnalF.tab(4), 'Style','text', 'Units', 'normalized', 'Position', [.8 .91 .05 .05],...
                        'String','1 / 3', 'FontSize', 15,'BackgroundColor','w','FontWeight','bold');

AnalF.IMFRI.btNext = uicontrol( AnalF.tab(4), 'Style','pushbutton', 'Units','normalized','Position', [.94 .92 .05 .05],...
                            'String', '>', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fNextRI);

AnalF.IMFRI.btBack = uicontrol( AnalF.tab(4), 'Style','pushbutton', 'Units','normalized','Position', [.88 .92 .05 .05],...
                            'String', '<', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fBackRI, 'Enable', 'off');
                        
AnalF.IMFRI.btImport = uicontrol( AnalF.tab(4), 'Style','pushbutton', 'Units','normalized','Position', [.82 .04 .08 .05],...
                            'String', 'Importar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fImportSeniales);

AnalF.IMFRI.btExport = uicontrol( AnalF.tab(4), 'Style','pushbutton', 'Units','normalized','Position', [.91 .04 .08 .05],...
                            'String', 'Exportar', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                            'Callback',@(h,e)fExportSeniales);                        
  %% Ploteo las señales en el grafico en comun  
  
fActualizarSeniales                          
fActualizarSenialesIMF


function fActualizarSeniales(~,~) 
cla reset;
j=0;
SumVec =    get(AnalF.SenialExi,'Value') + get(AnalF.RespueExi,'Value') + ...
            get(AnalF.RespImpuls,'Value');
        
SeEx = Modelo.getHilbExcitacion;
ReEx = Modelo.getHilbRespExitac;
ReIm = Modelo.getHilbRespImpulsiva;

x = 0.04;
width = 0.79;

switch SumVec
    case 1
         height = 0.85;
    case 2
         height = 0.35;
    case 3
         height = 0.2;
end
%% ----------------------------------------------------------------------------------     
if get(AnalF.SenialExi, 'Value')
    j = j + 1;
    y = 0.952 - (0.932 * j / SumVec) + 0.06;
    pos = [x y width height];
    ax1 = subplot('Position', pos);
    ax1.Parent = AnalF.tab(1);
    cla(ax1)
%     hht(ax1, SeEx.imf,44100);
    hht(SeEx.imf,44100);
    xlabel('Tiempo [ s ]');
    ylabel('Frecuencia [ Hz ]');
    title('HHT Exitacion');
    fAxesAnal
end
%% --------------------------------------------------------------------------------------
if get(AnalF.RespueExi, 'Value')
    j=j+1;
    y = 0.952 - (0.932 * j / SumVec) + 0.06;
    pos = [x y width height];    
    ax2 = subplot('Position', pos);
    ax2.Parent = AnalF.tab(1);
    cla(ax2)
    hht(ReEx.imf,44100);
    xlabel('Tiempo [ s ]');
    ylabel('Frecuencia [ Hz ]');
    title('HHT Respuesta');
    fAxesAnal
end
%% --------------------------------------------------------------------------------------
if get(AnalF.RespImpuls, 'Value') 
    j=j+1;
    y = 0.952 - (0.932 * j / SumVec) + 0.06;
    pos = [x y width height];
    ax3 = subplot('Position', pos);
    ax3.Parent = AnalF.tab(1);
    cla(ax3)
    hht(ReIm.imf,44100);
    xlabel('Tiempo [ s ]');
    ylabel('Frecuencia [ Hz ]');
    title('HHT Respuesta Impulsiva');
    fAxesAnal
end
   
    
end

function fAxesAnal()
    ax = gca;
    axtoolbar(ax,{'export','pan','zoomin','zoomout','restoreview'});        
   
    if get(AnalF.cbXGrid,'Value'), ax.XGrid = 'on'; else, ax.XGrid = 'off'; end
    if get(AnalF.cbYGrid,'Value'), ax.YGrid = 'on'; else, ax.YGrid = 'off'; end 
end

function fActualizarSenialesIMF(~,~)
SeEx = Modelo.getSenialExcitacion;
ReEx = Modelo.getRespuestaExcitacion;
ReIm = Modelo.getRespuestaImpulsiva;

delete(axSE);
delete(axRE);
delete(axRI);

x = 0.04;
width = 0.95;
height = 0.1;
Titulo = {'IMF 1';'IMF 2';'IMF 3';'IMF 4';'IMF 5';'IMF 6';'IMF 7';'IMF 8';'IMF 9';'IMF 10';'IMF 11';'IMF 12';'IMF 13';'IMF 14';};

[filSE, ~ ] = size(DataSE); 
[filRE, ~ ] = size(DataRE);
[filRI, ~ ] = size(DataRI);
%% ----------------------------------------------------------------------------------
if 5 > (filSE - 5 * IndImfSE)
    set(AnalF.IMFSE.btNext,'Enable','off');
    for i = 1 + (5 * IndImfSE):filSE
        y = 0.8 - (0.8 * (i - (5 * IndImfSE))/5)+ 0.15;
        axSE(i) = axes(AnalF.tab(2),'Position',[x y width height]);
        cla reset
        plot(SeEx.timeVector, DataSE(i, :));
        xlabel('Tiempo [ s ]');
        ylabel('Amplitud');
        if (i == filSE)
            title('Residuo');
        else
            title(Titulo{i});
        end
    end
else
    set(AnalF.IMFSE.btNext,'Enable','on');
    for i = 1 + (5 * IndImfSE):(5 + 5 * IndImfSE)
        y = 0.8 - (0.8 * (i - (5 * IndImfSE)) / 5 ) + 0.15;
        axSE(i) = axes(AnalF.tab(2),'Position',[x y width height]);
        cla reset
        plot(SeEx.timeVector, DataSE(i, :));
        xlabel('Tiempo [ s ]');
        ylabel('Amplitud');
        title(Titulo{i});
    end
end
%% --------------------------------------------------------------------------------------
if 5 > (filRE - 5 * IndImfRE)
    set(AnalF.IMFRE.btNext,'Enable','off');
    for i = 1 + (5 * IndImfRE):filRE
        y = 0.8 - (0.8 * (i - (5 * IndImfRE))/5)+ 0.15;
        axRE(i) = axes(AnalF.tab(3),'Position',[x y width height]);
        cla reset
        plot(ReEx.timeVector, DataRE(i, :));
        xlabel('Tiempo [ s ]');
        ylabel('Amplitud');
        if (i == filRE)
            title('Residuo');
        else
            title(Titulo{i});
        end
    end
else
    set(AnalF.IMFRE.btNext,'Enable','on');
    for i = 1 + (5 * IndImfRE):(5 + 5 * IndImfRE)
        y = 0.8 - (0.8 * (i - (5 * IndImfRE)) / 5 ) + 0.15;
        axRE(i) = axes(AnalF.tab(3),'Position',[x y width height]);
        cla reset
        plot(ReEx.timeVector, DataRE(i, :));
        xlabel('Tiempo [ s ]');
        ylabel('Amplitud');
        title(Titulo{i});
    end
end
%% --------------------------------------------------------------------------------------
if 5 > (filRI - 5 * IndImfRI)
    set(AnalF.IMFRI.btNext,'Enable','off');
    for i = 1 + (5 * IndImfRI):filRI
        y = 0.8 - (0.8 * (i - (5 * IndImfRI))/5)+ 0.15;
        axRI(i) = axes(AnalF.tab(4),'Position',[x y width height]);
        cla reset
        plot(ReIm.timeVector, DataRI(i, :));
        xlabel('Tiempo [ s ]');
        ylabel('Amplitud');
        if (i == filRI)
            title('Residuo');
        else
            title(Titulo{i});
        end
    end
else
    set(AnalF.IMFRI.btNext,'Enable','on');
    for i = 1 + (5 * IndImfRI):(5 + 5 * IndImfRI)
        y = 0.8 - (0.8 * (i - (5 * IndImfRI)) / 5 ) + 0.15;
        axRI(i) = axes(AnalF.tab(4),'Position',[x y width height]);
        cla reset
        plot(ReIm.timeVector, DataRI(i, :));
        xlabel('Tiempo [ s ]');
        ylabel('Amplitud');
        title(Titulo{i});
    end
end
    
end

function fNextSE(~,~)
    IndImfSE = IndImfSE + 1;
    set(AnalF.IMFSE.btBack,'Enable','on');
    set(AnalF.IMFSE.txPage,'String',[num2str(IndImfSE + 1),' / 3' ])
    fActualizarSenialesIMF
end
function fBackSE(~,~)
    IndImfSE = IndImfSE - 1;
    set(AnalF.IMFSE.txPage,'String',[num2str(IndImfSE + 1),' / 3' ])
    if IndImfSE == 0
        set(AnalF.IMFSE.btBack,'Enable','off');
    end
    fActualizarSenialesIMF
end

function fNextRE(~,~)
    IndImfRE = IndImfRE + 1;
    set(AnalF.IMFRE.btBack,'Enable','on');
    set(AnalF.IMFRE.txPage,'String',[num2str(IndImfRE + 1),' / 3' ])
    fActualizarSenialesIMF
end
function fBackRE(~,~)
    IndImfRE = IndImfRE - 1;
    set(AnalF.IMFSE.txPage,'String',[num2str(IndImfRE + 1),' / 3' ])
    if IndImfRE ==0
        set(AnalF.IMFRE.btBack,'Enable','off');
    end
    fActualizarSenialesIMF
end

function fNextRI(~,~)
    IndImfRI = IndImfRI + 1;
    set(AnalF.IMFRI.btBack,'Enable','on');
    set(AnalF.IMFRI.txPage,'String',[num2str(IndImfRI + 1),' / 3' ])
    fActualizarSenialesIMF
end
function fBackRI(~,~)
        IndImfRI = IndImfRI - 1;
        set(AnalF.IMFSE.txPage,'String',[num2str(IndImfRI + 1),' / 3' ])
        if IndImfRI ==0
            set(AnalF.IMFRI.btBack,'Enable','off');
        end
        fActualizarSenialesIMF
    end
end

