function [ output_args ] = HabilitoBotones( GUI )
% Habilito botones en el tiempo
    set(GUI.btPlay,             'Enable','on');
    set(GUI.btActu,             'Enable','on');
    set(GUI.DomTiemp.btRepro,   'Enable','on');
    set(GUI.DomTiemp.btRepet,   'Enable','on');
    set(GUI.DomTiemp.btAnalisis,'Enable','on');
    set(GUI.DomTiemp.btSenialEx,'Enable','on');
    set(GUI.DomTiemp.btRespImpu,'Enable','on');
    set(GUI.DomTiemp.btRespueEx,'Enable','on');
    set(GUI.DomTiemp.btFiltrInv,'Enable','on');
    
    set(GUI.DomTiemp.btRespImpu,'Enable','on');
    set(GUI.DomTiemp.btCurvEnTi,'Enable','on');
    set(GUI.DomTiemp.btCurvaETI,'Enable','on');
    
    % Habilito botones en la frecuencia
    set(GUI.DomFrec.btAnalisis, 'Enable','on');
    set(GUI.DomFrec.btSenialEx, 'Enable','on');
    set(GUI.DomFrec.btRespueEx, 'Enable','on');
    set(GUI.DomFrec.PSDSenExit, 'Enable','on');
    set(GUI.DomFrec.PSDResExit, 'Enable','on');
    set(GUI.DomFrec.btLogaritm, 'Enable','on');
    set(GUI.DomFrec.btLineal,   'Enable','on');
    
    % Habilito botones en ETF - Fourier
    set(GUI.Espectro.btAnalisis, 'Enable','on');
    set(GUI.Espectro.btSenialEx, 'Enable','on');
    set(GUI.Espectro.btRespueEx, 'Enable','on');
    set(GUI.Espectro.btRespImpu, 'Enable','on');
    set(GUI.Espectro.btLogaritm , 'Enable','on');
    set(GUI.Espectro.btLineal,   'Enable','on');
%     set(GUI.DomFrec.btEspectrograma, 'Enable','on');
    
    % HAbilito botones en ceptrum
    set(GUI.DomCept.btAnalisis, 'Enable','on');
    set(GUI.DomCept.btSenialEx, 'Enable','on');
    set(GUI.DomCept.btRespueEx, 'Enable','on');
    set(GUI.DomCept.btResImpul, 'Enable','on');
    
    %Habilito botones en transform hilbert
    set(GUI.DomHilb.btAnalisis, 'Enable','on');
    set(GUI.DomHilb.btSenialEx, 'Enable','on');
    set(GUI.DomHilb.btRespueEx, 'Enable','on');
    set(GUI.DomHilb.btResImpul, 'Enable','on');
    set(GUI.DomHilb.btLogaritm, 'Enable','on');
    set(GUI.DomHilb.btLineal,   'Enable','on');
end

