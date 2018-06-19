		;		Working with STR and LDR without increments
		;		Trying to increment all values
		;		Iterating over Memory
		
dat_a_10	DCD		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		
		
mov_end	ADR		R0, dat_a_10
		LDR		R1, [R0, #36]
		
		TEQ		R1, #100
		BLEQ		to_end
		
		ADD		R1, R1, #2
		STR		R1, [R0, #36]
		MOV		R2, #0
		
		
loop		STR		R1, [R0, R2]
		ADD		R2, R2, #4
		
		TEQ		R2, #36
		BLEQ		mov_end
		B		loop
		
		
to_end	END
