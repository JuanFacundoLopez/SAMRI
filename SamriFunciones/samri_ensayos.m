%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_ensayos.m                                               *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************
%*  samdir_ensayos - Calcula la cantidad de ensayos a realizar teniendo en
%*  cuenta la resolución ingresada y los ángulos de inicio y final.
%*  Devuelve el número de ensayos y una variable auxiliar que indica un
%*  giro completo.
%*
%*  Sintaxis: [int,int] = samdir_ensayos(int,int,int);
%*
%*  [ensayos,giro] = samdir_ensayos(res,ang1,ang2);
%***************************************************************************************
function varargout = samdir_ensayos(varargin)
%% Inicialización
res     = varargin{1}; 
ang1    = varargin{2};
ang2    = varargin{3};

%% Cálculo de la cantidad de ensayos a realizar
% El rango de los ángulos es [0;360], limitado por la GUI

if (ang1==0 && ang2==360)
    giro    = 1;  
    num     = 360/res;
elseif (ang1 > ang2)
        num1    = (360 - ang1)/res;
        num2    = ang2/res;
        num     = round(num1 + num2) + 1;
        giro    = 0;
    elseif (ang2 > ang1)
        num     = round((ang2 - ang1)/res) + 1;
        giro    = 0;
        else
        fprintf('\nIngrese una distancia angular válida.\n');
        num=0;
        giro=0;
end


varargout(1) = {num};
varargout(2) = {giro};
end












