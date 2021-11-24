%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_ventaneo_ver2.m                                          *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_ventaneo_ver(varargin)
%   samdir_ventaneo_ver - Busca el máximo de la IR y permite visualizar la
%   ventana de tiempo antes de aplicarla. Esta se debe especificar por el
%   tipo, cantidad de segundos a izquierda y derecha del máximo con la 
%   ventana seleccionada. Además se debe ingresar la cantidad de segundos
%   con ventana rectangular, lo que hace a la versatilidad del ventaneo.
%   Se devuelve la ventana lista para multiplicar en el dominio del tiempo,
%   la IR normalizada y los datos de inicio y final.
%
%   Sintaxis: samdirAudio = samdir_ventaneo_ver(samdirAudio,izq_rec,der_rec,'tipo',izq,´tipo',der)
%
%   samdirAudio:    IR a ventanear
%   izq_rec:        cantidad de seg. a la izquierda del maximo sin vent.
%   der_rec:        cantidad de seg. a la derecha del maximo sin vent.
%   tipo:           ventana
%   izq:            cantidad de segundos a la izquierda de izq_rec
%   der:            cantidad de segundos a la derecha de der_rec
%   
%   [ir_mod,vent]= samdir_ventaneo_ver2(ir,0.1,0.1,'hann',0.05,'hann',0.3)
%   
%% Variables de la GUI  
audioObj    = varargin{1};
izq_rec     = varargin{2};       
der_rec     = varargin{3};  
tipo_vent1  = varargin{4};
izq         = varargin{5};  
tipo_vent2  = varargin{6};
der         = varargin{7};
modoGUI     = varargin{8}; 

%% Configuraciones ModoGUI
if(modoGUI == true)
    logger = varargin{9}; 
end

%% Tratamiento de la IR
result = samdirAudio;
result.samplingRate = audioObj.samplingRate;

% Guarda la posición del máximo, puede ser un valor negativo asi que pasar a
% valores de energía
maximo = find(abs(audioObj.timeData) == max(abs(audioObj.timeData)));   

% Normalización e inversión de la señal si audioObj.timeData(maximo) era negativo
result.timeData = audioObj.timeData(1:1:end)./audioObj.timeData(maximo);

%% Generación y visualización de la ventana
samp_izq_rec    = result.samplingRate*izq_rec;
samp_der_rec    = result.samplingRate*der_rec;
samp_izq        = result.samplingRate*izq;
samp_der        = result.samplingRate*der;
inicio          = maximo-samp_izq_rec-samp_izq;
final           = maximo+samp_der_rec+samp_der;

%% Límites de las ventanas
if (inicio < 0)
    if (maximo-samp_izq_rec < 0)
        if (modoGUI)
            samdir_logMensajes(logger, '¡Cuidado! El valor de ventana rectangular izquierda es demasiado grande', 'w');
        else
            fprintf('\n¡Cuidado! El valor de ventana rectangular izquierda es demasiado grande\n');    
        end
        samp_izq = 0;
        samp_izq_rec = maximo-1;
    else
        if (modoGUI)
            samdir_logMensajes(logger, '¡Cuidado! El valor de tiempo a la izquierda del máximo es demasiado grande', 'w');
        else
            fprintf('\n¡Cuidado! El valor de tiempo a la izquierda del máximo es demasiado grande\n');    
        end
       
        samp_izq = maximo-1-samp_izq_rec;
    end
    inicio = maximo-samp_izq_rec-samp_izq;
end

if (final > length(result.timeData))
    if (maximo+samp_der_rec > length(result.timeData))
        if (modoGUI)
            samdir_logMensajes(logger, '¡Cuidado! El valor de ventana rectangular derecha es demasiado grande', 'w');
        else
            fprintf('\n¡Cuidado! El valor de ventana rectangular derecha es demasiado grande\n');    
        end
       
        samp_der = 0;
        samp_der_rec = length(result.timeData)-maximo;
    else
        samp_der = length(result.timeData)-maximo-samp_der_rec;
        if (modoGUI)
            samdir_logMensajes(logger, '¡Cuidado! El valor de tiempo a la derecha del máximo es demasiado grande', 'w');
        else
            fprintf('\n¡Cuidado! El valor de tiempo a la derecha del máximo es demasiado grande\n');    
        end
       
    end
    final = maximo+samp_der_rec+samp_der;
end

%% Generación de las ventanas

% Ventana izquierda
a   = samdir_ventana(samp_izq,tipo_vent1,1);
% Ventana izquierda rectangular
b   = ones(samp_izq_rec,1);
% Ventana derecha rectangular
c   = ones(samp_der_rec,1);
% Ventana derecha
d   = samdir_ventana(samp_der,tipo_vent2,0);
% Ventana total
e   = [a;b;1;c;d];

%% Generación del objeto ventana
vent = samdirAudio;
vent.samplingRate = result.samplingRate;
vent.timeData = zeros(length(result.timeData),1);
vent.timeData (inicio:1:final)= e;

%% Visualización de IR modificada y Ventana a aplicar
%plot(result.timeVector,result.timeData,'b',vent.timeVector,vent.timeData,'--r','LineWidth',1.5);
%xlabel('seg');
%ylabel('Amplitud');
%set(gca,'XLim', result.timeVector([1 end]));
%set(gca,'YLim', [-1.2 1.2]);
% grid on
result.comment = [audioObj.comment ' + Ventana'];
% title(result.comment);
% set(gcf,'Name', result.comment);

%% Retorno de IR modificada, Ventana a aplicar y datos inicio y final
varargout(1) = {result};
varargout(2) = {vent};
varargout(3) = {[inicio final]};

end
 
