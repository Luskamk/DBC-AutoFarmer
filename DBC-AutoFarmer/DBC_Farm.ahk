#Persistent
#SingleInstance, Force
SetKeyDelay, 30, 20

slotEspada := 1
slotOrb := 2
teclaChat := "t"
pixelsSubir := -45
tempoEntreKills := 2500

F12::
    Toggle := !Toggle
    if (Toggle) {
        ToolTip, [DBC] BOT ATIVADO, 10, 10
        SetTimer, RemoveToolTip, -2000
        SetTimer, CicloFarm, -1
    } else {
        ToolTip, [DBC] BOT DESATIVADO, 10, 10
        SetTimer, RemoveToolTip, -2000
        Send, {LButton up}
        Send, %slotEspada%
    }
return

RemoveToolTip:
    ToolTip
return

CicloFarm:
    while (Toggle) {
        Send, %slotEspada%
        Sleep, 300
        
        Loop, 180 {
            if (!Toggle)
                break
            
            Send, {LButton down}
            Sleep, 50
            Send, {LButton up}
            
            Sleep, 100
            Send, {LButton down}
            Sleep, 50
            Send, {LButton up}
            
            Sleep, % tempoEntreKills - 200
        }

        if (!Toggle)
            break

        Send, %slotOrb%
        Sleep, 500
        
        Send, %teclaChat%
        Sleep, 300
        Send, /trocar{Enter}
        Sleep, 1500

        MouseMove, 0, %pixelsSubir%, 10, R
        Sleep, 300
        Click
        Sleep, 300
        Send, {Esc}
        Sleep, 1000
    }
return