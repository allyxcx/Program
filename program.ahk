SetBatchLines, -1
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
version := 0.2
; pre auto update

if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"


;installer
if version <= 0.1
{
UrlDownloadToFile, http://tiny.cc/autoupdate/program.ahk?dl=1, %A_WorkingDir%\Updated.ahk
sleep, 10000
run, %A_WorkingDir%\Updated.ahk
exitapp
}
else
{
goto, nextnext
}

nextnext:

IfNotExist, C:\Program Files (x86)\Venera\Program\Fonts\Calligraphr-Regular (1).ttf
{
FileCreateDir, C:\Program Files (x86)\Venera\Program\Fonts
UrlDownloadToFile, https://www.dropbox.com/s/653pvstpuj4651l/font.ttf?dl=1, C:\Program Files (x86)\Venera\Program\Fonts\imagefont.ttf
goto, fdwnld.1
}
else
{
goto, fdwnld.1
}
fdwnld.1:

IfNotExist, C:\Program Files (x86)\Venera\Program\Theme\bloop.png
{
FileCreateDir, C:\Program Files (x86)\Venera\Program\Theme
UrlDownloadToFile, https://www.dropbox.com/s/ceh016gfmcg528h/bloop.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\bloop.png
goto, fdwnld.2
}
else
{
goto, fdwnld.2
}
fdwnld.2:

IfNotExist, C:\Program Files (x86)\Venera\Program\Theme\titlebar.png
{
FileCreateDir, C:\Program Files (x86)\Venera\Program\Theme
UrlDownloadToFile, https://www.dropbox.com/s/9odrulgp0lnw576/titlebar.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\titlebar.png
goto, fdwnld.3
}
else
{
goto, fdwnld.3
}
fdwnld.3:

IfNotExist, C:\Program Files (x86)\Venera\Program\Theme\Buttons\mbutton.png
{
FileCreateDir, C:\Program Files (x86)\Venera\Program\Theme\Buttons\
UrlDownloadToFile, https://www.dropbox.com/s/hm2l9gnufy074xt/mbutton.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\mbutton.png
goto, fdwnld.4
}
else
{
goto, fdwnld.4
}
fdwnld.4:

IfNotExist, C:\Program Files (x86)\Venera\Program\Theme\Buttons\cbutton.png
{
FileCreateDir, C:\Program Files (x86)\Venera\Program\Theme\Buttons\
UrlDownloadToFile, https://www.dropbox.com/s/l5oailr4aica3xm/cbutton.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\cbutton.png
goto, fdwnld.5
}
else
{
goto, fdwnld.5
}
fdwnld.5:

IfNotExist, C:\Program Files (x86)\Venera\Program\Theme\Buttons\bsettingsreinstall.png
{
FileCreateDir, C:\Program Files (x86)\Venera\Program\Theme\Buttons\
UrlDownloadToFile, https://www.dropbox.com/s/2i5geraxxixm0kx/bsettingsreinstall.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\bsettingsreinstall.png
goto, fdwnld.6
}
else
{
goto, fdwnld.6
}
fdwnld.6:

IfNotExist, C:\Program Files (x86)\Venera\Program\Theme\Buttons\larrowbutton.png
{
FileCreateDir, C:\Program Files (x86)\Venera\Program\Theme\Buttons\
UrlDownloadToFile, https://www.dropbox.com/s/4ar3c6jxt7x3ooz/larrowbutton.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\larrowbutton.png
UrlDownloadToFile, https://www.dropbox.com/s/4snoyal5o8i9n2y/rarrowbutton.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\rarrowbutton.png
goto, fdwnld.7
}
else
{
goto, fdwnld.7
}
fdwnld.7:



; program start
Gui, -Caption
Gui, -Resize
Gui, +hwndHGUI

;TabList = |. Shop|, Games|! Settings
TabList = |Shop|Games|Settings


; General images
Gui, Add, Picture, x0 y0 w3000 h21, C:\Program Files (x86)\Venera\Program\Theme\titlebar.png
Gui, Add, Picture, x118 y0 w1133 h21 gdrag BackgroundTrans AltSubmit, C:\Program Files (x86)\Venera\Program\Theme\titlebar.png
Gui, Add, Picture, x1278 y1 w20 h20 gclose +BackgroundTrans, C:\Program Files (x86)\Venera\Program\Theme\Buttons\cbutton.png
Gui, Add, Picture, x1255 y1 w20 h20 gminimize +BackgroundTrans, C:\Program Files (x86)\Venera\Program\Theme\Buttons\mbutton.png
Gui, Add, Picture, x0 y0 w1920 h1057 +0x4000000, C:\Program Files (x86)\Venera\Program\Theme\bloop.png
;Gui, Add, Picture, x600 y500 w80 h80 gpgback +BackgroundTrans, C:\Program Files (x86)\Venera\Program\Theme\Buttons\larrowbutton.png
;Gui, Add, Picture, x650 y500 w80 h80 gpgfwd +BackgroundTrans, C:\Program Files (x86)\Venera\Program\Theme\Buttons\rarrowbutton.png

;clock
SetTimer, UpdateOSD, 200
Gosub, UpdateOSD 
Gui, Add, Text, x200 y1 vMyText cFFFFFF +BackgroundTrans, XXXXX YYYYY


; Listbox/tabcontrol/tab functions and display
Gui, Font, S15 cwhite, Arial
Gui, Add, Text,x620 y-1 w1000 h20 +BackgroundTrans, Venera

Gui Color, , 313333
Gui, Font, S25 cwhite, Calligraphr
Gui, Add, ListBox, x-2 y-3 w120 h800 gListbox vMyListBox -E0x200, %TabList%
GuiControl, Choose, Tab, shop
Gui, Add, Tab, gShop vShop -Background +Theme,Shop
Gui, Add, Tab, x100 y0 w810 h630 gGames vGames -Background +Theme,Games
Gui, Add, Tab, gSettings vSettings -Background +Theme,Settings
Gui, Add, Picture, x650 y400 greset +BackgroundTrans, C:\Program Files (x86)\Venera\Program\Theme\Buttons\bsettingsreinstall.png
Gui,Show,w1300 h700 Center, Venera
HideFocusBorder(HGUI)
return

; tab functions
shop:
return

games:
return

settings:
return

; Program Functions / non-accesible by user

drag:
   PostMessage, 0xA1, 2
return

close:
exitapp
return

minimize:
WinMinimize
return


reset:
msgbox, Restart once the program shutdowns.
FileDelete, C:\Program Files (x86)\Venera\Program\Theme\titlebar.png
FileDelete, C:\Program Files (x86)\Venera\Program\Theme\Buttons\cbutton.png
FileDelete, C:\Program Files (x86)\Venera\Program\Theme\Buttons\mbutton.png
FileDelete, C:\Program Files (x86)\Venera\Program\Theme\bloop.png
FileDelete, C:\Program Files (x86)\Venera\Program\Theme\Buttons\bsettingsreinstall.png
FileDelete, C:\Program Files (x86)\Venera\Program\Theme\Buttons\larrowbutton.png
FileDelete, C:\Program Files (x86)\Venera\Program\Theme\Buttons\rarrowbutton.png
UrlDownloadToFile, https://www.dropbox.com/s/ceh016gfmcg528h/bloop.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\bloop.png
UrlDownloadToFile, https://www.dropbox.com/s/9odrulgp0lnw576/titlebar.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\titlebar.png
UrlDownloadToFile, https://www.dropbox.com/s/hm2l9gnufy074xt/mbutton.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\mbutton.png
UrlDownloadToFile, https://www.dropbox.com/s/l5oailr4aica3xm/cbutton.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\cbutton.png
UrlDownloadToFile, https://www.dropbox.com/s/2i5geraxxixm0kx/bsettingsreinstall.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\bsettingsreinstall.png
UrlDownloadToFile, https://www.dropbox.com/s/4ar3c6jxt7x3ooz/larrowbutton.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\larrowbutton.png
UrlDownloadToFile, https://www.dropbox.com/s/4snoyal5o8i9n2y/rarrowbutton.png?dl=1, C:\Program Files (x86)\Venera\Program\Theme\Buttons\rarrowbutton.png
exitapp
return


;tablistnames
listbox:
Gui, submit, NoHide
Loop, Parse, TabList, |
    {
        If (MyListBox = A_LoopField)
            GuiControl, Show, %A_LoopField%
        else
            GuiControl, Hide, %A_LoopField%
    }
return


;. Hide Button Border
HideFocusBorder(wParam, lParam := "", uMsg := "", hWnd := "") {
	Static Affected := [] ; affected controls / GUIs
        , HideFocus := 0x00010001 ; UIS_SET << 16 | UISF_HIDEFOCUS
	     , OnMsg := OnMessage(0x0128, Func("HideFocusBorder"))
	If (uMsg = 0x0128) { ; called by OnMessage()
      If (wParam = HideFocus)
         Affected[hWnd] := True
      Else If Affected[hWnd]
         PostMessage, 0x0128, %HideFocus%, 0, , ahk_id %hWnd%
   }
   Else If DllCall("IsWindow", "Ptr", wParam, "UInt")
	  PostMessage, 0x0128, %HideFocus%, 0, , ahk_id %wParam%
}
return

UpdateOSD:
FormatTime, Time , hh,Time
GuiControl,, MyText, %time%
return

