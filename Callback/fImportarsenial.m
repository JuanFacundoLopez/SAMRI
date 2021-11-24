function fImportarsenial( scr,event,GUI )

[nombre, path] = uigetfile('*.wav');
[GUI.audiodata, GUI.FS] = audioread([path, nombre]);

GUI.tiempo = 1/GUI.FS:1/GUI.FS:length(GUI.audiodata)/GUI.FS;
set(GUI.LabPath,'String',[path, nombre]);
set(GUI.LabPath,'ForegroundColor',[0.1 0.1 0.1]);

plot(GUI.axVisua, GUI.tiempo, GUI.audiodata);
    
GUI.axVisua.YLim = [-1 1];
GUI.axVisua.Title.String = 'Señal previsualizada';
GUI.axVisua.Title.FontWeight = 'bold';
GUI.axVisua.XLabel.String = 'Tiempo [s]';
GUI.axVisua.YLabel.String = 'Amplitud normalizada';

end

