Function OpenMultiFiles()
    Variable aa
    OPEN/D/R/MULT=1 aa
    
    String FilePaths
    FilePaths = S_fileName  //(*)
    
    If(Strlen(FilePaths)!=0)  //(**)
        Variable NumOfPath
        NumOfPath = ItemsInList(FilePaths, "\r")

        String Path
        Variable i
        For (i=0; i<NumOfPath; i+=1)
            Path = StringFromList(i, FilePaths, "\r")
            //ImageLoad/T=jpeg/O/G Path
             ReadFile1708_spectra(Path)
        EndFor
    EndIf
End

Function ReadFile1708_spectra(Path)
    string path
    LoadWave/A/J/D/W/Q/E=1/K=0 path
End
