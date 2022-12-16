        .ORIG x3000

        LEA R6, stackb

main:   LEA R1, string  ;Chargement de la chaîne
        LD R2, char     ;Chargement de la lettre, NB: LEA!=LD
        JSR index
        TRAP x25

        ;; index
        ;;@param R1 adresse de la chaîne de caractères
        ;;@param R2 adresse du caractère recherché
        ;;@return R0 adresse de la première apparition du caractère

index:  ADD R6, R6, -3  ;Prologue
        STR R1, R6, 0
        STR R2, R6, 1
        STR R3, R6, 2

        NOT R2, R2	;Inverser R2
        ADD R2, R2, 1   ;Ajouter -1
        AND R0, R0, 0   ;Mise à 0 du compteur/résultat
        AND R3, R3, 0   ;-Lettre courante

loop:   LDR R3, R1, 0   ;Chargement dans R3 l'adresse de la chaîne
        BRz finn        ;Test de fin de chaîne

        ADD R3, R3, R2  ;Verifier si R3 est la meme lettre que R2
        BRz fino        ;La première occurence a été trouvé

        ADD R0, R0, 1   ;Incrémenter la position
        ADD R1, R1, 1   ;Incrémentation du pointeur
        BR loop

finn:   AND R0, R0, 0   ;Caractère introuvable

fino:   LDR R1, R6, 0   ;Épilogue
        LDR R2, R6, 1
        LDR R3, R6, 2
        ADD R6, R6, 3
        RET

string: .STRINGZ "STRING"

char:   .FILL 82        ;Représente la lettre 'R'

        .BLKW x90
stackb:

       	.END
