!macro UMUI_BG
		SetOutPath "$PLUGINSDIR"
		File "${NSISDIR}\Contrib\UltraModernUI\BGSkins\blue\BackGround.bmp"
		BgImage::SetBg /NOUNLOAD /FILLSCREEN "$PLUGINSDIR\BackGround.bmp"
		CreateFont $1 "Verdana" 30 700
		BgImage::AddText /NOUNLOAD "$(^Name)" $1  43  85 131 16 114 -1 -1
		BgImage::AddText /NOUNLOAD "$(^Name)" $1 255 255 255 12 110 -1 -1
		BgImage::Redraw /NOUNLOAD
!macroend
!macro UMUI_BG_Destroy
		BgImage::Destroy
!macroend
