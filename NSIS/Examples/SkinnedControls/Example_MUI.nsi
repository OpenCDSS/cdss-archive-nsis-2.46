; example_MUI.nsi

;--------------------------------

!define VERSION 1.0
!define NAME "SkinnedControls plugin for NSIS"

; The name of the installer
Name "${NAME} ${VERSION}"

; The file to write
OutFile "SkinnedControls${VERSION}.exe"

; The default installation directory
InstallDir $PROGRAMFILES\NSIS

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM Software\NSIS ""

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  !define MUI_UNABORTWARNING
  !define MUI_COMPONENTSPAGE_NODESC
  !define MUI_CUSTOMFUNCTION_GUIINIT myGUIInit
  !define MUI_CUSTOMFUNCTION_UNGUIINIT un.myGUIInit
  !define MUI_LICENSEPAGE_RADIOBUTTONS
  !define MUI_HEADERIMAGE
  
;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "..\..\Docs\SkinnedControls\license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
 
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH
  
  
;--------------------------------
;very important!!!

  XPStyle off

;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
; The stuff to install

Section "${NAME}"
  SectionIn RO
  
  SetOutPath $INSTDIR\Plugins
  File "..\..\Plugins\SkinnedControls.dll"
    
  SetOutPath $INSTDIR\Examples\SkinnedControls
  File "Example.nsi"
  File "Example_MUI.nsi"

  SetOutPath $INSTDIR\Contrib\SkinnedControls\skins
  File "..\..\Contrib\SkinnedControls\skins\*.bmp"
  
  SetOutPath $INSTDIR\Docs\SkinnedControls
  File "..\..\Docs\SkinnedControls\*.*"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "DisplayName" "${NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "UninstallString" '"$INSTDIR\uninstall_SkinnedControls.exe"'
  WriteUninstaller "uninstall_SkinnedControls.exe"
  
  SetOutPath "$SMPROGRAMS\NSIS\Contrib\"
  CreateShortCut "$SMPROGRAMS\NSIS\Contrib\SkinnedControls Readme.lnk" "$INSTDIR\Docs\SkinnedControls\Readme.txt"
  CreateShortCut "$SMPROGRAMS\NSIS\Contrib\Uninstall SkinnedControls.lnk" "$INSTDIR\uninstall_SkinnedControls.exe"

SectionEnd

Section "Source Code"
    
  SetOutPath $INSTDIR\Contrib\SkinnedControls
  File "..\..\Contrib\SkinnedControls\wa_dlg.h"
  File "..\..\Contrib\SkinnedControls\wa_scrollbars.h"
  File "..\..\Contrib\SkinnedControls\exdll.h"
  File "..\..\Contrib\SkinnedControls\wa_scrollbars.c"
  File "..\..\Contrib\SkinnedControls\SkinnedControls.c"
  File "..\..\Contrib\SkinnedControls\SkinnedControls.sln"
  File "..\..\Contrib\SkinnedControls\SkinnedControls.vcproj"
  SetOutPath $INSTDIR\Contrib\SkinnedControls\coolsb
  File "..\..\Contrib\SkinnedControls\coolsb\*.h"
  File "..\..\Contrib\SkinnedControls\coolsb\*.c"
  File "..\..\Contrib\SkinnedControls\coolsb\detours.lib"
  File "..\..\Contrib\SkinnedControls\coolsb\coolsb.vcproj"
    
SectionEnd

;--------------------------------
; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"
  DeleteRegKey HKLM "SOFTWARE\NSIS\${NAME}"

  Delete "$INSTDIR\Plugins\SkinnedControls.dll"
  RMDir /r "$INSTDIR\Contrib\SkinnedControls"
  Delete "$INSTDIR\Docs\SkinnedControls\*.*"
  RMDir "$INSTDIR\Docs\SkinnedControls"
  Delete "$INSTDIR\Examples\SkinnedControls\*.nsi"
  RMDir "$INSTDIR\Examples\SkinnedControls"
  
  Delete "$SMPROGRAMS\NSIS\Contrib\SkinnedControls Readme.lnk"
  Delete "$SMPROGRAMS\NSIS\Contrib\Uninstall SkinnedControls.lnk"
  RMDir "$SMPROGRAMS\NSIS\Contrib"
  RMDir "$SMPROGRAMS\NSIS"
  Delete "$INSTDIR\uninstall_SkinnedControls.exe"
  
SectionEnd



;-------------------------
; Skin the button

Function .onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\SkinnedControls\skins\defaultbtn.bmp"
  File "/oname=$PLUGINSDIR\scrollbar.bmp" "${NSISDIR}\Contrib\SkinnedControls\skins\defaultsb.bmp"
FunctionEnd

Function myGUIInit
  ; start the plugin
	; the /disabledtextcolor, /selectedtextcolor and /textcolor parameters are optionnal
	SkinnedControls::skinit /NOUNLOAD \
				/disabledtextcolor=808080 \
				/selectedtextcolor=000080 \
				/textcolor=000000 \
				"/scrollbar=$PLUGINSDIR\scrollbar.bmp" \
				"/button=$PLUGINSDIR\button.bmp"
  Pop $0
  StrCmp $0 "success" noerror
    MessageBox MB_ICONEXCLAMATION|MB_OK "SkinnedControls error: $0"
  noerror:
FunctionEnd

Function .onGUIEnd
  ; stop the plugin
  SkinnedControls::unskinit
FunctionEnd

Function un.onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\SkinnedControls\skins\defaultbtn.bmp"
  File "/oname=$PLUGINSDIR\scrollbar.bmp" "${NSISDIR}\Contrib\SkinnedControls\skins\defaultsb.bmp"
FunctionEnd

Function un.myGUIInit
  ; start the plugin
	; the /disabledtextcolor, /selectedtextcolor and /textcolor parameters are optionnal
	SkinnedControls::skinit /NOUNLOAD \
				/disabledtextcolor=808080 \
				/selectedtextcolor=000080 \
				/textcolor=000000 \
				"/scrollbar=$PLUGINSDIR\scrollbar.bmp" \
				"/button=$PLUGINSDIR\button.bmp"
  Pop $0
  StrCmp $0 "success" noerror
    MessageBox MB_ICONEXCLAMATION|MB_OK "SkinnedScrollBar error: $0"
  noerror:
FunctionEnd

Function un.onGUIEnd
  ; stop the plugin
	SkinnedControls::unskinit
FunctionEnd