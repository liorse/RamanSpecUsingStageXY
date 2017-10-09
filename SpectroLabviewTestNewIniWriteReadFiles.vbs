 
'On Error Resume Next

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
 
 
 Dim  r, StatusFileObject, CommandFileObject
 
  
While True
   Set StatusFileObject = New ClsINI
   StatusFileObject.OpenINIFile(PathAndFileNameForStatus)

   ' Generate status file - To be completed
   If Timer - tic > 1 Then
     r = StatusFileObject.WriteINIValue(StatusSectionName, StatusKeyName, CStr(MeasurementInProgress))
     tic = Timer
   End If
   Set StatusFileObject = Nothing
   LabSpec.Pause 300
   
   ' Check Command file For a request from Labview To start a measurement
   Set CommandFileObject = New ClsINI
   CommandFileObject.OpenINIFile(PathAndFileNameForCommand)
   r = CommandFileObject.GetINIValue(CommandSectionName, CommandKeyName, Request2StartMeasurement)
   CommandFileObject.CloseINIfile 
  
   If CInt(Request2StartMeasurement) = 1 Then
     Set CommandFileObject = New ClsINI
     CommandFileObject.OpenINIFile(PathAndFileNameForCommand)
     Set StatusFileObject = New ClsINI
     StatusFileObject.OpenINIFile(PathAndFileNameForStatus)

     MeasurementInProgress = 1
     ' Nullify Command
     r = CommandFileObject.WriteINIValue(CommandSectionName, CommandKeyName, "0")
     ' Update status the measurement is in progress
     r = StatusFileObject.WriteINIValue(StatusSectionName, StatusKeyName, "1")
     ' Read filename from ini file To save spectrum
     r = CommandFileObject.GetINIValue(CommandSectionName, SavedSpectrumFileNameKeyName, SavedSpectrumFileName)
     StatusFileObject.CloseINIfile
     CommandFileObject.CloseINIfile 
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

'--//////////////// Class ClsINIOps /////////////////////////////////////////////--
'  To work with an INI file, first 'open' it. This Function reads the INI file into a dictionary
'  object. The Class is Then ready For operations. The file itself is Not open but as long as
' OpenINIFile has been successfully called the Class will hold the file in memory as a
' dictionary object and any number of operations can be performed.

' Ret = OpenINIFile(FilePath)  [ Boolean - returns True If file opened successfully. ]

'   CloseINIFile() [ Sub to close INI file after use. This sets the dictionary to Nothing.
                          ' The INI file itself is Not actually open so CloseINIFile is Not strictly
                           ' required. If another file is opened the dictionary will be Set to Nothing
                           ' before proceeding. If the Class is Set to Nothing the dictionary will also be cleared.
                           
'---- Get Section Names: ------------------------------
' Ret = GetSectionNames()
'     ex.: r = Cls.GetSectionNames()
' Return: If no file is open or file has no sections, an array is returned
'             with ubound(0) and the value of array(0) is ""
'           If there are sections in the file the names are returned in an array.
                           
'------ Get INI value:   -------------------------------                        
' Ret = GetINIValue(Section, Key, Value)
 '    ex.: r = Cls.GetINIValue("Section1", "val4", s)
 ' on success Ret returns 0 and s returns value of Key.    
 ' Errors: 1 - no such key. 2 - no such section.  3 - no file open. 4 - unexpected error in text of file.
 
'------ Get Section values: ------------------------
 '  Ret = GetSectionValues(sSection, sArray)
 ' ex.: r = Cls.GetSectionValues("Section1", A1)
   '      If r = 0 Then ......(A1 holds array of key=value pairs. )
 ' Return: 0 - success. 2 - no such section. 3 - no file open.    
 
'---- Write INI value: -----------------------------
' Ret = WriteINIValue(Section, Key, Value)
'   ex.: r = Cls.WriteINIValue("Section1", "backcolor", "blue")
'  Sets value: backcolor=blue  Key and Section will be created If necessary.
'  Return:  0 - success. 3 - no file open. 4 - unexpected error in text of file. 

'------ Delete INI value: ------------------------
'   Ret = DeleteINIValue(Section, Key)
'  ex.: r = Cls.DeleteINIValue("Section1", "backcolor")
'   Deletes 'backcolor' key.
'  Return: 0 - success. 1 - no such key. 2 - no such section.  3 - no file open. 4 - unexpected error in text of file.
'  For this Function success would be If Ret < 3.    

'-----  Write INI section: ------------------------
'  Ret = WriteINISection(Section)
'  ex.: r = Cls.WriteINISection("Section1")
'   writes a new section to INI file.
' Return: 0 - success. 2 - section already exists. 3 - no file open.
'  For this Function success would be If Ret < 3.  

'---- Delete INI section: -------------------------
' Ret = DeleteINISection(Section)  
'  ex.: r = Cls.DeleteINISection("Section1")
'  Return: 0 - success. 2 - no such section. 3 - no file open.
'  For this Function success would be If Ret < 3.  

'-- NOTE ABOUT ERROR CODES: The error codes are designed to relate
'--to the same thing regardless of the Function. 0 is always success.
'-- 1 always means the key does Not exist, regardless of whether you're
'--trying to read from or delete the key.
'-- 2 always relates to the section. For functions that require a section
'-- it means the section does Not exist. When trying to write a new section
'-- it means the section already exists. 
'-- 3 always means that no file has been opened.
'-- 4 is an unknown error indicating that there was an unexpected problem.

' ____________________ START INI Class HERE ________________________________________

Class ClsINI
Private FSO, TS, Dic, sFil, sBullet

 Private Sub Class_Initialize()
    Set FSO = CreateObject("Scripting.FileSystemObject")
    sBullet = Chr(149)
 End Sub
          
  Private Sub Class_Terminate()
     Set FSO = Nothing
     Set Dic = Nothing
  End Sub
  
   '--Function to Read INI file into Dic: -------------------------------------
  Public Function OpenINIFile(sFilePath)
    Dim s, sSec, sList
     If FSO.FileExists(sFilePath) = False Then
       OpenINIFile = False
       Exit Function
     End If
      sFil = sFilePath
    Set Dic = Nothing  '-- reset Dic in Case an earlier file wasn't closed with CloseINIFile.

    
    '--Read INI file into dictionary object. Each section will be a key.
    '--section key=value pairs will be added as Dic.key item.
    '-- After file is read there will be one Dic.Key For Each section header.
    '-- Each Key Item will be a string of key=value pairs separated by bullet characters.
    
   Set Dic = CreateObject("Scripting.Dictionary")
     Dic.Add "Glo_bal", sBullet
       On Error Resume Next 
    Set TS = FSO.OpenTextFile(sFil, 1)  
      Do While TS.AtEndOfStream = False
         s = TS.ReadLine
         s = Trim(s)
         If Len(s) > 0 Then
            If Left(s, 1) = "[" Then
               sSec = s
               Dic.Add sSec, sBullet
            ElseIf Dic.Exists(sSec) Then
               sList = Dic.Item(sSec)
               sList = sList & s & sBullet
               Dic.Item(sSec) = sList
            Else '--global comment at top. If no Dic.Key sSec exists Then no sections have been read yet.
                sList = Dic.Item("Glo_bal")
                sList = sList & s & sBullet
                Dic.Item("Glo_bal") = sList
            End If    
         End If    
       Loop
      TS.Close  
     Set TS = Nothing
     OpenINIFile = True
  End Function
 
'------------------------------------------------------------------------- 
   '--Close an open INI file. The file is Not actually open but it's closed
   '--For the purposes of this Class by setting Dic = Nothing.
    
  Public Sub CloseINIFile()
     Set Dic = Nothing
  End Sub
     
'-------------------------------------------------------------------------
'-- Get list of INI section names. Returns an array of names. If no file open
'-- or no sections in file Then an array of ubound(0) is returned with an array(0)
'-- value of "".
Public Function GetSectionNames()
  Dim ASec, iK, sTemp, sTemp1
    If IsObject(Dic) = False Then
        ASec = array("")
        GetSectionNames = ASec  '--  no file open.
        Exit Function
    End If
    
    If Dic.Count = 0 Then
        ASec = array("")
        GetSectionNames = ASec  '--  no keys.
        Exit Function
    End If
    
      On Error Resume Next
    ASec = Dic.Keys
     For iK = 0 to UBound(ASec) 
        sTemp = ASec(iK)
          If (sTemp <> "Glo_bal") Then
             sTemp = Mid(sTemp, 2, (len(sTemp) - 2))
             sTemp1 = sTemp1 & (sTemp & sBullet)
         End If   
    Next   
      GetSectionNames = Split(sTemp1, sBullet)
End Function
'-------------------------------------------------------------------------
  'read one value from INI. return 0 on success. 1 If no such value. 2 If no such section.
  ' 3 If no file open. 4 If unexpected error in text of file.
Public Function GetINIValue(sSection, sKey, sValue)
    Dim sList, pt, pt2, s1, Lens1
      
     Select Case CheckBasics(sSection)
       Case 3
          GetINIValue = 3  '-- return 3: no file open.
          Exit Function
       Case 2
          GetINIValue = 2  '-- return 2: no such section.
         Exit Function
     End Select
     
       sValue = ""
      sList = Dic.Item(sSection)
      s1 = sBullet & sKey & " = "
      Lens1 = Len(s1)
     
     pt = InStr(1, sList, s1, 1)
        If pt = 0 Then 
           sValue = ""
           GetINIValue = 1  '-- return 1: no such key.
           Exit Function
        End If
        
     pt2 = InStr((pt + Lens1), sList, sBullet, 1)
       If pt2 = 0 Then 
          GetINIValue = 4 '--error
       ElseIf pt2 = (pt + 1) Then   '-- key exists, value is ""
          GetINIValue = 0
       Else
         sValue = Mid(sList, (pt + Lens1), (pt2 - (pt + Lens1)))
         GetINIValue = 0
       End If  
  End Function
  
'------Read a Section: ------------------------------------
Public Function GetSectionValues(byVal sSection, sArray)
  Dim ATemp, ATemp2(), i, i2
    Select Case CheckBasics(sSection)
       Case 3
          GetSectionValues = 3  '-- return 3: no file open.
          Exit Function
       Case 2
          GetSectionValues = 2  '-- return 2: no such section.
         Exit Function
     End Select
   
  ATemp = Split(Dic.Item(sSection), sBullet)
     
       '-- go through ATemp, weeding out comments.
       '-- any non-comment can be added to ATemp2:
       
       i2 = 0
    For i = 0 to UBound(ATemp)
       If Left(ATemp(i), 1) <> ";" Then
          ReDim preserve ATemp2(i2)
          ATemp2(i2) = ATemp(i)
          i2 = (i2 + 1)
       End If
    Next   
    
   sArray = ATemp2      
   GetSectionValues = 0
End Function
 
'--------- Write INI value: ---------------------------------
    ' return 0 on success. 2 If no such section.
    ' 3 If no file open. 4 If unexpected error in text of file. 
    
  Public Function WriteINIValue(sSection, sKey, sValue)
    Dim sList, pt, pt2, s1, Lens1, sSec
        Select Case CheckBasics(sSection)
          Case 3
             WriteINIValue = 3  '-- return 3: no file open.
              Exit Function
          Case 2
             '--If section does Not exist, write section and key=value, Then quit:
               sList = sBullet & sKey & " = " & sValue & sBullet
               Dic.Add sSection, sList
               Call WriteNewINI
               WriteINIValue = 0
               Exit Function
        End Select
        
'--section exists. Get section values:

     sList = Dic.Item(sSection)
        s1 = sBullet & sKey & "="
       Lens1 = Len(s1)
        pt = instr(1, sList, s1, 1)
             '--If sKey does Not already exist, write it and quit:
          If pt = 0 Then
             sList = sList & sKey & "=" & sValue & sBullet
             Dic.Item(sSection) = sList
             Call WriteNewINI
             WriteINIValue = 0
          Else   
             '--sKey does exist. Snip out existing value from sList and rebuild string, adding new value:
             
             pt2 = instr((pt + Lens1), sList, sBullet)
                If pt2 <> 0 Then
                       If (pt2 + 1) < Len(sList) Then  '--If Not last value in section, Get left up to "=" & value & right from bullet:
                           sList = (Left(sList, ((pt + Lens1) - 1))) & sValue & (Right(sList, (Len(sList) - (pt2 - 1))))
                       Else  '--last value in section:
                           sList =  (Left(sList, ((pt + Lens1) - 1))) & sValue & sBullet
                       End If    
                        Dic.Item(sSection) = sList
                        Call WriteNewINI
                        WriteINIValue = 0
                Else
                        WriteINIValue = 4 '--error
                         Exit Function
                End If      
         End If
   End Function
   
'---Function to delete single key=value pair: ---------------------------------------
   
Public Function DeleteINIValue(sSection, sKey)
 Dim sSec, sList, pt, pt2, s1
    Select Case CheckBasics(sSection)
       Case 3
           DeleteINIValue = 3  '-- return 3: no file open.
           Exit Function
       Case 2
           DeleteINIValue = 2  '-- return 2: no such section.
           Exit Function
     End Select
      
  sList = Dic.Item(sSection)
    s1 = sBullet & sKey & "="
    pt = InStr(1, sList, s1, 1)
      If pt = 0 Then
        DeleteINIValue = 1  '--return 1: no such key.
        Exit Function
      End If
    
   pt2 = InStr((pt + 1), sList, sBullet, 1)
     If pt2 = 0 Then  
        DeleteINIValue = 4  '--error.
        Exit Function
     Else
        sList = (Left(sList, (pt))) & (Right(sList, (len(sList) - pt2)))
        Dic.Item(sSection) = sList
        Call WriteNewINI
        DeleteINIValue = 0
     End If
End Function
   
'------------- Function to Write new section -------------------------
Public Function WriteINISection(sSection)
    Select Case CheckBasics(sSection)
       Case 3
           WriteINISection = 3  '-- return 3: no file open.
       Case 2
           Dic.Add sSection, sBullet
           Call WriteNewINI
           WriteINISection = 0
        Case Else
           WriteINISection = 2 '-- section already exists.  
     End Select 
End Function   

'---------- Function to delete section -------------------
'-- 0 - success. 2 - no such section exists. 3 - no file open.
Public Function DeleteINISection(sSection)
  
  Select Case CheckBasics(sSection)
       Case 3
           DeleteINISection = 3  '-- return 3: no file open.
       Case 2
          DeleteINISection = 2  '-- return 2: no such section.
       Case Else
           Dic.Remove sSection
           Call WriteNewINI
           DeleteINISection = 0
     End Select

End Function    

'-------- Sub to update INI file after writing new value or adding section. --------
'----this Sub is called internally. It won't be called unless a file is "open". 
'-- in that Case file path is valid and Dic is Not Nothing, so just Set attributes to 0
'-- and write new INI file.
'-- NOTE: This has Not been tested with system INIs under Windows versions with 
'--  system file protection.

   Private Sub WriteNewINI()
      Dim Att, oFil, A1, i, s, s1, s2, sG
      On Error Resume Next
       '--remove attributes such as readonly and save current attributes:
        Set oFil = FSO.GetFile(sFil)
          Att = oFil.Attributes
          oFil.Attributes = 0
        Set oFil = Nothing
        
      A1 = Dic.Keys
         For i = 0 to UBound(A1)
            s1 = A1(i)
            If s1 = "Glo_bal" Then
               sG = Dic.Item(s1)
               sG = Replace(sG, sBullet, vbcrlf)
               sG = sG & vbcrlf
            Else   
              s2 = Dic.Item(s1)
              s2 = Replace(s2, sBullet, vbcrlf)
              s = s & s1 & s2 & vbcrlf
            End If   
         Next
            
       s = sG & s '--add in global comments section.
       
      FSO.DeleteFile sFil, True
    
      Set TS = FSO.CreateTextFile(sFil)     
        TS.Write s
        TS.Close
      Set TS = Nothing
      
     Set oFil = FSO.GetFile(sFil)
        oFil.Attributes = Att
     Set oFil = Nothing   
       
   End Sub
   
'--this is just a minor Function to check For Dic instantiation and section existence.
'-- it also does the work of putting [ ] around the section name sent in.
'-- it's here to save a few lines; so these functions don't have to be re-written
'-- For Each method in the Class

Private Function CheckBasics(sSection)

  If IsObject(Dic) = False Then
     CheckBasics = 3  '-- return 3: no file open.
     Exit Function
  End If
   
   If (Left(sSection, 1) <> "[") Then sSection = "[" & sSection
   If (right(sSection, 1) <> "]") Then sSection = sSection & "]"

 If Dic.Exists(sSection) = False Then
   CheckBasics = 2
 Else
   CheckBasics = 0
 End If
 
End Function
     
End Class
' __________________ End INI Class HERE ______________________________
