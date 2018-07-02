;NSIS UltraModern User Interface Installer
;Written by SyperPat

;--------------------------------
;General

  !define /date NOW "%Y-%m-%d"
  !define NAME "UltraModernUI"

  !define UMUI_VERSION "v1.00b2"
  !define UMUI_VERBUILD "1.00_${NOW}"

  !define VER_MAJOR 2
  !define VER_MINOR 46
  !define VER_REVISION ""
  !define VER_BUILD ""

  !define /date VERIPV "100.%Y.%m.%d"
  VIProductVersion "${VERIPV}"
  VIAddVersionKey "ProductName" "NSIS (Nullsoft Scriptable Install System) and the UltraModern User Interface."
  VIAddVersionKey "Comments" "This package also include some plugins used by UMUI to extend the possibilities of NSIS."
  VIAddVersionKey "LegalTrademarks" "NSIS and UltraModernUI are released under the zlib/libpng license"
  VIAddVersionKey "LegalCopyright" "Copyright � 2005-2009 SuperPat"
  VIAddVersionKey "FileDescription" "A package containing NSIS (Nullsoft Scriptable Install System) ${VER_MAJOR}.${VER_MINOR} the UltraModern User Interface."
  VIAddVersionKey "FileVersion" "${UMUI_VERBUILD}"


;--------------------------------
;Configuration

  ; The name of the installer
  Name "NSIS ${NSIS_VERSION} and ${NAME} ${UMUI_VERSION}"

  ; The file to write
  OutFile "..\..\NSIS_${VER_MAJOR}.${VER_MINOR}_UltraModernUI_${UMUI_VERBUILD}.exe"

  SetCompressor /FINAL /SOLID lzma

  ;Windows vista compatibility
  RequestExecutionLevel admin

  BrandingText "NSIS ${NSIS_VERSION} and ${NAME} ${UMUI_VERSION}"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\NSIS"


;--------------------------------
;Include UltraModernUI between others

  !include "UMUI.nsh"
  !include "Sections.nsh"

;--------------------------------
;Definitions

  !define SHCNE_ASSOCCHANGED 0x8000000
  !define SHCNF_IDLIST 0

;--------------------------------
;Interface Settings

  !define UMUI_SKIN "blue"

  !define UMUI_USE_INSTALLOPTIONSEX

  !define MUI_ABORTWARNING
  !define MUI_UNABORTWARNING

  !define UMUI_PAGEBGIMAGE
  !define UMUI_UNPAGEBGIMAGE

  !define UMUI_USE_ALTERNATE_PAGE
  !define UMUI_USE_UNALTERNATE_PAGE

  !define MUI_COMPONENTSPAGE_SMALLDESC

  !define UMUI_DEFAULT_SHELLVARCONTEXT all


  !define UMUI_ENABLE_DESCRIPTION_TEXT

;--------------------------------
;Registry Settings

  !define UMUI_PARAMS_REGISTRY_ROOT HKLM
  !define UMUI_PARAMS_REGISTRY_KEY "Software\NSIS"

  !define UMUI_LANGUAGE_REGISTRY_VALUENAME "UMUI_InstallerLanguage"
  !define UMUI_SHELLVARCONTEXT_REGISTRY_VALUENAME "UMUI_ShellVarContext"

  !define UMUI_UNINSTALLPATH_REGISTRY_VALUENAME "UMUI_UninstallPath"
  !define UMUI_UNINSTALL_FULLPATH "$INSTDIR\UninstallUMUI.exe"
  !define UMUI_INSTALLERFULLPATH_REGISTRY_VALUENAME "UMUI_InstallPath"

  !define UMUI_VERSION_REGISTRY_VALUENAME "UMUI_Version"
  !define UMUI_VERBUILD_REGISTRY_VALUENAME "UMUI_VerBuild"

  !define UMUI_PREUNINSTALL_FUNCTION preuninstall_function

  InstallDirRegKey ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" ""

;--------------------------------
;Reserve Files

  !insertmacro MUI_RESERVEFILE_INSTALLOPTIONS


;--------------------------------
;Pages

  Var STARTMENU_FOLDER


  !insertmacro UMUI_PAGE_MULTILANGUAGE

    !define UMUI_MAINTENANCEPAGE_MODIFY
    !define UMUI_MAINTENANCEPAGE_REPAIR
    !define UMUI_MAINTENANCEPAGE_REMOVE
    !define UMUI_MAINTENANCEPAGE_CONTINUE_SETUP
  !insertmacro UMUI_PAGE_MAINTENANCE

    !define UMUI_UPDATEPAGE_REMOVE
    !define UMUI_UPDATEPAGE_CONTINUE_SETUP
  !insertmacro UMUI_PAGE_UPDATE

    !define UMUI_WELCOMEPAGE_ALTERNATIVETEXT
  !insertmacro MUI_PAGE_WELCOME

    !define MUI_LICENSEPAGE_CHECKBOX
  !insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\UltraModernUI\License.txt"

    !define UMUI_INFORMATIONPAGE_USE_RICHTEXTFORMAT
  !insertmacro UMUI_PAGE_INFORMATION "${NSISDIR}\Docs\UltraModernUI\ReadMe.rtf"

    !define UMUI_SETUPTYPEPAGE_MINIMAL "$(UMUI_TEXT_SETUPTYPE_MINIMAL_TITLE)"
    !define UMUI_SETUPTYPEPAGE_STANDARD "$(UMUI_TEXT_SETUPTYPE_STANDARD_TITLE)"
    !define UMUI_SETUPTYPEPAGE_COMPLETE "$(UMUI_TEXT_SETUPTYPE_COMPLETE_TITLE)"
    !define UMUI_SETUPTYPEPAGE_DEFAULTCHOICE ${UMUI_COMPLETE}
    !define UMUI_SETUPTYPEPAGE_REGISTRY_VALUENAME "UMUI_SetupType"
  !insertmacro UMUI_PAGE_SETUPTYPE

    !define UMUI_COMPONENTSPAGE_INSTTYPE_REGISTRY_VALUENAME "UMUI_InstType"
    !define UMUI_COMPONENTSPAGE_REGISTRY_VALUENAME "UMUI_Components"
  !insertmacro MUI_PAGE_COMPONENTS

  !insertmacro MUI_PAGE_DIRECTORY

    !define UMUI_ALTERNATIVESTARTMENUPAGE_SETSHELLVARCONTEXT
    !define UMUI_ALTERNATIVESTARTMENUPAGE_USE_TREEVIEW
    !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "StartMenuFolder"
    !define MUI_STARTMENUPAGE_DEFAULTFOLDER "NSIS"
  !insertmacro UMUI_PAGE_ALTERNATIVESTARTMENU Application $STARTMENU_FOLDER

    !define UMUI_CONFIRMPAGE_TEXTBOX confirm_function
  !insertmacro UMUI_PAGE_CONFIRM

  !insertmacro MUI_PAGE_INSTFILES

    !define MUI_FINISHPAGE_SHOWREADME "${NSISDIR}\Docs\UltraModernUI\Readme.html"
    !define MUI_FINISHPAGE_LINK "UltraModernUI Home Page"
    !define MUI_FINISHPAGE_LINK_LOCATION "http://ultramodernui.sourceforge.net/"
  !insertmacro MUI_PAGE_FINISH

    !define UMUI_ABORTPAGE_LINK "UltraModernUI Home Page"
    !define UMUI_ABORTPAGE_LINK_LOCATION "http://ultramodernui.sourceforge.net/"
  !insertmacro UMUI_PAGE_ABORT


  !insertmacro UMUI_UNPAGE_MULTILANGUAGE

    !define UMUI_MAINTENANCEPAGE_MODIFY
    !define UMUI_MAINTENANCEPAGE_REPAIR
    !define UMUI_MAINTENANCEPAGE_REMOVE
    !define UMUI_MAINTENANCEPAGE_CONTINUE_SETUP
  !insertmacro UMUI_UNPAGE_MAINTENANCE

  !insertmacro MUI_UNPAGE_WELCOME

  !insertmacro MUI_UNPAGE_CONFIRM

  !insertmacro MUI_UNPAGE_INSTFILES

    !define MUI_FINISHPAGE_LINK "UltraModernUI Home Page"
    !define MUI_FINISHPAGE_LINK_LOCATION "http://ultramodernui.sourceforge.net/"
  !insertmacro MUI_UNPAGE_FINISH

    !define UMUI_ABORTPAGE_LINK "UltraModernUI Home Page"
    !define UMUI_ABORTPAGE_LINK_LOCATION "http://ultramodernui.sourceforge.net/"
  !insertmacro UMUI_UNPAGE_ABORT


;--------------------------------
;Languages

; first language is the default language if the system language is not in this list
  !insertmacro MUI_LANGUAGE "English"

; Other UMUI translated languages
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "Hungarian"
  !insertmacro MUI_LANGUAGE "Czech"
  !insertmacro MUI_LANGUAGE "Japanese"
  !insertmacro MUI_LANGUAGE "Polish"
; Other UMUI partially translated languages
  !insertmacro MUI_LANGUAGE "PortugueseBR"
  !insertmacro MUI_LANGUAGE "German"

; Other untranslated languages but usable even so.
  !insertmacro MUI_LANGUAGE "Spanish"
  !insertmacro MUI_LANGUAGE "SpanishInternational"
  !insertmacro MUI_LANGUAGE "SimpChinese"
  !insertmacro MUI_LANGUAGE "TradChinese"
  !insertmacro MUI_LANGUAGE "Korean"
  !insertmacro MUI_LANGUAGE "Italian"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "Danish"
  !insertmacro MUI_LANGUAGE "Swedish"
  !insertmacro MUI_LANGUAGE "Norwegian"
  !insertmacro MUI_LANGUAGE "Finnish"
  !insertmacro MUI_LANGUAGE "Greek"
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "Portuguese"
  !insertmacro MUI_LANGUAGE "Ukrainian"
  !insertmacro MUI_LANGUAGE "Slovak"
  !insertmacro MUI_LANGUAGE "Croatian"
  !insertmacro MUI_LANGUAGE "Bulgarian"
  !insertmacro MUI_LANGUAGE "Thai"
  !insertmacro MUI_LANGUAGE "Romanian"
  !insertmacro MUI_LANGUAGE "Latvian"
  !insertmacro MUI_LANGUAGE "Macedonian"
  !insertmacro MUI_LANGUAGE "Estonian"
  !insertmacro MUI_LANGUAGE "Turkish"
  !insertmacro MUI_LANGUAGE "Lithuanian"
  !insertmacro MUI_LANGUAGE "Slovenian"
  !insertmacro MUI_LANGUAGE "Serbian"
  !insertmacro MUI_LANGUAGE "SerbianLatin"
  !insertmacro MUI_LANGUAGE "Arabic"
  !insertmacro MUI_LANGUAGE "Farsi"
  !insertmacro MUI_LANGUAGE "Hebrew"
  !insertmacro MUI_LANGUAGE "Indonesian"
  !insertmacro MUI_LANGUAGE "Mongolian"
  !insertmacro MUI_LANGUAGE "Luxembourgish"
  !insertmacro MUI_LANGUAGE "Albanian"
  !insertmacro MUI_LANGUAGE "Breton"
  !insertmacro MUI_LANGUAGE "Belarusian"
  !insertmacro MUI_LANGUAGE "Icelandic"
  !insertmacro MUI_LANGUAGE "Malay"
  !insertmacro MUI_LANGUAGE "Bosnian"
  !insertmacro MUI_LANGUAGE "Kurdish"
  !insertmacro MUI_LANGUAGE "Basque"
  !insertmacro MUI_LANGUAGE "Welsh"
  !insertmacro MUI_LANGUAGE "Irish"
  !insertmacro MUI_LANGUAGE "NorwegianNynorsk"
  !insertmacro MUI_LANGUAGE "Uzbek"
  !insertmacro MUI_LANGUAGE "Galician"
  !insertmacro MUI_LANGUAGE "Afrikaans"
  !insertmacro MUI_LANGUAGE "Catalan"
  !insertmacro MUI_LANGUAGE "Esperanto"


;--------------------------------
;Installer Types

InstType "$(UMUI_TEXT_SETUPTYPE_MINIMAL_TITLE)"
InstType "$(UMUI_TEXT_SETUPTYPE_STANDARD_TITLE)"
InstType "$(UMUI_TEXT_SETUPTYPE_COMPLETE_TITLE)"


;--------------------------------
;Installer Sections

SectionGroup /e "NSIS ${NSIS_VERSION}" SecNSIS

Section "NSIS Core Files (required)" SecCore

  SetDetailsPrint textonly
  DetailPrint "Installing NSIS Core Files..."
  SetDetailsPrint listonly

  SectionIn 1 2 3 RO
  SetOutPath $INSTDIR
  RMDir /r $SMPROGRAMS\NSIS

  SetOverwrite on
  File ..\..\makensis.exe
  File ..\..\makensisw.exe
  File ..\..\COPYING
  File ..\..\NSIS.chm
  File ..\..\NSIS.exe
  File /nonfatal ..\..\NSIS.exe.manifest

  IfFileExists $INSTDIR\nsisconf.nsi "" +2
  Rename $INSTDIR\nsisconf.nsi $INSTDIR\nsisconf.nsh
  SetOverwrite off
  File ..\..\nsisconf.nsh
  SetOverwrite on

  SetOutPath $INSTDIR\Stubs
  File ..\..\Stubs\bzip2
  File ..\..\Stubs\bzip2_solid
  File ..\..\Stubs\lzma
  File ..\..\Stubs\lzma_solid
  File ..\..\Stubs\zlib
  File ..\..\Stubs\zlib_solid
  File ..\..\Stubs\uninst

  SetOutPath $INSTDIR\Include
  File ..\..\Include\WinMessages.nsh
  File ..\..\Include\Sections.nsh
  File ..\..\Include\Library.nsh
  File ..\..\Include\UpgradeDLL.nsh
  File ..\..\Include\LogicLib.nsh
  File ..\..\Include\StrFunc.nsh
  File ..\..\Include\Colors.nsh
  File ..\..\Include\FileFunc.nsh
  File ..\..\Include\TextFunc.nsh
  File ..\..\Include\WordFunc.nsh
  File ..\..\Include\WinVer.nsh
  File ..\..\Include\x64.nsh
  File ..\..\Include\Memento.nsh
  File ..\..\Include\LangFile.nsh
  File ..\..\Include\InstallOptions.nsh
  File ..\..\Include\MultiUser.nsh
  File ..\..\Include\VB6RunTime.nsh
  File ..\..\Include\Util.nsh
  File ..\..\Include\WinCore.nsh

  SetOutPath $INSTDIR\Include\Win
  File ..\..\Include\Win\WinDef.nsh
  File ..\..\Include\Win\WinError.nsh
  File ..\..\Include\Win\WinNT.nsh
  File ..\..\Include\Win\WinUser.nsh

  SetOutPath $INSTDIR\Docs\StrFunc
  File ..\..\Docs\StrFunc\StrFunc.txt

  SetOutPath $INSTDIR\Docs\makensisw
  File ..\..\Docs\makensisw\*.txt

  SetOutPath $INSTDIR\Docs\MultiUser
  File ..\..\Docs\MultiUser\Readme.html

  SetOutPath $INSTDIR\Menu
  File ..\..\Menu\*.html
  SetOutPath $INSTDIR\Menu\images
  File ..\..\Menu\images\header.gif
  File ..\..\Menu\images\line.gif
  File ..\..\Menu\images\site.gif

  Delete $INSTDIR\makensis.htm
  Delete $INSTDIR\Docs\*.html
  Delete $INSTDIR\Docs\style.css
  RMDir $INSTDIR\Docs

  SetOutPath $INSTDIR\Bin
  File ..\..\Bin\LibraryLocal.exe
  File ..\..\Bin\RegTool.bin

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\TypeLib.dll

  ReadRegStr $R0 HKCR ".nsi" ""
  StrCmp $R0 "NSISFile" 0 +2
    DeleteRegKey HKCR "NSISFile"

  WriteRegStr HKCR ".nsi" "" "NSIS.Script"
  WriteRegStr HKCR "NSIS.Script" "" "NSIS Script File"
  WriteRegStr HKCR "NSIS.Script\DefaultIcon" "" "$INSTDIR\makensisw.exe,1"
  ReadRegStr $R0 HKCR "NSIS.Script\shell\open\command" ""
  StrCmp $R0 "" 0 no_nsiopen
    WriteRegStr HKCR "NSIS.Script\shell" "" "open"
    WriteRegStr HKCR "NSIS.Script\shell\open\command" "" 'notepad.exe "%1"'
  no_nsiopen:
  WriteRegStr HKCR "NSIS.Script\shell\compile" "" "Compile NSIS Script"
  WriteRegStr HKCR "NSIS.Script\shell\compile\command" "" '"$INSTDIR\makensisw.exe" "%1"'
  WriteRegStr HKCR "NSIS.Script\shell\compile-compressor" "" "Compile NSIS Script (Choose Compressor)"
  WriteRegStr HKCR "NSIS.Script\shell\compile-compressor\command" "" '"$INSTDIR\makensisw.exe" /ChooseCompressor "%1"'

  ReadRegStr $R0 HKCR ".nsh" ""
  StrCmp $R0 "NSHFile" 0 +2
    DeleteRegKey HKCR "NSHFile"

  WriteRegStr HKCR ".nsh" "" "NSIS.Header"
  WriteRegStr HKCR "NSIS.Header" "" "NSIS Header File"
  WriteRegStr HKCR "NSIS.Header\DefaultIcon" "" "$INSTDIR\makensisw.exe,1"
  ReadRegStr $R0 HKCR "NSIS.Header\shell\open\command" ""
  StrCmp $R0 "" 0 no_nshopen
    WriteRegStr HKCR "NSIS.Header\shell" "" "open"
    WriteRegStr HKCR "NSIS.Header\shell\open\command" "" 'notepad.exe "%1"'
  no_nshopen:

  System::Call 'Shell32::SHChangeNotify(i ${SHCNE_ASSOCCHANGED}, i ${SHCNF_IDLIST}, i 0, i 0)'

  SetOutPath "$INSTDIR\"
  CreateShortCut "$DESKTOP\NSIS.lnk" "$INSTDIR\NSIS.exe"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    SetOutPath "$SMPROGRAMS\$STARTMENU_FOLDER\"
    SetOutPath "$INSTDIR\"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\NSIS.lnk" "$INSTDIR\NSIS.exe"
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

Section "Script Examples" SecExample

  SetDetailsPrint textonly
  DetailPrint "Installing Script Examples..."
  SetDetailsPrint listonly

  SectionIn 2 3
  SetOutPath $INSTDIR\Examples
  File ..\..\Examples\makensis.nsi
  File ..\..\Examples\example1.nsi
  File ..\..\Examples\example2.nsi
  File ..\..\Examples\viewhtml.nsi
  File ..\..\Examples\waplugin.nsi
  File ..\..\Examples\bigtest.nsi
  File ..\..\Examples\primes.nsi
  File ..\..\Examples\rtest.nsi
  File ..\..\Examples\gfx.nsi
  File ..\..\Examples\one-section.nsi
  File ..\..\Examples\languages.nsi
  File ..\..\Examples\Library.nsi
  File ..\..\Examples\VersionInfo.nsi
  File ..\..\Examples\UserVars.nsi
  File ..\..\Examples\LogicLib.nsi
  File ..\..\Examples\silent.nsi
  File ..\..\Examples\StrFunc.nsi
  File ..\..\Examples\FileFunc.nsi
  File ..\..\Examples\FileFunc.ini
  File ..\..\Examples\FileFuncTest.nsi
  File ..\..\Examples\TextFunc.nsi
  File ..\..\Examples\TextFunc.ini
  File ..\..\Examples\TextFuncTest.nsi
  File ..\..\Examples\WordFunc.nsi
  File ..\..\Examples\WordFunc.ini
  File ..\..\Examples\WordFuncTest.nsi
  File ..\..\Examples\Memento.nsi

  SetOutPath $INSTDIR\Examples\Plugin
  File ..\..\Examples\Plugin\exdll.c
  File ..\..\Examples\Plugin\exdll.dpr
  File ..\..\Examples\Plugin\exdll.dsp
  File ..\..\Examples\Plugin\exdll.dsw
  File ..\..\Examples\Plugin\exdll_with_unit.dpr
  File ..\..\Examples\Plugin\exdll-vs2008.sln
  File ..\..\Examples\Plugin\exdll-vs2008.vcproj
  File ..\..\Examples\Plugin\extdll.inc
  File ..\..\Examples\Plugin\nsis.pas

  SetOutPath $INSTDIR\Examples\Plugin\nsis
  File ..\..\Examples\Plugin\nsis\pluginapi.h
  File ..\..\Examples\Plugin\nsis\pluginapi.lib
  File ..\..\Examples\Plugin\nsis\api.h

SectionEnd

SectionGroup "User Interfaces" SecInterfaces

Section "Modern User Interface" SecInterfacesModernUI

  SetDetailsPrint textonly
  DetailPrint "Installing User Interfaces | Modern User Interface..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath "$INSTDIR\Examples\Modern UI"
  File "..\..\Examples\Modern UI\Basic.nsi"
  File "..\..\Examples\Modern UI\HeaderBitmap.nsi"
  File "..\..\Examples\Modern UI\MultiLanguage.nsi"
  File "..\..\Examples\Modern UI\StartMenu.nsi"
  File "..\..\Examples\Modern UI\WelcomeFinish.nsi"

  SetOutPath "$INSTDIR\Contrib\Modern UI"
  File "..\..\Contrib\Modern UI\System.nsh"
  File "..\..\Contrib\Modern UI\ioSpecial.ini"

  SetOutPath "$INSTDIR\Docs\Modern UI"
  File "..\..\Docs\Modern UI\Readme.html"
  File "..\..\Docs\Modern UI\Changelog.txt"
  File "..\..\Docs\Modern UI\License.txt"

  SetOutPath "$INSTDIR\Docs\Modern UI\images"
  File "..\..\Docs\Modern UI\images\header.gif"
  File "..\..\Docs\Modern UI\images\screen1.png"
  File "..\..\Docs\Modern UI\images\screen2.png"
  File "..\..\Docs\Modern UI\images\open.gif"
  File "..\..\Docs\Modern UI\images\closed.gif"

  SetOutPath $INSTDIR\Contrib\UIs
  File "..\..\Contrib\UIs\modern.exe"
  File "..\..\Contrib\UIs\modern_headerbmp.exe"
  File "..\..\Contrib\UIs\modern_headerbmpr.exe"
  File "..\..\Contrib\UIs\modern_nodesc.exe"
  File "..\..\Contrib\UIs\modern_smalldesc.exe"

  SetOutPath $INSTDIR\Include
  File "..\..\Include\MUI.nsh"

  SetOutPath "$INSTDIR\Contrib\Modern UI 2"
  File "..\..\Contrib\Modern UI 2\Deprecated.nsh"
  File "..\..\Contrib\Modern UI 2\Interface.nsh"
  File "..\..\Contrib\Modern UI 2\Localization.nsh"
  File "..\..\Contrib\Modern UI 2\MUI2.nsh"
  File "..\..\Contrib\Modern UI 2\Pages.nsh"

  SetOutPath "$INSTDIR\Contrib\Modern UI 2\Pages"
  File "..\..\Contrib\Modern UI 2\Pages\Components.nsh"
  File "..\..\Contrib\Modern UI 2\Pages\Directory.nsh"
  File "..\..\Contrib\Modern UI 2\Pages\Finish.nsh"
  File "..\..\Contrib\Modern UI 2\Pages\InstallFiles.nsh"
  File "..\..\Contrib\Modern UI 2\Pages\License.nsh"
  File "..\..\Contrib\Modern UI 2\Pages\StartMenu.nsh"
  File "..\..\Contrib\Modern UI 2\Pages\UninstallConfirm.nsh"
  File "..\..\Contrib\Modern UI 2\Pages\Welcome.nsh"

  SetOutPath "$INSTDIR\Docs\Modern UI 2"
  File "..\..\Docs\Modern UI 2\Readme.html"
  File "..\..\Docs\Modern UI 2\License.txt"

  SetOutPath "$INSTDIR\Docs\Modern UI 2\images"
  File "..\..\Docs\Modern UI 2\images\header.gif"
  File "..\..\Docs\Modern UI 2\images\screen1.png"
  File "..\..\Docs\Modern UI 2\images\screen2.png"
  File "..\..\Docs\Modern UI 2\images\open.gif"
  File "..\..\Docs\Modern UI 2\images\closed.gif"

  SetOutPath $INSTDIR\Include
  File "..\..\Include\MUI2.nsh"

SectionEnd

Section "Default User Interface" SecInterfacesDefaultUI

  SetDetailsPrint textonly
  DetailPrint "Installing User Interfaces | Default User Interface..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath "$INSTDIR\Contrib\UIs"
  File "..\..\Contrib\UIs\default.exe"

SectionEnd

Section "Tiny User Interface" SecInterfacesTinyUI

  SetDetailsPrint textonly
  DetailPrint "Installing User Interfaces | Tiny User Interface..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath "$INSTDIR\Contrib\UIs"
  File "..\..\Contrib\UIs\sdbarker_tiny.exe"

SectionEnd

SectionGroupEnd

Section "Graphics" SecGraphics

  SetDetailsPrint textonly
  DetailPrint "Installing Graphics..."
  SetDetailsPrint listonly

  SectionIn 2 3

  Delete $INSTDIR\Contrib\Icons\*.ico
  Delete $INSTDIR\Contrib\Icons\*.bmp
  RMDir $INSTDIR\Contrib\Icons
  SetOutPath $INSTDIR\Contrib\Graphics
  File /r "..\..\Contrib\Graphics\*.ico"
  File /r "..\..\Contrib\Graphics\*.bmp"
SectionEnd

Section "Language Files" SecLangFiles

  SetDetailsPrint textonly
  DetailPrint "Installing Language Files..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath "$INSTDIR\Contrib\Language files"
  File "..\..\Contrib\Language files\*.nlf"

  SetOutPath $INSTDIR\Bin
  File ..\..\Bin\MakeLangID.exe

  !insertmacro SectionFlagIsSet ${SecInterfacesModernUI} ${SF_SELECTED} mui nomui
  mui:
    SetOutPath "$INSTDIR\Contrib\Language files"
    File "..\..\Contrib\Language files\*.nsh"
  nomui:

SectionEnd

SectionGroup "Tools" SecTools

Section "Zip2Exe" SecToolsZ2E

  SetDetailsPrint textonly
  DetailPrint "Installing Tools | Zip2Exe..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Bin
  File ..\..\Bin\zip2exe.exe
  SetOutPath $INSTDIR\Contrib\zip2exe
  File ..\..\Contrib\zip2exe\Base.nsh
  File ..\..\Contrib\zip2exe\Modern.nsh
  File ..\..\Contrib\zip2exe\Classic.nsh

SectionEnd

SectionGroupEnd

SectionGroup "Plug-ins" SecPluginsPlugins

Section "Banner" SecPluginsBanner

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | Banner..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\Banner.dll
  SetOutPath $INSTDIR\Docs\Banner
  File ..\..\Docs\Banner\Readme.txt
  SetOutPath $INSTDIR\Examples\Banner
  File ..\..\Examples\Banner\Example.nsi
SectionEnd

Section "Language DLL" SecPluginsLangDLL

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | Language DLL..."
  SetDetailsPrint listonly

  SectionIn 2 3
  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\LangDLL.dll
SectionEnd

Section "nsExec" SecPluginsnsExec

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | nsExec..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\nsExec.dll
  SetOutPath $INSTDIR\Docs\nsExec
  File ..\..\Docs\nsExec\nsExec.txt
  SetOutPath $INSTDIR\Examples\nsExec
  File ..\..\Examples\nsExec\test.nsi
SectionEnd

Section "Splash" SecPluginsSplash

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | Splash..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\splash.dll
  SetOutPath $INSTDIR\Docs\Splash
  File ..\..\Docs\Splash\splash.txt
  SetOutPath $INSTDIR\Examples\Splash
  File ..\..\Examples\Splash\Example.nsi
SectionEnd

Section "AdvSplash" SecPluginsSplashT

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | AdvSplash..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\advsplash.dll
  SetOutPath $INSTDIR\Docs\AdvSplash
  File ..\..\Docs\AdvSplash\advsplash.txt
  SetOutPath $INSTDIR\Examples\AdvSplash
  File ..\..\Examples\AdvSplash\Example.nsi
SectionEnd

Section "BgImage" SecPluginsBgImage

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | BgImage..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\BgImage.dll
  SetOutPath $INSTDIR\Docs\BgImage
  File ..\..\Docs\BgImage\BgImage.txt
  SetOutPath $INSTDIR\Examples\BgImage
  File ..\..\Examples\BgImage\Example.nsi
SectionEnd

Section "InstallOptions" SecPluginsIO

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | InstallOptions..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\InstallOptions.dll
  SetOutPath $INSTDIR\Docs\InstallOptions
  File ..\..\Docs\InstallOptions\Readme.html
  File ..\..\Docs\InstallOptions\Changelog.txt
  SetOutPath $INSTDIR\Examples\InstallOptions
  File ..\..\Examples\InstallOptions\test.ini
  File ..\..\Examples\InstallOptions\test.nsi
  File ..\..\Examples\InstallOptions\testimgs.ini
  File ..\..\Examples\InstallOptions\testimgs.nsi
  File ..\..\Examples\InstallOptions\testlink.ini
  File ..\..\Examples\InstallOptions\testlink.nsi
  File ..\..\Examples\InstallOptions\testnotify.ini
  File ..\..\Examples\InstallOptions\testnotify.nsi
SectionEnd

Section "Math" SecPluginsMath

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | Math..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\Math.dll
  SetOutPath $INSTDIR\Docs\Math
  File ..\..\Docs\Math\Math.txt
  SetOutPath $INSTDIR\Examples\Math
  File ..\..\Examples\Math\math.nsi
  File ..\..\Examples\Math\mathtest.txt
  File ..\..\Examples\Math\mathtest.nsi
  File ..\..\Examples\Math\mathtest.ini

SectionEnd

Section "NSISdl" SecPluginsNSISDL

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | NSISdl..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\nsisdl.dll
  SetOutPath $INSTDIR\Docs\NSISdl
  File ..\..\Docs\NSISdl\ReadMe.txt
  File ..\..\Docs\NSISdl\License.txt
SectionEnd

Section "System" SecPluginsSystem

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | System..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\System.dll
  SetOutPath $INSTDIR\Docs\System
  File ..\..\Docs\System\System.html
  File ..\..\Docs\System\WhatsNew.txt
  SetOutPath $INSTDIR\Examples\System
  File ..\..\Examples\System\Resource.dll
  File ..\..\Examples\System\SysFunc.nsh
  File ..\..\Examples\System\System.nsh
  File ..\..\Examples\System\System.nsi
SectionEnd

Section "nsDialogs" SecPluginsDialogs

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | nsDialogs..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\nsDialogs.dll
  SetOutPath $INSTDIR\Examples\nsDialogs
  File ..\..\Examples\nsDialogs\example.nsi
  File ..\..\Examples\nsDialogs\InstallOptions.nsi
  File ..\..\Examples\nsDialogs\timer.nsi
  File ..\..\Examples\nsDialogs\welcome.nsi
  SetOutPath $INSTDIR\Include
  File ..\..\Include\nsDialogs.nsh
  SetOutPath $INSTDIR\Docs\nsDialogs
  File ..\..\Docs\nsDialogs\Readme.html

SectionEnd

Section "StartMenu" SecPluginsStartMenu

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | StartMenu..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\StartMenu.dll
  SetOutPath $INSTDIR\Docs\StartMenu
  File ..\..\Docs\StartMenu\Readme.txt
  SetOutPath $INSTDIR\Examples\StartMenu
  File ..\..\Examples\StartMenu\Example.nsi
SectionEnd

Section "UserInfo" SecPluginsUserInfo

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | UserInfo..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\UserInfo.dll
  SetOutPath $INSTDIR\Examples\UserInfo
  File ..\..\Examples\UserInfo\UserInfo.nsi
SectionEnd

Section "Dialer" SecPluginsDialer

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | Dialer..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\Dialer.dll
  SetOutPath $INSTDIR\Docs\Dialer
  File ..\..\Docs\Dialer\Dialer.txt
SectionEnd

Section "VPatch" SecPluginsVPatch

  SetDetailsPrint textonly
  DetailPrint "Installing Plug-ins | VPatch..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath $INSTDIR\Plugins
  File ..\..\Plugins\VPatch.dll
  SetOutPath $INSTDIR\Examples\VPatch
  File ..\..\Examples\VPatch\example.nsi
  File ..\..\Examples\VPatch\oldfile.txt
  File ..\..\Examples\VPatch\newfile.txt
  File ..\..\Examples\VPatch\patch.pat
  SetOutPath $INSTDIR\Docs\VPatch
  File ..\..\Docs\VPatch\Readme.html
  SetOutPath $INSTDIR\Bin
  File ..\..\Bin\GenPat.exe
  SetOutPath $INSTDIR\Include
  File ..\..\Include\VPatchLib.nsh
SectionEnd

SectionGroupEnd

Section -post

  ; When Modern UI is installed:
  ; * Always install the English language file
  ; * Always install default icons / bitmaps

  !insertmacro SectionFlagIsSet ${SecInterfacesModernUI} ${SF_SELECTED} mui nomui

    mui:

    SetDetailsPrint textonly
    DetailPrint "Configuring Modern UI..."
    SetDetailsPrint listonly

    !insertmacro SectionFlagIsSet ${SecLangFiles} ${SF_SELECTED} langfiles nolangfiles

      nolangfiles:

      SetOutPath "$INSTDIR\Contrib\Language files"
      File "..\..\Contrib\Language files\English.nlf"
      SetOutPath "$INSTDIR\Contrib\Language files"
      File "..\..\Contrib\Language files\English.nsh"

    langfiles:

    !insertmacro SectionFlagIsSet ${SecGraphics} ${SF_SELECTED} graphics nographics

      nographics:

      SetOutPath $INSTDIR\Contrib\Graphics
      SetOutPath $INSTDIR\Contrib\Graphics\Checks
      File "..\..\Contrib\Graphics\Checks\modern.bmp"
      SetOutPath $INSTDIR\Contrib\Graphics\Icons
      File "..\..\Contrib\Graphics\Icons\modern-install.ico"
      File "..\..\Contrib\Graphics\Icons\modern-uninstall.ico"
      SetOutPath $INSTDIR\Contrib\Graphics\Header
      File "..\..\Contrib\Graphics\Header\nsis.bmp"
      SetOutPath $INSTDIR\Contrib\Graphics\Wizard
      File "..\..\Contrib\Graphics\Wizard\win.bmp"

    graphics:

  nomui:

  SetDetailsPrint textonly
  DetailPrint "Creating Registry Keys..."
  SetDetailsPrint listonly

  SetOutPath $INSTDIR

  WriteRegStr HKLM "Software\NSIS" "" $INSTDIR
!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
  WriteRegDword HKLM "Software\NSIS" "VersionMajor" "${VER_MAJOR}"
  WriteRegDword HKLM "Software\NSIS" "VersionMinor" "${VER_MINOR}"
  WriteRegDword HKLM "Software\NSIS" "VersionRevision" "${VER_REVISION}"
  WriteRegDword HKLM "Software\NSIS" "VersionBuild" "${VER_BUILD}"
!endif

  WriteRegExpandStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "UninstallString" '"$INSTDIR\uninst-nsis.exe"'
  WriteRegExpandStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "DisplayName" "Nullsoft Install System"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "DisplayIcon" "$INSTDIR\NSIS.exe,0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "DisplayVersion" "${NSIS_VERSION}"
!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "VersionMajor" "${VER_MAJOR}"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "VersionMinor" "${VER_MINOR}.${VER_REVISION}"
!endif
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "URLInfoAbout" "http://nsis.sourceforge.net/"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "HelpLink" "http://nsis.sourceforge.net/Support"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "NoModify" "1"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS" "NoRepair" "1"

  SetOutPath "$INSTDIR"
  File ..\..\uninst-nsis.exe

  SetDetailsPrint both

SectionEnd

SectionGroupEnd

;--------------------------------
; UMUI Sections

SectionGroup /e "UltraModern User Interface ${UMUI_VERSION}" SecUMUIG

Section "UltraModernUI" SecUMUI

  SetDetailsPrint textonly
  DetailPrint "Installing UltraModernUI..."
  SetDetailsPrint listonly

  SectionIn RO

  SectionIn 1 2 3

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\"
  File "..\..\Contrib\UltraModernUI\UMUI.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Ini"
  File "..\..\Contrib\UltraModernUI\Ini\*.ini"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Language files\"
  File "..\..\Contrib\UltraModernUI\Language files\*.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File /r "..\..\Contrib\UltraModernUI\BGSkins\"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\blue.nsh"
  File "..\..\Contrib\UltraModernUI\Skins\blue2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\blue\"
  File "..\..\Contrib\UltraModernUI\Skins\blue\*.bmp"

  SetOutPath "$INSTDIR\Docs\UltraModernUI\"
  File "..\..\Docs\UltraModernUI\*.*"
  SetOutPath "$INSTDIR\Docs\UltraModernUI\images\"
  File "..\..\Docs\UltraModernUI\images\*.gif"
  File "..\..\Docs\UltraModernUI\images\*.png"

  SetOutPath "$INSTDIR\Examples\UltraModernUI\"
  File "*.nsi"
  File "*.ini"
  File "*.txt"

  SetOutPath "$INSTDIR\Contrib\UIs\UltraModernUI\"
  File "..\..\Contrib\UIs\UltraModernUI\*.exe"

  SetOutPath "$INSTDIR\Contrib\Graphics\UltraModernUI\"
  File "..\..\Contrib\Graphics\UltraModernUI\*.*"

  SetOutPath "$INSTDIR\Include\"
  File "..\..\Include\UMUI.nsh"
  File "..\..\Include\MUIEx.nsh"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
     SetOutPath "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\"
     CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\UltraModernUI Readme.lnk" "$INSTDIR\Docs\UltraModernUI\Readme.html"
     CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall UltraModernUI.lnk" "$INSTDIR\UninstallUMUI.exe"
  !insertmacro MUI_STARTMENU_WRITE_END

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallUMUI.exe"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "DisplayName" "$(^Name)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "UninstallString" '"$INSTDIR\UninstallUMUI.exe"'
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "Publisher" "SuperPat"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "HelpLink" "http://ultramodernui.sourceforge.net/"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "URLInfoAbout" "http://ultramodernui.sourceforge.net/"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "URLUpdateInfo" "http://ultramodernui.sourceforge.net/"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "ModifyPath" '"$INSTDIR\UninstallUMUI.exe" /modify'
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "DisplayVersion" "${UMUI_VERBUILD}"


SectionEnd

Section "Skins for UltraModernUI" SecSkins

  SetDetailsPrint textonly
  DetailPrint "Installing UltraModernUI | Skins..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\brown.nsh"
  File "..\..\Contrib\UltraModernUI\Skins\brown2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\brown\"
  File "..\..\Contrib\UltraModernUI\Skins\brown\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\darkgreen.nsh"
  File "..\..\Contrib\UltraModernUI\Skins\darkgreen2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\darkgreen\"
  File "..\..\Contrib\UltraModernUI\Skins\darkgreen\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\gray.nsh"
  File "..\..\Contrib\UltraModernUI\Skins\gray2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\gray\"
  File "..\..\Contrib\UltraModernUI\Skins\gray\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\green.nsh"
  File "..\..\Contrib\UltraModernUI\Skins\green2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\green\"
  File "..\..\Contrib\UltraModernUI\Skins\green\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\purple.nsh"
  File "..\..\Contrib\UltraModernUI\Skins\purple2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\purple\"
  File "..\..\Contrib\UltraModernUI\Skins\purple\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\red.nsh"
  File "..\..\Contrib\UltraModernUI\Skins\red2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\red\"
  File "..\..\Contrib\UltraModernUI\Skins\red\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftBlue.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBlue\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftBlue\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftBrown.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBrown\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftBrown\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftGray.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGray\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftGray\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftGreen.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGreen\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftGreen\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftPurple.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\SoftPurple\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftPurple\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftRed.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\Skins\SoftRed\"
  File "..\..\Contrib\UltraModernUI\Skins\SoftRed\*.bmp"

SectionEnd

Section "BackGround Skins for UltraModernUI" SecBGSkins

  SetDetailsPrint textonly
  DetailPrint "Installing UltraModernUI | BackGround Skins..."
  SetDetailsPrint listonly

  SectionIn 2 3

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\blue.nsh"
  File "..\..\Contrib\UltraModernUI\BGSkins\blue2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\blue\"
  File "..\..\Contrib\UltraModernUI\BGSkins\blue\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\brown.nsh"
  File "..\..\Contrib\UltraModernUI\BGSkins\brown2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\brown\"
  File "..\..\Contrib\UltraModernUI\BGSkins\brown\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\darkgreen.nsh"
  File "..\..\Contrib\UltraModernUI\BGSkins\darkgreen2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\darkgreen\"
  File "..\..\Contrib\UltraModernUI\BGSkins\darkgreen\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\gray.nsh"
  File "..\..\Contrib\UltraModernUI\BGSkins\gray2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\gray\"
  File "..\..\Contrib\UltraModernUI\BGSkins\gray\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\green.nsh"
  File "..\..\Contrib\UltraModernUI\BGSkins\green2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\green\"
  File "..\..\Contrib\UltraModernUI\BGSkins\green\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\purple.nsh"
  File "..\..\Contrib\UltraModernUI\BGSkins\purple2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\purple\"
  File "..\..\Contrib\UltraModernUI\BGSkins\purple\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\red.nsh"
  File "..\..\Contrib\UltraModernUI\BGSkins\red2.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\red\"
  File "..\..\Contrib\UltraModernUI\BGSkins\red\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftBlue.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBlue\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftBlue\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftBrown.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBrown\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftBrown\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftGray.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGray\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftGray\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftGreen.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGreen\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftGreen\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftPurple.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftPurple\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftPurple\*.bmp"

  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftRed.nsh"
  SetOutPath "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftRed\"
  File "..\..\Contrib\UltraModernUI\BGSkins\SoftRed\*.bmp"

SectionEnd


SectionGroup /e "Plugins" SecGroupPlugins

  Section "SkinnedControls plugin version 1.0" SecSkinnedControls

    SetDetailsPrint textonly
    DetailPrint "Installing UltraModernUI | Plugins | SkinnedControls..."
    SetDetailsPrint listonly

    SectionIn RO

    SectionIn 1 2 3

    SetOutPath $INSTDIR\Plugins
    File "..\..\Plugins\SkinnedControls.dll"

    SetOutPath $INSTDIR\Examples\SkinnedControls
    File "..\SkinnedControls\Example.nsi"
    File "..\SkinnedControls\Example_MUI.nsi"

    SetOutPath $INSTDIR\Contrib\SkinnedControls\skins
    File "..\..\Contrib\SkinnedControls\skins\*.bmp"

    SetOutPath $INSTDIR\Contrib\UIs
    File "..\..\Contrib\UIs\modern_sb.exe"
    File "..\..\Contrib\UIs\default_sb.exe"

    SetOutPath $INSTDIR\Docs\SkinnedControls
    File "..\..\Docs\SkinnedControls\*.*"

    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
       SetOutPath "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\"
       CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\SkinnedControls Readme.lnk" "$INSTDIR\Docs\SkinnedControls\Readme.htm"
    !insertmacro MUI_STARTMENU_WRITE_END

  SectionEnd

  Section "SkinnedControls plugin Sources Code" SecSkinnedControlsSources

    SetDetailsPrint textonly
    DetailPrint "Installing UltraModernUI | Plugins | SkinnedControls Soucres Code..."
    SetDetailsPrint listonly

    SectionIn 3

    SetOutPath $INSTDIR\Contrib\SkinnedControls
    File "..\..\Contrib\SkinnedControls\exdll.h"
    File "..\..\Contrib\SkinnedControls\wa_scrollbars.h"
    File "..\..\Contrib\SkinnedControls\wa_dlg.h"
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


  Section "InstallOptionsEx plugin version 2.4.5" SecInstallOptionsEx

    SetDetailsPrint textonly
    DetailPrint "Installing UltraModernUI | Plugins | InstallOptionsEx..."
    SetDetailsPrint listonly

    SectionIn 2 3

    SetOutPath $INSTDIR\Plugins
    File "..\..\Plugins\InstallOptionsEx_legacy.dll"
	File "..\..\Plugins\InstallOptionsEx_newAPI.dll"
	
	CopyFiles /SILENT "$INSTDIR\Plugins\InstallOptionsEx_newAPI.dll" "$INSTDIR\Plugins\InstallOptionsEx.dll"

    SetOutPath $INSTDIR\Examples\InstallOptionsEx
    File "..\InstallOptionsEx\*.nsi"
    File "..\InstallOptionsEx\*.ini"

    SetOutPath $INSTDIR\Docs\InstallOptionsEx
    File "..\..\Docs\InstallOptionsEx\*.*"

    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
      SetOutPath "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\"
      CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\InstallOptionsEx Readme.lnk" "$INSTDIR\Docs\InstallOptionsEx\Readme.html"
    !insertmacro MUI_STARTMENU_WRITE_END

  SectionEnd

  Section "InstallOptionsEx plugin Sources Code" SecInstallOptionsExSources

    SetDetailsPrint textonly
    DetailPrint "Installing UltraModernUI | Plugins | InstallOptionsEx Soucres Code..."
    SetDetailsPrint listonly

    SectionIn 3

	SetOutPath $INSTDIR\Contrib\InstallOptionsEx
	File "..\..\Contrib\InstallOptionsEx\InstallerOptions.h"
	File "..\..\Contrib\InstallOptionsEx\exdll.h"
	File "..\..\Contrib\InstallOptionsEx\resource.h"
	File "..\..\Contrib\InstallOptionsEx\InstallerOptions.cpp"	
	File "..\..\Contrib\InstallOptionsEx\ioptdll.rc"
	File "..\..\Contrib\InstallOptionsEx\io.sln"
	File "..\..\Contrib\InstallOptionsEx\io.vcproj"
	File "..\..\Contrib\InstallOptionsEx\api.h"
	File "..\..\Contrib\InstallOptionsEx\exdll.h"
	File "..\..\Contrib\InstallOptionsEx\pluginapi.c"
	File "..\..\Contrib\InstallOptionsEx\pluginapi.h"
	SetOutPath $INSTDIR\Contrib\InstallOptionsEx\Controls
	File "..\..\Contrib\InstallOptionsEx\Controls\*.h"

  SectionEnd


  Section "NSISArray plugin version 2.4" SecNSISArray

    SetDetailsPrint textonly
    DetailPrint "Installing UltraModernUI | Plugins | NSISArray..."
    SetDetailsPrint listonly

    SectionIn 2 3

    SetOutPath $INSTDIR\Plugins   
    File "..\..\Plugins\NSISArray_legacy.dll"
	File "..\..\Plugins\NSISArray_newAPI.dll"
	
	CopyFiles /SILENT "$INSTDIR\Plugins\NSISArray_newAPI.dll" "$INSTDIR\Plugins\NSISArray.dll"

    SetOutPath $INSTDIR\Include
    File "..\..\Include\NSISArray.nsh"

    SetOutPath $INSTDIR\Contrib\NSISArray
    File "..\..\Contrib\NSISArray\readme.txt"

    SetOutPath $INSTDIR\Docs\NSISArray
    File "..\..\Docs\NSISArray\*.*"

    SetOutPath $INSTDIR\Examples\NSISArray
    File "..\NSISArray\*.nsi"

    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
      SetOutPath "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\"
      CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\NSISArray Readme.lnk" "$INSTDIR\Docs\NSISArray\Readme.html"
    !insertmacro MUI_STARTMENU_WRITE_END

  SectionEnd

  Section "NSISArray plugin Sources Code" SecNSISArraySources

    SetDetailsPrint textonly
    DetailPrint "Installing UltraModernUI | Plugins | NSISArray Soucres Code..."
    SetDetailsPrint listonly

    SectionIn 3

    SetOutPath $INSTDIR\Contrib\NSISArray
    File "..\..\Contrib\NSISArray\resource.h"
    File "..\..\Contrib\NSISArray\NSISArray.*"

  SectionEnd

SectionGroupEnd

SectionGroupEnd

;--------------------------------
;Uninstall Section(s)

Section Uninstall

  SetDetailsPrint textonly
  DetailPrint "Uninstalling NSIS and UltraModernUI..."
  SetDetailsPrint listonly

  ;uninstall SkinnedControls Plugin
  Delete "$INSTDIR\Contrib\UIs\modern_sb.exe"
  Delete "$INSTDIR\Contrib\UIs\default_sb.exe"
  Delete "$INSTDIR\Plugins\SkinnedControls.dll"
  RMDir /r "$INSTDIR\Contrib\SkinnedControls"
  Delete "$INSTDIR\Docs\SkinnedControls\*.*"
  RMDir "$INSTDIR\Docs\SkinnedControls"
  Delete "$INSTDIR\Examples\SkinnedControls\*.nsi"
  RMDir "$INSTDIR\Examples\SkinnedControls"

  ;uninstall InstallOptionsEx Plugin
  Delete "$INSTDIR\Plugins\InstallOptionsEx.dll"
  Delete "$INSTDIR\Plugins\InstallOptionsEx_legacy.dll"
  Delete "$INSTDIR\Plugins\InstallOptionsEx_newAPI.dll"
  RMDir /r "$INSTDIR\Contrib\InstallOptionsEx"
  Delete "$INSTDIR\Docs\InstallOptionsEx\*.*"
  RMDir "$INSTDIR\Docs\InstallOptionsEx"
  Delete "$INSTDIR\Examples\InstallOptionsEx\*.*"
  RMDir "$INSTDIR\Examples\InstallOptionsEx"

  ;uninstall NSISArray Plugin
  Delete "$INSTDIR\Plugins\NSISArray.dll"
  Delete "$INSTDIR\Plugins\NSISArray_legacy.dll"
  Delete "$INSTDIR\Plugins\NSISArray_newAPI.dll"
  Delete "$INSTDIR\Include\NSISArray.nsh"
  Delete "$INSTDIR\Contrib\NSISArray\*.*"
  RMDir "$INSTDIR\Contrib\NSISArray"
  Delete "$INSTDIR\Docs\NSISArray\*.*"
  RMDir "$INSTDIR\Docs\NSISArray"
  Delete "$INSTDIR\Examples\NSISArray\*.nsi"
  RMDir "$INSTDIR\Examples\NSISArray"

  Delete "$INSTDIR\Include\UMUI.nsh"
  Delete "$INSTDIR\Include\MUIEx.nsh"
  RMDir "$INSTDIR\Include"

  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AdditionalTasks.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AlternateWelcomeFinishAbort.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AlternateWelcomeFinishAbortImage.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AlternativeStartMenu.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AlternativeStartMenuApplication.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\Confirm.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\Information.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\ioSpecial.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\Maintenance.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\MaintenanceSetupType.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\serialnumber.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\WelcomeFinishAbort.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\WelcomeFinishAbortImage.ini"
  RMDir "$INSTDIR\Contrib\UltraModernUI\Ini"

  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\blue"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\brown"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\darkgreen"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\gray"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\green"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\purple"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\red"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBlue"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBrown"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGray"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGreen"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftPurple"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftRed"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\blue2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\blue.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\brown2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\brown.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\darkgreen2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\darkgreen.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\gray2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\gray.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\green2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\green.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\purple2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\purple.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\red2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\red.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBlue.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBrown.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGray.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGreen.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftPurple.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftRed.nsh"
  RMDir "$INSTDIR\Contrib\UltraModernUI\BGSkins"

  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\blue"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\brown"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\darkgreen"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\gray"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\green"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\purple"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\red"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBlue"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBrown"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGray"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGreen"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftPurple"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftRed"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\blue2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\blue.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\brown2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\brown.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\darkgreen2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\darkgreen.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\gray2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\gray.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\green2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\green.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\purple2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\purple.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\red2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\red.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBlue.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBrown.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGray.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGreen.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftPurple.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftRed.nsh"
  RMDir "$INSTDIR\Contrib\UltraModernUI\Skins"

  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Language files"

  Delete "$INSTDIR\Contrib\UltraModernUI\UMUI.nsh"
  RMDir "$INSTDIR\Contrib\UltraModernUI\"
  RMDir "$INSTDIR\Contrib"

  RMDir /r "$INSTDIR\Docs\UltraModernUI\"
  RMDir "$INSTDIR\Docs"

  RMDir /r "$INSTDIR\Examples\UltraModernUI\"
  RMDir "$INSTDIR\Examples"

  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\modern_bigdesc.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\modern_headerbgimage.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\modern_sb.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_bigdesc.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_nodesc.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_noleftimage.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_sb.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_small.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_small_sb.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_smalldesc.exe"
  RMDir "$INSTDIR\Contrib\UIs\UltraModernUI\"
  RMDir "$INSTDIR\Contrib\UIs"

  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Complete.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\CompleteEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Continue.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\ContinueEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Custom.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\CustomEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\HeaderBG.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Minimal.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\MinimalEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Modify.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\ModifyEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Remove.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\RemoveEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Repair.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\RepairEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Standard.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\StandardEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Icon2.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Icon.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\install.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\installEx.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\UnIcon2.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\UnIcon.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\uninstall.ico"
  RMDir "$INSTDIR\Contrib\Graphics\UltraModernUI\"
  RMDir "$INSTDIR\Contrib\Graphics"

  Delete "$INSTDIR\UninstallUMUI.exe"
  RMDir "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $STARTMENU_FOLDER

  Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\UltraModernUI Readme.lnk"
  Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\SkinnedControls Readme.lnk"
  Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\NSISArray Readme.lnk"
  Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\InstallOptionsEx Readme.lnk"
  Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\Uninstall UltraModernUI.lnk"
  Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall UltraModernUI.lnk"
  Delete "$SMPROGRAMS\$STARTMENU_FOLDER\NSIS.lnk"
  RMDir "$SMPROGRAMS\$STARTMENU_FOLDER"
  RMDir "$SMPROGRAMS\$STARTMENU_FOLDER\.."

  Delete "$SMPROGRAMS\NSIS.lnk"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"

  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_SHELLVARCONTEXT_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_LANGUAGE_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "UMUI_SetupType" ;"${UMUI_SETUPTYPEPAGE_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "UMUI_InstType" ;"${UMUI_COMPONENTSPAGE_INSTTYPE_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "UMUI_Components" ;"${UMUI_COMPONENTSPAGE_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${MUI_STARTMENUPAGE_Application_REGISTRY_VALUENAME}" ;"${MUI_STARTMENUPAGE_REGISTRY_VALUENAME}" this define was removed after the inclusion of the (ALTERNATIVE)STARTMENU_PAGE
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_VERSION_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_VERBUILD_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_INSTALLERFULLPATH_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_UNINSTALLPATH_REGISTRY_VALUENAME}"
  DeleteRegKey /ifempty ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}"


  ;Delete NSIS
  SetDetailsPrint textonly
  DetailPrint "Uninstalling NSI Development Shell Extensions..."
  SetDetailsPrint listonly

  IfFileExists $INSTDIR\makensis.exe nsis_installed
    MessageBox MB_YESNO "It does not appear that NSIS is installed in the directory '$INSTDIR'.$\r$\nContinue anyway (not recommended)?" IDYES nsis_installed
    Abort "Uninstall aborted by user"
  nsis_installed:

  SetDetailsPrint textonly
  DetailPrint "Deleting Registry Keys..."
  SetDetailsPrint listonly

  ReadRegStr $R0 HKCR ".nsi" ""
  StrCmp $R0 "NSIS.Script" 0 +2
    DeleteRegKey HKCR ".nsi"

  ReadRegStr $R0 HKCR ".nsh" ""
  StrCmp $R0 "NSIS.Header" 0 +2
    DeleteRegKey HKCR ".nsh"

  DeleteRegKey HKCR "NSIS.Script"
  DeleteRegKey HKCR "NSIS.Header"

  System::Call 'Shell32::SHChangeNotify(i ${SHCNE_ASSOCCHANGED}, i ${SHCNF_IDLIST}, i 0, i 0)'

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS"
  DeleteRegKey HKLM "Software\NSIS"

  SetDetailsPrint textonly
  DetailPrint "Deleting Files..."
  SetDetailsPrint listonly

  RMDir /r "$SMPROGRAMS\$STARTMENU_FOLDER"
  Delete $DESKTOP\NSIS.lnk
  Delete $INSTDIR\makensis.exe
  Delete $INSTDIR\makensisw.exe
  Delete $INSTDIR\NSIS.exe
  Delete $INSTDIR\license.txt
  Delete $INSTDIR\COPYING
  Delete $INSTDIR\uninst-nsis.exe
  Delete $INSTDIR\nsisconf.nsi
  Delete $INSTDIR\nsisconf.nsh
  Delete $INSTDIR\NSIS.chm
  RMDir /r $INSTDIR\Bin
  RMDir /r $INSTDIR\Contrib
  RMDir /r $INSTDIR\Docs
  RMDir /r $INSTDIR\Examples
  RMDir /r $INSTDIR\Include
  RMDir /r $INSTDIR\Menu
  RMDir /r $INSTDIR\Plugins
  RMDir /r $INSTDIR\Stubs
  RMDir /r $INSTDIR

  SetDetailsPrint both

SectionEnd


;--------------------------------
;Installer Sections Declaration dans Description

!insertmacro UMUI_DECLARECOMPONENTS_BEGIN
  !insertmacro UMUI_COMPONENT SecNSIS
  !insertmacro UMUI_COMPONENT SecCore
  !insertmacro UMUI_COMPONENT SecExample
  !insertmacro UMUI_COMPONENT SecInterfaces
  !insertmacro UMUI_COMPONENT SecInterfacesModernUI
  !insertmacro UMUI_COMPONENT SecInterfacesDefaultUI
  !insertmacro UMUI_COMPONENT SecInterfacesTinyUI
  !insertmacro UMUI_COMPONENT SecTools
  !insertmacro UMUI_COMPONENT SecToolsZ2E
  !insertmacro UMUI_COMPONENT SecGraphics
  !insertmacro UMUI_COMPONENT SecLangFiles
  !insertmacro UMUI_COMPONENT SecPluginsPlugins
  !insertmacro UMUI_COMPONENT SecPluginsBanner
  !insertmacro UMUI_COMPONENT SecPluginsLangDLL
  !insertmacro UMUI_COMPONENT SecPluginsnsExec
  !insertmacro UMUI_COMPONENT SecPluginsSplash
  !insertmacro UMUI_COMPONENT SecPluginsSplashT
  !insertmacro UMUI_COMPONENT SecPluginsSystem
  !insertmacro UMUI_COMPONENT SecPluginsMath
  !insertmacro UMUI_COMPONENT SecPluginsDialer
  !insertmacro UMUI_COMPONENT SecPluginsIO
  !insertmacro UMUI_COMPONENT SecPluginsDialogs
  !insertmacro UMUI_COMPONENT SecPluginsStartMenu
  !insertmacro UMUI_COMPONENT SecPluginsBgImage
  !insertmacro UMUI_COMPONENT SecPluginsUserInfo
  !insertmacro UMUI_COMPONENT SecPluginsNSISDL
  !insertmacro UMUI_COMPONENT SecPluginsVPatch

  !insertmacro UMUI_COMPONENT SecUMUI
  !insertmacro UMUI_COMPONENT SecSkins
  !insertmacro UMUI_COMPONENT SecBGSkins
  !insertmacro UMUI_COMPONENT SecSkinnedControls
  !insertmacro UMUI_COMPONENT SecSkinnedControlsSources
  !insertmacro UMUI_COMPONENT SecInstallOptionsEx
  !insertmacro UMUI_COMPONENT SecInstallOptionsExSources
  !insertmacro UMUI_COMPONENT SecNSISArray
  !insertmacro UMUI_COMPONENT SecNSISArraySources
!insertmacro UMUI_DECLARECOMPONENTS_END

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecNSIS} "The NSIS package version ${VER_MAJOR}.${VER_MINOR}"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCore} "The core files required to use NSIS (compiler etc.)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecExample} "Example installation scripts that show you how to use NSIS"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInterfaces} "User interface designs that can be used to change the installer look and feel"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInterfacesModernUI} "A modern user interface like the wizards of recent Windows versions"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInterfacesDefaultUI} "The default NSIS user interface which you can customize to make your own UI"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInterfacesTinyUI} "A tiny version of the default user interface"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecTools} "Tools that help you with NSIS development"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecToolsZ2E} "A utility that converts a ZIP file to a NSIS installer"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecGraphics} "Icons, checkbox images and other graphics"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecLangFiles} "Language files used to support multiple languages in an installer"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsPlugins} "Useful plugins that extend NSIS's functionality"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsBanner} "Plugin that lets you show a banner before installation starts"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsLangDLL} "Plugin that lets you add a language select dialog to your installer"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsnsExec} "Plugin that executes console programs and prints its output in the NSIS log window or hides it"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsSplash} "Splash screen add-on that lets you add a splash screen to an installer"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsSplashT} "Splash screen add-on with transparency support that lets you add a splash screen to an installer"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsSystem} "Plugin that lets you call Win32 API or external DLLs"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsMath} "Plugin that lets you evaluate complicated mathematical expressions"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsDialer} "Plugin that provides internet connection functions"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsIO} "Plugin that lets you add custom pages to an installer"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsDialogs} "Plugin that lets you add custom pages to an installer"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsStartMenu} "Plugin that lets the user select the start menu folder"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsBgImage} "Plugin that lets you show a persistent background image plugin and play sounds"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsUserInfo} "Plugin that that gives you the user name and the user account type"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsNSISDL} "Plugin that lets you create a web based installer"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPluginsVPatch} "Plugin that lets you create patches to upgrade older files"

  !insertmacro MUI_DESCRIPTION_TEXT ${SecUMUI} "The UtraModern User Interface for NSIS."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecSkins} "A lot of skins for the UtraModern User Interface."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecBGSkins} "A lot of background skins for the UtraModern User Interface."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecGroupPlugins} "Install very useful NSIS plugins used by UltraModernUI to extend the possibilities of NSIS."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecSkinnedControls} "This NSIS plugin, writing by SuperPat, allow you to skin all buttons and scrollbars of your installer.$\n$\rIt's used by default with the UltraModern style."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecSkinnedControlsSources} "The Sources code of the SkinnedControls plugin."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInstallOptionsEx} "This NSIS plugin, writing by deguix and SuperPat is an expanded version of the original InstallOptions plugin containing a lot of new features.$\nThis plugin is supported natively by UltraModernUI."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInstallOptionsExSources} "The Sources code of the InstallOptionsEx plugin."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecNSISArray} "This NSIS plugin, writing by Afrow UK, add the support of the array in NSIS. It comes with plenty of functions for managing your arrays.$\nThis plugin is used with the AlternativeStartMenu and MultiLanguages pages of UltraModernUI."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecNSISArraySources} "The Sources code of the NSISArray plugin."
!insertmacro MUI_FUNCTION_DESCRIPTION_END


;--------------------------------
; Pages functions

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

  ;Only if StartMenu Folder is selected
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application

    !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_INSTCONFIRM_TEXTBOX_START_MENU_FOLDER)"
    !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $STARTMENU_FOLDER"
    !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""

    ;ShellVarContext
    !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_SHELL_VAR_CONTEXT)"
    !insertmacro UMUI_GETSHELLVARCONTEXT
    Pop $1
    StrCmp $1 "all" 0 current
      !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $(UMUI_TEXT_SHELL_VAR_CONTEXT_FOR_ALL_USERS)"
      Goto endsvc
    current:
      !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $(UMUI_TEXT_SHELL_VAR_CONTEXT_ONLY_FOR_CURRENT_USER)"
    endsvc:
    !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""

  !insertmacro MUI_STARTMENU_WRITE_END


  ;For the setuptype page
  !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_SETUPTYPE_TITLE):"
  !insertmacro UMUI_GET_CHOOSEN_SETUP_TYPE_TEXT
  Pop $R0
  !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $R0"
  !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""


  !insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_INSTCONFIRM_TEXTBOX_COMPNENTS)"

  !insertmacro confirm_addline NSIS
  !insertmacro confirm_addline Core
  !insertmacro confirm_addline Example
  !insertmacro confirm_addline Interfaces
  !insertmacro confirm_addline InterfacesModernUI
  !insertmacro confirm_addline InterfacesDefaultUI
  !insertmacro confirm_addline InterfacesTinyUI
  !insertmacro confirm_addline Tools
  !insertmacro confirm_addline ToolsZ2E
  !insertmacro confirm_addline Graphics
  !insertmacro confirm_addline LangFiles
  !insertmacro confirm_addline PluginsPlugins
  !insertmacro confirm_addline PluginsBanner
  !insertmacro confirm_addline PluginsLangDLL
  !insertmacro confirm_addline PluginsnsExec
  !insertmacro confirm_addline PluginsSplash
  !insertmacro confirm_addline PluginsSplashT
  !insertmacro confirm_addline PluginsSystem
  !insertmacro confirm_addline PluginsMath
  !insertmacro confirm_addline PluginsDialer
  !insertmacro confirm_addline PluginsIO
  !insertmacro confirm_addline PluginsDialogs
  !insertmacro confirm_addline PluginsStartMenu
  !insertmacro confirm_addline PluginsBgImage
  !insertmacro confirm_addline PluginsUserInfo
  !insertmacro confirm_addline PluginsNSISDL
  !insertmacro confirm_addline PluginsVPatch

  !insertmacro confirm_addline UMUI
  !insertmacro confirm_addline Skins
  !insertmacro confirm_addline BGSkins
  !insertmacro confirm_addline SkinnedControls
  !insertmacro confirm_addline SkinnedControlsSources
  !insertmacro confirm_addline InstallOptionsEx
  !insertmacro confirm_addline InstallOptionsExSources
  !insertmacro confirm_addline NSISArray
  !insertmacro confirm_addline NSISArraySources

FunctionEnd

Function preuninstall_function

  SetDetailsPrint textonly
  DetailPrint "Uninstalling NSIS and UltraModernUI..."
  SetDetailsPrint listonly

  ;uninstall SkinnedControls Plugin
  Delete "$INSTDIR\Contrib\UIs\modern_sb.exe"
  Delete "$INSTDIR\Contrib\UIs\default_sb.exe"
  Delete "$INSTDIR\Plugins\SkinnedControls.dll"
  RMDir /r "$INSTDIR\Contrib\SkinnedControls"
  Delete "$INSTDIR\Docs\SkinnedControls\*.*"
  RMDir "$INSTDIR\Docs\SkinnedControls"
  Delete "$INSTDIR\Examples\SkinnedControls\*.nsi"
  RMDir "$INSTDIR\Examples\SkinnedControls"

  ;uninstall InstallOptionsEx Plugin
  Delete "$INSTDIR\Plugins\InstallOptionsEx.dll"
  Delete "$INSTDIR\Plugins\InstallOptionsEx_legacy.dll"
  Delete "$INSTDIR\Plugins\InstallOptionsEx_newAPI.dll"
  RMDir /r "$INSTDIR\Contrib\InstallOptionsEx"
  Delete "$INSTDIR\Docs\InstallOptionsEx\*.*"
  RMDir "$INSTDIR\Docs\InstallOptionsEx"
  Delete "$INSTDIR\Examples\InstallOptionsEx\*.*"
  RMDir "$INSTDIR\Examples\InstallOptionsEx"

  ;uninstall NSISArray Plugin
  Delete "$INSTDIR\Plugins\NSISArray.dll"
  Delete "$INSTDIR\Plugins\NSISArray_legacy.dll"
  Delete "$INSTDIR\Plugins\NSISArray_newAPI.dll"
  Delete "$INSTDIR\Include\NSISArray.nsh"
  Delete "$INSTDIR\Contrib\NSISArray\*.*"
  RMDir "$INSTDIR\Contrib\NSISArray"
  Delete "$INSTDIR\Docs\NSISArray\*.*"
  RMDir "$INSTDIR\Docs\NSISArray"
  Delete "$INSTDIR\Examples\NSISArray\*.nsi"
  RMDir "$INSTDIR\Examples\NSISArray"

  Delete "$INSTDIR\Include\UMUI.nsh"
  Delete "$INSTDIR\Include\MUIEx.nsh"
  RMDir "$INSTDIR\Include"

  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AdditionalTasks.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AlternateWelcomeFinishAbort.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AlternateWelcomeFinishAbortImage.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AlternativeStartMenu.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\AlternativeStartMenuApplication.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\Confirm.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\Information.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\ioSpecial.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\Maintenance.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\MaintenanceSetupType.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\serialnumber.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\WelcomeFinishAbort.ini"
  Delete "$INSTDIR\Contrib\UltraModernUI\Ini\WelcomeFinishAbortImage.ini"
  RMDir "$INSTDIR\Contrib\UltraModernUI\Ini"

  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\blue"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\brown"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\darkgreen"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\gray"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\green"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\purple"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\red"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBlue"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBrown"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGray"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGreen"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftPurple"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftRed"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\blue2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\blue.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\brown2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\brown.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\darkgreen2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\darkgreen.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\gray2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\gray.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\green2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\green.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\purple2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\purple.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\red2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\red.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBlue.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftBrown.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGray.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftGreen.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftPurple.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\BGSkins\SoftRed.nsh"
  RMDir "$INSTDIR\Contrib\UltraModernUI\BGSkins"

  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\blue"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\brown"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\darkgreen"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\gray"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\green"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\purple"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\red"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBlue"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBrown"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGray"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGreen"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftPurple"
  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Skins\SoftRed"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\blue2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\blue.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\brown2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\brown.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\darkgreen2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\darkgreen.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\gray2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\gray.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\green2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\green.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\purple2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\purple.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\red2.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\red.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBlue.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftBrown.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGray.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftGreen.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftPurple.nsh"
  Delete "$INSTDIR\Contrib\UltraModernUI\Skins\SoftRed.nsh"
  RMDir "$INSTDIR\Contrib\UltraModernUI\Skins"

  RMDir /r "$INSTDIR\Contrib\UltraModernUI\Language files"

  Delete "$INSTDIR\Contrib\UltraModernUI\UMUI.nsh"
  RMDir "$INSTDIR\Contrib\UltraModernUI\"
  RMDir "$INSTDIR\Contrib"

  RMDir /r "$INSTDIR\Docs\UltraModernUI\"
  RMDir "$INSTDIR\Docs"

  RMDir /r "$INSTDIR\Examples\UltraModernUI\"
  RMDir "$INSTDIR\Examples"

  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\modern_bigdesc.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\modern_headerbgimage.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\modern_sb.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_bigdesc.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_nodesc.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_noleftimage.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_sb.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_small.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_small_sb.exe"
  Delete "$INSTDIR\Contrib\UIs\UltraModernUI\UltraModern_smalldesc.exe"
  RMDir "$INSTDIR\Contrib\UIs\UltraModernUI\"
  RMDir "$INSTDIR\Contrib\UIs"

  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Complete.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\CompleteEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Continue.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\ContinueEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Custom.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\CustomEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\HeaderBG.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Minimal.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\MinimalEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Modify.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\ModifyEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Remove.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\RemoveEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Repair.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\RepairEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Standard.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\StandardEx.bmp"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Icon2.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\Icon.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\install.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\installEx.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\UnIcon2.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\UnIcon.ico"
  Delete "$INSTDIR\Contrib\Graphics\UltraModernUI\uninstall.ico"
  RMDir "$INSTDIR\Contrib\Graphics\UltraModernUI\"
  RMDir "$INSTDIR\Contrib\Graphics"

  Delete "$INSTDIR\UninstallUMUI.exe"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"

  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_SHELLVARCONTEXT_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_LANGUAGE_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "UMUI_SetupType" ;"${UMUI_SETUPTYPEPAGE_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "UMUI_InstType" ;"${UMUI_COMPONENTSPAGE_INSTTYPE_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "UMUI_Components" ;"${UMUI_COMPONENTSPAGE_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${MUI_STARTMENUPAGE_Application_REGISTRY_VALUENAME}" ;"${MUI_STARTMENUPAGE_REGISTRY_VALUENAME}" this define was removed after the inclusion of the (ALTERNATIVE)STARTMENU_PAGE
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_VERSION_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_VERBUILD_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_INSTALLERFULLPATH_REGISTRY_VALUENAME}"
  DeleteRegValue ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" "${UMUI_UNINSTALLPATH_REGISTRY_VALUENAME}"


  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\UltraModernUI Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\SkinnedControls Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\NSISArray Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\InstallOptionsEx Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\Uninstall UltraModernUI.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall UltraModernUI.lnk"


  ;Delete NSIS

    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall NSIS.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\NSIS Menu.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\NSIS Examples Directory.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\NSIS Documentation.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\MakeNSISW (Compiler GUI).lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\NSIS Site.url"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\NSIS.lnk"

    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\zip2exe (Create SFX).lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\AdvSplash Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\Banner Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\BgImage Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\InstallOptions Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\MakeNSISw Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\Math Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\Modern UI 2 Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\Modern UI Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\nsDialogs Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\nsExec Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\NSISdl Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\Splash Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\StartMenu Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\System Readme.lnk"
    Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib\VPatch Readme.lnk"

    RMDir "$SMPROGRAMS\$STARTMENU_FOLDER\Contrib"
    RMDir "$SMPROGRAMS\$STARTMENU_FOLDER"
  !insertmacro MUI_STARTMENU_WRITE_END

  Delete "$SMPROGRAMS\NSIS.lnk"


  IfFileExists $INSTDIR\makensis.exe nsis_installed
    MessageBox MB_YESNO "It does not appear that NSIS is installed in the directory '$INSTDIR'.$\r$\nContinue anyway (not recommended)?" IDYES nsis_installed
    Abort "Uninstall aborted by user"
  nsis_installed:

  ReadRegStr $R0 HKCR ".nsi" ""
  StrCmp $R0 "NSIS.Script" 0 +2
    DeleteRegKey HKCR ".nsi"

  ReadRegStr $R0 HKCR ".nsh" ""
  StrCmp $R0 "NSIS.Header" 0 +2
    DeleteRegKey HKCR ".nsh"

  DeleteRegKey HKCR "NSIS.Script"
  DeleteRegKey HKCR "NSIS.Header"

  System::Call 'Shell32::SHChangeNotify(i ${SHCNE_ASSOCCHANGED}, i ${SHCNF_IDLIST}, i 0, i 0)'

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NSIS"

  Delete $DESKTOP\NSIS.lnk
  Delete $INSTDIR\makensis.exe
  Delete $INSTDIR\makensisw.exe
  Delete $INSTDIR\NSIS.exe
  Delete $INSTDIR\license.txt
  Delete $INSTDIR\COPYING
  Delete $INSTDIR\uninst-nsis.exe
  Delete $INSTDIR\nsisconf.nsi
  Delete $INSTDIR\nsisconf.nsh
  Delete $INSTDIR\NSIS.chm

  RMDir /r $INSTDIR\Stubs

  Delete $INSTDIR\Include\WinMessages.nsh
  Delete $INSTDIR\Include\Sections.nsh
  Delete $INSTDIR\Include\Library.nsh
  Delete $INSTDIR\Include\UpgradeDLL.nsh
  Delete $INSTDIR\Include\LogicLib.nsh
  Delete $INSTDIR\Include\StrFunc.nsh
  Delete $INSTDIR\Include\Colors.nsh
  Delete $INSTDIR\Include\FileFunc.nsh
  Delete $INSTDIR\Include\TextFunc.nsh
  Delete $INSTDIR\Include\WordFunc.nsh
  Delete $INSTDIR\Include\WinVer.nsh
  Delete $INSTDIR\Include\x64.nsh
  Delete $INSTDIR\Include\Memento.nsh
  Delete $INSTDIR\Include\LangFile.nsh
  Delete $INSTDIR\Include\InstallOptions.nsh

  RMDir /r $INSTDIR\Docs\StrFunc
  RMDir /r $INSTDIR\Docs\makensisw
  RMDir /r $INSTDIR\Menu

  RMDir /r $INSTDIR\Bin

  Delete $INSTDIR\Plugins\TypeLib.dll

  Delete $INSTDIR\Examples\makensis.nsi
  Delete $INSTDIR\Examples\example1.nsi
  Delete $INSTDIR\Examples\example2.nsi
  Delete $INSTDIR\Examples\viewhtml.nsi
  Delete $INSTDIR\Examples\waplugin.nsi
  Delete $INSTDIR\Examples\bigtest.nsi
  Delete $INSTDIR\Examples\primes.nsi
  Delete $INSTDIR\Examples\rtest.nsi
  Delete $INSTDIR\Examples\gfx.nsi
  Delete $INSTDIR\Examples\one-section.nsi
  Delete $INSTDIR\Examples\languages.nsi
  Delete $INSTDIR\Examples\Library.nsi
  Delete $INSTDIR\Examples\VersionInfo.nsi
  Delete $INSTDIR\Examples\UserVars.nsi
  Delete $INSTDIR\Examples\LogicLib.nsi
  Delete $INSTDIR\Examples\silent.nsi
  Delete $INSTDIR\Examples\StrFunc.nsi
  Delete $INSTDIR\Examples\FileFunc.nsi
  Delete $INSTDIR\Examples\FileFunc.ini
  Delete $INSTDIR\Examples\FileFuncTest.nsi
  Delete $INSTDIR\Examples\TextFunc.nsi
  Delete $INSTDIR\Examples\TextFunc.ini
  Delete $INSTDIR\Examples\TextFuncTest.nsi
  Delete $INSTDIR\Examples\WordFunc.nsi
  Delete $INSTDIR\Examples\WordFunc.ini
  Delete $INSTDIR\Examples\WordFuncTest.nsi

  RMDir /r "$INSTDIR\Examples\Modern UI"
  RMDir /r "$INSTDIR\Contrib\Modern UI"
  RMDir /r "$INSTDIR\Docs\Modern UI"
  Delete $INSTDIR\Include\MUI.nsh

  RMDir /r "$INSTDIR\Examples\Modern UI 2"
  RMDir /r "$INSTDIR\Contrib\Modern UI 2"
  RMDir /r "$INSTDIR\Docs\Modern UI 2"
  Delete $INSTDIR\Include\MUI2.nsh

  Delete $INSTDIR\Contrib\UIs\default.exe
  Delete $INSTDIR\Contrib\UIs\modern.exe
  Delete $INSTDIR\Contrib\UIs\modern_headerbmp.exe
  Delete $INSTDIR\Contrib\UIs\modern_headerbmpr.exe
  Delete $INSTDIR\Contrib\UIs\modern_nodesc.exe
  Delete $INSTDIR\Contrib\UIs\modern_smalldesc.exe
  Delete $INSTDIR\Contrib\UIs\sdbarker_tiny.exe

  RMDir /r $INSTDIR\Contrib\Graphics

  RMDir /r "$INSTDIR\Contrib\Language files\"

  RMDir /r $INSTDIR\Contrib\zip2exe

  Delete $INSTDIR\Plugins\Banner.dll

  RMDir /r "$INSTDIR\Docs\Banner\"
  RMDir /r "$INSTDIR\Examples\Banner\"

  Delete $INSTDIR\Plugins\LangDLL.dll

  Delete $INSTDIR\Plugins\nsExec.dll
  RMDir /r $INSTDIR\Docs\nsExec
  RMDir /r $INSTDIR\Examples\nsExec

  Delete $INSTDIR\Plugins\splash.dll
  RMDir /r $INSTDIR\Docs\Splash
  RMDir /r $INSTDIR\Examples\Splash

  Delete $INSTDIR\Plugins\advsplash.dll
  RMDir /r $INSTDIR\Docs\AdvSplash
  RMDir /r $INSTDIR\Examples\AdvSplash

  Delete $INSTDIR\Plugins\BgImage.dll
  RMDir /r $INSTDIR\Docs\BgImage
  RMDir /r $INSTDIR\Examples\BgImage

  Delete $INSTDIR\Plugins\InstallOptions.dll
  RMDir /r $INSTDIR\Docs\InstallOptions
  RMDir /r $INSTDIR\Examples\InstallOptions

  Delete $INSTDIR\Plugins\Math.dll
  RMDir /r $INSTDIR\Docs\Math
  RMDir /r $INSTDIR\Examples\Math

  Delete $INSTDIR\Plugins\nsisdl.dll
  RMDir /r $INSTDIR\Docs\NSISdl

  Delete $INSTDIR\Plugins\System.dll
  RMDir /r $INSTDIR\Docs\System
  RMDir /r $INSTDIR\Examples\System

  Delete $INSTDIR\Plugins\nsDialogs.dll
  RMDir /r $INSTDIR\Examples\nsDialogs
  Delete $INSTDIR\Include\nsDialogs.nsh
  RMDir /r $INSTDIR\Docs\nsDialogs

  Delete $INSTDIR\Plugins\StartMenu.dll
  RMDir /r $INSTDIR\Docs\StartMenu
  RMDir /r $INSTDIR\Examples\StartMenu

  Delete $INSTDIR\Plugins\UserInfo.dll
  RMDir /r $INSTDIR\Examples

  Delete $INSTDIR\Plugins\Dialer.dll
  RMDir /r $INSTDIR\Docs\Dialer

  Delete $INSTDIR\Plugins\VPatch.dll
  RMDir /r $INSTDIR\Examples\VPatch
  RMDir /r $INSTDIR\Docs\VPatch
  Delete $INSTDIR\Include\VPatchLib.nsh

  RMDir "$INSTDIR"

  SetDetailsPrint both

FunctionEnd


;--------------------------------
;Init Functions

Function .onInit

  !insertmacro UMUI_MULTILANG_GET

FunctionEnd

Function un.onInit

  !insertmacro UMUI_MULTILANG_GET

FunctionEnd