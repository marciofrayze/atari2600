; Cabeçalho padrão de todos os programas.
; Lembre-se: identação é importante!
    processor 6502
    seg code
    org $F000         ; define a origem em $F000

Start:
    sei               ; desabilita interrupts
    cld               ; desabilita BCD decimal math mode (vamos usar o modo binario, que é mais rapido mas menos preciso)
    ldx #$FF          ; carrega o registro x com o valor literal FF
    txs               ; transfere o valor do registro x para o stack register

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Zera a regiao Zero Page ($00 - $FF)
; que contem todo o espaço de registros da TIA e
; tambem memoria RAM.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0            ; A = 0
    ldx #$FF          ; X = #$FF

MemLoop:
    sta $0,X          ; armazena 0 no endereço $0 + x
    dex               ; x--
    bne MemLoop       ; loop até que X == 0 (zflag setada)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Tamanho da ROM precisa ser de exatos 4Kb.
; Precisamos preencher o restante.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word Start       ; reseta vector no $FFFC (onde programa inicia)
    .word Start       ; não utilizado pelo VCS (apenas para completar os 16 bits)
