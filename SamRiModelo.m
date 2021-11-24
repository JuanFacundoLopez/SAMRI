classdef SamRiModelo < handle    
    
    properties(Constant, Hidden = true)
       label_oct   = {'31.5Hz','63Hz','125Hz','250Hz','500Hz','1kHz','2kHz','4kHz','8kHz','16kHz'};
       label_ter   = {'25Hz','31.5Hz','40Hz','50Hz','63Hz','80Hz','100Hz','125Hz','160Hz','200Hz',...
        '250Hz','315Hz','400Hz','500Hz','630Hz','800Hz','1kHz','1.25kHz','1.6kHz','2kHz',... 
        '2.5kHz','3.15kHz','4kHz','5kHz','6.3kHz','8kHz','10kHz','12.5kHz','16kHz','20kHz'};
    end % DEfino los string de las octavas y tercios
    properties(Access = private)
      % Caracteristicas se la señal
       mSamplingRate         = 44100;
       mNBits                = 16;
       mGradoFft             = 16;
       mAmplitudSenialAudio  = 100;
       
      % Señales de audio 
       mSenialExcitacion     = samriAudio;
       mSenialRespExitac     = samriAudio;
       mSenialFiltroInve     = samriAudio;
       mSenialRespImpuls     = samriAudio;
       mSenialETC            = samriAudio;
       mSenialETCI           = samriAudio;
       
      % Espectros de audio
       mEspectroExcitacion   = samriAudio;
       mEspectroRespExitac   = samriAudio;
       mPSDExitacion         = samriAudio;
       mPSDRespExitac        = samriAudio;
              
       % Cespectrum de audio
       mCeptExcitacion       = samriAudio;
       mCeptRespExitac       = samriAudio;
       mCeptRespImpuls       = samriAudio;
       
       % Señales de Hilbert
       mHilbExcitacion       = [];
       mHilbRespExitac       = [];
       mHilbRespImpuls       = [];
       
      % Caracteristicas de la exitacion
       mTipoExcitacion       = 'linsweep'
       mDuracion             = 0.6826;
       mFrecuencia           = 1000;
       mFrecuenciaFinal      = 20000;
       mFrecuenciaInicial    = 20;
       mSilencio             = 0;
       mRepeticion           = 0;
       mAmplitud             = 1;
       
      % Caracteristicas del ventaneo
       mTipoVentana          = 'Hann';
       mInicioVentana        = 0.1;
       mFinVentana           = 0.1;
       
      % Caracteristicas de los filtros 
       mVectorFrecuencias    = [31.5,63,125,250,500,1000,2000,4000,8000,16000];
       mBandasOctava         = 1;
       mOrdenFiltro          = 10;
       mFrec                 = 0;
       
      % Caracteristicas de la placa de audio
       mEntradaAudioIndex    = 0;
       mSalidaAudioIndex     = 0;
       mEntradaAudioNombre   =  ' ';
       mSalidaAudioNombre    =  ' ';
       mEntSalNombre         =  ' ';
       mObjTARS              = [];
       
      % Parametros del archivo
       mDirectorioGuardar    = '';
       
      % Caracteristicas de la implemenacion de los filtros  en el dominio
      % del tiempo
      mTiempoModo            = '1/1';
      mTiempoFrecuencia      = 20;
      mTiempoVentana         = 'Rect';
      mTiempoLongitud        = 8192;
      
      % Caracteristicas de la implemenacion de los filtros  en el dominio
      % de la frecuencia
      mFrecueDimencion       = 2;
      mFrecueModo            = 31.5;
      mFrecueVentana         = 'Rect';
      mFrecueLongitud        = 8192;
      
      % Referencia por calibracion automatica
      mRefeCalibracion = []; 
      
      % GUI's
      mConfiguracionGUI = [];
      mPrincipal        = [];
      
      
    end

    methods
        function obj = SamRiModelo() % constructor del objeto

        end

        %% Seters
        function setConfiguracion(this,value)
            this.mConfiguracionGUI = value;
        end
        function setReferenciaCalibracion(this,value)
            this.mRefeCalibracion = value;
        end
        function setRepreAxTiemp(this,value)
            this.mRepresentacionAxTiempo = value;
        end
        function setRepreAxFrec(this, value)
            this.mRepresentacionAxFrecuen = value; 
        end
        function setSamplingRate(this,value)
            if isscalar(value)
                this.mSamplingRate = value;
            else
                error('%s.set.samplingRate  samplingRate must be a scalar value',mfilename);
            end
        end       
        function setGradoFft(this,value)
                this.mGradoFft =value;
        end
        function setInicioVentana(this,value)
                this.mInicioVentana =value;
        end       
        function setFinVentana(this,value)
                this.mFinVentana =value;
        end  
        
        %Set señales en el tiempo
        function setSenialExcitacion(this,value)         
                this.mSenialExcitacion = value;
%                 disp('guarde señal de exitacion');
        end%Señal de exitacion
        function setRespuestaExcitacion(this,value)         
                this.mSenialRespExitac = value;
        end%Respuesta a la exitacion
        function setSenialGrabada(this,value)
                this.mSenialGrabada = value;
        end
        function setFiltroInverso(this,value)
                this.mSenialFiltroInve = value;
        end
        function setSenialGrabadaTono(this,value)
           % if isa(value,'samriAudio')
          
                this.mSenialGrabadaTono = value;
        %    else
        %        error('%s.set.senialExcitacion La señal de excitacion debe ser del tipo samriAudio',mfilename);
         %   end
        end
        function setRespuestaImpulsiva(this, value)
            this.mSenialRespImpuls = value;
        end
        
        %Set Espectro de exitacion
        function setEspectroExcitacion(this,value) 
            this.mEspectroExcitacion = value;
        end
        function setEspectroRespExitac(this,value)   
            this.mEspectroRespExitac = value;size(value.timeData)
        end
        function setPSDExitacion(this,value) 
                        

            this.mPSDExitacion = value;
        end
        function setPSDRespExitac(this,value)  

            this.mPSDRespExitac = value;
        end
        
        %Set Cespectrum de exitacion
        function setCeptSenialExcitacion(this,value)         
            this.mCeptExcitacion = value;
        end
        function setCeptRespuestaExcitacion(this,value)         
            this.mCeptRespExitac = value;
        end
        function setCeptRespuestaImpulsiva(this, value)
            this.mCeptRespImpuls = value;
        end
         
        %Set señales de hilbert
        function setHilbSenialExcitacion(this,value)         
            this.mHilbExcitacion = value;
        end
        function setHilbRespuestaExcitacion(this,value)         
            this.mHilbRespExitac = value;
        end
        function setHilbRespuestaImpulsiva(this, value)
            this.mHilbRespImpuls = value;
        end
         
        
        function setSenialIRVentaneada(this,value)
               this.mSenialIRVentaneada = value;
        end    
        function setSenialIRExtendida(this,value)
               this.mSenialIRExtendida = value;
        end        
        function setSentana(this,value)
               this.mVentana = value;
        end       
        function setDatos(this,value)
               this.mDatos = value;
        end                
        function setPotenciaTonodB(this, value)
            this.mPotenciaTonodB = value;
        end        
        function setTipoExcitacion(this,value)
                this.mTipoExcitacion = value;
        end
        function setTipoVentana(this,value)
                this.mTipoVentana =value;
        end
        function setOctavas(this, value)
           
            if(strcmp(value, '1/1 Octava'))
               this.mBandasOctava = 1;
               this.mVectorFrecuencias = [31.5,63,125,250,500,1000,2000,4000,8000,16000];
            elseif (strcmp(value, '1/3 Octava'))
               this.mBandasOctava = 3;
               this.mVectorFrecuencias = [25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,...
                    800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000];
            else
                disp('Error')
            end
          
        end
        function setOrdenFiltro  (this, value)
            this.mOrdenFiltro = value;
        end
        function setFrec  (this, value)
            this.mFrec = value;
        end
        function setPotenciadB(this, value)
            this.mPotenciadB = value;
        end
        function setParametros(this, value)
            this.mParametros = value;
        end
        function setDirectorioGuardar(this, value)
            this.mDirectorioGuardar = value;
        end                   
        function setGuardaIR(this, value)
            this.mGuardaIR = value;
        end 
        function setNBits(this, value)
            this.mNBits = value;
        end
        function setDispEntradaStr(this, value)
            this.mEntradaAudioNombre = value;
        end
        function setDispEntradaNum(this, value)
            this.mEntradaAudioIndex = value;
        end
        function setDispSalidaStr(this,value)
            this.mSalidaAudioNombre = value;
        end
        function setDispSalidaNum(this,value)
            this.mSalidaAudioIndex  = value;
        end
        function setFrecMuestre(this,value)
            this.mSamplingRate = value;
        end
        function setTARSObj(this,value)
            this.mObjTARS = value;
        end
        function setDuracion(this,value)
            this.mDuracion = value;
        end
        function setFrecuencia(this,value)
            this.mFrecuencia = value;
        end
        function setFrecFinal(this,value)
            this.mFrecuenciaFinal = value;
        end
        function setFrecInicial(this,value)
            this.mFrecuenciaInicial = value;
        end
        function setSilencio(this,value)
            this.mSilencio = value;
        end
        function setRepeticion(this,value)
            this.mRepeticion = value;
        end
        function setAmplitud(this,value)
            this.mAmplitud = value;
        end
        function setCeptrum(this,value)
            this.mCeptrum = value;
        end
        function setCurvaEnergiaTiempo(this,value)
            this.mSenialETC = value;
        end
        function setCurvaEnergiaTiempoIntegrada(this,value)
            this.mSenialETCI = value;
        end
                
        %% Geters
        function result = getConfiguracion(this)
            result = this.mConfiguracionGUI;
        end

        function result = getReferenciaCalibracion(this)
            result = this.mRefeCalibracion;
        end
     
        function result = getSamplingRate(this)
            result = this.mSamplingRate;
        end        
        function result = getGradoFft(this)
            result = this.mGradoFft;
        end
        function result = getInicioVentana(this)
            result = this.mInicioVentana;
        end 
        function result = getFinVentana(this)
            result = this.mFinVentana;
        end  
        
        %%%%%%%%%%%%%%%%%%get respusetas de audio %%%%%%%%%%%%%%%%%%%%%%%%%
        function result = getSenialExcitacion(this)
            result = this.mSenialExcitacion;
        end    
        function result = getRespuestaExcitacion(this)
            result = this.mSenialRespExitac;
        end
        function result = getFiltroInverso(this)
            result = this.mSenialFiltroInve;
        end
        function result = getRespuestaImpulsiva(this)
            result = this.mSenialRespImpuls;
        end
        function result = getCurvaEnergiaTiempo(this)
            result = this.mSenialETC;
        end
        function result = getCurvaEnergiaTiempoIntegrada(this)
            result = this.mSenialETCI;
        end
        
        %%%%%%%%%%%%%%%%%%get espectros de audio%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function result = getEspectroExcitacion(this)   
            result = this.mEspectroExcitacion;
        end
        function result = getEspectroRespExitac(this)   
            result = this.mEspectroRespExitac;
        end
        function result = getPSDExitacion(this)   
            result = this.mPSDExitacion;
        end
        function result = getPSDRespExitac(this)   
            result = this.mPSDRespExitac;
        end
        
        %%%%%%%%%%%%%%%%%%get ceptrum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function result = getCeptExcitacion(this)   
            result = this.mCeptExcitacion;
        end
        function result = getCeptRespExitac(this)   
            result = this.mCeptRespExitac;
        end
        function result = getCeptRespImpulsiva(this)   
            result = this.mCeptRespImpuls;
        end
        
        %%%%%%%%%%%%%%%%%get Hilbert %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function result = getHilbExcitacion(this)   
            result = this.mHilbExcitacion;
        end
        function result = getHilbRespExitac(this)   
            result = this.mHilbRespExitac;
        end
        function result = getHilbRespImpulsiva(this)   
            result = this.mHilbRespImpuls;
        end
        
        
        function result = getDispEntradaStr(this)
            result = this.mEntradaAudioNombre;
        end
        function result = getDispEntradaNum(this)
            result = this.mEntradaAudioIndex;
        end
        function result = getDispSalidaStr(this)
            result = this.mSalidaAudioNombre;
        end
        function result = getDispSalidaNum(this)
            result = this.mSalidaAudioIndex;
        end       
        function result = getTipoExcitacion(this)
            result = this.mTipoExcitacion;           
        end
        function result = getTipoVentana(this)
            result = this.mTipoVentana;
        end
        function result = getVectorFrecuencias(this)
            result = this.mVectorFrecuencias;
        end
        function result = getOctavas(this)
           
            result = this.mBandasOctava;
        end
        function result = getOrdenFiltro(this)
            result = this.mOrdenFiltro;
        end
        function result = getFrec(this)
            result = this.mFrec;
        end
        function result = getDirectorioGuardar(this)
            result = this.mDirectorioGuardar;
        end
        function result = getNBits(this)
            result = this.mNBits;
        end
        function result = getDispEntrada(this)
            result = this.mEntradaAudioNombre;
        end
        function result = getDispSalida(this)
            result = this.mSalidaAudioNombre;
        end
        function result = getFrecMuestre(this)
            result = this.mSamplingRate;
        end
        function result = getTARSObj(this)
            result = this.mObjTARS;
        
        end
        function result = getDuracion(this)
            result = this.mDuracion;
        
        end
        function result = getFrecuencia(this)
            result = this.mFrecuencia;
        end
        function result = getFrecInicial(this)
            result = this.mFrecuenciaInicial;
        
        end
        function result = getFrecFinal(this)
            result = this.mFrecuenciaFinal;
        
        end
        function result = getSilencio(this)
            result = this.mSilencio;   
        end
        function result = getRepeticion(this)
            result = this.mRepeticion;   
        end
        function result = getAmplitud(this)
            result = this.mAmplitud;   
        end

      end
end
       