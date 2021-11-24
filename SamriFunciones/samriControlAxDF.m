function [ output_args ] = samriControlAxDF( Modelo, GUI )


ax      = GUI.axEspecFrec;
output_args = 0 ;


if get(GUI.btSenialEx, 'Value')
    SExitacion          = Modelo.getEspectroExcitacion();
    VectorSenial        = db(abs(real(SExitacion.freqData)),'power');
    VectorFrec          = SExitacion.freqVector;
    plot(ax, VectorFrec, VectorSenial);
    ax.YLabel.String    = 'Magnitud';
    ax.Title.String     = 'Representacion de la señal de exitacion';

    output_args = 1;
end     

if get(GUI.btRespueEx, 'Value')
    RExitacion          = Modelo.getEspectroRespExitac();
    VectorSenial        = db(abs(real(RExitacion.freqData)),'power');
    VectorFrec          = RExitacion.freqVector;
    plot(ax, VectorFrec, VectorSenial);
    ax.YLabel.String    = 'Magnitud';
    ax.Title.String     = 'Representacion de la respuesta a la exitacion';

    output_args = 2;

end

if get(GUI.PSDSenExit, 'Value')
    PSDSExitacion       = Modelo.getPSDExitacion();
    VectorSenial        = db(abs(real(PSDSExitacion.freqData)),'power');
    VectorFrec          = PSDSExitacion.freqVector;
    plot(ax, VectorFrec, VectorSenial);
    ax.YLabel.String    = 'Magnitud';
    ax.Title.String     = 'Representacion de la señal de energia de la exitacion';

    output_args = 3;

end

if get(GUI.PSDResExit, 'Value')
    PSDRExitacion       = Modelo.getPSDRespExitac();
    VectorSenial        = db(abs(real(PSDRExitacion.freqData)),'power');
    VectorFrec          = PSDRExitacion.freqVector;
    plot(ax, VectorFrec, VectorSenial);
    ax.YLabel.String    = 'Magnitud';
    ax.Title.String     = 'Representacion de la señal de energia de la respuesta a la exitacion';

    output_args = 4;
end

    % Embelequeado del comoeyquisio
    ax.Position = [0.04 0.06 0.81 0.9];
    ax.Title.FontWeight = 'bold';
    ax.XLabel.String        = 'Frecuencia [Hz]';
    ax.XLim     = [1 30000];
    ax.XGrid    = 'on';
    ax.YGrid    = 'on';

end

