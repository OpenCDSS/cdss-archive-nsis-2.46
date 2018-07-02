!macro UMUI_BG
		SetOutPath "$PLUGINSDIR"
		File "${NSISDIR}\Contrib\UltraModernUI\BGSkins\green\BackGround2.bmp"
		BgImage::SetBg /NOUNLOAD /FILLSCREEN "$PLUGINSDIR\BackGround2.bmp"
		CreateFont $1 "Verdana" 30 700
		BgImage::AddText /NOUNLOAD "$(^Name)" $1  43 131  85 16 114 -1 -1
		BgImage::AddText /NOUNLOAD "$(^Name)" $1 255 255 255 12 110 -1 -1
		BgImage::Redraw /NOUNLOAD
!macroend
!macro UMUI_BG_Destroy
		BgImage::Destroy
!macroend
