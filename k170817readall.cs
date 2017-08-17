#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma TextEncoding = "Shift_JIS"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.
 Function OpenMultiFiles()
     Variable aa
     OPEN/D/R/MULT=1 aa
     
     String FilePaths
     FilePaths = S_fileName  //(*)
    print S_fileName
     
     If(Strlen(FilePaths)!=0)  //(**)
         Variable NumOfPath
         NumOfPath = ItemsInList(FilePaths, "\r")

        String Path,datatitle
         Variable i
         For (i=0; i<NumOfPath; i+=1)
             Path = StringFromList(i, FilePaths, "\r")
            DataTitle = path[0,strlen(path)-5]
            print datatitle
             //ImageLoad/T=jpeg/O/G Path
              ReadFile1708_spectra(Path)
         EndFor
         endif
 End
 
 Function ReadFile1708_spectra(Path)
    string path
  //  LoadWave/A/J/D/W/Q/E=1/K=0 path
    string tablename
    //make/O wave0
    //make/O wave1
    //variable data0 ,data1
    LoadWave/A/J/D/W/Q/E=1/K=0/O path // /Jはtable作成 /Aはデフォルトのwave名
    TableName = WinName(0,2)
    print tablename
    WAVE/Z X = WaveRefIndexed(TableName,0,3)
    WAVE Y = WaveRefIndexed(TableName,1,3)
    //Duplicate/O  wave0, path_x
    //Duplicate/O wave1, path_y
   // killwaves wave0,wave1
   
 End
