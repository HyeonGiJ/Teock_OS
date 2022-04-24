.text
    .code 32    # 명령어 크기
    #extern lable
    .global vector_start
    .global vector_end

    vector_start:
        LDR R0, =0x10000000
        #할당 연산, HW ID Register
        LDR R1, [R0]       
        # 0x10000000에서 값 읽어서 R1에 저장
    
    vector_end:
        .space 1024, 0
.end    #text section