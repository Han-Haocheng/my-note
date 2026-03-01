; 编写一个子程序，对两个128位数据进行相加。
; 名称：add128
; 功能：两个128位数据进行相加。
; 参数：
; ds:si指向存储第一个数的内存空间，因数据为128位，所以需要8个字单元，由低地址单元到高地址单元依次存放128位数据由低到高的各个字。
; ds:di指向存储第二个数的内存空间。
; 运算结果：存储在第一个数的存储空间中。

ASSUME CS:CODESG,DS:DATASG

DATASG SEGMENT
         DW 8 DUP(8888H)
         DW 8 DUP(1111H)
DATASG ENDS



CODESG SEGMENT
  START: MOV  AX,DATASG
         MOV  DS,AX
         MOV  SI,0
         MOV  DI,16

         CALL ADD128
         MOV  AX,4C00H
         INT  21H

  ADD128:PUSH AX
         PUSH CX
         PUSH SI
         PUSH DI

         SUB  AX,AX
         MOV  CX,8
  EXCL:  MOV  AX,DS:[SI]
         ADC  AX,DS:[DI]
         MOV  DS:[SI],AX
         INC  SI
         INC  SI
         INC  DI
         INC  DI
         LOOP EXCL

         POP  DI
         POP  SI
         POP  CX
         POP  AX
         RET
CODESG ENDS
END START
