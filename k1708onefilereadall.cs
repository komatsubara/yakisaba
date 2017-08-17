#pragma TextEncoding = "Shift_JIS"
#pragma rtGlobals=3     // Use modern global access method and strict wave access.
LANG:Igor(linenumber)
 Function OpenMultiFiles()
     Variable aa
     OPEN/D/R/MULT=1 aa
     
     String FilePaths
     FilePaths = S_fileName  //(*)
     print "S_filename"
     print S_fileName
     
     If(Strlen(FilePaths)!=0)  //(**)
        Variable NumOfPath
        NumOfPath = ItemsInList(FilePaths, "\r")

        String Path,datatitle
        Variable i
        For (i=0; i<NumOfPath; i+=1)
            Path = StringFromList(i, FilePaths, "\r")
//             print datatitle
             
            datatitle= StringFromList(6, Path, ":")//この行のすうじを変えてファイル名だけを指定
            print "datatitle"
            print datatitle
//             print ExtractFileName("c:folder1:folder2:file.ext")
            ReadFile1708_spectra(Path)
        EndFor
    endif
 End
 
 Function ReadFile1708_spectra(Path)
    string path
//    string tablename
     LoadWave/W/A/J/D/Q/K=0/O path // /Jはtable作成 /Aはデフォルトのwave名/Eはテーブルを作成 
//    make/O wave0
//    make/O wave1
//    variable data0 ,data1
//    TableName = WinName(0,2)
//    print tablename
//    WAVE/Z X = WaveRefIndexed(TableName,0,3)
//    WAVE Y = WaveRefIndexed(TableName,1,3)
//    Duplicate/O  wave0, path_x
//    Duplicate/O wave1, path_y
//    killwaves wave0,wave1
   
 End
