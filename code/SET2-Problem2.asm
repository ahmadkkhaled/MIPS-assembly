# Written by Ahmad Khaled - 9th of December 2019

###############################################################
# The following MIPS program reads an array of characters and #
# counts the number of vowels in it considering both lowercase#							     
# and uppercase characters.	                              #
###############################################################
.data
	vowels: .asciiz "aeiouAEIOU"
	inputPrompt: .asciiz "Enter a string: "
	outResult: .asciiz "The number of vowels is: "
	userInput: .space 100 # 100 bytes for 99 characters at most (mips appends null)
.text

.globl main
main:
	# print inputPrompt
	li $v0, 4 
	la $a0, inputPrompt
	syscall
	
	# read userInput
	la $a0, userInput
	li $a1, 100
	li $v0, 8
	syscall
	
	#initalizing counters
	li $s0, 0 # counter for the number of vowels
	la $s1, userInput # point to first byte (char) in userInput
        
        input_while: #while current character is not null
        	lb $t0, 0($s1)
        	addi $s1, $s1, 1
        	beqz $t0, print_result
        	
        	la $s2, vowels #point to first byte(char) in vowels
        	vowel_while:
        		lb $t1, 0($s2)
        		beqz $t1, input_while #if the pointer is currently at the end of vowels, goto input_while
        		addi $s2, $s2, 1
        		
        		#if( currentInputChar == currentVowel)
        		bne $t1, $t0, vowel_while 
        			addi $s0, $s0, 1 #increment vowel counter
        			j input_while        		
        print_result:
        	#print output message
        	la $a0, outResult
        	li $v0, 4
        	syscall
        	
        	#print number of vowels
        	move $a0, $s0
        	li $v0, 1
        	syscall
        	
exit: 
	li $v0, 10 # terminate program system call
	syscall			
	
	
	