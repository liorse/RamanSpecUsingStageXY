 
Const ACQ_SPECTRUM = 0 
Const ACQ_IMAGE = 1 
Const ACQ_LABSPEC_PARAM = 2 
Const ACQ_SPECTRAL_IMAGE = 3 
Const ACQ_GET_TEMPERATURE = 4 
Const ACQ_SPECTRUM_RTD = 5 
Const ACQ_SET_PMT_PARAMETER = 6 
Const ACQ_MACRO_SPOT = 7 
Const ACQ_CANCEL=8 
Const ACQ_PMT_CCD=9 
Const ACQ_AUTO_SHOW = 10 
Const ACQ_LABSPEC_SPIKE_REMOVING = 0 
Const ACQ_NO_SPIKE_REMOVING = 100 
Const ACQ_SINGLE_SPIKE_REMOVING = 200 
Const ACQ_DOUBLE_SPIKE_REMOVING = 300 
Const ACQ_DOUBLE_AUTOADD_SPIKE_REMOVING = 400 
Const ACQ_AUTO_SCANNING = 1000 
Const ACQ_NO_CLOSE_SHUTTER = 2000 
Const ACQ_ACCUMULATION_MODE = 10000 
Const ACQ_NO_ICS = 100000 
Const ACQ_ICS = 200000 
Const ACQ_NO_DARK = 1000000 
Const ACQ_DARK = 2000000 

Dim SpectrumID 
Dim SpectrumValues


'Set fs = CreateObject("Scripting.FileSystemObject")
 
 ' Create a while loop which write to the file every 2 seconds
 Dim tic 
 Dim Path
 Dim CommandFileName
 Dim StatusFileName
 Dim SavedSpectrumFileName ' Read from command line
 Dim PathAndFileName
 Dim PathAndFileNameForCommand 
 Dim PathAndFileNameForStatus
 Dim Request2StartMeasurement
 Dim CommandSectionName
 Dim CommandKeyName
 Dim SavedSpectrumFileNameKeyName
 Dim StatusSectionName
 Dim StatusKeyName
 Dim MeasurementInProgress
 Dim Format 
 Dim Ret 
 
 MeasurementInProgress = 0
 CommandSectionName = "RequestFromLabview"
 CommandKeyName = "Request2StartMeasurement"
 SavedSpectrumFileNameKeyName = "FileName4Spectrum"
 StatusSectionName = "Measurement"
 StatusKeyName = "MeasurementInProgress"
 Path = "C:\Users\OmerLab\Documents\GitHub\RamanSpecUsingStageXY\"
 CommandFileName = "SpectrometerCommand.txt"
 StatusFileName = "SpectrometerStatus.txt"
 
 PathAndFileNameForStatus = Path & StatusFileName
 PathAndFileNameForCommand =  Path & CommandFileName
 tic = Timer
 SpectrumID = 0
 
 
 
While True
   ' Generate status file - To be completed
   If Timer - tic > 1 Then
     WriteIni PathAndFileNameForStatus, StatusSectionName, StatusKeyName, MeasurementInProgress
     'Set a = fs.CreateTextFile(PathAndFileNameForStatus, True)
     'a.WriteLine(Timer)
     'a.Close
     
    'Wscript.Echo Timer - tic
     tic = Timer
   End If
   LabSpec.Pause 300
   
   ' Check Command file For a request from Labview To start a measurement
   Request2StartMeasurement = ReadIni(PathAndFileNameForCommand, CommandSectionName, CommandKeyName)
   If Request2StartMeasurement = 1 Then
     MeasurementInProgress = 1
     ' Nullify Command
     WriteIni PathAndFileNameForCommand, CommandSectionName, CommandKeyName, 0
     ' Update status the measurement is in progress
     WriteIni PathAndFileNameForStatus, StatusSectionName, StatusKeyName, MeasurementInProgress
     ' Read filename from ini file To save spectrum
     SavedSpectrumFileName = ReadIni(PathAndFileNameForCommand, CommandSectionName,SavedSpectrumFileNameKeyName)
     StartAcq()
     SpectrumID=LabSpec.GetAcqID() ' Wait until Spectrum is ready (acquisition is done) 
  
   End If
   
   
   If SpectrumID > 0 Then
      'Measurement Ended
      LabSpec.Exec SpectrumID , SHOW_SPECTRUM, Param ' Show Spectrum 
      ' Save To file
      Format = "txt" 
      With New RegExp 
        .Pattern = """"
        .IgnoreCase = False
        .Global = True
        SavedSpectrumFileName = .Replace(SavedSpectrumFileName, "")
      End With
      
      Ret = LabSpec.Save(SpectrumID, Path & SavedSpectrumFileName, Format) 
  
      MeasurementInProgress = 0
      SpectrumID = 0
   End If 
'LabSpec.Message CStr(Request2StartMeasurement), 0  
    
     
   
Wend 

Private Sub StartAcq() 

   Dim Mode 
   Dim IntegrationTime 
   Dim AccumulationNum 
   Dim AcqFrom 
   Dim AcqTo 

   Mode=ACQ_LABSPEC_PARAM 
   'Mode= ACQ_IMAGE
   IntegrationTime=1 ' 1.5 sec acquisition 
   AccumulationNum=2   ' 2 Accumulations 
   AcqFrom=LabSpec.ConvertUnit(-400, 0) ' From=To => No MultiWindows 
   AcqTo=LabSpec.ConvertUnit(1700, 0) 
   
   LabSpec.Acq Mode,IntegrationTime,AccumulationNum,AcqFrom,AcqTo 
   
    
End Sub 

Function ReadIni( myFilePath, mySection, myKey )
    ' This function returns a value read from an INI file
    '
    ' Arguments:
    ' myFilePath  [string]  the (path and) file name of the INI file
    ' mySection   [string]  the section in the INI file to be searched
    ' myKey       [string]  the key whose value is to be returned
    '
    ' Returns:
    ' the [string] value for the specified key in the specified section
    '
    ' CAVEAT:     Will return a space if key exists but value is blank
    '
    ' Written by Keith Lacelle
    ' Modified by Denis St-Pierre and Rob van der Woude

    Const ForReading   = 1
    Const ForWriting   = 2
    Const ForAppending = 8

    Dim intEqualPos
    Dim objFSO, objIniFile
    Dim strFilePath, strKey, strLeftString, strLine, strSection

    Set objFSO = CreateObject( "Scripting.FileSystemObject" )

    ReadIni     = ""
    strFilePath = Trim( myFilePath )
    strSection  = Trim( mySection )
    strKey      = Trim( myKey )

    If objFSO.FileExists( strFilePath ) Then
        Set objIniFile = objFSO.OpenTextFile( strFilePath, ForReading, False )
        Do While objIniFile.AtEndOfStream = False
            strLine = Trim( objIniFile.ReadLine )

            ' Check if section is found in the current line
            If LCase( strLine ) = "[" & LCase( strSection ) & "]" Then
                strLine = Trim( objIniFile.ReadLine )

                ' Parse lines until the next section is reached
                Do While Left( strLine, 1 ) <> "["
                    ' Find position of equal sign in the line
                    intEqualPos = InStr( 1, strLine, "=", 1 )
                    If intEqualPos > 0 Then
                        strLeftString = Trim( Left( strLine, intEqualPos - 1 ) )
                        ' Check if item is found in the current line
                        If LCase( strLeftString ) = LCase( strKey ) Then
                            ReadIni = Trim( Mid( strLine, intEqualPos + 1 ) )
                            ' In case the item exists but value is blank
                            If ReadIni = "" Then
                                ReadIni = " "
                            End If
                            ' Abort loop when item is found
                            Exit Do
                        End If
                    End If

                    ' Abort if the end of the INI file is reached
                    If objIniFile.AtEndOfStream Then Exit Do

                    ' Continue with next line
                    strLine = Trim( objIniFile.ReadLine )
                Loop
            Exit Do
            End If
        Loop
        objIniFile.Close
    Else
       'WScript.Echo strFilePath & " doesn't exists. Exiting..."
       'Wscript.Quit 1
    End If
End Function

Sub WriteIni( myFilePath, mySection, myKey, myValue )
    ' This subroutine writes a value to an INI file
    '
    ' Arguments:
    ' myFilePath  [string]  the (path and) file name of the INI file
    ' mySection   [string]  the section in the INI file to be searched
    ' myKey       [string]  the key whose value is to be written
    ' myValue     [string]  the value to be written (myKey will be
    '                       deleted if myValue is <DELETE_THIS_VALUE>)
    '
    ' Returns:
    ' N/A
    '
    ' CAVEAT:     WriteIni function needs ReadIni function to run
    '
    ' Written by Keith Lacelle
    ' Modified by Denis St-Pierre, Johan Pol and Rob van der Woude

    Const ForReading   = 1
    Const ForWriting   = 2
    Const ForAppending = 8

    Dim blnInSection, blnKeyExists, blnSectionExists, blnWritten
    Dim intEqualPos
    Dim objFSO, objNewIni, objOrgIni, wshShell
    Dim strFilePath, strFolderPath, strKey, strLeftString
    Dim strLine, strSection, strTempDir, strTempFile, strValue

    strFilePath = Trim( myFilePath )
    strSection  = Trim( mySection )
    strKey      = Trim( myKey )
    strValue    = Trim( myValue )

    Set objFSO   = CreateObject( "Scripting.FileSystemObject" )
   'Set wshShell = CreateObject( "WScript.Shell" )

    'strTempDir  = wshShell.ExpandEnvironmentStrings( "%TEMP%" )
    strTempFile = objFSO.BuildPath( Path, objFSO.GetTempName )
    'strTempFile =  "C:\Users\OmerLab\Documents\GitHub\RamanSpecUsingStageXY\SpectrometerCommand1.txt"
    
    Set objOrgIni = objFSO.OpenTextFile( strFilePath, ForReading, True )
    Set objNewIni = objFSO.CreateTextFile(strTempFile, False, False )

    blnInSection     = False
    blnSectionExists = False
    ' Check if the specified key already exists
    blnKeyExists     = ( ReadIni( strFilePath, strSection, strKey ) <> "" )
    blnWritten       = False

    ' Check if path to INI file exists, quit if not
    'strFolderPath = Mid( strFilePath, 1, InStrRev( strFilePath, "\" ) )
    'If Not objFSO.FolderExists ( strFolderPath ) Then
       'WScript.Echo "Error: WriteIni failed, folder path (" _
        '           & strFolderPath & ") to ini file " _
         '          & strFilePath & " not found!"
     '   Set objOrgIni = Nothing
     '   Set objNewIni = Nothing
     '   Set objFSO    = Nothing
       'WScript.Quit 1
    'End If

    While objOrgIni.AtEndOfStream = False
        strLine = Trim( objOrgIni.ReadLine )
        If blnWritten = False Then
            If LCase( strLine ) = "[" & LCase( strSection ) & "]" Then
                blnSectionExists = True
                blnInSection = True
            ElseIf InStr( strLine, "[" ) = 1 Then
                blnInSection = False
            End If
        End If

        If blnInSection Then
            If blnKeyExists Then
                intEqualPos = InStr( 1, strLine, "=", vbTextCompare )
                If intEqualPos > 0 Then
                    strLeftString = Trim( Left( strLine, intEqualPos - 1 ) )
                    If LCase( strLeftString ) = LCase( strKey ) Then
                        ' Only write the key if the value isn't empty
                        ' Modification by Johan Pol
                        If strValue <> "<DELETE_THIS_VALUE>" Then
                            objNewIni.WriteLine strKey & "=" & strValue
                        End If
                        blnWritten   = True
                        blnInSection = False
                    End If
                End If
                If Not blnWritten Then
                    objNewIni.WriteLine strLine
                End If
            Else
                objNewIni.WriteLine strLine
                    ' Only write the key if the value isn't empty
                    ' Modification by Johan Pol
                    If strValue <> "<DELETE_THIS_VALUE>" Then
                        objNewIni.WriteLine strKey & "=" & strValue
                    End If
                blnWritten   = True
                blnInSection = False
            End If
        Else
            objNewIni.WriteLine strLine
        End If
    Wend

    If blnSectionExists = False Then ' section doesn't exist
        objNewIni.WriteLine
        objNewIni.WriteLine "[" & strSection & "]"
            ' Only write the key if the value isn't empty
            ' Modification by Johan Pol
            If strValue <> "<DELETE_THIS_VALUE>" Then
                objNewIni.WriteLine strKey & "=" & strValue
            End If
    End If

    objOrgIni.Close
    objNewIni.Close

    ' Delete old INI file
    objFSO.DeleteFile strFilePath, True
    ' Rename new INI file
    objFSO.MoveFile strTempFile, strFilePath

    Set objOrgIni = Nothing
    Set objNewIni = Nothing
    Set objFSO    = Nothing
    Set wshShell  = Nothing
End Sub