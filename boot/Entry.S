.text
    .code 32    # 명령어 크기
    #extern lable
    .global vector_start
    .global vector_end

    vector_start:
        MOV R0, R1
    
    vector_end:
        .space 1024, 0
.end    #text section