function CONF = samriConfiguracionGUI(Modelo,GUI)
% Constantes
clc
CONF = [];

z = peaks(25);
CONF.BGC.Claro  = [1,1,1];          % Color de fondo del objeto claro
CONF.BGC.Oscuro = [9,7,37]./255;    % Color de fondo del objeto oscuro
CONF.FGC.Claro  = [0,0,0];          % Color de la letra del objeto claro
CONF.FGC.Oscuro = [1,1,1];          % Color de la letra del objeto oscuro

mCONF = Modelo.getConfiguracion;
if ~isempty(mCONF)
   if mCONF.claro
       TemaC = 1;
   else
       TemaC = 0;
   end
   if mCONF.oscuro 
       TemaO = 1;
   else
       TemaO = 0;
   end
end



CONF.hFig = findall(0, '-depth',1, 'type','figure', 'Name','samri Configuracion');
if isempty(CONF.hFig)
    CONF.hFig = figure( 'Name','samri Configuracion', 'NumberTitle','off', 'Visible','off',...
                        'Color','w','Units','normalized', 'Position',[0.25,0.3,0.5,0.5],...
                        'Toolbar','none', 'Menu', 'none');
else
    clf(CONF.hFig);
    hc=findall(gcf); 
    delete(hc(2:end)); 
end

set(CONF.hFig,'Visible','on');

CONF.hTabGroup = uitabgroup(CONF.hFig); 
CONF.tab(1) = uitab(CONF.hTabGroup, 'title','Interface','BackgroundColor','w');
CONF.tab(2) = uitab(CONF.hTabGroup, 'title','Audio','BackgroundColor','w');
CONF.tab(3) = uitab(CONF.hTabGroup, 'title','Graficos','BackgroundColor','w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------PANEL DE Interface-------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CONF.panel(1) = uibuttongroup('Parent',CONF.tab(1),'Title','Idioma','FontSize',12,...                   %entradas salidas
                               'BackgroundColor','w','Position',[.03 .57 .95 .4]);        
                           
CONF.panel(2) = uibuttongroup('Parent',CONF.tab(1),'Title','Tema','FontSize',12,...                     %Info secundaria 
                               'BackgroundColor','w','Position',[.03 .15 .95 .4]);    

CONF.config.btSave   =  uicontrol(CONF.tab(1),'Style','pushbutton','Units','normalized',...
                        'Position', [0.75 0.02 0.1 0.08],...
                        'String','Aplicar', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold','Callback',@(h,e)fbtSave);
                    
CONF.config.btCancel =  uicontrol(CONF.tab(1),'Style','pushbutton','Units','normalized',...
                        'Position', [0.88 0.02 0.1 0.08],...
                        'String','Cancelar', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold','Callback',@(h,e)fbtCancel);
 
CONF.rbEsp = uicontrol(CONF.panel(1),'Style','radiobutton','Units','normalized', 'Position', [0.2 0.5 0.2 0.1],...
                            'String','Castellano',...
                            'FontSize', 12,'BackgroundColor','w','Value', 1);  
        
CONF.rbEng = uicontrol(CONF.panel(1),'Style','radiobutton','Units','normalized', 'Position', [0.5 0.5 80 0.1],...
                            'String','Ingles',...
                            'FontSize', 12,'BackgroundColor','w');
                    
CONF.rbPort = uicontrol(CONF.panel(1),'Style','radiobutton','Units','normalized', 'Position', [0.7 0.5 80 0.1],...
                            'String','Portugues',...
                            'FontSize', 12,'BackgroundColor','w');                   
                    
CONF.rbClaro = uicontrol(CONF.panel(2),'Style','radiobutton','Units','normalized', 'Position', [0.33 0.5 0.2 0.1],...
                            'String','Claro','FontSize', 12,'BackgroundColor','w', 'Value', TemaC,'Callback',@(h,e)frbClaro);  
        
CONF.rbOscuro = uicontrol(CONF.panel(2),'Style','radiobutton','Units','normalized', 'Position', [0.66 0.5 80 0.1],...
                            'String','Oscuro','FontSize', 12,'BackgroundColor','w', 'Value', TemaO,'Callback',@(h,e)frbOscuro);
                     
                        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------PANEL DE AUDIO-----------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %% Agrego objetos al panel 2 
CONF.audio.txCT = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.02 0.56 0.3 0.15],...
                        'String','Control TARS', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
CONF.audio.txML = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.02 0.48 0.3 0.15],...
                        'String','Modo Latencia', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold'); 
                    
CONF.audio.txSD = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.02 0.40 0.3 0.15],...
                        'String','Servidor de audio', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
        
CONF.audio.txCA = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.02 0.32 0.3 0.15],...
                        'String','Canales de audio', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                    
CONF.audio.txEA = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.02 0.24 0.3 0.15],...
                        'String','Entrada', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
        
CONF.audio.txSA = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.02 0.16 0.3 0.15],...
                        'String','Salida', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                    
CONF.audio.txRM = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.02 0.08 0.3 0.15],...
                        'String','Resolucion / Muestreo', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
 
CONF.audio.txBT = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.44 0.13 0.1 0.1],...
                        'String','[ bits ]', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                     
CONF.audio.txKH = uicontrol(CONF.tab(2),'Style','text','Units','normalized', 'Position', [0.64 0.13 0.1 0.1],...
                        'String','[ kHz ]', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                     
CONF.pmConA = uicontrol(CONF.tab(2),'Style','popupmenu','Units','normalized', 'Position', [0.35 0.56 0.4 0.15],'String','Agregar Control TARS',...
                        'FontSize', 11,'BackgroundColor','w');
                    
CONF.pmNLat = uicontrol(CONF.tab(2),'Style','popupmenu','Units','normalized', 'Position', [0.35 0.48 0.4 0.15],'String','Agregar Latencia',...
                        'FontSize', 11,'BackgroundColor','w');                                 
                    
CONF.pmSerA = uicontrol(CONF.tab(2),'Style','popupmenu','Units','normalized', 'Position', [0.35 0.4 0.4 0.15],'String','Agregar Servidor',...
                        'FontSize', 11,'BackgroundColor','w');
                    
CONF.pmNCha = uicontrol(CONF.tab(2),'Style','popupmenu','Units','normalized', 'Position', [0.35 0.32 0.4 0.15],'String',{'1 Canal';'2 Canales';},...
                        'FontSize', 11,'BackgroundColor','w');                            
       
CONF.pmEntr = uicontrol(CONF.tab(2),'Style','popupmenu','Units','normalized', 'Position', [0.35 0.24 0.4 0.15],...
                       'String', ' ', 'FontSize', 13,'BackgroundColor','w');
                   
CONF.pmSali = uicontrol(CONF.tab(2),'Style','popupmenu','Units','normalized', 'Position', [0.35 0.16 0.4 0.15],...
                       'String', ' ', 'FontSize', 13,'BackgroundColor','w');
                           
CONF.pmReso = uicontrol(CONF.tab(2),'Style','popupmenu','Units','normalized', 'Position', [0.35 0.08 0.1  0.15],...
                       'String',{'16';'24';'32'}, 'FontSize', 13,'BackgroundColor','w','HorizontalAlignment','Center');
        
CONF.pmMues = uicontrol(CONF.tab(2),'Style','popupmenu','Units','normalized', 'Position', [0.55 0.08 0.1  0.15],...
                       'String', {'44,1';'48';'88,1';'96'}, 'FontSize', 13,'BackgroundColor','w', 'HorizontalAlignment', 'Center', 'Value', 2);
                   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------PANEL DE GRAFICOS--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

CONF.Config.axSignal3D               = axes;      
CONF.Config.axSignal3D.Parent        = CONF.tab(3);
CONF.Config.axSignal3D.Position      = [0.62 0.08 0.33 0.38];

surfl(CONF.Config.axSignal3D,z)
shading interp
light               % create a light
lighting gouraud    % preferred method for lighting curved surfaces
CONF.Config.axSignal3D.Box           = 'off';
CONF.Config.axSignal3D.XLabel.String = 'Eje X';
CONF.Config.axSignal3D.YLabel.String = 'Eje Y';
CONF.Config.axSignal3D.ZLabel.String = 'Eje Z';
CONF.Config.axSignal3D.Title.String  = '3D';
% 
CONF.Graf.panel(1) = uibuttongroup('Parent',CONF.tab(3),'Title','Personalizar 3D','FontSize',12,...                  %entradas salidas
                               'BackgroundColor','w','Position',[.01 .02 .52 .49]);  
                           
CONF.Graf.txCM = uicontrol(CONF.Graf.panel(1), 'Style','text', 'Units','normalized', 'Position', [0.03 0.85 0.25 0.1],...
                        'String','Colormap', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
 
CONF.pmColMap = uicontrol(CONF.Graf.panel(1),'Style','popupmenu','Units','normalized', 'Position', [0.03 0.75 0.9 0.1],...
                        'String',{  'parula';'hsv';'hot';'cool';'spring';'summer';'autumn';'winter';'bone';...
                                    'copper';'pink';'jet';'white';'gray';},...
                        'FontSize', 12,'BackgroundColor','w','Callback',@(h,e)fpmColorMap);
                                    
CONF.Graf.txEs = uicontrol(CONF.Graf.panel(1), 'Style','text', 'Units','normalized', 'Position', [0.03 0.6 0.25 0.1],...
                        'String','Escala', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
 
CONF.pmEscala3D = uicontrol(CONF.Graf.panel(1),'Style','popupmenu','Units','normalized', 'Position', [0.03 0.5 0.9 0.1],...
                                        'String',{  'Logaritmica (dB)';'Lineal';},...
                                        'FontSize', 12,'BackgroundColor','w');                                    
%-------------------------------------------------------------------------------------------------%
CONF.Config.axSignal2D             = axes;      
CONF.Config.axSignal2D.Parent      = CONF.tab(3);
CONF.Config.axSignal2D.Position    = [0.62 0.58 0.33 0.35];

CONF.Config.axpl = plot(CONF.Config.axSignal2D,sin((1:100*6.28)./100));

CONF.Config.axSignal2D.Box           = 'off';
CONF.Config.axSignal2D.XLabel.String = 'Eje X';
CONF.Config.axSignal2D.YLabel.String = 'Eje Y';
CONF.Config.axSignal2D.Title.String  = '2D';
CONF.Config.axSignal2D.XAxisLocation = 'origin';

CONF.Graf.panel(2) = uibuttongroup( 'Parent',CONF.tab(3),'Title','Personalizar 2D','FontSize',12,...                  %entradas salidas
                                    'BackgroundColor','w','Position',[.01 .52 .52 .47]);  
                        
CONF.Graf.txCL = uicontrol(CONF.Graf.panel(2), 'Style','text', 'Units','normalized', 'Position', [0.03 0.85 0.4 0.1],...
                                    'String','Color de linea', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
 
CONF.pmColLin = uicontrol(CONF.Graf.panel(2),'Style','popupmenu','Units','normalized', 'Position', [0.03 0.75 0.9 0.1],...
                                        'String',{  'Azul';'Verde';'Rojo';'Amarillo';'Negro';'Magenta';'Blanco';},...
                                        'FontSize', 12,'BackgroundColor','w','Callback',@(h,e)fpmColLin); 
                                    
CONF.Graf.txEC = uicontrol(CONF.Graf.panel(2),  'Style','text', 'Units','normalized', 'Position', [0.03 0.55 0.2 0.1],...
                                                'String','Escala', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
 
CONF.pmEscala2D = uicontrol(CONF.Graf.panel(2),'Style','popupmenu','Units','normalized', 'Position', [0.03 0.45 0.9 0.1],...
                                        'String',{  'Logaritmica (dB) ';'Lineal';}, 'FontSize', 12,'BackgroundColor','w'); 
                                    
frbClaro                                   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------FUNCIONES--------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                  
function fpmColorMap(h,e)
    indVal = get(CONF.pmColMap,'Value');
    strVal = get(CONF.pmColMap,'String');
    CONF.colmp  = strVal{indVal};
    axis(CONF.Config.axSignal3D)
    colormap(CONF.colmp);
end

function fpmColLin(h,e)
    strVal = {'b';'g';'r';'y';'k';'m';'w';};
    indVal = get(CONF.pmColLin,'Value');
    CONF.coline  = strVal{indVal};
    axis(CONF.Config.axSignal2D)
    CONF.Config.axpl.Color = CONF.coline;
end

function frbClaro(h,e)
%         
CONF.claro = 1;
CONF.oscuro = 0;

set(CONF.tab(1),         'BackgroundColor', CONF.BGC.Claro);
set(CONF.tab(2),         'BackgroundColor', CONF.BGC.Claro);
set(CONF.tab(3),         'BackgroundColor', CONF.BGC.Claro);
set(CONF.rbOscuro,       'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.rbClaro,        'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.rbPort,         'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.rbEng,          'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.rbEsp,          'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.config.btCancel,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.config.btSave,  'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.panel(1),       'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.panel(2),       'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
%                        
set(CONF.pmMues,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmReso,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmSali,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmEntr,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmNCha,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmSerA,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmNLat,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmConA,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txKH,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txBT,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txRM,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txSA,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txEA,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txCA,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txSD,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txML,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.audio.txCT,'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
%         
set(CONF.Graf.panel(1), 'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.Graf.panel(2), 'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.Graf.txCM,     'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmColMap,      'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.Graf.txEs,     'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmEscala3D,    'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.Graf.txCL,     'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmColLin,      'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.Graf.txEC,     'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);
set(CONF.pmEscala2D ,   'ForegroundColor', CONF.FGC.Claro, 'BackgroundColor', CONF.BGC.Claro);

set(CONF.Config.axSignal3D ,   'Color', CONF.BGC.Claro);
set(CONF.Config.axSignal2D ,   'Color', CONF.BGC.Claro);

CONF.Config.axSignal3D.Title.Color = CONF.FGC.Claro;
CONF.Config.axSignal2D.Title.Color = CONF.FGC.Claro;
CONF.Config.axSignal3D.XLabel.Color = CONF.FGC.Claro;
CONF.Config.axSignal2D.XLabel.Color = CONF.FGC.Claro;
CONF.Config.axSignal3D.YLabel.Color = CONF.FGC.Claro;
CONF.Config.axSignal2D.YLabel.Color = CONF.FGC.Claro;
CONF.Config.axSignal3D.ZLabel.Color = CONF.FGC.Claro;
CONF.Config.axSignal3D.GridColor = CONF.FGC.Claro;
CONF.Config.axSignal2D.GridColor = CONF.FGC.Claro;
CONF.Config.axSignal3D.XAxis.Color = CONF.FGC.Claro;
CONF.Config.axSignal2D.XAxis.Color = CONF.FGC.Claro;
CONF.Config.axSignal3D.YAxis.Color = CONF.FGC.Claro;
CONF.Config.axSignal2D.YAxis.Color = CONF.FGC.Claro;
CONF.Config.axSignal3D.ZAxis.Color = CONF.FGC.Claro;

end

function frbOscuro(h,e)
% 
CONF.claro = 0;
CONF.oscuro = 1;
set(CONF.tab(1),         'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.tab(2),         'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.tab(3),         'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.rbOscuro,       'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.rbClaro,        'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.rbPort,         'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.rbEng,          'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.rbEsp,          'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.config.btCancel,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.config.btSave,  'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.panel(1),       'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.panel(2),       'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
%                       
set(CONF.pmMues,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmReso,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmSali,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmEntr,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmNCha,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmSerA,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmNLat,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmConA,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txKH,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txBT,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txRM,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txSA,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txEA,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txCA,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txSD,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txML,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.audio.txCT,'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
%          
set(CONF.Graf.panel(1), 'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.Graf.panel(2), 'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.Graf.txCM,     'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmColMap,      'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.Graf.txEs,     'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmEscala3D,    'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.Graf.txCL,     'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmColLin,      'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.Graf.txEC,     'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);
set(CONF.pmEscala2D ,   'ForegroundColor', CONF.FGC.Oscuro, 'BackgroundColor', CONF.BGC.Oscuro);

set(CONF.Config.axSignal3D ,   'Color', CONF.BGC.Oscuro);
set(CONF.Config.axSignal2D ,   'Color', CONF.BGC.Oscuro);

CONF.Config.axSignal3D.Title.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal2D.Title.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal3D.XLabel.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal2D.XLabel.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal3D.YLabel.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal2D.YLabel.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal3D.ZLabel.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal3D.GridColor = CONF.FGC.Oscuro;
CONF.Config.axSignal2D.GridColor = CONF.FGC.Oscuro;
CONF.Config.axSignal3D.XAxis.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal2D.XAxis.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal3D.YAxis.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal2D.YAxis.Color = CONF.FGC.Oscuro;
CONF.Config.axSignal3D.ZAxis.Color = CONF.FGC.Oscuro;

end
function fbtSave(h,e)
    Modelo.setConfiguracion(CONF);
    samriSetTema(GUI,CONF);
    set(CONF.hFig,'Visible','off');
end
function fbtCancel(h,e)
    close(CONF.hFig,'Visible','off');
end
end

