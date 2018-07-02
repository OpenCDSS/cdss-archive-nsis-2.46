
		UltraModernUI ReadMe File
		=========================


Introduction
--------------

The UltraModern User Interface is an new interface with a style like the most recent installers for NSIS 2 (Nullsoft Scriptable Install System), the tool that allows programmers to create such installers for Windows. UltraModernUI and NSIS are released under an open source license.

The UltraModern User Interface also features new pages (Confirm, Abort, AlternativeStartMenu, AdditionnalTasks, ReadMe, Maintenance, Update, StupType...).

UltraModernUI include also ModernUIEx. ModernUIEx is the same User Interface as the original Modern UI style but with the support of the new UltraModern pages.

Using the UltraModernUI macros and language files, writing scripts with a ultra modern interface is easy. This document contains all information about writing UltraModernUI scripts and a reference of all settings.

The issue of UltraModernUI is to be the most compatible with the existing Modern UI scripts. Because of it is based on the Modern UI of Joost Verburg, it use the same macro an define and provide new one. The new macro and define use the prefix UMUI_ instead of MUI_.


Version history
-----------------

    *  Version 1.00 beta 2 - ???? ??, 2010
          o Second public beta release after more than one year of development.
          o UltraModernUI use the new NSIS Doc directory used since the version 2.07 and UMUI.nsh is resynchronised under Modern UI version 1.75.
          o UltraModernUI include also a second Unsed Interface named ModernUIEx. ModernUIEx is an extended version of Modern UI but with the new UltraModern pages support.
          o UltraModernUI included henceforth two plug-in that are supported natively :
                + The SkinnedButton plug-in. SkinnedButton is based on the wansis plug-in of Saivert and can skin all buttons of your NSIS installer like the most recent installers.
                + The InstallOptionEx plug-in. InstallOptionEx is writen by Diego Pedroso (deguix) and is an expanded version of InstallOptions containing many new features, with size drawback.
          o A new darkgreen skin is available.
          o New pages are available:
                + MultiLanguage Page to replace the MultiLanguage Plug-in.
                + Maintenance Page with Repair, Modify and Uninstall options.
                + Update Page with Update and Uninstall options.
                + Readme Page for text file.
                + SerialNumber Page.
                + Setup Type Page with Complete and Custom options.
                + AlternativeStartMenu Page to replace the StartMenu Plug-in.
                + Additionnal Tasks page.
                + File and Disk Request Page.
          o Left Text, Left Time and LeftMessageBox functions are removed.
          
    * Version 1.00 beta 1 - March 20, 2005
          o First public beta release.
          o Several skins are available in several color (blue , green, red, purple, brown, gray, cleargreen) and a background skin named wxp. You can obviously create your own skins.
          o The Header Image defines are disables momentarily.
          o New pages are available: Abrot Page and Confim page with recapitulation of your setting , LeftMessageBox.
          o Draw Left Text and Left Time.

