JMP fib

limite: DB 55           ;O display só cabe até o 55
ppos: DB 0xE8
fib:
.init:
    MOV A, 0            ;mais anterioir
    MOV B, 1            ;anterior
    MOV C, 1            ;resultado
.loop:
    CMP C, [limite]     ;while(c <= limite)
    JA .fim

    PUSH C              ;passo o argumento por pilha
    CALL imprimir
    INC SP              ;libera a pilha, mesmo que ADD SP, 1

    ADD C, A, B         ;C = A + B
    MOV A, B            ;atualiza a e b
    MOV B, C            ;ou seja, os valores anteriores
    JMP .loop
.fim:
    HLT

imprimir:               ;void (byte valor)
    PUSH A              ;uso a pilha para proteger os valores
    PUSH B              ;presentes nesses registradores
    PUSH C              ;antes dessa funcao
    PUSH D              ;pois está "funcao" os usa

                        ;4 dos PUSH, 1 do retorno e 1 pois a pilha está a frente
    MOV B, [SP+6]       ;Recebe o argumento por valor

    MOV A, B
    DIV 10              ;A contem a dezena

    MOV D, [ppos]       ;carrega a posicao de impressao
    CMP A, 0
    JE .unidade;        ;Se A = 0, não preciso imprimi-lo

    MOV C, A
    ADD C, '0'          ;C = ASCII(A)

    MOV [D], C          ;escreve C
    INC D               ;D++

    MUL 10              ;A *= 10
    SUB B, A            ;B contém a unidade

.unidade:               ;se chegar aqui pelo salto, nem precisa de B -= A
    MOV C, B
    ADD C, '0'          ;C = ASCII(B)
    MOV [D], C          ;imprime C
    INC D

    MOV [D], ' '        ;escreve o espaco
    INC D

    MOV [ppos], D       ;salva a nova posicao de escrita

    POP D               ;retorna os antigos valores
    POP C               ;desses registradores
    POP B
    POP A
    RET                 ;emfim retorna
