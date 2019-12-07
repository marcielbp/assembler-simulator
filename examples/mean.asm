;Escreva um programa em Assembly que calcule a média aritmética de uma sequência de até 10 números inteiros armazenados em formato ASCII entre 0 e 9 e exiba o resultado com uma casa decimal de precisão. Ex.: o vetor X= '1;7;3;6;5;5;2' possui média aritmética '4,1'. Exibir o resultado na saída na forma: 'MED(1;7;3;6;5;5;2) = 4,1'.

JMP start
num1:DB "1;3;2;6;5;7"
    	DB 0
	RES:   DB 0d
	RES2: DB 0d
	RES3: DB 0d
	RES4: DB 0d
	P1VALOR: DB 0d
	P2VALOR: DB 0d
	PMEDIA: DB "MED: "
	DB 0
start:
	MOV C, num1 ;copia num1 em C
	MOV B, 0d
	MOV D, 0d
.loop:
	MOV A, [C] ;copia c em A
	CMP A, 59d ;comparando o conteúdo de A com 59d
	JE pontoevirgula ;pule se for igual
	SUB A, 48d ;subtrair A de 48d, e vai colocar o res em A
	ADD B, A ;somar B com A e colocar o resultado em B
pontoevirgula:
	INC C ;vai incrementar C
	CMP D, [C] ;compara o valor de D com C
	JNZ .loop ;salte se não for zero
	MOV A, C
	DIV 2d
	MOV C, A
	MOV A, B ;copia B em A
	MOV B, C ;copia C em B
	MOV [RES], A
	DIV B
	MOV [P1VALOR], A ;RECEBENDO O VALOR DE 4, QUE É A PARTE INTERIRA DE DIVISÃO
	MUL B ;VALOR 24
	MOV [RES2], A
	MOV B, [RES]
	SUB B, A ; B = 2
	MOV [RES3], B ;vou copiar o valor de 2 no RES3
	MOV A, [RES3] ;vou copiar o valor de RES3 para A
	MUL 10 ;vou mult o valor de 10 pelo A que é 2
	DIV C ;ESSE C, SIGNIFICA A QUANTIDADE DOS NÚMEROS
	MOV [P2VALOR], A ;REBECE O VALOR DE 3, QUE É O PRIMEIRO VALOR DEPOIS DA VÍRGULA
	MOV [RES4], A ;A RES4 ESTÁ RECEBENDO O VALOR DE 3, QUE ESTAVE EM "A"
	MOV D, 0xE8
	MOV C, PMEDIA
.IMEDIA:
	MOV A ,[C]
	CMP A, 0
	JE .FMEDIA
	MOV [D], A
	INC D
	INC C
	JMP .IMEDIA
.FMEDIA:
	MOV A, [P1VALOR]
	ADD A, '0'
	MOV [D], A
	INC D
	MOV [D], ','
	INC D
	MOV A, [P2VALOR]
	ADD A, '0'
	MOV [D], A
HLT