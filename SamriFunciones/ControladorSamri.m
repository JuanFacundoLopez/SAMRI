classdef ControladorSamri < SingletonControlador
   %*** Define your own properties for SingletonImpl.
   properties % Public Access
      myData;
   end
   
    methods(Access=private)
      % Guard the constructor against external invocation.  We only want
      % to allow a single instance of this class.  See description in
      % Singleton superclass.
      function newObj = ControladorSamdir()
         % Initialise your custom properties.
         newObj.myData = [];
      end
   end
   
   methods(Static)
      % Concrete implementation.  See Singleton superclass.
      function obj = instance()
         persistent uniqueInstance
         if isempty(uniqueInstance)
            obj = ControladorSamdir();
            uniqueInstance = obj;
         else
            obj = uniqueInstance;
         end
      end
   end
   
   %*** Define your own methods for SingletonImpl.
   methods % Public Access
      function myOperation(obj, val)
         % Just assign the input value to singletonData.  See Singleton
         % superclass.
         obj.setSingletonData(val);
      end
   end

end