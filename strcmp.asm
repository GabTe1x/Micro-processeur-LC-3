        .ORIG	x3000

        LEA R6, stbot

        ;; point d'entrée du programme
main:   LEA R1,str1     ;R1 <-adresse de str1
        LEA R2,str2     ;R2 <-adresse de str2
        JSR strcmp
        TRAP x25

        ;;function strcmp(src1, src2)
        ;;@param R1 addresse du premier caractère d'un mot (src1)
        ;;@param R2 addresse du premier caractère d'un autre mot (src2)        
        ;;@res R0 nbr de diffèrence entre le premier caractère différent de src1 et src2

strcmp: ADD R6,R6, -3
        STR R1,R6, 0
        STR R2,R6, 1     
        STR R3,R6, 2    ;prologue
                        
                        ;do
                        ;{   
loop:   LDR R0,R2,0     ;   R0 <- R2[0]
        LDR R3,R1,0     ;   R3 <- R1[0]
        ADD R1,R1,1     ;   R1++
        ADD R2,R2,1     ;   R2++
        NOT R3,R3       
        ADD R3,R3,1     ;   R3 = inverse R3
        ADD R0,R0,R3    ;   R0 = R0+R3
        BRz loop        ; }while(R0==0)

        LDR R1,R6, 0    ;prologue
        LDR R2,R6, 1
        LDR R3,R6, 2
        ADD R6,R6, 3 
        RET        


str1:   .STRINGZ	"string"
str2    .STRINGZ	"stringi"

sttop:  .BLKW 100
stbot:

        .END