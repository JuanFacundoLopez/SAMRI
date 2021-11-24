%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_ventana.m                                                *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_ventana(varargin)
%   samdir_ventana - Utilizada en todas las funciones de ventaneo. Recibe
%   como argumento una cantidad de samples, el tipo de ventana y si el 
%   resultado será izquierda o derecha.
%
%   Sintaxis: ventana = samdir_ventana(long,'hann',true)
%
%   ventana:    resultado
%   long:       cantidad de samples
%   true:       si es izquierda
%   false:      si es derecha
%   
%   a = samdir_ventana(4800,'hann',1);
%   
%% Variables de la GUI  
long    = varargin{1};
tipo_v  = varargin{2};  
sentido = varargin{3};  

%% Tratamiento de la IR
switch (tipo_v)
    
    case {'hann' , 'Hann'}                       %Ventana Hann
        w1 = window(@hann,long*2);
        
    case {'hamming', 'Hamming'}                    %Ventana Hamming
        w1 = window(@hamming,long*2);
        
    case {'flattopwin', 'Flat Top'}                 %Ventana Flat Top
        w1 = window(@flattopwin,long*2);
        
    case {'blackman', 'Blackman'}                   %Ventana Blackman
        w1 = window(@blackman,long*2);
        
    case {'bartlett', 'Bartlett'}                   %Ventana Bartlett
        w1 = window(@bartlett,long*2);
        
    case {'barthannwin', 'Bartlett-Hann'}                %Ventana Bartlett-Hann modificada
        w1 = window(@barthannwin,long*2);
        
    case {'blackmanharris', 'Blackman-Harris'}             %Ventana Blackman-Harris de 4 terminos
        w1 = window(@blackmanharris,long*2);
        
    case {'bohmanwin', 'Bohman'}                  %Ventana Bohman 
        w1 = window(@bohmanwin,long*2);
        
    case {'chebwin', 'Chebyshev'}                    %Ventana Chebyshev 
        w1 = window(@chebwin,long*2);
        
    case {'gausswin', 'Gaussian'}                   %Ventana Gaussian 
        w1 = window(@gausswin,long*2);
        
    case {'kaiser', 'Kaiser'}                     %Ventana Kaiser 
        w1 = window(@kaiser,long*2);
        
    case {'nuttallwin', 'Nuttall'}                 %Ventana Nuttall
        w1 = window(@nuttallwin,long*2);
        
    case {'parzenwin', 'Parzen'}                  %Ventana Parzen
        w1 = window(@parzenwin,long*2);
      
    case {'rectwin', 'Rectangular'}                    %Ventana Rectangular
        w1 = window(@rectwin,long*2);

    case {'taylorwin', 'Taylor'}                  %Ventana Taylor
        w1 = window(@taylorwin,long*2);
        
    case {'tukeywin', 'Tukey'}                   %Ventana Tukey 
        w1 = window(@tukeywin,long*2);
            
    case {'triang', 'Triangular'}                     %Ventana Triangular 
        w1 = window(@triang,long*2);       
end

if (sentido)
    w1_med=w1(1:1:long);
else
    w1_med=w1(long+1:1:long*2);
end

varargout(1) = {w1_med};

end
