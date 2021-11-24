classdef SamRiVista < handle
    properties
        mGui
        mModelo
        mControlador
    end
    
    methods
        function obj = SamRiVista(controlador) % creo el constructor del objeto vista
            obj.mControlador = controlador;
            obj.mModelo = controlador.mModelo;
            obj.mGui = samriGUI('controlador',obj.mControlador);
            
         end
    end
end