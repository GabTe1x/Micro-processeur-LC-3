        .ORIG	x3000

        LEA R6, stbot

        ;; point d'entrée du programme
main:   AND R0,R0,0
        ADD R0,R0,3
        LEA R1,str       ;R1 <-adresse de str
        LEA R2,copie     ;R2 <-adresse de copie
        JSR strncpy
        LEA R1,str2
        JSR strncpy
        TRAP x25

        ;; strncpy(src,dest,n)
        ;;@param R1 addresse du premier caractère de la chaîne a copier src: 
        ;;@param R2 addresse du premier caractère de la destination : dest
        ;;@param R0 nombre de caractère a copier : n
        
strncpy: ADD R6,R6, -4
        STR R0,R6, 0
        STR R1,R6, 1
        STR R2,R6, 2    
        STR R3,R6, 3    ;prologue

        AND R0,R0,R0
        BRnz endncpy    ;si R0 <= 0 goto endncpy
                
                        ;do{
loopncpy:LDR R3,R1,0    ; R3 <- R1[0]
        STR R3,R2,0     ; R2[0] <- R3
        ADD R1,R1,1     ; R1++
        ADD R2,R2,1     ; R2++
        ADD R0,R0,-1    ; R0 --
        BRp loopncpy    ;}while( R0 > 0 )

endncpy:LDR R0,R6,0     ;prologue
        LDR R1,R6,1
        LDR R2,R6,2
        LDR R3,R6,3
        ADD R6,R6,4    
        ret

str:    .STRINGZ	"string"
str2:   .FILL	0
copie:  .BLKW	10


sttop:  .BLKW 100
stbot:

        .END