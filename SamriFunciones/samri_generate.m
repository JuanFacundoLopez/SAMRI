function varargout = samri_generate(varargin)
%  A continuación se muestran ejemplos:
%
%  Sintaxis: samdirAudio = samdir_generate('tipo', Amplitud,(Frec),SamplingRate,Duracion(s),)
%
%  a = samdir_generate('impulse',1,44100,15)
%  a = samdir_generate('impulsetrain',1,44100,15,cantidad de impulsos)
%  a = samdir_generate('sine',1,1000,44100,15)
%  a = samdir_generate('cosine',1,1000,44100,15)
%  a = samdir_generate('whitenoise',1,44100,15)
%  a = samdir_generate('pinknoise',1,44100,15)
% ObjAudio = samri_generate(Exitacion,...
%                                   [FInicial FFinal],...
%                                   Duracion, fs,18);
%   
%  Barridos:

%  Sintaxis: samdirAudio = samdir_generate(sweeptype,freq_range,[stopmargin],sr,fft_degree)
%  
%  b = samdir_generate('expsweep',[2 22000],44100,18) 
%  b = samdir_generate('linsweep',[2 22000],0.5,44100,18)
%
%  sweeptype:  	puede ser linsweep (lineal) o expsweep (exponencial)
%  freq_range: 	vector con la frecuencia inicial y la final de la forma [f1 f2]
%  tiempobarri:	segundos de silencio al final del barrido
%  sr:         	frecuencia de muestreo en Hz
%  fft_degree: 	grado de la FFT, lo que indica la duración de la señal.

%% Inicialización

narginchk(0,8);

% if there is no input parameter --> GUI                        %VER
if nargin == 0
    varargout(1) = 0; % lo agregue porque no puede quedar el if verdadero sin nada
else
    signal_type  = varargin{1};
    
    %% Generación de las distintas señales
    audioObj = samriAudio();
    
    switch lower(signal_type)
            
       case {'impulse'}                        %Impulso
            if nargin ~= 4
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            SamplingRate = varargin{3};
            fft_degree   = varargin{4};
            
            if fft_degree > 40
                nSamples = fft_degree;
            else
                nSamples = 2^fft_degree;
            end
            audioObj.timeData   = zeros(nSamples,1);
            
            audioObj.timeData(1,:)  = Amplitude;
            audioObj.samplingRate   = SamplingRate;
            audioObj.comment        = 'Impulso';
            audioObj.signalType     = 'energy';     %señal de energia %VER
        
            
        case {'impulsetrain'}                   %Tren de impulsos
            if nargin ~= 5
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            SamplingRate = varargin{3};
            fft_degree   = varargin{4};
            repetition   = varargin{5};
            FullSize = 2^fft_degree;
            Interval = round(FullSize/repetition);
            audioObj.timeData   = zeros(FullSize,1);
            audioObj.timeData(1:Interval:FullSize,:) = Amplitude;
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = 'Tren de impulsos';
            audioObj.signalType = 'energy';     %señal de energia %VER
        
            
        case {'sine'}                           %Tono senoidal
            if nargin ~= 4 
                error('samdir_generate: Verificar la sintaxis')
            end
            Frequency    = varargin{2};
            Duracion     = varargin{3};
            SamplingRate = varargin{4};
            
            audioObj.timeData = sin(2*pi*Frequency*(0:(Duracion*SamplingRate-1))/SamplingRate)';
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = ['Seno - '  num2str(Frequency) 'Hz' ];
            audioObj.signalType = 'power';      
            
       case {'whitenoise'}                     %Ruido blanco
            if nargin ~= 4
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            SamplingRate = varargin{3};
            fft_degree   = varargin{4};
            if fft_degree > 30
                nSamples = fft_degree;
            else
                nSamples = 2.^fft_degree;
            end
           
            audioObj.timeData  = randn(round(nSamples),1).*Amplitude;
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = 'Ruido Blanco';
            audioObj.signalType = 'power';      %señal de potencia %VER
            
            
       case {'pinknoise'}                       %Ruido rosa
            if nargin ~= 4
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            SamplingRate = varargin{3};
%             fft_degree   = varargin{4};
            audioObj.timeData   = randn(2.^fft_degree,1).*Amplitude;
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = 'Ruido Rosa';
            audioObj    =   samdir_fft(audioObj);
            bin_dist    =   audioObj.samplingRate ./ (2 .* (audioObj.nBins - 1));
            bin_vector  =   (0:audioObj.nBins-1).' .* bin_dist;
            audioObj.freqData  =   audioObj.freqData ./  sqrt(bin_vector .* 2 .* pi .* 1i);
            audioObj.signalType = 'power';      %señal de potencia %VER
            audioObj      =   samdir_ifft(audioObj);
            
            
        case {'linsweep','expsweep'}            %Barridos
            switch lower(signal_type)
                case {'linsweep'}
                    methodStr = 'linear';
                case {'expsweep'}
                    methodStr = 'exponential';
            end
            
            Silencio = 0; %Valor por defecto
            Repeticion = 0; %Valor por defecto
            
            switch nargin
                case 4
                    f0 = varargin{2}(1); f1 = varargin{2}(2); samplingRate = varargin{3}; Silencio = varargin{4};
                case 5
                    if length(varargin{2}) == 2     %vector de frecuencia
                        f0 = varargin{2}(1); f1 = varargin{2}(2); TDura = varargin{3}; samplingRate = varargin{4}; Silencio = varargin{5};               
                    else                            %la frecuencia se da en forma separada
                        f0 = varargin{2}; f1 = varargin{3}; samplingRate = varargin{4}; Silencio = varargin{5};
                    end
                case 6
                    f0 = varargin{2}; f1 = varargin{3}; TDura = varargin{4}; samplingRate = varargin{5}; Silencio = varargin{6};
                case 7
                    f0 = varargin{2}; f1 = varargin{3}; TDura = varargin{4}; samplingRate = varargin{5}; Silencio = varargin{6}; Repeticion = varargin{7};
                otherwise
                    error('samdir_generate: Verificar la sintaxis')
            end
            
            phi     = 270;    
            t       = 0:1/samplingRate:TDura;     

            if f0 < 1e-6, f0 = 1e-6; end                %f0 (frecuencia inicial) no puede ser menor a 1 uHz
            
            if strcmp(methodStr,'exponential')         %la funcion chirp de matlab usa 'logarithmic'
                methodStr4chirp = 'logarithmic';
            else
                methodStr4chirp = methodStr;
            end
            
            audioObj.samplingRate = samplingRate;            
            audioObj.timeData    = chirp(t, f0, TDura, f1, methodStr4chirp, phi).';% funcion que realiza todo
            
            if round(Repeticion) > 0
                aux = audioObj.timeData;
                for i = 1:Repeticion
                    audioObj.timeData = [audioObj.timeData(:); aux(:)];
                end
            end
            if Silencio > 0 
                audioObj.timeData = [zeros((audioObj.samplingRate * Silencio),1); audioObj.timeData(:)];
            end
            if strcmp(methodStr,'exponential')
                audioObj.comment = ['Barrido senoidal exponencial de ' num2str(f0) ' a ' num2str(f1) 'Hz'];
            else
                audioObj.comment = ['Barrido senoidal lineal de ' num2str(f0) ' a ' num2str(f1) 'Hz'];     
            end
    end

%% Devuelve el valor de salida
varargout(1) = {audioObj};

end
