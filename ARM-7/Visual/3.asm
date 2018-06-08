start		MOV R0, #16
			MOV R1, #16
			MOV R3, #0

BL func_AD
B _end


func_AD	ADD R3, R0, R1
			MOV PC, LR



_end