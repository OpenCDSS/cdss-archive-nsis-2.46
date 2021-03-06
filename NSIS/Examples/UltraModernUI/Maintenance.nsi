;NSIS Ultra Modern User Interface
;Maintenance Page Example Script
;Written by SuperPat

; How to test this example:
; launch and install this example a first time
; Relaunch this example again or laucnh the uninstaller, the maintnance page will appear


;--------------------------------
;General

  ;Name and file
  Name "UltraModernUI Test"
  OutFile "Maintenance.exe"

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\UltraModernUI Test"
  
  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Include Modern UI

  !include "MUIEx.nsh"

  !include "Sections.nsh"
	
;--------------------------------
;Interface Settings

  !define UMUI_PARAMS_REGISTRY_ROOT HKCU
  !define UMUI_PARAMS_REGISTRY_KEY "Software\UltraModernUI Test"
  
  !define UMUI_INSTALLDIR_REGISTRY_VALUENAME "InstallDir"		;Replace the InstallDirRegKey instruction and automatically save the $INSTDIR variable
    
	!define UMUI_VERSION "1.00 beta 2"
  !define /date UMUI_VERBUILD "1.00_%Y-%m-%d"

	!define UMUI_VERSION_REGISTRY_VALUENAME "Version"
	!define UMUI_VERBUILD_REGISTRY_VALUENAME "VerBuild"

  !define UMUI_UNINSTALLPATH_REGISTRY_VALUENAME "uninstallpath"
  !define UMUI_INSTALLERFULLPATH_REGISTRY_VALUENAME "installpath"
	!define UMUI_UNINSTALL_FULLPATH "$INSTDIR\Uninstall.exe"
	!define UMUI_PREUNINSTALL_FUNCTION preuninstall_function

;--------------------------------
;Pages

		!define UMUI_MAINTENANCEPAGE_MODIFY
		!define UMUI_MAINTENANCEPAGE_REPAIR
		!define UMUI_MAINTENANCEPAGE_REMOVE
		!define UMUI_MAINTENANCEPAGE_CONTINUE_SETUP
  !insertmacro UMUI_PAGE_MAINTENANCE
  
  !insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\UltraModernUI\License.txt"
  
;		!define UMUI_COMPONENTSPAGE_INSTTYPE_REGISTRY_VALUENAME "insttype"
		!define UMUI_COMPONENTSPAGE_REGISTRY_VALUENAME "components"  
  !insertmacro MUI_PAGE_COMPONENTS

  !insertmacro MUI_PAGE_DIRECTORY
  
		!define UMUI_CONFIRMPAGE_TEXTBOX confirm_function
  !insertmacro UMUI_PAGE_CONFIRM

  !insertmacro MUI_PAGE_INSTFILES
  
		!define UMUI_MAINTENANCEPAGE_MODIFY
		!define UMUI_MAINTENANCEPAGE_REPAIR
		!define UMUI_MAINTENANCEPAGE_REMOVE
		!define UMUI_MAINTENANCEPAGE_CONTINUE_SETUP
  !insertmacro UMUI_UNPAGE_MAINTENANCE
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
   
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section "Dummy Section 2" SecDummy2

  SetOutPath "$INSTDIR"
  
  

SectionEnd


;--------------------------------
; Pages functions

Function preuninstall_function

	; execute this function only in Modify, repair and update function
	!insertmacro UMUI_IF_INSTALLFLAG_IS ${UMUI_MODIFY}|${UMUI_REPAIR}|${UMUI_UPDATE}

		;ADD YOUR DELETE INSTRUCTION HERE...
	
		Delete "$INSTDIR\Uninstall.exe"
	
		DeleteRegKey ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}"

	!insertmacro UMUI_ENDIF_INSTALLFLAG

FunctionEnd

!macro confirm_addline section

	SectionGetFlags ${Sec${section}} $1
	IntOp $1 $1 & ${SF_SELECTED}
	IntCmp $1 ${SF_SELECTED} 0 n${section} n${section}
		SectionGetText ${Sec${section}} $1
		!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "    - $1"
	n${section}:

!macroend

Function confirm_function

	!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_INSTCONFIRM_TEXTBOX_DESTINATION_LOCATION)"
	!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $INSTDIR"
	!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""


	!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_INSTCONFIRM_TEXTBOX_COMPNENTS)"

	!insertmacro confirm_addline Dummy
	!insertmacro confirm_addline Dummy2

FunctionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."
  LangString DESC_SecDummy2 ${LANG_ENGLISH} "An other test section."

	;Declare all the components (Needed by UMUI_COMPONENTSPAGE_REGISTRY_VALUENAME)
	!insertmacro UMUI_DECLARECOMPONENTS_BEGIN
		!insertmacro UMUI_COMPONENT SecDummy
		!insertmacro UMUI_COMPONENT SecDummy2
	!insertmacro UMUI_DECLARECOMPONENTS_END


  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy2} $(DESC_SecDummy2)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR DELETE INSTRUCTION HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}"

SectionEnd