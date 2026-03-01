; 名称：divdw
; 功能：进行不会产生溢出的除法运算，被除数为dword型，除数为word型，结果为dword型。
; 参数：
; (ax)=dword型数据的低16位
; (dx)=dword型数据的高16位
; (cx)=除数
; 返回：
; (dx)=结果的高16位，
; (ax)=结果的低16位
; (cx)=余数
; 应用举例：计算1000000/10(F4240H/0AH)
; mov ax,4240H
; mov dx,000FH
; mov cx,0AH
; call divdw
; 结果：(dx)=0001H,(ax)=86AOH,(cx)=0
; 公式：X/N=int(H/N)*65536+[rem(H/N)*65536+L]/N


ASSUME CS:CODESG,SS:STACKSG

STACKSG SEGMENT
               DW 8 DUP(0)
STACKSG ENDS

CODESG SEGMENT
       START: MOV  AX,STACKSG
              MOV  SS,AX
              MOV  SP,10H

              MOV  AX,4240H
              MOV  DX,000FH
              MOV  CX,0AH
              CALL DIVDW
         

       DIVDW: MOV  BX,AX            ;T1=L
              MOV  AX,DX
              MOV  DX,0
              DIV  CX               ;H/N =  AX int(H/N)
              MOV  BP,AX            ; T2= AX int(H/N)
              MOV  AX,BX
              DIV  CX
              MOV  CX,DX
              MOV  DX,BP
              RET
          
CODESG ENDS
END START
