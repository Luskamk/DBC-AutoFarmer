#Persistent
#SingleInstance, Force
SetKeyDelay, 30, 20

; ------ CONFIGURAÇÕES ------ ;
slotEspada := 1     ; Slot da espada
slotOrb := 2        ; Slot das orbs
teclaChat := "t"    ; Tecla do chat
pixelsSubir := -45  ; Movimento do mouse (negativo = cima)
tempoEntreKills := 2500 ; 2.5s entre ciclos completos
; -------------------------- ;

F12::  ; Liga/Desliga com F12
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
        ; --- FARMAR COM ESPADA ---
        Send, %slotEspada%
        Sleep, 300
        
        Loop, 180 {  ; Aprox. 7.5 minutos
            if (!Toggle)
                break
            
            ; Primeiro hit
            Send, {LButton down}
            Sleep, 50
            Send, {LButton up}
            
            ; Segundo hit após 100ms
            Sleep, 100
            Send, {LButton down}
            Sleep, 50
            Send, {LButton up}
            
            ; Espera restante para completar 2.5s
            Sleep, % tempoEntreKills - 200
        }

        if (!Toggle)
            break

        ; --- VENDER ORBS ---
        Send, %slotOrb%
        Sleep, 500
        
        ; Abrir menu de troca
        Send, %teclaChat%
        Sleep, 300
        Send, /trocar{Enter}
        Sleep, 1500

        ; Movimento e venda (AJUSTADO)
        MouseMove, 0, %pixelsSubir%, 10, R
        Sleep, 300
        Click
        Sleep, 300
        Send, {Esc}  ; APENAS 1 ESC
        Sleep, 1000
    }
return