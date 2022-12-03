        .ORIG	x3000

        LEA R6, stbot

        ;; point d'entrée du programme
main:   LEA R1,str       ;R1 <-adresse de str
        LEA R2,copie     ;R2 <-adresse de copie
        JSR strcpy
        LEA R1,str2
        JSR strcpy
        TRAP x25

        ;;function strcpy(src, dst)
        ;;@param R1 addresse du premier caractère de la chaîne a copier (src)
        ;;@param R2 addresse du premier caractère de la destination (dst)   
        
strcpy: ADD R6,R6, -3
        STR R0,R6, 0
        STR R1,R6, 1
        STR R2,R6, 2    ;prologue

loopcpy:LDR R0,R1,0     ;while R0 <- R1 == 0
        BRz endcpy      ;{
        ADD R1,R1,1     ;   R1++
        STR R0,R2,0     ;   R2[0] <- R0
        ADD R2,R2,1     ;   R2++
        BR loopcpy      ;}
endcpy: STR R0,R2,0     ;R2[0]<-R0

        LDR R0,R6,0     ;prologue
        LDR R1,R6,1
        LDR R2,R6,2
        ADD R6,R6,3     
        ret

str:    .STRINGZ	"string"
str2:   .FILL	0
copie:  .BLKW	10


sttop:  .BLKW 100
stbot:

        .END