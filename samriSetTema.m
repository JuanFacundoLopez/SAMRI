function samriSetTema(GUI,CONF)
BGC = [];
FGC = [];

BGC.Claro  = [1,1,1];          % Color de fondo del objeto claro
BGC.Oscuro = [9,7,37]./255;    % Color de fondo del objeto oscuro
FGC.Claro  = [0,0,0];          % Color de la letra del objeto claro
FGC.Oscuro = [1,1,1];          % Color de la letra del objeto oscuro


if CONF.claro == 1 && CONF.oscuro == 0
    BGC.Tema = BGC.Claro; 
    FGC.Tema = FGC.Claro; 
end

if CONF.claro == 0 && CONF.oscuro == 1
    BGC.Tema = BGC.Oscuro;
    FGC.Tema = FGC.Oscuro;
end

set(GUI.tab(1:6),'BackgroundColor', BGC.Tema)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Panel de medicion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%Agrego los separadores
set(GUI.panel(1), 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.panel(2), 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);  
set(GUI.panel(4), 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);                                   

                           %% Agrego las notas
                           
set(GUI.config.txUsuario,   'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.config.txEquipo,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.config.txComenta,   'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.config.editUsuario, 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.config.editEquipos, 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);    
set(GUI.config.editComenta, 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.config.btGuard,     'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.config.btCarga,     'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
                    
%% agrego objetos al panel 1
%Menu texto no modificable 
set(GUI.rbInterna,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.rbExterna,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.config.btMedir, 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);                                  
set(GUI.config.txTipo,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.config.txDura,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);    
set(GUI.config.txTono,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.config.txFreF,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.config.txFreI,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.config.txSile,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);            
set(GUI.config.txRepe,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);    
set(GUI.config.txVolu,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.pmTipo,         'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.edDura,         'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);     
set(GUI.edFrec,         'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);          
set(GUI.edFreF,         'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);          
set(GUI.edFreI,         'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);          
set(GUI.edSile,         'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);          
set(GUI.edRepe,         'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.edVolu,         'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
                    
                    %% %Menu de texto no modificable (unidades)
set(GUI.axVisua,      'Color', BGC.Tema); 
        
set(GUI.txLabel(1:17),'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.LabPath,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);      
set(GUI.btImpor,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.btPlay,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.pmConA,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);          
set(GUI.pmNLat,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);          
set(GUI.pmSerA,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);         
set(GUI.pmNCha,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.pmEntr,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);        
set(GUI.pmSali,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);                 
set(GUI.pmReso,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.pmMues,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);        
set(GUI.btActu,       'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                Agrego objetos a "Dominio en el timpo"             %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agrego grafico

set(GUI.DomTiemp.axSenialTiem, 'Color', BGC.Tema); 
set(GUI.DomTiemp.btRepro,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomTiemp.btRepet,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);                                
%Agrego un panel y objetos al panel de señales en el dominio del tiempo

set(GUI.DomTiemp.panelTiemp(1), 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);                     
set(GUI.DomTiemp.btAnalisis,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomTiemp.btSenialEx,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomTiemp.btRespueEx,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomTiemp.btFiltrInv,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomTiemp.btRespImpu,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomTiemp.btCurvEnTi,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);  
set(GUI.DomTiemp.btCurvaETI,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ************************************** DOMINIO DE LA FRECUENCIA*********************************************** %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                            
            %% Creacion de los objetos en el dominio de la frecuencia

% Agrego grafico

set(GUI.DomFrec.axEspecFrec, 'Color', BGC.Tema); 

                %% Creacion del panel de señales en el dominio de la frecuencia

set(GUI.DomFrec.panelSeniales(1),'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomFrec.btAnalisis,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomFrec.btSenialEx,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomFrec.btRespueEx,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomFrec.PSDSenExit,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomFrec.PSDResExit,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);     
set(GUI.DomFrec.btLogaritm,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomFrec.btLineal,        'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%********************Agrego objetos ETF Fourier ****************************************%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(GUI.Espectro.axSenialTiem, 'Color', BGC.Tema);    
                                                     
%Agrego un panel y objetos al panel de señales en el dominio del tiempo

set(GUI.Espectro.panelTiemp(1), 'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);                  
set(GUI.Espectro.btAnalisis,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.Espectro.btSenialEx,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.Espectro.btRespueEx,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.Espectro.btRespImpu,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.Espectro.pmTamaVen,     'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);    
set(GUI.Espectro.pmVentana,     'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);     
set(GUI.Espectro.edDivisiones,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);                   
set(GUI.Espectro.edOverlaping,  'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.Espectro.pmFrecMin,     'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);  
set(GUI.Espectro.pmFrecMax,     'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.Espectro.btLogaritm,    'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.Espectro.btLineal,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%% ETF - Mediante transformada Hilbert - Huang %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agrego grafico

set(GUI.DomHilb.axEspecFrec,'Color', BGC.Tema);
                %% Creacion del panel para ETF - HHT

set(GUI.DomHilb.panelSeniales(1),'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomHilb.btAnalisis,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomHilb.btSenialEx,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomHilb.btRespueEx,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomHilb.btResImpul,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 
set(GUI.DomHilb.btLogaritm,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomHilb.btLineal,        'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%********************Dominio CEPTRAL************************************%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agrego grafico

set(GUI.DomCept.axEspecFrec,     'Color', BGC.Tema);
set(GUI.DomCept.panelSeniales(1),'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomCept.btAnalisis,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomCept.btSenialEx,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomCept.btRespueEx,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema);
set(GUI.DomCept.btResImpul,      'ForegroundColor', FGC.Tema, 'BackgroundColor', BGC.Tema); 

% titulo
GUI.axVisua.Title.Color                 = FGC.Tema;
GUI.DomCept.axEspecFrec.Title.Color     = FGC.Tema;
GUI.DomHilb.axEspecFrec.Title.Color     = FGC.Tema;
GUI.Espectro.axSenialTiem.Title.Color   = FGC.Tema;
GUI.DomFrec.axEspecFrec.Title.Color     = FGC.Tema;
GUI.DomTiemp.axSenialTiem.Title.Color   = FGC.Tema;

% Xlabel
GUI.axVisua.XLabel.Color     = FGC.Tema;
GUI.DomCept.axEspecFrec.XLabel.Color     = FGC.Tema;
GUI.DomHilb.axEspecFrec.XLabel.Color     = FGC.Tema;
GUI.Espectro.axSenialTiem.XLabel.Color   = FGC.Tema;
GUI.DomFrec.axEspecFrec.XLabel.Color     = FGC.Tema;
GUI.DomTiemp.axSenialTiem.XLabel.Color   = FGC.Tema;

%ylabel
GUI.axVisua.YLabel.Color     = FGC.Tema;
GUI.DomCept.axEspecFrec.YLabel.Color     = FGC.Tema;
GUI.DomHilb.axEspecFrec.YLabel.Color     = FGC.Tema;
GUI.Espectro.axSenialTiem.YLabel.Color   = FGC.Tema;
GUI.DomFrec.axEspecFrec.YLabel.Color     = FGC.Tema;
GUI.DomTiemp.axSenialTiem.YLabel.Color   = FGC.Tema;

%zlabel
GUI.DomHilb.axEspecFrec.ZLabel.Color     = FGC.Tema;
GUI.Espectro.axSenialTiem.ZLabel.Color   = FGC.Tema;

%gridcolor
GUI.axVisua.GridColor     = FGC.Tema;
GUI.DomCept.axEspecFrec.GridColor     = FGC.Tema;
GUI.DomHilb.axEspecFrec.GridColor     = FGC.Tema;
GUI.Espectro.axSenialTiem.GridColor   = FGC.Tema;
GUI.DomFrec.axEspecFrec.GridColor     = FGC.Tema;
GUI.DomTiemp.axSenialTiem.GridColor   = FGC.Tema;

%xaxis
GUI.axVisua.XAxis.Color     = FGC.Tema;
GUI.DomHilb.axEspecFrec.XAxis.Color     = FGC.Tema;
GUI.DomCept.axEspecFrec.XAxis.Color     = FGC.Tema;
GUI.DomHilb.axEspecFrec.XAxis.Color     = FGC.Tema;
GUI.Espectro.axSenialTiem.XAxis.Color   = FGC.Tema;
GUI.DomFrec.axEspecFrec.XAxis.Color     = FGC.Tema;
GUI.DomTiemp.axSenialTiem.XAxis.Color   = FGC.Tema;


%yaxis
GUI.axVisua.YAxis.Color     = FGC.Tema;
GUI.DomCept.axEspecFrec.YAxis.Color     = FGC.Tema;
GUI.DomHilb.axEspecFrec.YAxis.Color     = FGC.Tema;
GUI.Espectro.axSenialTiem.YAxis.Color   = FGC.Tema;
GUI.DomFrec.axEspecFrec.YAxis.Color     = FGC.Tema;
GUI.DomTiemp.axSenialTiem.YAxis.Color   = FGC.Tema;

%zaxis
GUI.DomHilb.axEspecFrec.ZAxis.Color     = FGC.Tema;
GUI.Espectro.axSenialTiem.ZAxis.Color   = FGC.Tema;

end

