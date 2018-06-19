var		DCD		2, 4, 5, 0
		
		ADR		R5, var
		LDR		R1, [R5, #0]
		LDR		R2, [R5, #4]
		LDR		R3, [R5, #8]
		ADD		R0, R1, R2
		ADD		R0, R0, R3
		
		STR		R0, [R5, #12]
		
		END
