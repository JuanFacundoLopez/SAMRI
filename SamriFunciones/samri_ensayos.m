%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_ensayos.m                                               *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************
%*  samdir_ensayos - Calcula la cantidad de ensayos a realizar teniendo en
%*  cuenta la resoluci�n ingresada y los �ngulos de inicio y final.
%*  Devuelve el n�mero de ensayos y una variable auxiliar que indica un
%*  giro completo.
%*
%*  Sintaxis: [int,int] = samdir_ensayos(int,int,int);
%*
%*  [ensayos,giro] = samdir_ensayos(res,ang1,ang2);
%***************************************************************************************
function varargout = samdir_ensayos(varargin)
%% Inicializaci�n
res     = varargin{1}; 
ang1    = varargin{2};
ang2    = varargin{3};

%% C�lculo de la cantidad de ensayos a realizar
% El rango de los �ngulos es [0;360], limitado por la GUI

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
        fprintf('\nIngrese una distancia angular v�lida.\n');
        num=0;
        giro=0;
end


varargout(1) = {num};
varargout(2) = {giro};
end












