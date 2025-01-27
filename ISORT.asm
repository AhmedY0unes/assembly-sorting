; This program prompts user for array size, then sorts the array using INSERTION SORT algorithm and prints the sorted array.

section .data
    input_format: dq "%lld", 0
    output_format: dq "%lld ",0xA, 0
    input_number: dq 2
    counter: dq 0
    size_msg: dq "Enter array size : ", 0xA, 0
    msg: dq "Enter numbers : ", 0xA, 0
    output_msg: dq "The sorted array is : ", 0xA, 0
    sorting_type_msg: dq "Choose 1 for Ascending sort or 2 for Decending : ", 0xA, 0 ; new
    new_line: db "", 0xA, 0

section .bss
    size resq 2
    array resq 21
    sortingType resq 2          ;new

section .text
global main
extern printf
extern scanf

main:
    push RBP
    ; Prompt user for input size
    mov RDI, size_msg
    call printf

    ; Scan input size
    mov RDI, input_format
    mov RSI, size
    call scanf

    ; Print newline
    mov RDI, new_line
    call printf

    ; Prompt user to input array elements
    mov RDI, msg
    call printf

    xor RAX, RAX; RAX = 0
    xor RCX, RCX; RCX = 0
    xor RBX, RBX; RBX = 0

    ; Get input and store it in an array
    INPUT_ARRAY: 						
    	cmp RCX, [size]					; Check the size
    	mov RDI, new_line
    	jz DONE							; Goto done after the input is complete
    	mov [counter], RCX
    	mov RAX, 0
    	mov RDI, input_format
    	mov RSI, input_number
    	call scanf
    	mov RAX, [input_number]
    	mov RCX, [counter]
    	mov [array+RCX*8], RAX
    	inc RCX	
    	jmp INPUT_ARRAY 

    DONE:								; Reinitialize
	    xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0
    ; prompt user for sorting type
    mov RDI, sorting_type_msg
    call printf
    
    ;scan for sorting type
    mov RDI,input_format
    mov RSI, sortingType
    call scanf
    mov R15, [sortingType]
    ;jump if number is 2 to descending order code other wise continue with the ascending order
    cmp R15, 2
    je DISORT_1
    
    
;***************** Ascending INSERTION SORT START *******************        
AISORT_1:
	cmp RSI, [size]
	jge AISORT1_END
	mov RDI, RSI
	inc RDI
	AISORT_2:
		cmp RDI, [size]
		jge AISORT2_END
		mov RAX, [array+RSI*8]
		mov RBX, [array+RDI*8]
		cmp RAX, RBX
		jg AISWAP
		inc RDI
		jmp AISORT_2
	AISWAP:
		mov [array+RDI*8], RAX
		mov [array+RSI*8], RBX
		inc RDI
		jmp AISORT_2
	AISORT2_END:
		inc RSI
		jmp AISORT_1
AISORT1_END:
	mov RBX, 0    
        jmp PRINT_OUTPUT_MSG
;***************** Ascending INSERTION SORT END *******************   


;***************** DESCENDING INSERTION SORT START *******************        
DISORT_1:
	cmp RSI, [size]
	jge DISORT1_END
	mov RDI, RSI
	inc RDI
	DISORT_2:
		cmp RDI, [size]
		jge DISORT2_END
		mov RAX, [array+RSI*8]
		mov RBX, [array+RDI*8]
		cmp RAX, RBX
		jl DISWAP
		inc RDI
		jmp DISORT_2
	DISWAP:
		mov [array+RDI*8], RAX
		mov [array+RSI*8], RBX
		inc RDI
		jmp DISORT_2
	DISORT2_END:
		inc RSI
		jmp DISORT_1
DISORT1_END:
	mov RBX, 0    
        jmp PRINT_OUTPUT_MSG
;***************** DESCENDING INSERTION SORT END *******************     
    PRINT_OUTPUT_MSG:

        ;Clear RAX, RCX and RBX
        xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0

        ; Print the output message "The sorted array is:"
        mov RDI, output_msg
        call printf

        xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0


    PRINT_ARRAY:						
        ;Print array
        ; Iterate through the array and print each element and then goto END when reaching size

	    cmp RCX, [size]
	    jz END

        ;Get the next element at the array and put it in RAX then increment the counter
	    mov RAX, [array+RCX*8]			
	    inc RCX	
	    mov [counter], RCX

        ;Print the current element
	    mov RDI, output_format
	    mov RSI, RAX
	    call printf

	    mov RCX, [counter]
	    jmp PRINT_ARRAY


    END:	
        ; Print newline and clear registers
	    mov RDI, new_line
	    call printf

	    xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0
	
	    pop RBP
	    ret
