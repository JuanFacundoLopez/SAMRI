clc
GUI = [];

        %Inicializa Archivos y Path necesarios
        %samdir_configuracion();
        
        % Inicializa Datos
        
GUI.TipoSenial = {'Barrido Senoidal Logaritmico'; 'Barrido Senoidal Cuadratico'; 'Barrido Senoidal Lineal'; 'Barrido Cosenoidal Logaritmico'; 'Barrido Cosenoidal Cuadratico'; 'Barrido Cosenoidal Lineal';};
GUI.DuracionSenial = {'0,6826'; '1,3653'; '2,7306'; '5,4613'; '10,9226';};
[ GUI.Entrada, GUI.Salida, GUI.EntSal, GUI.Muest, GUI.Objeto ] = ConsulDisp(); %Deberia ir en el controlador
GUI.ModoTiempo = {'Filtro 1/1 Octava', 'Filtro 1/3 Octava', 'Filtro 1/6 Octava', 'Filtro 1/12 Octava'};
GUI.ModoFrecue = {'Espectro', 'Filtro 1/1 Octava', 'Filtro 1/3 Octava', 'Filtro 1/6 Octava', 'Filtro 1/12 Octava'};
GUI.FFT.Str    = {'8192', '16384', '32768', '65536'};
GUI.FFT.Num    = [8129 16384 32768 65536]; 
GUI.Ventana    = {'Rectangular','Hanning','Blackman - Harris','Flat top'};
GUI.Filtros.Octava.Str = {'31.5 [Hz]','63','125','250','500','1000','2000','4000','8000','16000'};
GUI.Filtros.TerOct.Str = {'20 [Hz]','25 [Hz]','31.5 [Hz]','40 [Hz]','50 [Hz]','63 [Hz]','80','100','125','160','200','250','315','400','500','630','800','1000','1250','1600','2000','2500','3150','4000','5000','6300','8000','10000','12500','16000','20000'};
GUI.Filtros.SexOct.Str = {};
GUI.Filtros.DocOct.Str = {};
GUI.Resol = {'16'; '24';}; %

GUI.preferencias = [{['usuario' '@' datestr(now,'HH:MM:SS')]};...
                    {['tipo' ' ' [20 20000] ' ' '0,68' 'seg.']};...
                    {['tipoVentana' ' ' 'Hann']}; ...
                    {['Comentario: ' ' ' 'Temperatura: 27°C' ]};...
                    {['Equipo: ' ' ']};];
GUI.ColorFondo = [0.200000 0.580000 0.810000];

setappdata(0,'creacionPanel2', 0);
setappdata(0,'excitacion', 0);
setappdata(0,'ir_ext', 0);
rmappdata(0,'excitacion');
rmappdata(0,'ir_ext');
GUI.axTop2 = 0;
%         [GUI.ventanaConfiguracion GUI.ventanaAjuste] = samdir_preferencias();

try stop(timerfindall);    catch; end
try delete(timerfindall);  catch; end
%%
% Crea una figura nueva
GUI.hFig = findall(0, '-depth',1, 'type','figure', 'Name','Samdir');
if isempty(GUI.hFig)
    GUI.hFig = figure('Name','SAMRI', 'NumberTitle','off', 'Visible','off', 'Color','w', 'Position',[100,100,1500,900], 'Toolbar','none', 'Menu', 'none');
else
    clf(GUI.hFig);
    hc=findall(gcf); delete(hc(2:end));  % bypass javacomponent-clf bug on R2012b-R2013a
end
%%
set(GUI.hFig,'Visible','on') 
%% Agrego los uimenu FILE

GUI.menu(1) = uimenu(GUI.hFig,'Label','Archivo');                                                       %CREO EL MENU

GUI.subMenuArchivo(1) = uimenu(GUI.menu(1),'Label','Abrir','Accelerator','O');                          %CREO LOS SUBMENU
GUI.subMenuArchivo(2) = uimenu(GUI.menu(1),'Label','Guardar','Accelerator','S');                        %
GUI.subMenuArchivo(3) = uimenu(GUI.menu(1),'Label','Guardar como...');                                  %
GUI.subMenuArchivo(4) = uimenu(GUI.menu(1),'Label','Importar','Separator','on','Accelerator','I');      %
GUI.subMenuArchivo(5) = uimenu(GUI.menu(1),'Label','Exportar','Accelerator','E');                       %
GUI.subMenuArchivo(6) = uimenu(GUI.menu(1),'Label','Empty','Separator','on');                           %
GUI.subMenuArchivo(7) = uimenu(GUI.menu(1),'Label','Salir','Separator','on','Accelerator','Q');         %

% Agrego los uimenu HERRAMIENTAS       
GUI.menu(2) = uimenu(GUI.hFig,'Label','Herramientas');                                                  %CREO EL MENU

GUI.subMenuHerrami(1) = uimenu(GUI.menu(2),'Label','Ecualizador','Accelerator','W');                    %CREO LOS SUBMENU
GUI.subMenuHerrami(2) = uimenu(GUI.menu(2),'Label','Empty','Accelerator','R');                          %
GUI.subMenuHerrami(3) = uimenu(GUI.menu(2),'Label','Empty');                                            %

% Agrego los uimenu AYUDA
GUI.menu(3) = uimenu(GUI.hFig,'Label','Ayuda'); 
GUI.subMenuAyuda(1) = uimenu(GUI.menu(3),'Label','Ecualizador','Accelerator','W');                      %CREO LOS SUBMENU
GUI.subMenuAyuda(2) = uimenu(GUI.menu(3),'Label','Empty','Accelerator','R');                            %
GUI.subMenuAyuda(3) = uimenu(GUI.menu(3),'Label','Empty');  

% Agrego los uimenu DONACIONES
GUI.menu(4) = uimenu(GUI.hFig,'Label','Acerca de...');        
GUI.subMenuAyuda(1) = uimenu(GUI.menu(4),'Label','CINTRA');                                             %CREO LOS SUBMENU
GUI.subMenuAyuda(2) = uimenu(GUI.menu(4),'Label','SAMDA');                                              %
        
            
      %% establezco los tabs

GUI.hTabGroup = uitabgroup(GUI.hFig); 
GUI.tab(1) = uitab(GUI.hTabGroup, 'title','Señales');
GUI.tab(2) = uitab(GUI.hTabGroup, 'title','Dominio tiempo');
GUI.tab(3) = uitab(GUI.hTabGroup, 'title','Dominio frecuencia');
        

        %% agrego los separadores
GUI.panel(1) = uibuttongroup('Parent',GUI.tab(1),'Title','Señal de exitacion','FontSize',12,...   %señal de exitacion
                               'BackgroundColor','w','Position',[.01 .35 .52 .62]);
                           
GUI.panel(2) = uipanel('Parent',GUI.tab(1),'Title','E/S','FontSize',12,...                  %entradas salidas
                               'BackgroundColor','w','Position',[.54 .67 .45 .30]);        
                           
GUI.panel(3) = uipanel('Parent',GUI.tab(1),'Title','Informacion secundaria','FontSize',12,...%Info secundaria
                               'BackgroundColor','w','Position',[.54 .35 .45 .31]);          
        
                           %%Agrego las notas 
GUI.LabNotas = uicontrol(GUI.tab(1),'Style','text', 'Position', [0 0 300 200],...
                                'String','Notas', 'FontSize', 20);
                           
GUI.EditNotas = uicontrol(GUI.tab(1),'Style','edit', 'Position', [300 10 1190 280],'SliderStep',[0.01 0.10],...
                                'String',' ', 'FontSize', 10, 'HorizontalAlignment', 'Left');
                            
%% agrego objetos al panel 1
%Menu texto no modificable 
GUI.rbInterna = uicontrol(GUI.panel(1),'Style','radiobutton', 'Position', [20 475 80 30],'String','Interna',...
                            'FontSize', 12,'BackgroundColor','w','Value', 1,'Callback',{@fInterna,GUI});    %%{}
        
GUI.rbExterna = uicontrol(GUI.panel(1),'Style','radiobutton', 'Position', [420 475 80 30],'String','Externa',...
                            'FontSize', 12,'BackgroundColor','w');


GUI.LabTipo = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 400 100 30],...
                                'String','Tipo', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
        
GUI.LabDura = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 330 100 30],...
                                'String','Duracion', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
GUI.LabFreF = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 260 100 50],...
                                'String','Frecuencia final', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
GUI.LabFreI = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 190 100 50],...
                                'String','Frecuencia inicial', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
GUI.LabSile = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 120 100 30],...
                                'String','Silencio', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
GUI.LabRepe = uicontrol(GUI.panel(1),'Style','text', 'Position', [10 50 100 30],...
                                'String','Repeticion', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            

%Menu de entrada de datos
                            
GUI.pmTipo = uicontrol(GUI.panel(1),'Style','popupmenu', 'Position', [140 400 200 30],...
                        'String',GUI.TipoSenial, 'FontSize', 11,'BackgroundColor','w');


GUI.pmDura = uicontrol(GUI.panel(1),'Style','popupmenu', 'Position', [140 330 200 30],...
                        'String',GUI.DuracionSenial, 'FontSize', 13,'BackgroundColor','w');


GUI.edFreF = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 260 200 50],...
                        'String',' 20000 ', 'FontSize', 13,'BackgroundColor','w');


GUI.edFreI = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 190 200 50],...
                        'String',' 20 ', 'FontSize', 13,'BackgroundColor','w');


GUI.edSile = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 120 200 30],...
                        'String',' 1 ', 'FontSize', 13,'BackgroundColor','w');


GUI.edRepe = uicontrol(GUI.panel(1),'Style','edit', 'Position', [140 50 200 30],...
                        'String',' 0 ', 'FontSize', 13,'BackgroundColor','w'); 
       
%Menu de texto no modificable (unidades)
        
GUI.LabTipo = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 405 50 20],...
                        'String',' ', 'FontSize', 11,'BackgroundColor','w');

GUI.LabDura = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 335 50 20],...
                        'String','[ s ]', 'FontSize', 11,'BackgroundColor','w');

GUI.LabFreF = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 280 50 20],...
                        'String','[ Hz ]', 'FontSize', 11,'BackgroundColor','w');

GUI.LabFreI = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 205 50 20],...
                        'String','[ Hz ]', 'FontSize', 11,'BackgroundColor','w');

GUI.LabSile = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 125 50 20],...
                        'String','[ s ]', 'FontSize', 11,'BackgroundColor','w');

GUI.LabSile = uicontrol(GUI.panel(1),'Style','text', 'Position', [340 55 50 20],...
                        'String','[  ]', 'FontSize', 11,'BackgroundColor','w');

GUI.btBuscar =  uicontrol(GUI.panel(1),'Style','pushbutton', 'Position', [420 405 80 30],...
                        'String','Importar', 'FontSize', 10,'BackgroundColor','w',...
                        'FontWeight','bold', 'Enable', 'off');

GUI.LabPath = uicontrol(GUI.panel(1),'Style','text', 'Position', [510 405 230 30],...
                        'String','Path', 'FontSize', 8,'BackgroundColor','w',...
                        'ForegroundColor',[0.1 0.1 0.1]);

GUI.axVisua = axes;      
GUI.axVisua.Parent = GUI.panel(1);
GUI.axVisua.Position = [0.6 0.3 0.34 0.4];
GUI.axVisua.XAxisLocation = 'origin';
GUI.axVisua.YLim = [-1 1];
GUI.axVisua.Title.String = 'Señal previsualizada';
GUI.axVisua.Title.FontWeight = 'bold';
GUI.axVisua.XLabel.String = 'Tiempo [s]';
GUI.axVisua.YLabel.String = 'Amplitud normalizada';
        
        
        %% Agrego objetos al panel 2
        
GUI.LabEntr = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 200 100 30],...
                        'String','Entrada', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
        
GUI.LabSali = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 125 100 30],...
                        'String','Salida', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
GUI.LabReMu = uicontrol(GUI.panel(2),'Style','text', 'Position', [10 50 100 50],...
                        'String','Resolucion / Muestreo', 'FontSize', 13,'BackgroundColor','w','FontWeight','bold');
                            
       
GUI.pmEntr = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 200 480 30],...
                       'String', GUI.Entrada, 'FontSize', 13,'BackgroundColor','w');
        
        
GUI.pmSali = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 130 480 30],...
                       'String', GUI.Salida, 'FontSize', 13,'BackgroundColor','w');
         
                            
 GUI.pmReso = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [140 70 220 30],...
                       'String',GUI.Resol, 'FontSize', 13,'BackgroundColor','w');
        
        
 GUI.pmMues = uicontrol(GUI.panel(2),'Style','popupmenu', 'Position', [400 70 220 30],...
                       'String',GUI.Muest, 'FontSize', 13,'BackgroundColor','w');
                            
%% Agrego objetos al tercer panel

GUI.LabEntr = uicontrol(GUI.panel(3),'Style','text', 'Position', [10 200 50 20],...
                        'String','TARS', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold');
        
GUI.LabSali = uicontrol(GUI.panel(3),'Style','text', 'Position', [10 145 90 40],...
                        'String','Frecuencia de muestreo', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold');
                            
GUI.LabReMu = uicontrol(GUI.panel(3),'Style','text', 'Position', [10 100 80 20],...
                        'String','Resolución', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold');

GUI.LabReMu = uicontrol(GUI.panel(3),'Style','text', 'Position', [10 50 80 20],...
                        'String','Latencia', 'FontSize', 10,'BackgroundColor','w','FontWeight','bold');

GUI.LabReMu = uicontrol(GUI.panel(3),'Style','text', 'Position', [150 200 500 20],...
                        'String','Agregar Descripcion', 'FontSize', 10,'BackgroundColor','w','FontWeight','normal');                    

GUI.LabReMu = uicontrol(GUI.panel(3),'Style','text', 'Position', [150 145 500 35],...
                        'String','Agregar Descripcion', 'FontSize', 10,'BackgroundColor','w','FontWeight','normal');  

GUI.LabReMu = uicontrol(GUI.panel(3),'Style','text', 'Position', [150 100 500 20],...
                        'String','Agregar Descripcion', 'FontSize', 10,'BackgroundColor','w','FontWeight','normal');                    

GUI.LabReMu = uicontrol(GUI.panel(3),'Style','text', 'Position', [150 50 500 20],...
                        'String','Agregar Descripcion', 'FontSize', 10,'BackgroundColor','w','FontWeight','normal');    
                    
%% Agrego objetos al segundo tab "dominio en el timpo"

% Agrego grafico

GUI.DomTiemp.axSenialTiem = axes;      
GUI.DomTiemp.axSenialTiem.Parent = GUI.tab(2);
GUI.DomTiemp.axSenialTiem.Position = [0.02 0.03 0.7 0.95];
GUI.DomTiemp.axSenialTiem.XAxisLocation = 'origin';
GUI.DomTiemp.axSenialTiem.YLim = [-1 1];


%Agrego un panel y objetos a ese panel

GUI.DomTiemp.panelTiemp(1) = uipanel('Parent',GUI.tab(2),'Title','Señales','FontSize',12,...                 %señal de exitacion
                               'BackgroundColor','w','Position',[.725 .03 .13 .95]);
                           
GUI.DomTiemp.cbCompara = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','checkbox', 'Position', [10 765 170 25],...
                                'String','Comparar', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold');                          
                           
 
GUI.DomTiemp.btIndividu = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 720 170 25],...
                                'String','Individualmente', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold');


GUI.DomTiemp.btSenialEx = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 640 170 60],...
                                'String','Señal de exitación', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold');


GUI.DomTiemp.btRespueEx = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 540 170 60],...
                                'String','Respuesta a la exitación', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold');


GUI.DomTiemp.btFiltrInv = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 440 170 60],...
                                'String','Filtro Inverso', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold');


GUI.btRespImpu = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 340 170 60],...
                                'String','Respuesta Impulsiva', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold');


GUI.btCurvEnTi = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 240 170 60],...
                                'String','ETC', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold');
                            
GUI.btRespImpu = uicontrol(GUI.DomTiemp.panelTiemp(1),'Style','pushbutton', 'Position', [10 140 170 60],...
                                'String','ETCI', 'FontSize', 10,'BackgroundColor','w',...
                                'FontWeight','bold');

%% Agregamos objetos al panel de filtros

                           
GUI.DomTiemp.panelTiemp(2) = uipanel('Parent',GUI.tab(2),'Title','Filtros','FontSize',12,...                     %entradas salidas
                               'BackgroundColor','w','Position',[.863 .53 .13 .45]);    

 

GUI.DomTiemp.btVentTiemp = uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','pushbutton', 'Position', [10 320 170 25],...
                                'String','Ventana de tiempo', 'FontSize', 10,'BackgroundColor','w', 'FontWeight','bold');
                            
uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','text', 'Position', [5 277 57 20],...
                        'String','Modo:', 'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');                            

GUI.DomTiemp.pmModo = uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','popupmenu', 'Position', [65 240 120 60],...
                                'String', GUI.ModoTiempo, 'FontSize', 10,'BackgroundColor','w');

uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','text', 'Position', [5 227 57 20],...
                        'String','Frec:', 'FontSize', 10,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');  
                            
GUI.DomTiemp.pmFrec = uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','popupmenu', 'Position', [65 190 120 60],...
                                'String', GUI.Filtros.TerOct.Str, 'FontSize', 10,'BackgroundColor','w');

uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','text', 'Position', [5 177 57 20],...
                        'String','Ventana:', 'FontSize', 8,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');
                    
GUI.DomTiemp.pmTipo = uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','popupmenu', 'Position', [65 140 120 60],...
                                'String', GUI.Ventana, 'FontSize', 10,'BackgroundColor','w');
 
uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','text', 'Position', [5 127 57 20],...
                        'String','Longitud:', 'FontSize', 8,'BackgroundColor','w','FontWeight','normal','FontWeight','bold');
                    
GUI.DomTiemp.pmLong = uicontrol(GUI.DomTiemp.panelTiemp(2),'Style','popupmenu', 'Position', [65 90 120 60],...
                                'String', GUI.FFT.Str, 'FontSize', 10,'BackgroundColor','w');
                            
                           
%% Cargo objetos en el panel de visualizacion en la ventana del dominio 
                            
GUI.DomTiemp.panelTiemp(3) = uipanel('Parent',GUI.tab(2),'Title','Visualización','FontSize',12,...                     %entradas salidas
                               'BackgroundColor','w','Position',[.863 .03 .13 .48]); 
                           
GUI.DomTiemp.btVentTiemp = uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','pushbutton', 'Position', [10 315 80 80],...
                                'String',' + 10% ', 'FontSize', 15,'BackgroundColor','w', 'FontWeight','bold');                           
                           
GUI.DomTiemp.btVentTiemp = uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','pushbutton', 'Position', [100 315 80 80],...
                                'String',' - 10% ', 'FontSize', 15,'BackgroundColor','w', 'FontWeight','bold');       
                            
GUI.DomTiemp.btVentTiemp = uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','pushbutton', 'Position', [10 220 170 80],...
                                'String',' 100% ', 'FontSize', 15,'BackgroundColor','w', 'FontWeight','bold');
                            

uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','text', 'Position', [5 180 57 20],'String','X max:', 'FontSize', 10,...
                                'BackgroundColor','w','FontWeight','normal','FontWeight','bold');  
                
uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','text', 'Position', [5 150 57 20],'String','X min:', 'FontSize', 10,...
                                'BackgroundColor','w','FontWeight','normal','FontWeight','bold');                  
                
uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','text', 'Position', [5 120 57 20],'String','Y max:', 'FontSize', 10,...
                                'BackgroundColor','w','FontWeight','normal','FontWeight','bold');                  
                
uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','text', 'Position', [5 90 57 20],'String','Y min:', 'FontSize', 10,...
                                'BackgroundColor','w','FontWeight','normal','FontWeight','bold');     
                            
                            
GUI.DomTiemp.edXmax = uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','edit', 'Position', [80 180 50 30],...
                                'String',' 0 ', 'FontSize', 13,'BackgroundColor','w'); 
                            
GUI.DomTiemp.edXmin = uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','edit', 'Position', [80 150 50 30],...
                                'String',' 0 ', 'FontSize', 13,'BackgroundColor','w'); 
                            
GUI.DomTiemp.edYmax = uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','edit', 'Position', [80 120 50 30],...
                                'String',' 0 ', 'FontSize', 13,'BackgroundColor','w');                             
                            
GUI.DomTiemp.edYmin = uicontrol(GUI.DomTiemp.panelTiemp(3),'Style','edit', 'Position', [80 90 50 30],...
                                'String',' 0 ', 'FontSize', 13,'BackgroundColor','w');  
                            
                            
%Defino callbacks

set(GUI.rbExterna,'Callback',{@fExterna,GUI}); %Funcion que habilita el boton de importar y deshabilita el resto de opciones de importar
set(GUI.rbInterna,'Callback',{@fInterna,GUI}); %Funcion que deshabilita el boton de importar y habilita el resto de uicontrols
set(GUI.btBuscar,'Callback',{@fImportarsenial,GUI});


% set(GUI.rbInterna,'Callback',{@fInterna,GUI});
% set(GUI.rbExterna,'Callback',{@fExterna,GUI});
% set(GUI.rbInterna,'Callback',{@fInterna,GUI});
% set(GUI.rbExterna,'Callback',{@fExterna,GUI});
% set(GUI.rbInterna,'Callback',{@fInterna,GUI});
% set(GUI.rbExterna,'Callback',{@fExterna,GUI});
% set(GUI.rbInterna,'Callback',{@fInterna,GUI});
% set(GUI.rbExterna,'Callback',{@fExterna,GUI});
% set(GUI.rbInterna,'Callback',{@fInterna,GUI});




