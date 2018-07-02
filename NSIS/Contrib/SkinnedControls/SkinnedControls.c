/* SkinnedScrollBar.c : Plug-in that skins NSIS scrollbars.
 * Version 1.0
 * Written by SuperPat
*
* based on wansis, a Plug-in written by Saivert that skins NSIS like Winamp.
* wansis homepage: http://saivert.inthegray.com
*/

#define _WIN32_IE 0x0600
#define WINVER 0x0500
#define _WIN32_WINNT 0x0500
#include <windows.h>
#include <richedit.h>
#include <commctrl.h>

//Used in wa_dlg.h
HINSTANCE g_hInstance;

//Private #includes
#include "exdll.h"
#define WADLG_IMPLEMENT
#include "wa_dlg.h"
#include "wa_scrollbars.h"

//Variables
HWND g_hwndParent;
WNDPROC oldProc;
LONG g_oldnsiswndstyle;
HWND g_oldnsisparentwnd;
HBITMAP g_hbmb;
HBITMAP g_hbma;


//Functions
BOOL CALLBACK EnumChildProc(HWND, LPARAM);
BOOL CALLBACK EnumChildProc_ScrollBarUninit(HWND hwnd, LPARAM lParam);
void internal_skin(int);
char* GetLastErrorStr(void);
unsigned int myatoi(char*);
unsigned int myhtoi(char*);
unsigned int rgbtobgr(unsigned int);
void FixMainControls();


//Implementation
void main(){}
// makes a smaller DLL file
BOOL WINAPI _DllMainCRTStartup(HINSTANCE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
	return 1;
}

BOOL WINAPI DllMain(HANDLE hInst, ULONG ul_reason_for_call, LPVOID lpReserved)
{
	g_hInstance = hInst;
	return TRUE;
}

// This is really a window procedure
LRESULT CALLBACK ChildDlgProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	WNDPROC proc;
	LRESULT a, dlgresult;

	proc = (WNDPROC)(UIntToPtr(GetWindowLongPtr(hwnd, DWLP_USER)));
	dlgresult = CallWindowProc(proc, hwnd, uMsg, wParam, lParam);

	if (g_hbmb)
		if (wascrollbars_handleMessages(hwnd, uMsg, wParam, lParam, &a)) return a;

	if (g_hbma)
	{
		if (a = WADlg_handleDialogMsgs(hwnd, uMsg, wParam, lParam))
		{
			SetWindowLong(hwnd, DWL_MSGRESULT, (LONG)a);
			return a;
		}

		/* fix for buttons unskinning itself after click under control */
		if (uMsg == WM_COMMAND) {
			FixMainControls();
		}
	}
	return dlgresult;
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	if (g_hbma)
	{
		LRESULT a;
		if (a = WADlg_handleDialogMsgs(hwnd, uMsg, wParam, lParam))
			return a;
	}

	if (uMsg == WM_NOTIFY_OUTER_NEXT)
	{
		HWND dlg;
		dlg = FindWindowEx(hwnd, 0, "#32770", NULL);
		SetWindowLongPtr(dlg, GWLP_WNDPROC, GetWindowLongPtr(dlg, DWLP_USER));

		PostMessage(hwnd, WM_USER+0x9, 0, 0);
	}
	else if (uMsg == WM_USER+0x9)
	{				
		HWND dlg;
		LONG oldChildDlgProc, tempChildDlgProc;
		EnumChildWindows(hwnd, EnumChildProc, 0);
		if (!wParam)
		{
			dlg = FindWindowEx(hwnd, 0, "#32770", NULL);
			if (dlg)
			{
				EnumChildWindows(dlg, EnumChildProc, 0);
				tempChildDlgProc=GetWindowLongPtr(dlg, GWLP_WNDPROC);
				if(PtrToInt(tempChildDlgProc)!=PtrToInt(ChildDlgProc))//don't replace DlgProc multiple times!
				{
					oldChildDlgProc = SetWindowLongPtr(dlg, GWLP_WNDPROC, PtrToInt(ChildDlgProc));
					SetWindowLongPtr(dlg, DWLP_USER, (LONG) oldChildDlgProc);
				}
			}
		}

		InvalidateRect(hwnd, NULL, TRUE);
		return 0;
	}

	return CallWindowProc(oldProc, hwnd, uMsg, wParam, lParam);
}

LRESULT CALLBACK FrameWndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	switch (uMsg)
	{
		case WM_DESTROY:
		{
			SetWindowLongPtr(g_hwndParent, GWLP_WNDPROC, PtrToInt(oldProc));
			SetWindowLong(g_hwndParent, GWL_STYLE, PtrToInt(g_oldnsiswndstyle));
			SetParent(g_hwndParent, g_oldnsisparentwnd);
			InvalidateRect(hwnd, NULL, TRUE);
		}
		break;

		case WM_CLOSE:
		{
			SetWindowLongPtr(g_hwndParent, GWLP_WNDPROC, PtrToInt(oldProc));
			SetWindowLong(g_hwndParent, GWL_STYLE, PtrToInt(g_oldnsiswndstyle));
			SetParent(g_hwndParent, g_oldnsisparentwnd);
			InvalidateRect(hwnd, NULL, TRUE);

			PostMessage(g_hwndParent, WM_SYSCOMMAND, SC_CLOSE, 0);
			return 0;
		}
		case WM_PAINT:
		{			
			PAINTSTRUCT ps;

			BeginPaint(hwnd, &ps);
			EndPaint(hwnd, &ps);

			return 0;
		}
	}
	return CallWindowProc(DefWindowProc, hwnd, uMsg, wParam, lParam);
}

// re-skin the button when we click on "Browse" in the directory page
void FixMainControls()
{
	LONG style;

  #define MakeButtonOwnerdraw(hwnd) style = GetWindowLong(hwnd, GWL_STYLE);\
	SetWindowLong(hwnd, GWL_STYLE, (style & ~BS_PUSHBUTTON) | BS_OWNERDRAW); \
	SetProp(hwnd, "SCBtn", (HANDLE)1);

	MakeButtonOwnerdraw(GetDlgItem(g_hwndParent, 3));
	MakeButtonOwnerdraw(GetDlgItem(g_hwndParent, 2));
	MakeButtonOwnerdraw(GetDlgItem(g_hwndParent, 1));
	MakeButtonOwnerdraw(GetDlgItem(g_hwndParent, 1027));  // Show Detail button

  #undef MakeButtonOwnerdraw
}

BOOL CALLBACK EnumChildProc(HWND hwnd, LPARAM lParam)
{
	char classname[256];

	GetClassName(hwnd, classname, 255);

	if (g_hbma)
	{
		if (!lstrcmpi(classname, "BUTTON"))
		{
			LONG style;

			style = GetWindowLong(hwnd, GWL_STYLE);

			if ( ((style & BS_GROUPBOX) == 0) || (GetParent(hwnd) == g_hwndParent) )
			{
				if ((style & BS_TYPEMASK) != BS_OWNERDRAW &&
					(style & BS_TYPEMASK) != BS_GROUPBOX &&
					(style & BS_TYPEMASK) != BS_AUTOCHECKBOX &&
					(style & BS_TYPEMASK) != BS_AUTORADIOBUTTON  ) {
					SetProp(hwnd, "SCBtn", (HANDLE)1);
				}
				SetWindowLong(hwnd, GWL_STYLE, (style & ~BS_PUSHBUTTON) | BS_OWNERDRAW);
			}
		}
	}
	if (g_hbmb)
	{
		if (!lstrcmpi(classname, "RICHEDIT20A") || !lstrcmpi(classname, "RICHEDIT32A")
			|| !lstrcmpi(classname, "SYSLISTVIEW32")
			|| !lstrcmpi(classname, "SYSTREEVIEW32")
			|| !lstrcmpi(classname, "EDIT")
			|| !lstrcmpi(classname, "LISTBOX"))
		{
			wascrollbars_init(hwnd);
		}
	}
	UpdateWindow(hwnd);
	return TRUE;
}

BOOL CALLBACK EnumChildProc_ScrollBarUninit(HWND hwnd, LPARAM lParam)
{
	char classname[256];
	if (g_hbmb)
	{
		GetClassName(hwnd, classname, 255);
		if (GetProp(hwnd, "SCBtn") )
			RemoveProp(hwnd, "SCBtn");

		// Special case for RichEdit controls
		if (!lstrcmpi(classname, "RICHEDIT20A") || !lstrcmpi(classname, "RICHEDIT32A")
			|| !lstrcmpi(classname, "SYSLISTVIEW32")
			|| !lstrcmpi(classname, "SYSTREEVIEW32")
			|| !lstrcmpi(classname, "EDIT")
			|| !lstrcmpi(classname, "LISTBOX"))
		{
			wascrollbars_uninit(hwnd);
		}
		UpdateWindow(hwnd);
	}
	return TRUE;
}


void __declspec(dllexport) skinit(HWND hwndParent, int string_size, char *variables, stack_t **stacktop)
{
	g_hwndParent = hwndParent;
	wascrollbars_initapp();
	EXDLL_INIT();
	internal_skin(0);
}

void __declspec(dllexport) setskin(HWND hwndParent, int string_size, char *variables, stack_t **stacktop)
{
	g_hwndParent = hwndParent;
	EXDLL_INIT();
	internal_skin(1);
}

void internal_skin(int isUpdating)
{
	char fnb[MAX_PATH];
	char fna[MAX_PATH];
	char temp[MAX_PATH];
	char compstring[30];

	char *szLastErr;

	int textcolor = 0x00000000;
	int textscolor = 0x00000000;
	int textdcolor = 0x00808080;

	char tcp[] = "/textcolor=";
	char tscp[] = "/selectedtextcolor=";
	char tdcp[] = "/disabledtextcolor=";
	char bcp[] = "/button=";
	char sbcp[] = "/scrollbar=";

	// get parmaters
	int image;
	do
	{
		image = 1;
		popstring(temp);

		lstrcpyn(compstring , temp, lstrlen(tdcp)+1);
		if (lstrcmp(compstring , tdcp) == 0 )
		{
			image = 0;
			textdcolor = myhtoi(&temp[lstrlen(tdcp)]);
		}
		else
		{
			lstrcpyn(compstring , temp, lstrlen(tscp)+1);
			if (lstrcmp(compstring , tscp) == 0 )
			{
				image = 0;
				textscolor = myhtoi(&temp[lstrlen(tscp)]);
			}
			else
			{
				lstrcpyn(compstring , temp, lstrlen(tcp)+1);
				if (lstrcmp(compstring , tcp) == 0 )
				{
					image = 0;
					textcolor = myhtoi(&temp[lstrlen(tcp)]);
				}
				else
				{
					lstrcpyn(compstring , temp, lstrlen(bcp)+1);
					if (lstrcmp(compstring , bcp) == 0 )
					{
						image = 0;
						lstrcpy(fna , &temp[lstrlen(bcp)]);
						lstrcpy(temp , "");
					}
					else
					{
						lstrcpyn(compstring , temp, lstrlen(sbcp)+1);
						if (lstrcmp(compstring , sbcp) == 0 )
						{
							image = 0;
							lstrcpy(fnb , &temp[lstrlen(sbcp)]);
							lstrcpy(temp , "");
						}
						else
						{
							lstrcpyn(compstring , temp, 2);
							if (lstrcmp(compstring , "/") == 0 )
							{
								char szErr[255];
								wsprintf(szErr, "bad parameter: %s", (LPSTR)temp);
								pushstring(szErr);

								return;
							}
						}
					}
				}
			}
		}
	}
	while (image != 1);
	
	pushstring(temp);

	textcolor = rgbtobgr(textcolor);
	textscolor = rgbtobgr(textscolor);
	textdcolor = rgbtobgr(textdcolor);



	if (GetFileAttributes(fnb) == 0xFFFFFFFF && GetFileAttributes(fna) == 0xFFFFFFFF)
	{
		szLastErr = GetLastErrorStr();
		pushstring(szLastErr);
		LocalFree((HLOCAL)szLastErr);// Free the buffer.
		return;
	}


	if (isUpdating)
	{
		WADlg_close();
		if (g_hbmb)       DeleteObject(g_hbmb);
		if (g_hbma)		  DeleteObject(g_hbma);
	}

	g_hbma=LoadImage(NULL,fna,IMAGE_BITMAP,0,0,LR_CREATEDIBSECTION|LR_LOADFROMFILE);
	g_hbmb=LoadImage(NULL,fnb,IMAGE_BITMAP,0,0,LR_CREATEDIBSECTION|LR_LOADFROMFILE);

	if (!g_hbmb && !g_hbma) 
	{
		szLastErr = GetLastErrorStr();
		pushstring(szLastErr);
		LocalFree((HLOCAL)szLastErr);// Free the buffer.
		return;
	}


	WADlg_init(g_hbmb, g_hbma, textcolor, textscolor, textdcolor);

	if (!isUpdating)
	{
		SetWindowLong(g_hwndParent, GWL_EXSTYLE, WS_EX_CONTROLPARENT);

		oldProc = IntToPtr(SetWindowLongPtr(g_hwndParent, GWLP_WNDPROC, PtrToInt(WndProc)));
		PostMessage(g_hwndParent, WM_USER+0x9, 0, 0);
		ShowWindow(g_hwndParent, SW_SHOW);
	}

	pushstring("success");
}

void __declspec(dllexport) unskinit(HWND hwndParent, int string_size, char *variables, stack_t **stacktop)
{
	// Free graphics stuff
	WADlg_close();

	if (g_hbma)		DeleteObject(g_hbma);
	if (g_hbmb)
	{
		DeleteObject(g_hbmb);
		wascrollbars_uninitapp();
	}
	InvalidateRect(hwndParent, NULL, TRUE);
}

// U T I L I T Y   F U N C T I O N S

char* GetLastErrorStr(void)
{
	LPVOID lpMsgBuf;
 
	FormatMessage( 
		FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
		NULL,
		GetLastError(),
		MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
		(LPTSTR) &lpMsgBuf,
		0,
		NULL 
	);

	return (char*)lpMsgBuf;
}

unsigned int myatoi(char *s)
{
  unsigned int v=0;

  for (;;)
  {
    unsigned int c=*s++;
    if (c >= '0' && c <= '9') c-='0';
    else break;
    v*=10;
    v+=c;
  }
  return v;
}

unsigned int myhtoi(char *s)
{
	unsigned int v = 0;

	for (;;)
	{
		unsigned int c=*s++;
		if (c >= '0' && c <= '9')
		{
			c -= '0';
		}
		else if (c >= 'A' && c <= 'F')
		{
			c -= 'A';
			c += 10;
		}
		else if (c >= 'a' && c <= 'f')
		{
			c -= 'a';
			c += 10;
		}
		else break;
		v *= 16;
		v += c;
	}
	return v;
}

unsigned int rgbtobgr(unsigned int rgb)
{
	unsigned int bgr;
	unsigned int temp1 , temp2;

	temp1 = rgb & 0x000000FF;
	temp2 = rgb & 0x00FF0000;

	temp1 = temp1 * 0x00010000;
	temp2 = temp2 / 0x00010000;

	bgr = rgb & 0x0000FF00;
	bgr += temp1;
	bgr += temp2;

	return bgr;
}