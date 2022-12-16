        .ORIG x3000

        LEA R6, stackb

main:   LEA R1, string  ;Chargement de la chaîne
        LD R2, char     ;Chargement de la lettre, NB: LEA!=LD
        JSR rindex
        TRAP x25

        ;; rindex
        ;;@param R1 adresse de la chaîne de caractères
        ;;@param R2 adresse du caractère recherché
        ;;@return R0 adresse de la dernière apparition du caractère

rindex: ADD R6, R6, -4  ;Prologue
        STR R1, R6, 0
        STR R2, R2, 1
        STR R3, R3, 2
        STR R4, R4, 3

        NOT R2, R2	;Inverser R2
        ADD R2, R2, 1   ;Ajouter -1
        ;;AND R0, R0, 0   ;Mise à 0 du compteur/résultat
        AND R3, R3, 0   ;-Lettre courante
        AND R4, R4, 0   ;-Dernière position où le char a été trouvé

loop:   LDR R3, R1, 0   ;Chargement dans R3 l'adresse de la chaîne
        BRz finn        ;Test de fin de chaîne

        ADD R3, R3, R2  ;Verifier si R3 est la meme lettre que R2
        BRz find        ;Une occurence a été trouvé

        BR incr

finn:   AND R0, R0, 0   ;Caractère introuvable
	;;AND R0, R0, 0
        ADD R0, R4, 0   ;Chargement de la position de la dernière occurence trouvé

        LDR R1, R6, 0
        LDR R2, R6, 1
        LDR R3, R6, 2
        LDR R4, R6, 3
        ADD R6, R6, 4
        RET

find:   ;;AND R4, R4, 0
	ADD R4, R1, 0
        ;;ADD R4, R0, 0   ;savegarde de la position du dernier char trouvé

incr:   ;;ADD R0, R0, 1   ;Incrémenter la position
        ADD R1, R1, 1   ;Incrémentation du pointeur
        BR loop

string: .STRINGZ "STRINGRI"

char:   .FILL 82        ;Représente la lettre 'R'

        .BLKW x90
stackb:

        .END
