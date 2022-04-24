#build 과정
# as로 어셈블리어 컴파일
# ld로 링킹

#Architecture, CPU -> as로 컴파일할 때 사용
ARCH = armv7-a
MCPU = cortex-a8

#Tool chains
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OC = arm-none-eabi-objcopy

LINKER_SCRIPT = ./Teock.ld

ASM_SRCS = $(wildcard boot/*.S)
ARM_OBJS = $(patsubst boot/%.S, build/%.o, $(ASM_SRCS))
#boot 안에 .S 파일 확장자를 .o로 바꾸고 build 폴더에 

Teock = build/Teock.axf
Teock_bin = build/Teock_bin

.PHONY: all clean run debug gdb

all: $(Teock)

clean:
	@rm -rf build

run: $(Teock)
	qemu-system-arm -M realview-pb-a8 -kernel $(Teock)

debug: $(Teock)
	qemu-system-arm -M realview-pb-a8 -kernel $(Teock) -S -gdb tcp::1234,ipv4

gdb:
	arm-none-eabi-gdb

$(Teock): $(ARM_OBJS) $(LINKER_SCRIPT)
	$(LD) -n -T $(LINKER_SCRIPT) -o $(Teock) $(ARM_OBJS)
	$(OC) -O binary $(Teock) $(Teock_bin)

#mkdir -p : 중간 폴더들도 연속으로 생성 /f1/f2/f3 ...
build/%.o: boot/%.S
	mkdir -p $(shell dirname $@)
	$(AS) -march=$(ARCH) -mcpu=$(MCPU) -g -o $@ $<