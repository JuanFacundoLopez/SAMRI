function varargout = set_preferencias(varargin)
%  struct = set_preferencias() - Retorna todas las preferencias existentes 
%  set_preferencias(struct) - set todos los campos especificos en la estructura, 
                           %puede ser usado para restaurar/cargar configuraciones (ej. de otra computadora)
%  set_preferencias('reset') - reset todas las preferencias a default

%  Usar: set_preferencias('pref_nombre') - devuelve el valor de la preferencia llamada pref_nombre.
%  Usar: [pref1, pref2] = set_preferencias({'pref1','pref2'}) - devuelve los valores de todas las preferencias en el argumento cell
%  Usar: s = set_preferencias('s*') - devuelve todas las preferencias que comienzan con s
%  Usar: set_preferencias('pref_nombre',value) - Set preferencia pref_name el valor dado;

% Las variables estáticas o persistent no pierden su valor por la llamadas
% a funciones u otros acontecimientos. Tan solo se ven afectadas por
% órdenes de asignación. 
persistent preferencias_definidas
persistent infoUsuario;

%Verifica si está vacía y luego carga las preferencias definidas.
if isempty(preferencias_definidas)
    
   preferencias_definidas = samdir_preferencias_definidas();
end


%% Verifica si existen preferencias
if nargin == 0
    value = getpref('AppSamriPreferencias');%Obtiene todos los campos de preferencias de %AppSamriPreferencias
    
    %Si está vacío (primera vez o después de llamar reset) establece todas las preferencias por defecto
    if isempty(value)
        for idx = 1:size(preferencias_definidas,1)
            value = preferencias_definidas{idx,2};
            className = preferencias_definidas{idx,3};
            if ~isempty(strfind(className,'bool')) || ~isempty(strfind(className,'logic'))
               value = cast(value,'logical');
            end
            setpref('AppSamriPreferencias',preferencias_definidas{idx,1},value);
        end
         value = getpref('AppSamriPreferencias');%Preference now contains all the preference fields of the %RWTH_ITA_Toolbox
    end
elseif nargin == 1
   %% Cuando el usuario pregunta por un valor de preferencia
   if ischar(varargin{1})
       if strcmpi(varargin{1},'reset') % Reset todas las configuraciones
           try
                rmpref('AppSamriPreferencias');
            catch errmsg %#ok<NASGU>
                disp('SET_PREFERENCIAS: no se pueden borrar las preferencias');
            end;
            % borra todas las variables globales del espacio de trabajo.
            clear global;
            return;
       elseif strcmp(varargin{1}(end),'*')
            searchStr = varargin{1}(1:end-1);
            returnPrefs = preferencias_definidas(strncmp(preferencias_definidas(:,1),searchStr,numel(searchStr)),1);
            result = struct();
            for idx = 1:numel(returnPrefs)
               result.(returnPrefs{idx}) = set_preferencias(returnPrefs{idx}); 
            end
            varargout{1} = result;
            return;
       else
           nombre_preferencia = varargin{1};
           prefidx = strcmpi(preferencias_definidas(:,1),nombre_preferencia);
           if any(prefidx)
                nombre_preferencia = preferencias_definidas{prefidx,1}; %Get the case right!
                global_nombre_preferencia = ['AppSamri' nombre_preferencia];
                eval(['persistent ' global_nombre_preferencia ';']); %Persistent is better than global because it is only visible and changeable by this function
           else
               %tratar de actualizar las preferencias definidas, tal vez algo 
               %cambió después de una actualización
               preferencias_definidas = samdir_preferencias_definidas();
               prefidx = strcmpi(preferencias_definidas(:,1),nombre_preferencia);
               if ~any(prefidx)
                   disp(['Disculpa, pero nose que preferencia es: ' nombre_preferencia '.']);
                    varargout{1} = [];
                    return;
                else % if it is found now, continue
                    nombre_preferencia = preferencias_definidas{prefidx,1};
                    global_nombre_preferencia = ['AppSamri' nombre_preferencia];
                    eval(['persistent ' global_nombre_preferencia ';']);
                end
           end
       end
   elseif iscellstr(varargin{1})
        input = varargin{1};
        for idx = 1:numel(input)
            varargout{idx} = set_preferencias(input{idx});
        end
        return  
   elseif isstruct(varargin{1}) % All setting as a struct
        fields = fieldnames(varargin{1});
        for idx = 1:numel(fields)
            set_preferencias(fields{idx},varargin{1}.(fields{idx}));
        end
        return
   else
        error('SET_PREFERENCIAS: no se especifica el nombre del string');
   end
   
   value = eval(global_nombre_preferencia);
   if isempty(value)
       if any(strcmpi(preferencias_definidas(:,1),nombre_preferencia))
           if isempty(infoUsuario)
               infoUsuario.AutorStr = 'None';
           end
           if isfield(infoUsuario,nombre_preferencia)
                value = infoUsuario.(nombre_preferencia);
                eval([global_nombre_preferencia ' = value;']); %Set global for faster access the next time
           end
       elseif ispref('AppSamriPreferencias',nombre_preferencia)
           value = getpref('AppSamriPreferencias',nombre_preferencia);
            eval([global_nombre_preferencia ' = value;']); %Set global for faster access the next time
       elseif any(strcmpi(preferencias_definidas(:,1),nombre_preferencia))
            is_defined = strcmpi(preferencias_definidas(:,1),nombre_preferencia);
            value = preferencias_definidas{find(is_defined,1),2};
            %pdi: in this case the preference has to be set
            setpref('AppSamriPreferencias',nombre_preferencia,value);
            eval([global_nombre_preferencia ' = value;']); %Set global for faster access the next time
       else
            error('La preferencia no existe!');
       end
    end
elseif nargin == 2  
    %% Verifica si el nombre está en la lista
    if ~ischar(varargin{1})
        error('SET_PREFERENCES: Nombre de string no especificado.');
    end
    nombre_preferencia = varargin{1};
    idx_list = strcmpi(preferencias_definidas(:,1),nombre_preferencia);
    if any(idx_list)
        nombre_preferencia = preferencias_definidas{idx_list,1}; %Get the case right!
    else
        warning(['SET_PREFERENCES: Perdón, No se que preferencia es: ' nombre_preferencia]); %#ok<WNTAG>
        return
    end
    
    global_nombre_preferencia = ['AppSamri' nombre_preferencia];
    value      = varargin{2};
    value_type = preferencias_definidas{idx_list,3};
    
    switch(value_type)
        case {'path','*path'}
            if (~ischar(value) ||  ~isdir(value)) && ~isempty(value)
                value = set_preferences(nombre_preferencia);
                disp('Preferencia: Path invalid. Using old.');
            end
        case {'logical','bool','*bool','bool_ispc','*bool_ispc'}
            if value < 0 || value > 1 || isempty(value) || ~isnatural(value)
                error('SET_PREFERENCES:bool value expected')
            end
            if strcmpi(value,'off'), value = false; end
            if strcmpi(value,'on'),  value = true; end
        case {'numeric','double','int','*int','matrix','int_portMidi','popup_double'}
            if ~isnumeric(value) && ~isempty(value), error('SET_PREFERENCES:tipo no coincide con las especificaciones'), end
            if isnan(value), value = []; end;
        case {'playrecFunctionHandle'}
            if ~isnumeric(value) || value == 0; value = 1; end
        case {'int_portAudio'}
            %% handle port audio IDs and strings
            if ischar(value); value = 'a';end;%ita_portaudio_string2deviceID(value);end;
            if ~isnumeric(value) && ~isempty(value), error('SET_PREFERENCES:tipo no coincide con las especificaciones'), end
            if isnan(value), value = []; end;
        case {'string','char','char*','*char','popup_char'}
            if ~ischar(value) && ~isempty(value), error('SET_PREFERENCES:tipo no coincide con las especificaciones'), end
        case {'str_comPort'}
            if ~ischar(value) && ~isempty(value), error('SET_PREFERENCES:tipo no coincide con las especificaciones'), end
            if ~isincellstr(value,ita_get_available_comports())
                error('ITA_PREFERENCES: Este COM Port no está habilitado');
            end
        case '*struct'
            if ~isstruct(value)
                error('%s debería ser de tipo struct (not %s)', nombre_preferencia, class(value))
            end
    otherwise
            error(['SET_PREFERENCES: Que tipo debería ser? ' value_type])
    end
  
    %% generate global variable and set preference
    setpref('AppSamriPreferencias',nombre_preferencia,value);
    eval(['persistent ' global_nombre_preferencia ';']);
    eval([global_nombre_preferencia ' = value;']);
end


%% Show result
if nargout == 1
    %just return result
    varargout{1} = value;
elseif nargout == 0
    if nargin == 0
        %show gui
    elseif nargin == 1
        %disp(value);
    else
        %return value
        varargout{1} = value;
    end
end

    
end