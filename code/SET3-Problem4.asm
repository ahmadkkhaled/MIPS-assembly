# Written by Ahmad Khaled - 9th of December 2019

#################################################################
# The following MIPS program implements this C++ code segment:  #
#	int x;							#
#	cin >> x;						#
#	cout << (isOdd(x) ? "odd" : "even");			#
#								#
#	int isOdd(int n) { return !isEven(n);     }		#
#	int isEven(int n){ return ( (n%2) == 0 ); } 	        #
#################################################################
.data
	odd:  .asciiz "odd"
	even: .asciiz "even"
.text

.globl main

main:	
	# read integer and store in $s1	
	li $v0, 5
	syscall
	move $a0, $v0
	
	#call isOdd()
	jal isOdd
	
	beqz $v1, printEven
		la $a0, odd
		li $v0, 4
		syscall
		j exit
	printEven:
		la $a0, even
		li $v0, 4
		syscall	
exit: 
	li $v0, 10 # terminate program system call
	syscall			
	
isEven:
	li $t1, 2 #store 2 in $t1
	div $a0, $t1 #divide $a0 by $t1 (pre-programmed to store remainder in hi register)
	mfhi $v1 # move the result of $a0 % 2 to the return register $v1
	xor $v1, 1 # set v1 to the result of ( ($a0 % 2) == 0 )
	jr $ra

isOdd:
	move $s0, $ra # store the address of the instruction after the function call in the caller segment
	jal isEven
	xor $v1, 1 # set v1 to the complement of v1 (return !isEven() )
	jr $s0
			