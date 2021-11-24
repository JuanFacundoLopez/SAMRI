function [ CcepsVar ] = samriCeptrum( ObjAudio )
    CcepsVar = samriAudio;
    
    CcepsVar.timeData = cceps(ObjAudio.timeData);
    
end

