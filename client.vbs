'
' CLIENT WINSOCK VBSCRIPT
'
' NOTES: (FEBRUARY 20, 2007)
'
' Delays are required where they are located,
' or it sends data too quick, and errors.
' 
' Uses Port 80 by default.
' IP and Port are user settings.
'
' Creates a Log file.
' c:\WSClient.log
'
' if winsock not registered it will try to register
' if winsock ocx is in path it will register
' if cannot register it will error and quit
'
' client connects to server
' client sends data to server when connected
' server checks data received from client
' server sends reply to client if data valid
' server closes whether valid or invalid
' if data valid client receives, closes and quits
' if data invalid client ends loop, closes and quits
'
' this only sends basic text, no long essays or files.
' for that, it would require some minor but required changes.
'

Option Explicit
Dim winsock, ReceiveData, secs

'****** CHANGE THESE SETTINGS *********

Const RemoteHost           = "localhost" '"192.168.1.144"
Const RemotePort           = 80
Const DataToSend           = "Test"

'***************************************

Const sckClosed            = 0 '// Default. Closed 
Const sckOpen              = 1 '// Open 
Const sckListening         = 2 '// Listening 
Const sckConnectionPending = 3 '// Connection pending 
Const sckResolvingHost     = 4 '// Resolving host 
Const sckHostResolved      = 5 '// Host resolved 
Const sckConnecting        = 6 '// Connecting 
Const sckConnected         = 7 '// Connected 
Const sckClosing           = 8 '// Peer is closing the connection 
Const sckError             = 9 '// Error 

MsgBox "Client Started."
WriteData Now & " - Client Started"

'********* CREATE & CONNECT **********

'// CREATE WINSOCK
On Error Resume Next
Set winsock = Wscript.CreateObject("MSWINSOCK.Winsock", "winsock_")
If Err.Number <> 0 Then
    '// REGISTER WINSOCK IF ERROR
    WriteData Now & " - Registering Winsock"  '// log action
    Set winsock = Nothing
    If RegWinsock = False Then
        '// REGISTER ERROR SO EXIT
        MsgBox "Winsock Object Error!" & vbCrLf & "Script will exit now."
        WriteData Now & " - Winsock Object Error."
        WScript.Quit
    Else
        Set winsock = Wscript.CreateObject("MSWINSOCK.Winsock", "winsock_")
    End If
End If
On Error Goto 0

'// CONNECT NOW
winsock.RemoteHost = RemoteHost
winsock.RemotePort = RemotePort 
winsock.Connect

'********* WAIT FOR EVENTS ***********

'// MAIN DELAY - WINSOCK EVENTS WILL EXIT SCRIPT

'// 25 SEC TIMEOUT OR SERVER CLOSING EXITS LOOP
while winsock.State <> sckError And winsock.State <> sckClosing And secs <> 25
    WScript.Sleep 1000  '// 1 sec delay in loop
    secs = secs + 1     '// wait 25 secs max
Wend

'********** FAIL SAFE EXIT ***********

'// IF WE GET HERE THERE WAS AN ERROR

If secs > 24 Then
    '// CONNECTION TIMED OUT
    MsgBox "Error! Client Timed Out"
    WriteData Now & " - Client Timed Out"
ElseIf winsock.State = sckClosing Or winsock.State = sckClosed Then
    '// DATA SENT TO SERVER WAS INVALID SO IT CLOSED
    MsgBox "Error! Invalid Data Sent"
    WriteData Now & " - Invalid Data Sent"
End If
ClientClose()

'********** WINSOCK EVENTS ***********

'// WINSOCK CONNECTED // SEND DATA
Sub winsock_Connect()
    WriteData Now & " - Connected to Server"
    winsock.SendData CStr(DataToSend)
    WriteData Now & " - Data Sent to Server"
End Sub

'// WINSOCK DATA ARRIVE // GET REPLY & EXIT
Sub winsock_dataArrival(bytesTotal)
    Dim strData
    winsock.GetData strData, vbString
    ReceiveData = strData 
    WriteData Now & " - Server Replied Okay: " & ReceiveData    
    WScript.Sleep 1000
    ClientClose() 
End Sub

'// WINSOCK ERROR // ERROR SO EXIT
Sub winsock_Error(Number, Description, SCode, Source, HelpFile, HelpContext, CancelDisplay)
    MsgBox "Cient Error: " & Number & vbCrLf & Description
    WriteData Now & " - Cient Error: " & Number & ". " & Description
    ClientClose()
End Sub

'******** COMMON PROCEDURES **********

'// EXIT SCRIPT
Sub ClientClose()
    If winsock.state <> sckClosed Then winsock.Close
    Set winsock = Nothing
    WriteData Now & " - Client Closed."
    Wscript.Quit
End SUb

'// CREATE LOG ENTRY
Function WriteData(Data)
    Dim fso, file
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set file = fso.OpenTextFile("C:\Users\OmerLab\Documents\GitHub\RamanSpecUsingStageXY\WSClient.log", 8, True)
    file.write Data & vbCrLf
    file.Close
    Set file = Nothing
    Set fso = Nothing
End Function

'******** REGISTER WINSOCK **********

Function RegWinsock()
    Dim RegCmd, RegOcx, TmpOcx
    If CheckObject("MSWINSOCK.Winsock", "winsock_") Then
        RegWinsock = True
        Exit Function
    End If
    RegOcx = SystemDirectory & "\MSWINSCK.OCX"
    TmpOcx = ScriptPath & "\MSWINSCK.OCX"
    RegCmd = "regsvr32.exe /s " & RegOcx
    If Not FileExists(TmpOcx) Then Exit Function
    If FileCopy(TmpOcx, RegOcx) = False Then Exit Function
    If FileExists(RegOcx) = False Then Exit Function
    If ShellCmd(RegCmd) = False Then Exit Function
    If CheckObject("MSWINSOCK.Winsock", "winsock_") Then
        RegWinsock = True
    End If
End Function

'// SHELL COMMAND PROMPT
Function ShellCmd(ByVal pCmd)
    Dim ShellWsck, Rtrn
    On Error Goto 0: On Error Resume Next
    Set ShellWsck = CreateObject("WScript.Shell")
    Rtrn = ShellWsck.Run(pCmd, 0, True)
    If Rtrn = 0 Then
        If Err = 0 Then ShellCmd = True
    End If
    Set ShellWsck = Nothing
    On Error Goto 0
End Function

'// GET THIS SCRIPT PATH
Function ScriptPath()
    On Error Goto 0: On Error Resume Next
    ScriptPath = CreateObject("Scripting.FileSystemObject")._
        GetParentFolderName(Wscript.ScriptFullName)
    On Error Goto 0
End Function

'// GET WINDOWS SYSTEM DIRECTORY
Function SystemDirectory()
    Dim objFso
    On Error Goto 0: On Error Resume Next
    Set objFso = CreateObject("Scripting.FileSystemObject")
        SystemDirectory = objFso.GetSpecialFolder(1)
    Set objFso = nothing
    On Error Goto 0
End Function

'// COPY A FILE
Function FileCopy(ByVal pFile1, ByVal pFile2)
    Dim objFso
    On Error Goto 0: On Error Resume Next
    Set objFso = CreateObject("Scripting.FileSystemObject")
        If objFSO.FileExists(pFile2) Then
            If Err = 0 Then FileCopy = True    
            Exit Function
        End If
        If objFSO.FileExists(pFile1) Then
            objFso.CopyFile pFile1, pFile2
            If Err = 0 Then FileCopy = True
        End If
    Set objFso = nothing
    On Error Goto 0
End Function

'// FILE EXISTS
Function FileExists(ByVal pFile)
    Dim objFSO
    On Error Goto 0: On Error Resume Next
    Set objFSO = CreateObject("Scripting.FileSystemObject")
        If objFSO.FileExists(pFile) = True Then
            If Err = 0 Then FileExists = True
        End If
    Set objFSO = Nothing
    On Error Goto 0
End Function

'// CHECK IF OBJECT IS REGISTERED
Function CheckObject(ByVal pObj, ByVal pAram)
    Dim objTemp
    On Error Goto 0: On Error Resume Next
    If Len(pAram) <> 0 Then
        Set objTemp = WScript.CreateObject(pObj, pAram)
    Else
        Set objTemp = CreateObject(pObj)
    End If
    If Err = 0 Then CheckObject = True
    Set objTemp = Nothing
    On Error Goto 0
End Function
