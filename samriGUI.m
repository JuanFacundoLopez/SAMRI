function varargout = samriGUI(varargin)

% Display the GUI window

    %clc
    GUI = [];
    varargout{1} = initGUI(varargin{2});

% Display the initial GUI window
function varargout =  initGUI(controlador)
        %Inicializa Archivos y Path necesarios

        
        % Inicializa Datos
GUI.Config.TipoSenial = {'Señal Impulso sintetizada';'Tren de impulsos sintetizados';...
                         'Tono Seno';'Ruido Blanco';'Ruido Rosa';...
                         'Barrido Senoidal Logaritmico'; 'Barrido Senoidal lineal';};
GUI.Config.ModoFrecue           = {'Espectro', 'Filtro 1/1 Octava', 'Filtro 1/3 Octava', 'Filtro 1/6 Octava', 'Filtro 1/12 Octava'};
GUI.Config.FFT.Num              = [8129 16384 32768 65536]; 
GUI.Config.ModoTiempo           = {'Filtro 1/1 Octava', 'Filtro 1/3 Octava'};
GUI.Config.Filtros.Octava.Str   = {'31.5','63','125','250','500','1000','2000','4000','8000','16000'};
GUI.Config.Filtros.TerOct.Str   = {'20','25','31.5','40','50','63','80','100','125','160','200','250','315','400','500','630','800','1000','1250','1600','2000','2500','3150','4000','5000','6300','8000','10000','12500','16000','20000'};
GUI.Config.Ventana              = {'Rectangular','Hanning','Blackman - Harris','Flat top'};
GUI.Config.FFT.Str              = {'8192', '16384', '32768', '65536'};
GUI.Config.Ord.Str              = {'8','10','12','16','20','26'};
GUI.Config.Met.Str              = {'Filtro IIR', 'Filtro FIR','FFT'};    
GUI.Config.ControlTARS.Str      = {'Nivel 0', 'Nivel 1','Nivel 2', 'Nivel 3','Nivel 4'};  
GUI.Config.ControlLate.Str      = {'Baja', 'Media','Alta'};  
GUI.Resol                       = {'16'; '24';}; %
GUI.imagen.logo                 = imread('LogoCINTRA1.png');
GUI.imagen.x                    = imread('LogoCINTRA.png');
GUI.Const.Ventana               = {'- Tipo de ventana -';'Rectangular';'Hanning';'Hamming';'Blackman';'Blackman-Harris';};
GUI.Const.TamVent               = {'- Tamaño FFT -';'256';'512';'1024';'2048';'4096';'8192';'16384';'32768';'65536';};
GUI.Const.FrecMax               = {'31.5','63','125','250','500','1000','2000','4000','8000','16000','Frecuencia Maxima'};
GUI.Const.FrecMin               = {'Frecuencia Minima','31.5','63','125','250','500','1000','2000','4000','8000','16000'};

GUI.preferencias = [{['usuario' '@' datestr(now,'HH:MM:SS')]};...
                    {['tipo' ' ' [20 20000] ' ' '0,68' 'seg.']};...
                    {['tipoVentana' ' ' 'Hann']}; ...
                    {['Comentario: ' ' ' 'Temperatura: 27°C' ]};...
                    {['Equipo: ' ' ']};];
                
GUI.ColorFondo = [0.200000 0.580000 0.810000];
GUI.axTop2 = 0;

%%
GUI.handles.controller = controlador; % Controlador cargado en vista

%% Cargo datos de la tarjeta de audio
GUI.Config.Entrada  = GUI.handles.controller.fActualizarDispAudio('Entrada'); % Me devuelve el arreglo de la entrada
GUI.Config.Salida   = GUI.handles.controller.fActualizarDispAudio('Salida'); % Me devuelve el arreglo de la salida
GUI.Config.Muest    = GUI.handles.controller.fActualizarDispAudio('Muestreo');        
GUI.Config.Servidor = GUI.handles.controller.fActualizarDispAudio('Servidor');

% Crea una figura nueva
GUI.hFig = findall(0, '-depth',1, 'type','figure', 'Name','Samri');
if isempty(GUI.hFig)
    GUI.hFig = figure(  'Name','SAMRI', 'NumberTitle','off', 'Visible','off',...
                        'Color','w','Position',[10,10,1500,900],...
                        'Toolbar','none', 'Menu', 'none');
else
    clf(GUI.hFig);
    hc=findall(gcf); delete(hc(2:end)); 
end

%%
set(GUI.hFig,'Visible','on') 
%% Agrego los uimenu FILE

GUI.menu(1) = uimenu(GUI.hFig,'Label','Archivo');                                                 %CREO EL MENU

GUI.subMenuArchivo(1) = uimenu(GUI.menu(1), 'Label','Abrir','Accelerator','O');                   %CREO LOS SUBMENU
GUI.subMenuArchivo(2) = uimenu(GUI.menu(1), 'Label','Guardar','Accelerator','S');                 %
GUI.subMenuArchivo(3) = uimenu(GUI.menu(1), 'Label','Guardar como...');                           %
GUI.subMenuArchivo(4) = uimenu(GUI.menu(1), 'Label','Importar señales','Separator','on',...       % Crear GUI para importar
                                            'Accelerator','I','Callback',@(h,e)fmImportar);       % señales
GUI.subMenuArchivo(5) = uimenu(GUI.menu(1), 'Label','Exportar','Accelerator','E');                %
GUI.subMenuArchivo(6) = uimenu(GUI.menu(1), 'Label','Configuraciones...','Accelerator','C','Separator','on','Callback',@(h,e)fConfiguracion);       %
GUI.subMenuArchivo(7) = uimenu(GUI.menu(1), 'Label','Salir','Separator','on','Accelerator','Q','Callback',@(h,e)fSalir);  %

% Agrego los uimenu CALIBRACION
GUI.menu(3) = uimenu(GUI.hFig,'Label','Calibracion'); 
GUI.subMenuAyuda(1) = uimenu(GUI.menu(3),'Label','Calibracion Automatica',...
                                         'Accelerator','W','Callback',@(h,e)fbtCalibracion);      %CREO LOS SUBMENU
GUI.subMenuAyuda(2) = uimenu(GUI.menu(3),'Label','Calibracion Manual','Accelerator','R');          %

% Agrego los uimenu AYUDA
GUI.menu(4) = uimenu(GUI.hFig,'Label','Ayuda'); 
GUI.subMenuAyuda(1) = uimenu(GUI.menu(4),'Label','Buscar...','Accelerator','B');                  %CREO LOS SUBMENU
GUI.subMenuAyuda(2) = uimenu(GUI.menu(4),'Label','Manual','Accelerator','M');                        %

% Agrego los uimenu ACERCA DE...
GUI.menu(5) = uimenu(GUI.hFig,'Label','Acerca de...');        
GUI.subMenuAyuda(1) = uimenu(GUI.menu(5),'Label','SAMRI');                                         %CREO LOS SUBMENU
GUI.subMenuAyuda(2) = uimenu(GUI.menu(5),'Label','SAMDA');                                          %
           
      %% establezco los tabs

GUI.hTabGroup = uitabgroup(GUI.hFig); 
GUI.tab(1) = uitab(GUI.hTabGroup, 'title','Medición','BackgroundColor','w');
GUI.tab(2) = uitab(GUI.hTabGroup, 'title','Tiempo','BackgroundColor','w');
GUI.tab(3) = uitab(GUI.hTabGroup, 'title','Frecuencia','BackgroundColor','w');
GUI.tab(4) = uitab(GUI.hTabGroup, 'title','ETF-Fourier','BackgroundColor','w');
GUI.tab(5) = uitab(GUI.hTabGroup, 'title','ETF-Hilbert-Huang','BackgroundColor','w');   
GUI.tab(6) = uitab(GUI.hTabGroup, 'title','Cepstrum','BackgroundColor','w');        


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Panel de medicion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%Agrego los separadores
GUI.panel(1) = uibuttongroup('Parent',GUI.tab(1),'Title','Señal de exitacion','FontSize',12,...   %señal de exitacion
                               'BackgroundColor','w','Position',[.01 .35 .525 .63]);
                           
GUI.panel(2) = uipanel('Parent',GUI.tab(1),'Title','E/S','FontSize',12,...                  %entradas salidas
                               'BackgroundColor','w','Position',[.54 .35 .45 .63]);        
                           
% GUI.panel(3) = uipanel('Parent',GUI.tab(1),'Title','Informacion secundaria','FontSize',12,...%Info secundaria
%                                'BackgroundColor','w','Position',[.54 .35 .45 .31]);    

GUI.panel(4) = uipanel('Parent',GUI.tab(1),'Title','Notas','FontSize',12,...                %Notas
                               'BackgroundColor','w','Position',[.01 .01 .8377 .33]);    
                                                      

                           %% Agrego las notas
                           
GUI.config.txUsuario = uicontrol(GUI.panel(4),'Style','text', 'Position', [10 230 90 20],'BackgroundColor','w',...
                                'String','Usuario', 'FontSize', 13);

GUI.config.txEquipo  = uicontrol(GUI.panel(4),'Style','text', 'Position', [10 150 90 20],'BackgroundColor','w',...
                                'String','Equipo', 'FontSize', 13);                            
                            
GUI.config.txComenta = uicontrol(GUI.panel(4),'Style','text', 'Position', [390 230 90 20],'BackgroundColor','w',...
                                'String','Comentarios', 'FontSize', 13);                            
                            
                            
GUI.config.editUsuario = uicontrol(GUI.panel(4),'Style','edit', 'Position', [100 210 250 50],...
                                'String',' ', 'Min',0,'Max',10, 'FontSize', 15);
  
GUI.config.editEquipos = uicontrol(GUI.panel(4),'Style','edit', 'Position', [100 30 250 150],...
                                'String',' ', 'Min',0,'Max',10, 'FontSize', 15);
                            
GUI.config.editComenta = uicontrol(GUI.panel(4),'Style','edit', 'Position', [500 30 500 230],...
                                'String',' ', 'Min',0,'Max',10, 'FontSize', 10, 'HorizontalAlignment', 'Left');
      
GUI.config.btGuard =  uicontrol(GUI.panel(4),'Style','pushbutton', 'Position', [1050 160 160 60],...
                        'String','Guardar Configuracion', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold','Callback', @(h,e)fbtGuardarConfg());
                    
GUI.config.btCarga =  uicontrol(GUI.panel(4),'Style','pushbutton', 'Position', [1050 80 160 60],...
                        'String','Cargar Configuracion', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold','Callback', @(h,e)fbtCargarConfg());
                    
GUI.config.axImagen1          = axes;      
GUI.config.axImagen1.Parent   = GUI.tab(1);
GUI.config.axImagen1.Position = [0.8535 0.10 0.14 0.19];
imshow(GUI.imagen.logo);

GUI.config.axImagen2          = axes;      
GUI.config.axImagen2.Parent   = GUI.tab(1);
GUI.config.axImagen2.Position = [0.86 0.015 0.13 0.1];
imshow(GUI.imagen.x);
                    
%% agrego objetos al panel 1
%Menu texto no modificable 
GUI.rbInterna = uicontrol(GUI.panel(1),'Style','radiobutton', 'Position', [20 475 80 30],'String','Interna',...
                            'FontSize', 12,'BackgroundColor','w','Value', 1,'Callback',@(h,e)frbInterna());  
        
GUI.rbExterna = uicontrol(GUI.panel(1),'Style','radiobutton', 'Position', [420 475 80 30],'String','Externa',...
                            'FontSize', 12,'BackgroundColor','w','Callback',@(h,e)frbExterna());

GUI.config.btMedir = uicontrol('Parent', GUI.panel(1),'Style','pushbutton', 'Position', [670 473 90 30],...
                            'String','Medir', 'FontSize', 12,'BackgroundColor','w',...
                            'FontWeight','bold','Callback',@(h,e)fMedir());
                            
% Labels del menu de entrada de datos de la caracteristica de la señal                            

GUI.config.txTipo = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 400 100 30],'String','Tipo',...
                        'FontSize', 13,'BackgroundColor','w','FontWeight','bold');

GUI.config.txDura = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 340 100 30],...
                        'String','Duracion', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                    
GUI.config.txTono = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 280 100 40],...
                        'String','Tono frecuencia', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');                    

GUI.config.txFreF = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 230 100 40],...
                        'String','Frecuencia final', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');

GUI.config.txFreI = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 180 100 40],...
                        'String','Frecuencia inicial', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');

GUI.config.txSile = uicontrol(GUI.panel(1), 'Style','text', 'Position', [10 135 100 30],'String','Silencio',...
                        'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
GUI.config.txRepe = uicontrol(GUI.panel(1), 'Style','text', 'Position', [10 95 100 30], 'String','Repeticion',...
                        'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                     
GUI.config.txVolu = uicontrol(GUI.panel(1), 'Style','text', 'Position', [10 55 100 30], 'String','Volumen',...
                        'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                             
            % Menu de entrada de datos
            
GUI.pmTipo = uicontrol(GUI.panel(1),'Style','popupmenu', 'Position', [140 400 200 30],...
                        'String',GUI.Config.TipoSenial, 'FontSize', 11,'BackgroundColor','w',...
                        'Callback',@(h,e)fpmTipo,'Value', 6);

GUI.edDura = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 340 200 30],...
                        'String','1', 'FontSize', 13,'BackgroundColor','w',...
                        'Callback',@(h,e)fedDura);
               
GUI.edFrec = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 280 200 40],...
                        'String',' 1000 ', 'FontSize', 13,'BackgroundColor','w',...
                        'Callback',@(h,e)fedFreF,'Enable','off');
                    
GUI.edFreF = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 230 200 40],...
                        'String',' 20000 ', 'FontSize', 13,'BackgroundColor','w',...
                        'Callback',@(h,e)fedFreF);
                    
GUI.edFreI = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 180 200 40],...
                        'String',' 20 ', 'FontSize', 13,'BackgroundColor','w',...
                        'Callback',@(h,e)fedFreI);
                    
GUI.edSile = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 135 200 30],...
                        'String',' 0 ', 'FontSize', 13,'BackgroundColor','w',...
                        'Callback',@(h,e)fedSile);
                    
GUI.edRepe = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 100 200 30],...
                        'String',' 0 ', 'FontSize', 13,'BackgroundColor','w',...
                        'Callback',@(h,e)fedRepe); 

GUI.edVolu = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 60 200 30],...
                        'String',' 100 ', 'FontSize', 13,'BackgroundColor','w',...
                        'Callback',@(h,e)fedVolu); 

                    
                    %% %Menu de texto no modificable (unidades)
        
GUI.txLabel(1)= uicontrol(GUI.panel(1),'Style','text', 'Position', [340 405 50 20],...
                        'String',' ', 'FontSize', 11,'BackgroundColor','w');

GUI.txLabel(2) = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 345 50 20],...
                        'String','[ s ]', 'FontSize', 11,'BackgroundColor','w');

GUI.txLabel(3) = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 290 40 20],...
                        'String','[ Hz ]', 'FontSize', 11,'BackgroundColor','w');

GUI.txLabel(4)= uicontrol(GUI.panel(1),'Style','text', 'Position', [340 240 40 20],...
                        'String','[ Hz ]', 'FontSize', 11,'BackgroundColor','w');

GUI.txLabel(5)= uicontrol(GUI.panel(1),'Style','text', 'Position', [340 195 40 20],...
                        'String','[ Hz ]', 'FontSize', 11,'BackgroundColor','w');

GUI.txLabel(6) = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 140 50 20],...
                        'String','[ s ]', 'FontSize', 11,'BackgroundColor','w');

GUI.txLabel(7)= uicontrol(GUI.panel(1),'Style','text', 'Position', [340 100 50 20],...
                        'String','[ - ]', 'FontSize', 11,'BackgroundColor','w');
                    
GUI.txLabel(8)= uicontrol(GUI.panel(1),'Style','text', 'Position', [340 65 50 20],...
                        'String',' % ', 'FontSize', 11,'BackgroundColor','w');

GUI.LabPath = uicontrol(GUI.panel(1),'Style','text', 'Position', [510 405 230 30],...
                        'String','Path', 'FontSize', 8,'BackgroundColor','w',...
                        'ForegroundColor',[0.1 0.1 0.1]);
                    
GUI.btImpor =  uicontrol(GUI.panel(1),'Style','pushbutton', 'Position', [420 410 80 30],...
                        'String','Importar', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold', 'Enable', 'off', 'Callback',@(h,e)fbtImport);

GUI.axVisua = axes;      
GUI.axVisua.Parent = GUI.panel(1);
GUI.axVisua.Position = [0.6 0.05 0.368 0.68];
GUI.axVisua.XAxisLocation = 'origin';
GUI.axVisua.YLim = [-1 1];
GUI.axVisua.Box = 'off';
GUI.axVisua.Title.String = 'Señal previsualizada';
GUI.axVisua.Title.FontWeight = 'bold';
GUI.axVisua.XLabel.String = 'Tiempo [s]';
GUI.axVisua.YLabel.String = 'Amplitud normalizada';
 
GUI.btPlay =  uicontrol(GUI.panel(1),'Style','pushbutton', 'Position', [700 20 60 30],...
                        'String','Play', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold','Callback',@(h,e)fbtPlay);
        
        %% Agrego objetos al panel 2
GUI.txLabel(9) = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 480 100 40],...
                        'String','Control TARS', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
GUI.txLabel(10) = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 405 100 50],...
                        'String','Modo Latencia', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold'); 
                    
GUI.txLabel(11) = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 330 100 50],...
                        'String','Servidor de audio', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
        
GUI.txLabel(12) = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 255 100 50],...
                        'String','Canales de audio', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                    
GUI.txLabel(13) = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 200 100 30],...
                        'String','Entrada', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
        
GUI.txLabel(14) = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 125 100 30],...
                        'String','Salida', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
GUI.txLabel(15) = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 50 100 50],...
                        'String','Resolucion / Muestreo', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                              
GUI.pmConA = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 480 480 30],'String',GUI.Config.ControlTARS.Str,...
                        'FontSize', 11,'BackgroundColor','w', 'Callback',@(h,e)fpmTipo);
                    
GUI.pmNLat = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 410 480 30],'String',GUI.Config.ControlLate.Str,...
                        'FontSize', 11,'BackgroundColor','w','Callback',@(h,e)fpmTipo);                                 
                    
GUI.pmSerA = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 340 480 30],'String',GUI.Config.Servidor,...
                        'FontSize', 11,'BackgroundColor','w', 'Callback',@(h,e)fpmServidor);
                    
                    
GUI.pmNCha = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 270 480 30],'String',{'1 Canal';'2 Canales';},...
                        'FontSize', 11,'BackgroundColor','w','Callback',@(h,e)fpmTipo);                            
       
GUI.pmEntr = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 200 480 30],...
                       'String', ' ', 'FontSize', 13,'BackgroundColor','w');
                   
GUI.pmSali = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 130 480 30],...
                       'String', ' ', 'FontSize', 13,'BackgroundColor','w');
                           
GUI.pmReso = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [138 70 140 30],...
                       'String',GUI.Resol, 'FontSize', 13,'BackgroundColor','w','HorizontalAlignment','Center');
        
GUI.pmMues = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [308 70 140 30],'Callback',@(h,e)fMuestreo,...
                       'String',GUI.Config.Muest, 'FontSize', 13,'BackgroundColor','w', 'HorizontalAlignment', 'Center', 'Value', 2);
                   
GUI.btActu = uicontrol(GUI.panel(2),'Style','pushbutton', 'Position',[482 70 140 30],'Callback',@(h,e)fActualizarTARS,...
                       'String','Actualizar', 'FontSize', 13,'BackgroundColor','w','HorizontalAlignment','Center');
 
fpmServidor % Cargo los valores de la entrada y de la salida                    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                Agrego objetos a "Dominio en el timpo"             %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agrego grafico

GUI.DomTiemp.axSenialTiem = axes;      
GUI.DomTiemp.axSenialTiem.Parent = GUI.tab(2);
GUI.DomTiemp.axSenialTiem.Position = [0.045 0.03 0.81 0.936];
GUI.DomTiemp.axSenialTiem.XAxisLocation = 'origin';
GUI.DomTiemp.axSenialTiem.YLim  = [-1 1];
GUI.DomTiemp.axSenialTiem.XGrid = 'on';
GUI.DomTiemp.axSenialTiem.YGrid = 'on';
GUI.DomTiemp.axSenialTiem.Box   = 'off';
GUI.DomTiemp.axSenialTiem.XLabel.String = 'Tiempo [s]';
GUI.DomTiemp.axSenialTiem.YLabel.String = 'Amplitud';

GUI.DomTiemp.btRepro = uicontrol('Parent', GUI.tab(2),'Style','pushbutton', 'Position', [1180 30 90 40],...
                                'String','Reproducir', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtReproducirRI);

GUI.DomTiemp.btRepet = uicontrol('Parent', GUI.tab(2),'Style','pushbutton', 'Position', [1080 30 90 40],...
                                'String','Repetir', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtRepetirRI);
                                                     
%Agrego un panel y objetos al panel de señales en el dominio del tiempo

GUI.DomTiemp.panelTiemp(1) = uipanel('Parent',GUI.tab(2),'Title','Señales','FontSize',12,...                 %señal de exitacion
                               'BackgroundColor','w','Position',[.86 .295 .13 .7]);
                                               
GUI.DomTiemp.btAnalisis = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 520 170 60],...
                                'String','Analisis', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtAnalisis);

GUI.DomTiemp.btSenialEx = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 440 170 60],...
                                'String','Exitación', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtSenialEx);

GUI.DomTiemp.btRespueEx = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 360 170 60],...
                                'String','Respuesta Exitación', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtRespueEx);

GUI.DomTiemp.btFiltrInv = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 280 170 60],...
                                'String','Filtro Inverso', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtFiltrInv);

GUI.DomTiemp.btRespImpu = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 200 170 60],...
                                'String','Respuesta Impulsiva', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtRespImpu);

GUI.DomTiemp.btCurvEnTi = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 120 170 60],...
                                'String','Energía-Tiempo', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtCurvEnTi);
                            
GUI.DomTiemp.btCurvaETI = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 40 170 60],...
                                'String','Energía-Tiempo Integrada', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtCurvaETI);

GUI.DomTiemp.axImagen1          = axes;      
GUI.DomTiemp.axImagen1.Parent   = GUI.tab(2);
GUI.DomTiemp.axImagen1.Position = [0.8535 0.10 0.14 0.19];
imshow(GUI.imagen.logo);

GUI.DomTiemp.axImagen2          = axes;      
GUI.DomTiemp.axImagen2.Parent   = GUI.tab(2);
GUI.DomTiemp.axImagen2.Position = [0.86 0.015 0.13 0.1];
imshow(GUI.imagen.x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ************************************** DOMINIO DE LA FRECUENCIA*********************************************** %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                            
            %% Creacion de los objetos en el dominio de la frecuencia

% Agrego grafico

GUI.DomFrec.axEspecFrec                 = axes;      
GUI.DomFrec.axEspecFrec.Parent          = GUI.tab(3);
GUI.DomFrec.axEspecFrec.Position        = [0.04 0.06 0.81 0.9];
GUI.DomFrec.axEspecFrec.XScale          = 'log';
GUI.DomFrec.axEspecFrec.YLim            = [-120 0];
GUI.DomFrec.axEspecFrec.XLim            = [1 30000];
GUI.DomFrec.axEspecFrec.XGrid           = 'on';
GUI.DomFrec.axEspecFrec.YGrid           = 'on';
GUI.DomFrec.axEspecFrec.Title.FontWeight= 'bold';
GUI.DomFrec.axEspecFrec.XLabel.String   = 'Frecuencia [ Hz ]';
GUI.DomFrec.axEspecFrec.YLabel.String   = 'Magnitud [dB]';

                %% Creacion del panel de señales en el dominio de la frecuencia

GUI.DomFrec.panelSeniales(1) = uibuttongroup('Parent',GUI.tab(3),'Title','Señales','FontSize',12,...                 
                               'BackgroundColor','w','Position',[.86 .295 .13 .7]);  

GUI.DomFrec.btAnalisis = uicontrol(GUI.DomFrec.panelSeniales(1),'Style','pushbutton', 'Position', [10 520 170 60],...
                                'String','Analisis', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtFAnalisis);  
                            
GUI.DomFrec.btSenialEx = uicontrol(GUI.DomFrec.panelSeniales(1),'Style','pushbutton', 'Position', [10 440 170 60],...
                                'String','Exitación', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtDFSenialEx);

GUI.DomFrec.btRespueEx = uicontrol(GUI.DomFrec.panelSeniales(1),'Style','pushbutton', 'Position', [10 360 170 60],...
                                'String','Respuesta Exitación', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtDFRespueEx);

GUI.DomFrec.PSDSenExit = uicontrol(GUI.DomFrec.panelSeniales(1),'Style','pushbutton', 'Position', [10 280 170 60],...
                                'String','PSD Exitación', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtDFPSDSenExit);

GUI.DomFrec.PSDResExit = uicontrol(GUI.DomFrec.panelSeniales(1),'Style','pushbutton', 'Position', [10 200 170 60],...
                                'String','PSD Respuesta Exitación', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtDFPSDResExit);

% GUI.DomFrec.btEspectrograma = uicontrol(GUI.DomFrec.panelSeniales(1),'Style','pushbutton', 'Position', [10 120 170 60],...
%                                 'String','Espectrograma','Enable','off', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
%                                 'Callback',@(h,e)fbtEspectrograma);  
                            
GUI.DomFrec.btLogaritm = uicontrol('Parent', GUI.tab(3),'Style','pushbutton', 'Position', [1180 70 90 40],...
                                'String','Eje log', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtLog);

GUI.DomFrec.btLineal   = uicontrol('Parent', GUI.tab(3),'Style','pushbutton', 'Position', [1080 70 90 40],...
                                'String','Eje lin', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtLin);                           
                            
GUI.DomFrec.axImagen1          = axes;      
GUI.DomFrec.axImagen1.Parent   = GUI.tab(3);
GUI.DomFrec.axImagen1.Position = [0.8535 0.10 0.14 0.19];
imshow(GUI.imagen.logo);

GUI.DomFrec.axImagen2          = axes;      
GUI.DomFrec.axImagen2.Parent   = GUI.tab(3);
GUI.DomFrec.axImagen2.Position = [0.86 0.015 0.13 0.1];
imshow(GUI.imagen.x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%********************Agrego objetos ETF Fourier ****************************************%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


GUI.Espectro.axSenialTiem               = axes;      
GUI.Espectro.axSenialTiem.Parent        = GUI.tab(4);
GUI.Espectro.axSenialTiem.Position      = [0.045 0.03 0.79 0.936];
GUI.Espectro.axSenialTiem.YLim          = [0 1];
GUI.Espectro.axSenialTiem.XLim          = [1 30000];
GUI.Espectro.axSenialTiem.View          = [45, 45];
GUI.Espectro.axSenialTiem.YLim          = [0 1];
GUI.Espectro.axSenialTiem.XGrid         = 'on';
GUI.Espectro.axSenialTiem.YGrid         = 'on';
GUI.Espectro.axSenialTiem.Box           = 'off';
GUI.Espectro.axSenialTiem.XLabel.String = 'Frecuencia [kHz]';
GUI.Espectro.axSenialTiem.YLabel.String = 'Tiempo [s]';
GUI.Espectro.axSenialTiem.ZLabel.String = 'Magnitud';

                                                     
%Agrego un panel y objetos al panel de señales en el dominio del tiempo

GUI.Espectro.panelTiemp(1) = uipanel('Parent',GUI.tab(4),'Title','Señales','FontSize',12,...                 %señal de exitacion
                               'BackgroundColor','w','Position',[.86 .295 .13 .7]);
                                               
GUI.Espectro.btAnalisis = uicontrol(GUI.Espectro.panelTiemp(1),'Style','pushbutton', 'Position', [10 520 170 60],...
                                'String','Analisis', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtETFAnalisis);

GUI.Espectro.btSenialEx = uicontrol(GUI.Espectro.panelTiemp(1),'Style','pushbutton', 'Position', [10 440 170 60],...
                                'String','Exitación', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtETFSenialEx);

GUI.Espectro.btRespueEx = uicontrol(GUI.Espectro.panelTiemp(1),'Style','pushbutton', 'Position', [10 360 170 60],...
                                'String','Respuesta Exitación', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtETFRespueEx);

GUI.Espectro.btRespImpu = uicontrol(GUI.Espectro.panelTiemp(1),'Style','pushbutton', 'Position', [10 280 170 60],...
                                'String','Respuesta Impulsiva', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtETFRespImpuls);

GUI.Espectro.pmTamaVen  = uicontrol(GUI.Espectro.panelTiemp(1),'Style','popupmenu', 'Position', [10 240 170 25],...
                                'String',GUI.Const.TamVent, 'FontSize', 10,'BackgroundColor','w',...
                                'Value', 1);
                            
GUI.Espectro.pmVentana  = uicontrol(GUI.Espectro.panelTiemp(1),'Style','popupmenu', 'Position', [10 200 170 25],...
                                'String',GUI.Const.Ventana, 'FontSize', 11,'BackgroundColor','w',...
                                'Value', 1);       
                            
GUI.txLabel(16) = uicontrol(GUI.Espectro.panelTiemp(1),'Style','text', 'Position', [10 160 60 25],...
                        'String','Div.    :', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold');
                    
GUI.txLabel(17) = uicontrol(GUI.Espectro.panelTiemp(1),'Style','text', 'Position', [10 120 60 25],...
                        'String','Sbrlap. :', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold');
                    
GUI.Espectro.edDivisiones = uicontrol(GUI.Espectro.panelTiemp(1),'Style','edit', 'Position', [70 160 110 25],...
                                'FontSize', 11,'BackgroundColor','w','String', '100');    
                                                
GUI.Espectro.edOverlaping = uicontrol(GUI.Espectro.panelTiemp(1),'Style','edit', 'Position', [70 120 110 25],...
                                'FontSize', 11,'BackgroundColor','w','String', '50');   

GUI.Espectro.pmFrecMin  = uicontrol(GUI.Espectro.panelTiemp(1),'Style','popupmenu', 'Position', [10 80 170 25],...
                                'String',GUI.Const.FrecMin, 'FontSize', 11,'BackgroundColor','w',...
                                'Value', 1);
                            
GUI.Espectro.pmFrecMax  = uicontrol(GUI.Espectro.panelTiemp(1),'Style','popupmenu', 'Position', [10 40 170 25],...
                                'String',GUI.Const.FrecMax, 'FontSize', 11,'BackgroundColor','w',...
                                'Value', 11); 
                            
GUI.Espectro.btLogaritm = uicontrol('Parent', GUI.tab(4),'Style','pushbutton', 'Position', [1080 70 90 40],...
                                'String','Eje log', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtLogEsp);

GUI.Espectro.btLineal   = uicontrol('Parent', GUI.tab(4),'Style','pushbutton', 'Position', [980 70 90 40],...
                                'String','Eje lin', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtLinEsp);  

GUI.Espectro.axImagen1          = axes;      
GUI.Espectro.axImagen1.Parent   = GUI.tab(4);
GUI.Espectro.axImagen1.Position = [0.8535 0.10 0.14 0.19];
imshow(GUI.imagen.logo);

GUI.Espectro.axImagen2          = axes;      
GUI.Espectro.axImagen2.Parent   = GUI.tab(4);
GUI.Espectro.axImagen2.Position = [0.86 0.015 0.13 0.1];
imshow(GUI.imagen.x);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%% ETF - Mediante transformada Hilbert - Huang %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agrego grafico

GUI.DomHilb.axEspecFrec                 = axes;      
GUI.DomHilb.axEspecFrec.Parent          = GUI.tab(5);
GUI.DomHilb.axEspecFrec.Position        = [0.045 0.03 0.79 0.936];
GUI.DomHilb.axEspecFrec.YLim            = [0 1];
GUI.DomHilb.axEspecFrec.View            = [45, 45];
GUI.DomHilb.axEspecFrec.XLim            = [1, 30000];
GUI.DomHilb.axEspecFrec.XGrid           = 'on';
GUI.DomHilb.axEspecFrec.YGrid           = 'on';
GUI.DomHilb.axEspecFrec.Title.FontWeight= 'bold';
GUI.DomHilb.axEspecFrec.XLabel.String   = 'Frecuencia [ kHz ]';
GUI.DomHilb.axEspecFrec.YLabel.String   = 'Tiempo [ s ]';
GUI.DomHilb.axEspecFrec.ZLabel.String   = 'Magnitud';
                %% Creacion del panel para ETF - HHT

GUI.DomHilb.panelSeniales(1) = uibuttongroup('Parent',GUI.tab(5),'Title','Señales','FontSize',12,...                 
                               'BackgroundColor','w','Position',[.86 .295 .13 .7]);  

GUI.DomHilb.btAnalisis = uicontrol(GUI.DomHilb.panelSeniales(1),'Style','pushbutton', 'Position', [10 520 170 60],...
                                'String','Analisis', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtHHTAnalisis);  
                            
GUI.DomHilb.btSenialEx = uicontrol(GUI.DomHilb.panelSeniales(1),'Style','pushbutton', 'Position', [10 440 170 60],...
                                'String','Exitación', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtHHTFSenialEx);

GUI.DomHilb.btRespueEx = uicontrol(GUI.DomHilb.panelSeniales(1),'Style','pushbutton', 'Position', [10 360 170 60],...
                                'String','Respuesta Exitación', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtHHTFRespueEx);

GUI.DomHilb.btResImpul = uicontrol(GUI.DomHilb.panelSeniales(1),'Style','pushbutton', 'Position', [10 280 170 60],...
                                'String','Respuesta Impulsiva', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtHHTFRespueIm);

GUI.DomHilb.btLogaritm = uicontrol('Parent', GUI.tab(5),'Style','pushbutton', 'Position', [1180 70 90 40],...
                                'String','Eje log', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtLogHHT);

GUI.DomHilb.btLineal   = uicontrol('Parent', GUI.tab(5),'Style','pushbutton', 'Position', [1080 70 90 40],...
                                'String','Eje lin', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtLinHHT);                             
                            
GUI.DomHilb.axImagen1          = axes;      
GUI.DomHilb.axImagen1.Parent   = GUI.tab(5);
GUI.DomHilb.axImagen1.Position = [0.8535 0.10 0.14 0.19];
imshow(GUI.imagen.logo);

GUI.DomHilb.axImagen2          = axes;      
GUI.DomHilb.axImagen2.Parent   = GUI.tab(5);
GUI.DomHilb.axImagen2.Position = [0.86 0.015 0.13 0.1];
imshow(GUI.imagen.x);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%********************Dominio CEPTRAL************************************%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agrego grafico

GUI.DomCept.axEspecFrec                 = axes;      
GUI.DomCept.axEspecFrec.Parent          = GUI.tab(6);
GUI.DomCept.axEspecFrec.Position        = [0.04 0.06 0.81 0.9];
GUI.DomCept.axEspecFrec.YLim            = [-120 0];
GUI.DomCept.axEspecFrec.XLim            = [1 30000];
GUI.DomCept.axEspecFrec.XGrid           = 'on';
GUI.DomCept.axEspecFrec.YGrid           = 'on';
GUI.DomCept.axEspecFrec.Title.FontWeight= 'bold';
GUI.DomCept.axEspecFrec.XLabel.String   = 'Quefrency';
GUI.DomCept.axEspecFrec.YLabel.String   = 'Magnitud [dB]';

GUI.DomCept.panelSeniales(1) = uibuttongroup('Parent',GUI.tab(6),'Title','Señales','FontSize',12,...                 
                               'BackgroundColor','w','Position',[.86 .295 .13 .7]);  

GUI.DomCept.btAnalisis = uicontrol(GUI.DomCept.panelSeniales(1),'Style','pushbutton', 'Position', [10 520 170 60],...
                                'String','Analisis', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold','Enable','off','Callback',@(h,e)fbtCAnalisis);  
                            
GUI.DomCept.btSenialEx = uicontrol(GUI.DomCept.panelSeniales(1),'Style','pushbutton', 'Position', [10 440 170 60],...
                                'String','Exitación', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtCFSenialEx);

GUI.DomCept.btRespueEx = uicontrol(GUI.DomCept.panelSeniales(1),'Style','pushbutton', 'Position', [10 360 170 60],...
                                'String','Respuesta Exitación', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtCFRespueEx);

GUI.DomCept.btResImpul = uicontrol(GUI.DomCept.panelSeniales(1),'Style','pushbutton', 'Position', [10 280 170 60],...
                                'String','Respuesta Impulsiva', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold',...
                                'Enable','off','Callback',@(h,e)fbtCFRespueIm);

GUI.DomCept.axImagen1          = axes;     
GUI.DomCept.axImagen1.Parent   = GUI.tab(6);
GUI.DomCept.axImagen1.Position = [0.8535 0.10 0.14 0.19];
imshow(GUI.imagen.logo);

GUI.DomCept.axImagen2          = axes;      
GUI.DomCept.axImagen2.Parent   = GUI.tab(6);
GUI.DomCept.axImagen2.Position = [0.86 0.015 0.13 0.1];
imshow(GUI.imagen.x);



%% Importar previsualizacion
GUI.handles.controller.fimportarPrevisual(GUI);

%% Actualizacion de la GUI
                           
    if nargout
            [varargout{1}] = GUI;
    end   
    
end
function fmImportar(h,e)
    GUI.handles.controller.fImportarSenExternas(GUI); 
end
%% ***********************************************************************%
%                   Funciones del panel de Medicion
%*******************--------------------------------**********************%
    function frbExterna(h,e)
        GUI.handles.controller.fExterna(GUI);
    end
    function frbInterna(h,e)
        GUI.handles.controller.fInterna(GUI);
    end
    function fbtImport(h,e)
        GUI.handles.controller.fImportSignal(GUI); % llamo a la funcion fimportarPrevisual en el controlador
    end
    function fbtPlay(h,e)
        GUI.handles.controller.fReproduceSenial(); % llamo a la funcion fimportarPrevisual en el controlador
    end
    function fMedir(h,e)
        GUI.handles.controller.fMedir(GUI) %llamo a la funcion en el controlador
    end
    function fActualizarTARS(h,e)
        TARS = GUI.handles.controller.fActualizarDispAudio('Todo',GUI);
        set(GUI.pmEntr, 'String', TARS.Entrada );%Verificar funcionamiento con la tarjeta desconectada
        set(GUI.pmSali, 'String', TARS.Salida);
        set(GUI.pmMues, 'String', TARS.Muestr);
    end
    function fpmTipo(h,e)
        GUI.handles.controller.fTipo(GUI);
    end
    function fedDura(h,e)
        GUI.handles.controller.fimportarPrevisual(GUI);
    end
    function fedFreF(h,e)
        GUI.handles.controller.fimportarPrevisual(GUI);
    end
    function fedFreI(h,e)
        GUI.handles.controller.fimportarPrevisual(GUI);
    end
    function fedSile(h,e)
        GUI.handles.controller.fimportarPrevisual(GUI);
    end
    function fedRepe(h,e)
        GUI.handles.controller.fimportarPrevisual(GUI);
    end
    function fedVolu(h,e)
        GUI.handles.controller.fimportarPrevisual(GUI);
    end
    function fMuestreo(h,e)
        GUI.handles.controller.fimportarPrevisual(GUI);
    end
    function fpmServidor(h,e)
        GUI.handles.controller.fServidor(GUI);
    end


%% ***********************************************************************%
%                   Funciones Dominio Tiempo
%*******************------------------------------************************%
function fbtAnalisis(h,e)
GUI.handles.controller.fbtAnalisis(GUI);       
end
function fbtSenialEx(h,e)
    GUI.handles.controller.fbtMostrarSenialExitacion(GUI);
end
function fbtRespueEx(h,e)
    GUI.handles.controller.fbtMostrarRespuestaExitacion(GUI);       
end
function fbtFiltrInv(h,e)
    GUI.handles.controller.fbtMostrarFiltroInverso(GUI);       
end
function fbtRespImpu(h,e)
    GUI.handles.controller.fbtMostrarRespuestaImpulsiva(GUI);       
end
function fbtCurvEnTi(h,e)
    GUI.handles.controller.fbtMostrarCurvaEnergiaTiempo(GUI);        
end
function fbtCurvaETI(h,e)
    GUI.handles.controller.fbtMostrarCurvaEnergiaTiempoIntegrada(GUI);            
end
function fbtReproducirRI(h,e)
    GUI.handles.controller.fbtReproducirRespuestaImpulsiva(GUI);       
end
%% ***********************************************************************%
%                       Funciones Frecuencia 
%*******************------------------------------************************%
%% Funciones en el panel del dominio de la frecuencia
function fbtFAnalisis(h,e)
    GUI.handles.controller.fbtFrecAnalisis(GUI);
end
function fbtDFSenialEx(h,e)
    GUI.handles.controller.fbtMostrarEspectroExitacion(GUI);
end
function fbtDFRespueEx(h,e) 
    GUI.handles.controller.fbtMostrarEspectroResExitac(GUI);
end
function fbtDFPSDSenExit(h,e) 
    GUI.handles.controller.fbtMostrarPSDSenialExitacion(GUI);
end
function fbtDFPSDResExit(h,e)
    GUI.handles.controller.fbtMostrarPSDRespueExitacion(GUI);
end
function fbtLog(h,e)
    GUI.DomFrec.axEspecFrec.XScale = 'log';
end
function fbtLin(h,e)
    GUI.DomFrec.axEspecFrec.XScale = 'linear';
    end
%% ***********************************************************************%
%                       Funciones ETF - Fourier
%*******************------------------------------************************%
function fbtETFAnalisis(h,e)
    GUI.handles.controller.fETFFrecAnalisis(GUI);
end
function fbtETFSenialEx(h,e)
    
    if get(GUI.Espectro.pmTamaVen ,'Value') == 1, GUI.EspecParam.TamanioVentana = 1024;
    else, GUI.EspecParam.TamanioVentana = str2double(GUI.Const.TamVent{get(GUI.Espectro.pmTamaVen,'Value')}); end
    if get(GUI.Espectro.pmVentana ,'Value') == 1, GUI.EspecParam.Ventana = 3;
    else,  GUI.EspecParam.Ventana = get(GUI.Espectro.pmVentana ,'Value'); end
    
    GUI.EspecParam.Divisiones     = str2double(get(GUI.Espectro.edDivisiones,'String'));
    GUI.EspecParam.FrecMax        = GUI.Const.FrecMax{get(GUI.Espectro.pmFrecMax,'Value')-1};
    GUI.EspecParam.FrecMin        = GUI.Const.FrecMin{get(GUI.Espectro.pmFrecMin,'Value')+1};
    GUI.EspecParam.Overlaping     = str2double(get(GUI.Espectro.edOverlaping,'String'))/100;   
    
    switch GUI.EspecParam.Ventana 
        case 1
            GUI.EspecParam.Vent = rectwin(GUI.EspecParam.Divisiones);      %ventana rectangular
        case 2
            GUI.EspecParam.Vent = hann(GUI.EspecParam.Divisiones);         % ventana hann
        case 3
            GUI.EspecParam.Vent = hamming(GUI.EspecParam.Divisiones);      % ventana hamming
        case 4
            GUI.EspecParam.Vent = blackman(GUI.EspecParam.Divisiones);     % ventana blackman
        case 5
            GUI.EspecParam.Vent = blackmanharris(GUI.EspecParam.Divisiones);% blackman harris
    end

    GUI.EspecParam.Ovlp  = GUI.EspecParam.Divisiones * GUI.EspecParam.Overlaping ;
   
    GUI.handles.controller.fETFMostrarEspectroExitacion(GUI);
end
function fbtETFRespueEx(h,e) 

    if get(GUI.Espectro.pmTamaVen ,'Value') == 1, GUI.EspecParam.TamanioVentana = 1024;
    else, GUI.EspecParam.TamanioVentana = str2double(GUI.Const.TamVent{get(GUI.Espectro.pmTamaVen,'Value')}); end
    if get(GUI.Espectro.pmVentana ,'Value') == 1, GUI.EspecParam.Ventana = 3;
    else,  GUI.EspecParam.Ventana = get(GUI.Espectro.pmVentana ,'Value'); end
    GUI.EspecParam.Divisiones     = str2double(get(GUI.Espectro.edDivisiones,'String'));
    GUI.EspecParam.FrecMax        = GUI.Const.FrecMax{get(GUI.Espectro.pmFrecMax,'Value')-1};
    GUI.EspecParam.FrecMin        = GUI.Const.FrecMin{get(GUI.Espectro.pmFrecMin,'Value')+1};
    GUI.EspecParam.Overlaping     = str2double(get(GUI.Espectro.edOverlaping,'String'))/100;

    switch GUI.EspecParam.Ventana 
        case 1
            GUI.EspecParam.Vent = rectwin(GUI.EspecParam.Divisiones);      %ventana rectangular
        case 2
            GUI.EspecParam.Vent = hann(GUI.EspecParam.Divisiones);         % ventana hann
        case 3
            GUI.EspecParam.Vent = hamming(GUI.EspecParam.Divisiones);      % ventana hamming
        case 4
            GUI.EspecParam.Vent = blackman(GUI.EspecParam.Divisiones);     % ventana blackman
        case 5
            GUI.EspecParam.Vent = blackmanharris(GUI.EspecParam.Divisiones);% blackman harris
    end

    GUI.EspecParam.Ovlp  = GUI.EspecParam.Divisiones * GUI.EspecParam.Overlaping ;
    GUI.handles.controller.fETFMostrarEspectroResExitac(GUI);
end
function fbtETFRespImpuls(h,e) 
    if get(GUI.Espectro.pmTamaVen ,'Value') == 1, GUI.EspecParam.TamanioVentana = 1024;
    else, GUI.EspecParam.TamanioVentana = str2double(GUI.Const.TamVent{get(GUI.Espectro.pmTamaVen,'Value')}); end
    if get(GUI.Espectro.pmVentana ,'Value') == 1, GUI.EspecParam.Ventana = 3;
    else,  GUI.EspecParam.Ventana = get(GUI.Espectro.pmVentana ,'Value'); end
    GUI.EspecParam.Divisiones     = str2double(get(GUI.Espectro.edDivisiones,'String'));
    GUI.EspecParam.FrecMax        = GUI.Const.FrecMax{get(GUI.Espectro.pmFrecMax,'Value')-1};
    GUI.EspecParam.FrecMin        = GUI.Const.FrecMin{get(GUI.Espectro.pmFrecMin,'Value')+1};
    GUI.EspecParam.Overlaping     = str2double(get(GUI.Espectro.edOverlaping,'String'))/100;

    switch GUI.EspecParam.Ventana 
        case 1
            GUI.EspecParam.Vent = rectwin(GUI.EspecParam.Divisiones);      %ventana rectangular
        case 2
            GUI.EspecParam.Vent = hann(GUI.EspecParam.Divisiones);         % ventana hann
        case 3
            GUI.EspecParam.Vent = hamming(GUI.EspecParam.Divisiones);      % ventana hamming
        case 4
            GUI.EspecParam.Vent = blackman(GUI.EspecParam.Divisiones);     % ventana blackman
        case 5
            GUI.EspecParam.Vent = blackmanharris(GUI.EspecParam.Divisiones);% blackman harris
    end

    GUI.EspecParam.Ovlp  = GUI.EspecParam.Divisiones * GUI.EspecParam.Overlaping ;
    
    GUI.handles.controller.fETFMostrarRespuestaImpulsiva(GUI);
end
function fbtLogEsp(h,e)
    GUI.Espectro.axSenialTiem.YScale = 'log';
end
function fbtLinEsp(h,e)
    GUI.Espectro.axSenialTiem.YScale = 'linear';
end
%% ***********************************************************************%
%                          Funciones CEPTSRUM
%*******************------------------------------************************%
    function fbtCAnalisis(h,e)
        GUI.handles.controller.fCeptrumAnalisis(GUI);
    end
    function fbtCFSenialEx(h,e)
        GUI.handles.controller.fbtMostrarCeptrumExitacion(GUI);
    end
    function fbtCFRespueEx(h,e) 
        GUI.handles.controller.fbtMostrarCeptrumRespExita(GUI);
    end
    function fbtCFRespueIm(h,e) 
        GUI.handles.controller.fbtMostrarCeptrumRespImpul(GUI);
    end

%% ***********************************************************************%
%                           Funciones HHT
%*******************------------------------------************************%
    function fbtHHTAnalisis(h,e)
        GUI.handles.controller.fETFHHTAnalisis(GUI);
    end
    function fbtHHTFSenialEx(h,e)
        GUI.handles.controller.fbtMostrarHilbertExitacion(GUI);
    end
    function fbtHHTFRespueEx(h,e) 
        GUI.handles.controller.fbtMostrarHilbertRespExita(GUI);
    end
    function fbtHHTFRespueIm(h,e) 
    GUI.handles.controller.fbtMostrarHilbertRespImpul(GUI);
    
    end
    function fbtLogHHT(h,e)
        GUI.DomHilb.axEspecFrec.YScale = 'log';
    end
    function fbtLinHHT(h,e)
    	GUI.DomHilb.axEspecFrec.YScale = 'linear';
    end
%% ***********************************************************************%
%                        Funcion Calibracion
%*******************------------------------------************************%
    function fbtCalibracion(h,e)
        GUI.handles.controller.fCalibracionGUI(GUI);
    end

%% ***********************************************************************%
%                        Guardar Configuracion
%*******************------------------------------************************%
    function fbtGuardarConfg(h,e)
        GUI.handles.controller.fGuardarConfg(GUI);
    end

%% ***********************************************************************%
%                        Cargar Configuracion
%*******************------------------------------************************%

    function fbtCargarConfg()
        GUI.handles.controller.fCargarConfg(GUI);
    end
%% ***********************************************************************%
%                        Opcion de salir de SAMRI
%*******************------------------------------************************%
    function fSalir()
        Close(GUI.hFig);
    end
%% ***********************************************************************%
%                   Ir a pantalla de configuracion
%*******************------------------------------************************%
    function fConfiguracion(h,e)
        GUI.handles.controller.fConfiguracionGUI(GUI);
    end


end