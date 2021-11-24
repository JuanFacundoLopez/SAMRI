function [ HilbVar ] = samriHilbert( ObjAudio )
    HilbVar = [];
    
    imf = emd(ObjAudio.timeData,'Interpolation','pchip');
    fs = ObjAudio.samplingRate;
    [HilbVar.hs,HilbVar.f,HilbVar.t] = hht(imf,fs);
    HilbVar.imf = imf;
end

