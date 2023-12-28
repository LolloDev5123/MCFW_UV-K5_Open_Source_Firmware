# People who help making this Code
# Matoz @spm81 | Joaquim @joaquimorg | Need your name here ;)
TARGET = firmware

ENABLE_AIRCOPY 							:= 0

#AM Modulation
#ENABLE_AM_FIX - 544 bytes
ENABLE_AM_FIX 							:= 1
#ENABLE_AM_FIX_ON_SPECTRUM - 40 bytes
ENABLE_AM_FIX_ON_SPECTRUM				:= 1

#FM Radio
#ENABLE_FMRADIO - 3856 bytes
ENABLE_FMRADIO							:= 1
#ENABLE_FMRADIO_FAST_RESTORE - 0 bytes
# Restore FM Radio in 1 second after RX
ENABLE_FMRADIO_FAST_RESTORE 			:= 1


ENABLE_OVERLAY 							:= 0
ENABLE_SWD 								:= 0

ENABLE_TX1750 							:= 0

#Battery Percentage in Status Bar	296 bytes
ENABLE_STATUS_BATTERY_PERC  			:= 1

#More LCD Settings
ENABLE_LCD_INVERT_OPTION				:= 0
# ENABLE_LCD_CONTRAST_OPTION Not working ...... yet, don't use it. Keep it at 0
#ENABLE_LCD_CONTRAST_OPTION 				:= 0 


#Sound Bar(s) 255 bytes // MIC_PLUS_GAIN_BAR_TX by LolloDev5123
ENABLE_MIC_PLUS_GAIN_BAR_TX 			:= 1

#SOS Flashlight 84 bytes
ENABLE_FLASHLIGHT_SOS       			:= 1


#UART
ENABLE_UART                 			:= 1
ENABLE_UART_CAT             			:= 0

#Trying to remove all about DTMF (Incomplete.. Have to check it better) ) 
ENABLE_DTMF_CALLING         			:= 0
#DTMF FN1 1750hz & FN2 1050hz Tones
ENABLE_DTMF_CALLING_FN1_FN2				:= 1

#Options
ENABLE_NOSCANTIMEOUT        			:= 1
ENABLE_KEEPNAMEONSAVE       			:= 1
ENABLE_FASTER_CHANNEL_SCAN  			:= 1

#Roger - To Enable MDC, ROGERBEEP HAS TO BE ENABLED
ENABLE_ROGERBEEP            			:= 0
ENABLE_MDC                  			:= 0	

#Spectrum
ENABLE_SPECTRUM             			:= 1
SPECTRUM_AUTOMATIC_SQUELCH  			:= 1
SPECTRUM_EXTRA_VALUES       			:= 1
ENABLE_ALL_REGISTERS        			:= 0
ENABLE_MATOZ_KEYS           			:= 1

#Messenger ( Thanks to joaquimorg https://github.com/joaquimorg )
ENABLE_MESSENGER            			:= 1
ENABLE_MESSENGER_DELIVERY_NOTIFICATION	:= 1
#ENABLE_MESSENGER_UART - 156 bytes
ENABLE_MESSENGER_UART					:= 0

#Try to implement CW Modulation like IJV
ENABLE_CW                   			:= 0

BSP_DEFINITIONS := $(wildcard hardware/*/*.def)
BSP_HEADERS := $(patsubst hardware/%,bsp/%,$(BSP_DEFINITIONS))
BSP_HEADERS := $(patsubst %.def,%.h,$(BSP_HEADERS))

OBJS =
# Startup files
OBJS += start.o
OBJS += init.o
ifeq ($(ENABLE_OVERLAY),1)
OBJS += sram-overlay.o
endif
OBJS += external/printf/printf.o

# Drivers
OBJS += driver/adc.o
ifeq ($(ENABLE_UART),1)
OBJS += driver/aes.o
endif
ifeq ($(ENABLE_MESSENGER),1)
	OBJS += app/messenger.o
endif
OBJS += driver/backlight.o
ifeq ($(ENABLE_FMRADIO),1)
OBJS += driver/bk1080.o
endif
OBJS += driver/bk4819.o
ifeq ($(filter $(ENABLE_AIRCOPY) $(ENABLE_UART),1),1)
OBJS += driver/crc.o
endif
OBJS += driver/eeprom.o
ifeq ($(ENABLE_OVERLAY),1)
OBJS += driver/flash.o
endif
OBJS += driver/gpio.o
OBJS += driver/i2c.o
OBJS += driver/keyboard.o
OBJS += driver/spi.o
OBJS += driver/st7565.o
OBJS += driver/system.o
OBJS += driver/systick.o
ifeq ($(ENABLE_UART),1)
OBJS += driver/uart.o
endif

# Main
OBJS += app/action.o
ifeq ($(ENABLE_AM_FIX),1)
OBJS += am_fix.o
endif
ifeq ($(ENABLE_AIRCOPY),1)
OBJS += app/aircopy.o
endif
OBJS += app/app.o
OBJS += app/dtmf.o
OBJS += app/finput.o
ifeq ($(ENABLE_FMRADIO),1)
OBJS += app/fm.o
endif
OBJS += app/generic.o
OBJS += app/main.o
OBJS += app/menu.o
OBJS += app/appmenu.o
OBJS += app/scanner.o
ifeq ($(ENABLE_SPECTRUM), 1)
OBJS += app/spectrum.o
endif
ifeq ($(ENABLE_UART),1)
OBJS += app/uart.o
endif
OBJS += audio.o
OBJS += bitmaps.o
OBJS += board.o
OBJS += dcs.o
OBJS += font.o
OBJS += frequencies.o
OBJS += functions.o
OBJS += helper/battery.o
OBJS += helper/boot.o
OBJS += helper/measurements.o
OBJS += misc.o
OBJS += radio.o
OBJS += scheduler.o
OBJS += settings.o
ifeq ($(ENABLE_AIRCOPY),1)
OBJS += ui/aircopy.o
endif
OBJS += ui/battery.o
ifeq ($(ENABLE_FMRADIO),1)
OBJS += ui/fmradio.o
endif
ifeq ($(ENABLE_MESSENGER),1)
	OBJS += ui/messenger.o
endif
OBJS += ui/helper.o
OBJS += ui/inputbox.o
OBJS += ui/lock.o
OBJS += ui/main.o
OBJS += ui/menu.o
OBJS += ui/appmenu.o
OBJS += ui/rssi.o
OBJS += ui/scanner.o
OBJS += ui/status.o
OBJS += ui/ui.o
OBJS += ui/welcome.o
OBJS += apps/scanlist.o
OBJS += version.o

OBJS += main.o

ifeq ($(OS),Windows_NT)
	TOP := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
	RM = del /Q
	FixPath = $(subst /,\,$1)
else
	TOP := $(shell pwd)
	RM = rm -f
    FixPath = $1
endif

AS = arm-none-eabi-gcc
CC = arm-none-eabi-gcc
LD = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

GIT_HASH := $(shell git rev-parse --short HEAD)

ASFLAGS = -c -mcpu=cortex-m0
ifeq ($(ENABLE_OVERLAY),1)
ASFLAGS += -DENABLE_OVERLAY
endif

CFLAGS = -Os -Wall -Werror -mcpu=cortex-m0 -fno-builtin -fshort-enums -fno-delete-null-pointer-checks -std=c11 -MMD
CFLAGS += -DPRINTF_INCLUDE_CONFIG_H
CFLAGS += -DGIT_HASH=\"$(GIT_HASH)\"

ifeq ($(ENABLE_LCD_INVERT_OPTION),1)
	CFLAGS += -DENABLE_LCD_INVERT_OPTION
endif
ifeq ($(ENABLE_AIRCOPY),1)
	CFLAGS += -DENABLE_AIRCOPY
endif
ifeq ($(ENABLE_DTMF_CALLING),1)
	CFLAGS += -DENABLE_DTMF_CALLING
endif
ifeq ($(ENABLE_DTMF_CALLING_FN1_FN2),1)
	CFLAGS += -DENABLE_DTMF_CALLING_FN1_FN2
endif
ifeq ($(ENABLE_MIC_PLUS_GAIN_BAR_TX),1)
	CFLAGS += -DENABLE_MIC_PLUS_GAIN_BAR_TX
endif
ifeq ($(ENABLE_FLASHLIGHT_SOS),1)
	CFLAGS  += -DENABLE_FLASHLIGHT_SOS
endif
ifeq ($(ENABLE_AM_FIX),1)
	CFLAGS  += -DENABLE_AM_FIX
endif
ifeq ($(ENABLE_AM_FIX_ON_SPECTRUM),1)
	CFLAGS  += -DENABLE_AM_FIX_ON_SPECTRUM
endif
ifeq ($(ENABLE_FMRADIO),1)
	CFLAGS += -DENABLE_FMRADIO
endif
ifeq ($(ENABLE_FMRADIO_FAST_RESTORE),1)
	CFLAGS += -DENABLE_FMRADIO_FAST_RESTORE
endif
ifeq ($(ENABLE_ROGERBEEP),1)
	CFLAGS += -DENABLE_ROGERBEEP
endif
ifeq ($(ENABLE_MDC),1)
	CFLAGS += -DENABLE_MDC
endif
ifeq ($(ENABLE_OVERLAY),1)
	CFLAGS += -DENABLE_OVERLAY
endif
ifeq ($(ENABLE_SPECTRUM),1)
	CFLAGS += -DENABLE_SPECTRUM
endif
ifeq ($(ENABLE_SWD),1)
	CFLAGS += -DENABLE_SWD
endif
ifeq ($(ENABLE_TX1750),1)
	CFLAGS += -DENABLE_TX1750
endif
ifeq ($(ENABLE_STATUS_BATTERY_PERC),1)
	CFLAGS += -DENABLE_STATUS_BATTERY_PERC
endif
ifeq ($(ENABLE_LCD_CONTRAST_OPTION),1)
	CFLAGS  += -DENABLE_LCD_CONTRAST_OPTION
endif
ifeq ($(ENABLE_UART),1)
	CFLAGS += -DENABLE_UART
endif
LDFLAGS = -mcpu=cortex-m0 -nostartfiles -Wl,-T,firmware.ld
ifeq ($(ENABLE_NOSCANTIMEOUT),1)
	CFLAGS += -DENABLE_NOSCANTIMEOUT
endif
ifeq ($(ENABLE_KEEPNAMEONSAVE),1)
	CFLAGS += -DENABLE_KEEPNAMEONSAVE
endif
ifeq ($(ENABLE_FASTER_CHANNEL_SCAN),1)
	CFLAGS  += -DENABLE_FASTER_CHANNEL_SCAN
endif
ifeq ($(ENABLE_ALL_REGISTERS),1)
	CFLAGS += -DENABLE_ALL_REGISTERS
endif
ifeq ($(ENABLE_UART_CAT),1)
	CFLAGS += -DENABLE_UART_CAT
endif
ifeq ($(SPECTRUM_AUTOMATIC_SQUELCH),1)
	CFLAGS += -DSPECTRUM_AUTOMATIC_SQUELCH
endif
ifeq ($(SPECTRUM_EXTRA_VALUES),1)
	CFLAGS += -DSPECTRUM_EXTRA_VALUES
endif
ifeq ($(ENABLE_MATOZ_KEYS),1)
	CFLAGS += -DENABLE_MATOZ_KEYS
endif
ifeq ($(ENABLE_MESSENGER),1)
	CFLAGS += -DENABLE_MESSENGER
endif
ifeq ($(ENABLE_MESSENGER_DELIVERY_NOTIFICATION),1)
	CFLAGS += -DENABLE_MESSENGER_DELIVERY_NOTIFICATION
endif
ifeq ($(ENABLE_MESSENGER_UART),1)
	CFLAGS += -DENABLE_MESSENGER_UART
endif
ifeq ($(ENABLE_CW),1)
	CFLAGS += -DENABLE_CW
endif


ifeq ($(DEBUG),1)
ASFLAGS += -g
CFLAGS += -g
LDFLAGS += -g
endif

INC =
INC += -I $(TOP)
INC += -I $(TOP)/external/CMSIS_5/CMSIS/Core/Include/
INC += -I $(TOP)/external/CMSIS_5/Device/ARM/ARMCM0/Include

LIBS =

DEPS = $(OBJS:.o=.d)

all: $(TARGET)
	$(OBJCOPY) -O binary $< $<.bin
	-python fw-pack.py $<.bin $(GIT_HASH) $<.packed.bin
	-python3 fw-pack.py $<.bin $(GIT_HASH) $<.packed.bin
	$(SIZE) $<

debug:
	/opt/openocd/bin/openocd -c "bindto 0.0.0.0" -f interface/jlink.cfg -f dp32g030.cfg

flash:
	/opt/openocd/bin/openocd -c "bindto 0.0.0.0" -f interface/jlink.cfg -f dp32g030.cfg -c "write_image firmware.bin 0; shutdown;"

version.o: .FORCE

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@ $(LIBS)

bsp/dp32g030/%.h: hardware/dp32g030/%.def

%.o: %.c | $(BSP_HEADERS)
	$(CC) $(CFLAGS) $(INC) -c $< -o $@

%.o: %.S
	$(AS) $(ASFLAGS) $< -o $@

.FORCE:

-include $(DEPS)

clean:
#	rm -f $(TARGET).bin $(TARGET) $(OBJS) $(DEPS)
	$(RM) $(call FixPath, $(TARGET) $(OBJS) $(DEPS))

