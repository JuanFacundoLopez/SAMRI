function samriConfigEspectroGUI(Modelo)

% ConfE.Const.Ventana = {'Rectangular';'Hanning';'Hamming';'Blackman';'Blackman-Harris';};
% ConfE.Const.TamVent = {'256';'512';'1024';'2048';'4096';'8192';'16384';'32768';'65536';};
% ConfE.Const.FrecMax = {'31.5','63','125','250','500','1000','2000','4000','8000','16000','Maxima'};
% ConfE.Const.FrecMin = {'Minima','31.5','63','125','250','500','1000','2000','4000','8000','16000','Maxima'};
% ConfE.Const.Seniale = {'Señal de exitacion','Respuesta a la exitacion','Filtro inverso','Respuesta impulsiva'};
% 

% Crea una figura nueva

ConfE.hFig = figure('Name','Configuracion de espectrograma',...
                    'NumberTitle','off',...
                    'Visible','on',...
                    'Color','w',...
                    'Position',[300,350,750,450],...
                    'Toolbar','none',...
                    'Menu', 'none');

%% Agrego los uimenu FILE

ConfE.menu(1) = uimenu(ConfE.hFig,'Label','Archivo');                                                       %CREO EL MENU

ConfE.subMenuArchivo(1) = uimenu(ConfE.menu(1),'Label','Abrir','Accelerator','O');                          %CREO LOS SUBMENU
ConfE.subMenuArchivo(2) = uimenu(ConfE.menu(1),'Label','Guardar','Accelerator','S');                        %
ConfE.subMenuArchivo(3) = uimenu(ConfE.menu(1),'Label','Guardar como...');                                  %
ConfE.subMenuArchivo(4) = uimenu(ConfE.menu(1),'Label','Cerrar');  

% Agrego los uimenu HERRAMIENTAS       
ConfE.menu(2) = uimenu(ConfE.hFig,'Label','Herramientas');                                                  %CREO EL MENU

ConfE.subMenuHerrami(1) = uimenu(ConfE.menu(2),'Label','Aplicar filtros','Accelerator','F');                    %CREO LOS SUBMENU

%% %%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE VENTANAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ConfE.panel(1)  = uipanel(  'Parent', ConfE.hFig, 'Title','Ventana', 'FontSize',12,...                  %entradas salidas
%                             'BackgroundColor','w','Position',[.02 .63 .47 .33]);        
% 
% uicontrol(ConfE.panel(1),'Style','text','Position', [30 33 100 40],...
%                          'String','Tamaño de la ventana FFT', 'FontSize', 11,'BackgroundColor',...
%                          'w','FontWeight','bold');
%         
% ConfE.pmTamaVen = uicontrol(ConfE.panel(1),'Style','popupmenu', 'Position', [155 40 180 25],...
%                                 'String',ConfE.Const.TamVent, 'FontSize', 11,'BackgroundColor','w',...
%                                 'Value', 1);
%                             
% uicontrol(ConfE.panel(1),'Style','text','Position', [30 73 100 40],...
%                          'String','Ventana', 'FontSize', 13,'BackgroundColor',...
%                          'w','FontWeight','bold');
%                      
% ConfE.pmVentana = uicontrol(ConfE.panel(1),'Style','popupmenu', 'Position', [155 89 180 25],...
%                                 'String',ConfE.Const.Ventana, 'FontSize', 11,'BackgroundColor','w',...
%                                 'Value', 1);    
                            
                              
%% %%%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE TIEMPO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ConfE.panel(2) = uipanel('Parent', ConfE.hFig,'Title','Tiempo', 'FontSize',12,...%Info secundaria
%                                'BackgroundColor','w','Position',[.52 .63 .47 .33]); 
%                              
% uicontrol(ConfE.panel(2),'Style','text','Position', [30 73 100 40],...
%                          'String','Divisiones', 'FontSize', 13,'BackgroundColor',...
%                          'w','FontWeight','bold');
%                      
% ConfE.edDivisiones = uicontrol(ConfE.panel(2),'Style','edit', 'Position', [140 90 130 25],...
%                                 'FontSize', 11,'BackgroundColor','w','String', '500');    
%                             
% uicontrol(ConfE.panel(2),'Style','text','Position', [30 33 100 40],...
%                          'String','Overlaping', 'FontSize', 13,'BackgroundColor',...
%                          'w','FontWeight','bold');
%                      
% ConfE.edOverlaping = uicontrol(ConfE.panel(2),'Style','edit', 'Position', [140 50 100 25],...
%                                 'FontSize', 11,'BackgroundColor','w','String', '50');   
%                             
% uicontrol(ConfE.panel(2),'Style','text','Position', [245 50 30 25],...
%                          'String','[%]', 'FontSize', 11,'BackgroundColor',...
%                          'w','FontWeight','bold');                                                                              
%% %%%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE TIPO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ConfE.panel(3)  = uibuttongroup(  'Parent', ConfE.hFig, 'Title','Tipo', 'FontSize',12,...                  %entradas salidas
%                             'BackgroundColor','w','Position',[.02 .28 .47 .33]);     
% 
% ConfE.rb2D = uicontrol(ConfE.panel(3) ,'Style','radiobutton', 'Position', [25 65 160 30],...
%                             'String','Espectrograma 2D', 'FontSize', 12,'BackgroundColor','w','Value',1);  
%         
% ConfE.rb3D = uicontrol(ConfE.panel(3) ,'Style','radiobutton', 'Position', [190 65 160 30],...
%                             'String','Espectrograma 3D', 'FontSize', 12,'BackgroundColor','w');

%% %%%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE FRECUENCIA %%%%%%%%%%%%%%%%%%%%%%%%%
% ConfE.panel(4)  = uibuttongroup(  'Parent', ConfE.hFig, 'Title','Frecuencia', 'FontSize',12,...                  %entradas salidas
%                             'BackgroundColor','w','Position',[.52 .28 .5 .33]);  
%                         
% uicontrol(ConfE.panel(4),'Style','text','Position', [20 53 120 25],...
%                          'String','Frecuencia min.', 'FontSize', 11,'BackgroundColor',...
%                          'w','FontWeight','bold');
%         
% ConfE.pmFrecMin = uicontrol(ConfE.panel(4),'Style','popupmenu', 'Position', [155 60 180 25],...
%                                 'String',ConfE.Const.FrecMin, 'FontSize', 11,'BackgroundColor','w',...
%                                 'Value', 1);
%                             
% uicontrol(ConfE.panel(4),'Style','text','Position', [20 93 120 25],...
%                          'String','Frecuencia max.', 'FontSize', 11,'BackgroundColor',...
%                          'w','FontWeight','bold');
%                      
% ConfE.pmFrecMax = uicontrol(ConfE.panel(4),'Style','popupmenu', 'Position', [155 99 180 25],...
%                                 'String',ConfE.Const.FrecMax, 'FontSize', 11,'BackgroundColor','w',...
%                                 'Value', 11);    
%                             
% ConfE.rbLineal = uicontrol(ConfE.panel(4) ,'Style','radiobutton', 'Position', [50 15 110 30],...
%                             'String','Lineal', 'FontSize', 12,'BackgroundColor','w','Value',1);  
%         
% ConfE.rbLogaritmica = uicontrol(ConfE.panel(4) ,'Style','radiobutton', 'Position', [180 15 120 30],...
%                             'String','Logaritmico', 'FontSize', 12,'BackgroundColor','w');                         
%                    
%% %%%%%%%%%%%%%%%%%%%%%%%%%% SEÑALES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                        
% ConfE.panel(5)  = uibuttongroup(  'Parent', ConfE.hFig, 'Title','Señal', 'FontSize',12,...                  %entradas salidas
%                             'BackgroundColor','w','Position',[.02 .02 .47 .23]);  
% 
% ConfE.pmDatos = uicontrol(ConfE.panel(5),'Style','popupmenu', 'Position', [20 40 300 25],...
%                                 'FontSize', 12,'BackgroundColor','w','String', ConfE.Const.Seniale);  



%% %%%%%%%%%%%%%%%%%%%%%%%%%% BOTONERA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ConfE.Aplicar   = uicontrol(ConfE.hFig,'Style','pushbutton', 'Position', [450 20 90 35],...
%                                 'String','Aplicar', 'FontSize', 13,'BackgroundColor','w',...
%                                 'FontWeight','bold','Callback',@(h,e)fbtAplicar);
% ConfE.Cancelar  = uicontrol(ConfE.hFig,'Style','pushbutton', 'Position', [550 20 90 35],...
%                                 'String','Cancelar', 'FontSize', 13,'BackgroundColor','w',...
%                                 'FontWeight','bold','Callback',@(h,e)fbtCancelar);
% ConfE.Ayuda     = uicontrol(ConfE.hFig,'Style','pushbutton', 'Position', [650 20 90 35],...
%                                 'String','Ayuda', 'FontSize', 13,'BackgroundColor','w',...
%                                 'FontWeight','bold','Callback',@(h,e)fbtAyuda);
                       
function fbtAplicar(h,e)
% Parametros =[];
% Parametros.TamanioVentana = str2double(ConfE.Const.TamVent{get(ConfE.pmTamaVen,'Value')}); 
% Parametros.Ventana        = get(ConfE.pmVentana ,'Value');
% Parametros.Divisiones     = str2double(get(ConfE.edDivisiones,'String'));
% Parametros.Dimension      = get(ConfE.rb2D,'Value');
% Parametros.Escala         = get(ConfE.rbLineal,'Value');
% Parametros.FrecMax        = ConfE.Const.FrecMax{get(ConfE.pmFrecMax,'Value')};
% Parametros.FrecMin        = ConfE.Const.FrecMin{get(ConfE.pmFrecMin,'Value')};
% Parametros.Datos          = get(ConfE.pmDatos,'Value');
% Parametros.Overlaping     = str2double(get(ConfE.edOverlaping,'String'))/100;

   fs = 44100; 

% switch Parametros.Datos 
%     case 1
%         y = Modelo.getSenialExcitacion; 
%     case 2
%         y = Modelo.getRespuestaExcitacion;
%     case 3
% %         y = Modelo.getFiltroInverso;
%     case 4
%         y = Modelo.getRespuestaImpulsiva;
% end

% switch Parametros.Ventana 
%     case 1
%         Vent = rectwin(Parametros.Divisiones); %ventana rectangular
%     case 2
%         Vent = hann(Parametros.Divisiones); % ventana hann
%     case 3
%         Vent = hamming(Parametros.Divisiones);% ventana hamming
%     case 4
%         Vent = blackman(Parametros.Divisiones);% ventana blackman
%     case 5
%         Vent = blackmanharris(Parametros.Divisiones);% blackman harris
% end

Overlaping = Parametros.Divisiones * Parametros.Overlaping ;

ConfE.hFigEspectrog = figure('Name','Espectrograma',...
                                'NumberTitle','off',...
                                'Visible','on',...
                                'Color','w',...
                                'Position',[300,350,850,450],...
                                'Toolbar','figure');
                % la ventana tiene que ser siempre mas grande que el
                % overlaping
if Parametros.Dimension % si es 2D

    spectrogram(y.timeData,Vent,Overlaping,Parametros.TamanioVentana,fs,'yaxis')
    
    colormap bone
    title('Espectrograma 2D')
    xlabel('Tiempo [ms]')
    ylabel('Frecuencia [Hz]')

end
if Parametros.Dimension == 0% si es 3D

    spectrogram(y.timeData,Vent,Overlaping ,Parametros.TamanioVentana,fs,'yaxis')% señal,ventana,divisiones,nfft,fs
    
    view(-45,65)
    colormap bone
    title('Espectrograma 3D')
    xlabel('Tiempo [ms]')
    ylabel('Frecuencia [Hz]')

end



close(ConfE.hFig);
end

function fbtCancelar(h,e)

    close(ConfE.hFig);
end                        

function fbtAyuda(h,e)


end                             
                            
                     
end