
; indicate start of 
start		MOV		R0, #100
			MOV		R1, #0
loop		ADD		R1, R1, #1
			CMP		R0, R1
			BNE		loop
end



