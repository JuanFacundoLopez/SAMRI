function [ salida ] = samriControlAxesTiempo( Modelo, GUI)

if get(GUI.btSenialEx, 'Value')
     
end

if get(GUI.btRespueEx, 'Value')
    

end

if get(GUI.btFiltrInv, 'Value')
    

end

if get(GUI.btRespImpu, 'Value')
     

end

if get(GUI.btCurvEnTi, 'Value')
    
end

if get(GUI.btCurvaETI, 'Value')
    
end

Ax.Position = [0.045 0.03 0.81 0.936];
Ax.Title.FontWeight = 'bold';
Ax.XLabel.String = 'Tiempo [s]';
Ax.Box   = 'off';

%      Introducido en el 2018


end

