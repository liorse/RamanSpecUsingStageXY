 Set fs = CreateObject("Scripting.FileSystemObject")
 
 ' Create a while loop which write to the file every 2 seconds
 Dim tic 
 tic = Timer
 
 
 
 
While True
   If Timer - tic > 1 then
     Set a = fs.CreateTextFile("C:\Users\OmerLab\Documents\GitHub\RamanSpecUsingStageXY\testfiles.txt", True)
     a.WriteLine(Timer)
     a.Close
     Wscript.Echo Timer - tic
     tic = Timer
   End If
   WScript.Sleep 300
Wend 

