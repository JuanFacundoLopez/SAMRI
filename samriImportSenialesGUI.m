function samriImportSenialesGUI(Modelo)

%Variables globales

SenExPath = [];
ResExPath = [];
ResImPath = [];

% Crea una figura nueva

ImportGUI.hFig = figure('Name','Importar señales...',...
                    'NumberTitle','off',...
                    'Visible','on',...
                    'Color','w',...
                    'Position',[300,350,750,450],...
                    'Toolbar','none',...
                    'Menu', 'none');

%% %%%%%%%%%%%%%%%%%%%%%%%%% PANEL DE VENTANAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
ImportGUI.panel(1)  = uipanel(  'Parent', ImportGUI.hFig, 'Title','¿Que señales desea importar?', 'FontSize',14,...           % Entradas salidas
                            'BackgroundColor','w','Position',[.01 .01 .98 .99]);        

ImportGUI.edSE    = uicontrol(ImportGUI.panel(1),'Style','text',            'Position', [280 353 420 30],...
                                'String',' Path ','HorizontalAlignment','left',...
                                'FontSize', 11,'BackgroundColor','w');
        
ImportGUI.SenExit = uicontrol(ImportGUI.panel(1),'Style','pushbutton',      'Position', [10 350 250 50],... % IMPORTO SEÑAL DE EXITACION
                                'String','Importar Señal de exitacion',...
                                'FontSize', 11,'BackgroundColor','w',...
                                'Callback',@(h,e)ImportSE);
                            
ImportGUI.edRE    = uicontrol(ImportGUI.panel(1),'Style','text',            'Position', [280 253 420 30],...
                                'String',' Path ','HorizontalAlignment','left',...
                                'FontSize', 11, 'BackgroundColor','w');
                     
ImportGUI.ResExit = uicontrol(ImportGUI.panel(1),'Style','pushbutton',      'Position', [10 250 250 50],...% IMPORTO RESPUESTA A LA EXITACION
                                'String','Importar Respuesta a la exitacion',...
                                'FontSize', 11,'BackgroundColor','w',...
                                'Callback',@(h,e)ImportRE);    

ImportGUI.edRI    = uicontrol(ImportGUI.panel(1),'Style','text',            'Position', [280 153 420 30],...
                                'String','Path','HorizontalAlignment','left',...
                                'FontSize', 11,'BackgroundColor','w');
        
ImportGUI.ResImp  = uicontrol(ImportGUI.panel(1),'Style','pushbutton',      'Position', [10 150 250 50],...% IMPORTO RESPUESTA IMPULSIVA
                                'String','Importar Respuesta impulsiva ',...
                                'FontSize', 11,'BackgroundColor','w',...
                                'Callback',@(h,e)ImportRI);
                            
ImportGUI.AplImp  = uicontrol(ImportGUI.panel(1),'Style','pushbutton',      'Position', [400 10 150 30],...% IMPORTO RESPUESTA IMPULSIVA
                                'String','Aplicar',...
                                'FontSize', 11,'BackgroundColor','w',...
                                'Callback',@(h,e)ImportAP);
ImportGUI.CanImp  = uicontrol(ImportGUI.panel(1),'Style','pushbutton',      'Position', [575 10 150 30],...% IMPORTO RESPUESTA IMPULSIVA
                                'String','Cancelar ',...
                                'FontSize', 11,'BackgroundColor','w',...
                                'Callback',@(h,e)ImportCA);
                            
%% -------------------------------- Funciones ------------------------------
                       
function ImportSE(h,e)
    [file, path]= uigetfile('*wav;*.mp3','Importar señal de exitacion...');
    if file ~= 0 
        set(ImportGUI.edSE ,'String',[path,file]);
        SenExPath = [path,file];
    end
end

function ImportRE(h,e)
    [file, path]= uigetfile('*wav;*.mp3','Importar respuesta de exitacion...');
    if file ~= 0 
        set(ImportGUI.edRE ,'String',[path,file]);
        ResExPath = [path,file];
    end
end                        

function ImportRI(h,e)
    [file, path]= uigetfile('*wav;*.mp3','Importar respuesta impulsiva...');
    if file ~= 0 
        set(ImportGUI.edRI ,'String',[path,file]);
        ResImPath = [path,file];
    end
end                             

function ImportAP(h,e)
    ObjAudio = samriAudio;
    
    if isempty(SenExPath) == 0
        [ObjAudio.timeData,ObjAudio.samplingRate] = audioread(SenExPath);
        Modelo.setSenialExcitacion(ObjAudio);
    end
    
    if isempty(ResExPath) == 0
        [ObjAudio.timeData,ObjAudio.samplingRate] = audioread(ResExPath);
        Modelo.setRespuestaExcitacion(ObjAudio);
    end
    
    if isempty(ResImPath) == 0
        [ObjAudio.timeData,ObjAudio.samplingRate] = audioread(ResImPath);
        Modelo.setRespuestaImpulsiva(ObjAudio);
    end
    
    close(ImportGUI.hFig);
end   

function ImportCA(h,e)
    close(ImportGUI.hFig);
    
end   
                     
end