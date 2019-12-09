# Written by Ahmad Khaled - 9th of December 2019

################################################################
# The following program applies the following C code segment on#
# an array of integers:                                        #							     
# for(int i=0; i<N; i++) 				       #	
#	for(int j = 0; j < i; j++)                             #
#		arr[i] += j;                                   #
################################################################
.data
	arr: .word 0, 0, 0, 0, 0, 0, 0, 0
	spacer: .asciiz " "
.text

.globl main
main:
	la $t0, arr # load memory address of arr in $t0
	li $t1, 0   # set loop counter to 0 (i = 0)
	li $t2, 8   # set loop end          (N = 5)
	i_loop:
		beq $t1, $t2, exit # branch on (i == 8)
		li $t3, 0 # set inner loop counter to 0 (j = 0)
		j_loop:
			beq $t3, $t1, j_end # branch on (j == i)
			lw $t6, 0($t0) # load contents of arr[i]
			add $t6, $t6, $t3 # arr[i]  = arr[i] + j
			sw $t6, 0($t0) #store contents of $t6 into arr[i]
			addi $t3, $t3, 1
			j j_loop	
		j_end:
			#print arr[i]
			lw $a0, 0($t0)
			li $v0, 1
			syscall
			#print whitespace
			la $a0, spacer
			li $v0, 4
			syscall
			
			#increment i
			addi $t1, $t1, 1
			addi $t0, $t0, 4
			j i_loop
exit: 
	li $v0, 10 # terminate program system call
	syscall			
	
	
	