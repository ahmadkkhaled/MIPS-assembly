# Written by Ahmad Khaled - 9th of December 2019

##############################################################
# The following MIPS program implements this C code segment: #
#	if(g <= h && g > 0) 				     #
#		g = h;                                       #
#	else 						     #
#		h = g;                                       #
##############################################################
.data

.text

.globl main

main:	
	li $v0, 5 #read G
	syscall
	add $s0, $0, $v0 #store g in $s0
	
	li $v0, 5 #read h
	syscall
	add $s1, $0, $v0 #store h in $s1
	
	bgt $s0, $s1, else # if (g<=h) -> branch if g > h
	blez $s0, else     # if (g > 0) -> branch if g <= 0
		move $s0, $s1 # g = h
		j exit
		
	else:
		move $s1, $s0 # h = g
		 
exit: 
	li $v0, 10 # terminate program system call
	syscall			
	
	
	