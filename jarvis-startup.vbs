' S.H.A.N.E. Startup Greeting
' Shows a styled popup with Yes/No buttons + speaks

Set WshShell = CreateObject("WScript.Shell")
Set sapi = CreateObject("SAPI.SpVoice")
Set fso = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Set voice
For Each v In sapi.GetVoices()
    If InStr(LCase(v.GetDescription()), "david") > 0 Or InStr(LCase(v.GetDescription()), "mark") > 0 Then
        Set sapi.Voice = v
        Exit For
    End If
Next
sapi.Rate = 1

' Greet based on time of day
currentHour = Hour(Now)
If currentHour < 12 Then
    greeting = "Good morning sir."
ElseIf currentHour < 17 Then
    greeting = "Good afternoon sir."
Else
    greeting = "Good evening sir."
End If

' Result file for button click
resultFile = WshShell.ExpandEnvironmentStrings("%TEMP%") & "\jarvis_response.txt"
If fso.FileExists(resultFile) Then fso.DeleteFile(resultFile)

' Create HTA popup with clickable buttons
htaPath = WshShell.ExpandEnvironmentStrings("%TEMP%") & "\jarvis_prompt.hta"
Set htaFile = fso.CreateTextFile(htaPath, True)
htaFile.WriteLine "<html><head>"
htaFile.WriteLine "<title>S.H.A.N.E.</title>"
htaFile.WriteLine "<HTA:APPLICATION ID=""jarvisPrompt"" BORDER=""none"" BORDERSTYLE=""none"" CAPTION=""no"" SHOWINTASKBAR=""yes"" SINGLEINSTANCE=""yes"" WINDOWSTATE=""normal"" SCROLL=""no"" />"
htaFile.WriteLine "<style>"
htaFile.WriteLine "body { background: #080816; color: #00d4ff; font-family: 'Segoe UI', sans-serif; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; margin: 0; border: 2px solid rgba(0,212,255,0.25); overflow: hidden; }"
htaFile.WriteLine ".title { font-size: 32px; font-weight: bold; letter-spacing: 10px; margin-bottom: 8px; background: linear-gradient(90deg, #00d4ff, #00ff88); -webkit-background-clip: text; color: #00d4ff; }"
htaFile.WriteLine ".line { width: 200px; height: 1px; background: linear-gradient(90deg, transparent, #00d4ff55, transparent); margin-bottom: 18px; }"
htaFile.WriteLine ".greeting { font-size: 18px; opacity: 0.8; margin-bottom: 6px; }"
htaFile.WriteLine ".ask { font-size: 16px; opacity: 0.9; margin-bottom: 25px; }"
htaFile.WriteLine ".buttons { display: flex; gap: 20px; }"
htaFile.WriteLine ".btn { padding: 12px 40px; font-size: 15px; font-weight: bold; letter-spacing: 3px; border: 2px solid; border-radius: 4px; cursor: pointer; font-family: 'Segoe UI', sans-serif; transition: all 0.2s; }"
htaFile.WriteLine ".btn-yes { background: rgba(0,255,136,0.1); border-color: #00ff88; color: #00ff88; }"
htaFile.WriteLine ".btn-yes:hover { background: rgba(0,255,136,0.25); }"
htaFile.WriteLine ".btn-no { background: rgba(255,68,68,0.1); border-color: #ff4444; color: #ff4444; }"
htaFile.WriteLine ".btn-no:hover { background: rgba(255,68,68,0.25); }"
htaFile.WriteLine "</style></head><body>"
htaFile.WriteLine "<div class=""title"">S.H.A.N.E.</div>"
htaFile.WriteLine "<div class=""line""></div>"
htaFile.WriteLine "<div class=""greeting"">" & greeting & "</div>"
htaFile.WriteLine "<div class=""ask"">Would you like to activate Shane, sir?</div>"
htaFile.WriteLine "<div class=""buttons"">"
htaFile.WriteLine "  <button class=""btn btn-yes"" onclick=""respond('yes')"">YES</button>"
htaFile.WriteLine "  <button class=""btn btn-no"" onclick=""respond('no')"">NO</button>"
htaFile.WriteLine "</div>"
htaFile.WriteLine "<script>"
htaFile.WriteLine "window.resizeTo(440, 260);"
htaFile.WriteLine "var sw = screen.width, sh = screen.height;"
htaFile.WriteLine "window.moveTo((sw - 440) / 2, (sh - 260) / 2);"
htaFile.WriteLine "function respond(ans) {"
htaFile.WriteLine "  var fso = new ActiveXObject('Scripting.FileSystemObject');"
htaFile.WriteLine "  var f = fso.CreateTextFile('" & Replace(resultFile, "\", "\\") & "', true);"
htaFile.WriteLine "  f.Write(ans);"
htaFile.WriteLine "  f.Close();"
htaFile.WriteLine "  window.close();"
htaFile.WriteLine "}"
htaFile.WriteLine "</script>"
htaFile.WriteLine "</body></html>"
htaFile.Close

' Speak greeting in background while showing popup
sapi.Speak greeting, 1
sapi.Speak "Would you like to activate Shane?", 1

' Show the popup (waits until user clicks a button and it closes)
WshShell.Run "mshta """ & htaPath & """", 1, True

' Read result
If fso.FileExists(resultFile) Then
    Set rf = fso.OpenTextFile(resultFile, 1)
    response = Trim(rf.ReadAll())
    rf.Close
    fso.DeleteFile resultFile
Else
    response = "no"
End If

' Always start the floating icon
WshShell.Run "wscript """ & scriptDir & "\jarvis-widget.vbs""", 0, False

If LCase(response) = "yes" Then
    sapi.Speak "Right away sir. Activating Shane now."
    WScript.Sleep 2000
    WshShell.Run "chrome http://localhost:8080/jarvis.html", 0, False
Else
    sapi.Speak "Understood sir. I'll be on standby. Click the icon when you need me."
End If
