        .ORIG	x3000

        LEA R6, stbot

        ;; point d'entrée du programme
main:   LD R1,test
        JSR b2g
        TRAP x25

        ;;function bin2gray(int x)
        ;;@param R1 registre contenant un entier strictement positif sur 16bits      
        ;;@res R0 entier codé en code Gray

b2g:    ADD R6,R6, -4
        STR R1,R6, 0
        STR R2,R6, 1    
        STR R3,R6, 2
        STR R4,R6, 3
        STR R5,R6, 4    ;prologue
       
        AND R0,R0,0     ; R0 = 0
        LD R2,seize     ; R2 = 16
                        ;do{
loop:   ADD R2,R2,-1    ;    R2--;
        BRz end         ;    if(R2==0)break;

        ; APPEL A PUISSANCE DE 2^R2;
        ADD R6,R6,-1   
        STR  R7,R6,0    ; SAUVEGARDE DE R7
        JSR pow         ;APPEL
        LDR R7,R6,0     ; REMISE DANS R7 de la sauvegarde
        ADD R6,R6,1
        ; FIN DE L'APPEL 

        NOT R3,R3
        ADD R3,R3,1     ;   R3 = -R3
        ADD R4,R1,R3    ;   R4 = R1-R3
                        ;   if(R4>=0)
        BRn loop        ;   {
        NOT R3,R3
        ADD R3,R3,1     ;       R3=-R3 remis comme à la sortie de pow
        
        ADD R5,R3,0     ;       R5 = R3
        ADD R3,R3,R3    ;       R3 = R3*2
        NOT R4,R1       ;       R4 = -R1-1
        ADD R1,R3,R4    ;       R1 = R3-R1-1
        ADD R0,R0,R5    ;       RES/R0 = R0+R5
                        ;   }
        BR loop         ;}while(R2>0);
end:    ADD R0,R0,R1    ;res=+R1; C1(n) = n
        LDR R1,R6, 0    ;prologue
        LDR R2,R6, 1
        LDR R3,R6, 2
        LDR R4,R6, 3
        ADD R6,R6, 4
        RET


        ;;function 2^k
        ;;@param R2 registre la puissance k > 0    
        ;;@res R3 = 2^k

pow:    ADD R6, R6, -1  
        STR R2, R6, 0   ;Prologue

        AND R3, R3, 0   ;R3=0
        ADD R3,R3,2     ;R3=2
        ADD R2,R2,-1    ;R2--
        BRz skip

loop2:  ADD R3, R3, R3  ;R3*2
        ADD R2, R2, -1  ;R2--
        BRp loop2

skip:   LDR R2,R6,0
        ADD R6,R6,1     ;prologue
fin:    RET

seize:  .FILL 16


test:   .FILL 2;ENTIER test à modifier à la valeur que vous voulez utiliser

sttop:  .BLKW 100
stbot:

        .END