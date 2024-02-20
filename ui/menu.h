/* Copyright 2023 Dual Tachyon
 * https://github.com/DualTachyon
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */

#ifndef UI_MENU_H
#define UI_MENU_H

#include <stdbool.h>
#include <stdint.h>
//#define MENU_ITEMS_COUNT 56

enum {
	MENU_SQL		= 0,
	MENU_STEP,
	MENU_TXP,
	MENU_R_DCS,
	MENU_R_CTCS,
	MENU_T_DCS,
	MENU_T_CTCS,
	MENU_SFT_D,
	MENU_OFFSET,
	MENU_W_N,
#ifdef ENABLE_LIVESEEK_MHZ_KEYPAD
	MENU_LIVESEEK,
#endif	
	MENU_SCR,
	MENU_BCL,
	MENU_MEM_CH,
	MENU_SAVE,
	MENU_VOX,
	MENU_ABR,
	//invert here
	#ifdef ENABLE_LCD_CONTRAST_OPTION
	MENU_CONTRAST,
	#endif
	MENU_TDR,
	MENU_WX,
#ifdef ENABLE_MESSENGER_ENCRYPTION
	MENU_ENC_KEY,
	MENU_MSG_ENC,
#endif
#ifdef ENABLE_MESSENGER
	MENU_MSG_ACK,
	MENU_MSG_MODULATION,
	#ifdef ENABLE_MESSENGER_ROGERBEEP_NOTIFICATION
	MENU_MSG_NOTIFICATION,
	#endif		
#endif	
	MENU_BEEP,
	MENU_TOT,
//	MENU_VOICE,
	MENU_SC_REV,
	MENU_MDF,
	MENU_AUTOLK,
	MENU_S_ADD1,
	MENU_S_ADD2,
	MENU_STE,
	MENU_RP_STE,
	MENU_MIC,
	MENU_1_CALL,
	MENU_S_LIST,
	MENU_SLIST1,
	MENU_SLIST2,
#ifdef ENABLE_DTMF_CALLING
	MENU_ANI_ID,
	MENU_UPCODE,
	MENU_DWCODE,
	MENU_D_ST,
	MENU_D_RSP,
	MENU_D_HOLD,
	MENU_D_PRE,
	MENU_PTT_ID,
	MENU_D_DCD,
	MENU_D_LIST,
#endif	
	MENU_PONMSG,
#if defined (ENABLE_ROGERBEEP) || defined (ENABLE_MDC)
	MENU_ROGER,
#endif
	MENU_VOL,
#ifdef ENABLE_STATUS_BATTERY_PERC	
	MENU_BATTYP,
#endif
	MENU_AM,
	MENU_DEL_CH,
	MENU_RESET,
	MENU_UPCONVERTER,
#ifdef ENABLE_DOCK
	MENU_REMOTE_UI,
#endif		
	MENU_350TX,
	MENU_F_LOCK,
	MENU_200TX,
	MENU_500TX,
	MENU_ALL_TX,
	MENU_SCREN,
};

extern bool gIsInSubMenu;

extern uint8_t gMenuCursor;
extern int8_t gMenuScrollDirection;
extern uint32_t gSubMenuSelection;
#if defined (ENABLE_ROGERBEEP) && defined (ENABLE_MDC)
extern const char gSubMenu_ROGER[11][9];
#elif defined (ENABLE_ROGERBEEP) && !defined (ENABLE_MDC)
extern const char gSubMenu_ROGER[10][9];
#elif defined (ENABLE_MDC) && !defined (ENABLE_ROGERBEEP)
extern const char gSubMenu_ROGER[2][4];
#endif
#ifdef ENABLE_LIVESEEK_MHZ_KEYPAD
extern const char gSubMenu_LIVESEEK[3][6];
#endif

#ifdef ENABLE_MESSENGER
extern const char        gSubMenu_MSG_MODULATION[3][10];
#endif

extern char              edit[17];
extern int               edit_index;

void UI_DisplayMenu(void);

#endif

