; 编程，计算1E F000 1000H+20 1000 1EF0H,结果放在ax(最高16位),bx(次高16位),cx(低16位)中。


ASSUME CS:CODESG

CODESG SEGMENT
  START: MOV AX,1EH
         MOV BX,0F000H
         MOV CX,1000H
         ADD CX,1EF0H
         ADC BX,1000H
         ADC AX,20H

         MOV AX,4C00H
         INT 21H
CODESG ENDS
END START
