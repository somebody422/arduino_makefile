
########################################################
## SET THESE: ##

arduino_base_dir = arduino-1.8.8




cc = avr-gcc

# removed: -c -g/?
cc_flags = -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -MMD -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10808 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR

# All sources files associated with arduino core
arduino_core_src = $(wildcard $(arduino_base_dir)/hardware/arduino/avr/cores/arduino/*.c)

arduino_core_dir = $(arduino_base_dir)/hardware/arduino/avr/cores/arduino

arduino_core_include_dirs = $(arduino_core_dir) $(arduino_base_dir)/hardware/arduino/avr/variants/standard
#arduino_core_include = $(wildcard $(arduino_base_dir)/hardware/arduino/avr/cores/arduino/*.h)
#arduino_core_include = $(foreach dir,$(arduino_core_include_dirs),$(wildcard $(dir)/*.h))
arduino_core_include_string = $(patsubst %,-I%, $(arduino_core_include_dirs))

# TODO: how to choose variant?
arduino_core_src += $(wildcard $(arduino_base_dir)/hardware/arduino/avr/variants/standard/*.h)
arduino_core_obj = $(patsubst %.c,obj/%.o, $(notdir $(arduino_core_src)))


include_dirs = $(arduino_core_include)
include_string = $(patsubst %,-I%, $(include_dirs))
sources = $(arduino_core_src)

all: $(arduino_core_obj)


$(arduino_core_obj): $(arduino_core_src)
	$(cc) $(cc_flags) $(arduino_core_include_string) -c $< -o $@


#$(arduino_core_src): obj/$(notdir %.o): %.c
#	echo $@ $<


#MCU = atmega328p
#ISP = avrisp2
#
####  Compiler Options  ####
# GCC FLAGS:
#	* -mcall-prologues - function prologue/epilogues expanded. Lowers overall code size
#  * -Wl, option - pass option on to the linker
#CC = avr-gcc
#CFLAGS = -g -Wall -mcall-prologues -mmcu=$(MCU) -Os
#LDFLAGS = -Wl,-gc-sections -Wl,-relax
#
#OBJCOPY_FLAGS = -R .eeprom
#
# Target: the name of the generated .hex file
#TARGET=NAME_ME
#
#SOURCE_FILES = $(wildcard ./*.c)
#OBJECT_FILES = $(patsubst %.c, %.o, $(SOURCE_FILES))
#
#first:
#	echo $(ARDUINO_CORE_SRC)
#
#
#all: $(TARGET).hex
#
#clean:
#	rm -f *.o *.hex *.obj *.hex
#
#%.hex: %.obj
#	avr-objcopy $(OBJCOPY_FLAGS) -O ihex $< $@
#
#%.obj: $(OBJECT_FILES)
#	$(CC) $(CFLAGS) $(OBJECT_FILES) $(LDFLAGS) -o $@
#
#upload: $(TARGET).hex
#	avrdude -p $(MCU) -c $(ISP) -U flash:w:$(TARGET).hex

