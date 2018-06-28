
#pragma TextEncoding = "Shift_JIS"

#pragma rtGlobals=3     // Use modern global access method and strict wave access.
Menu "yakisabadayo"
"load and graph" ,OpenMultiFiles()
"load image" ,OpenImage1805()
end

Function OpenMultiFiles()
    Variable aa
     string filefilters="Data Files(*.txt,*.dat,*csv):.txt,.dat,.csv;"
     OPEN/D/R/MULT=1/F=filefilters aa
    Print S_fileName
    
    String FilePaths
    FilePaths = S_fileName  //(*)
    
    If(Strlen(FilePaths)!=0)  //(**)
        Variable NumOfPath
        NumOfPath = ItemsInList(FilePaths, "\r")

        String Path
        Variable i
        For (i=0; i<NumOfPath; i+=1)
            Path = StringFromList(i, FilePaths, "\r")
            ReadFile1708_spectra(Path)
        EndFor
    EndIf
End

//‚±‚±‚Ü‚Å‚Å•¡”ƒtƒ@ƒCƒ‹‚ÌƒpƒX‚ð“¾‚½
Function ReadFile1708_spectra(Path)
string Path
//define parameters
    Variable refNum,mode,readMode
    Variable w, N, i, pnts, mun
    String   TextFileName, TextFilePath
    String   currentFolder, newFolderName, newFolderPath, tmpFolderName, tmpFolderPath
    String   GraphName, TableName, Comment, cmd, DataTitle, GraphTitle
    
//define LoadWave parameters
//    textFileName = pathstr(S_filename,0,0)
     textfilename= StringFromList(6, Path, ":")//‚±‚Ìs‚Ì‚·‚¤‚¶‚ð•Ï‚¦‚Äƒtƒ@ƒCƒ‹–¼‚¾‚¯‚ðŽw’è-------------‘åŽ–なんで文字化けするんや
    TextFilePath = Path
//    Printf "@%s %s\r","textfilename:",textfilename
//read text name string
    DataTitle = TextFileName[0,strlen(TextFileName)-5]//strlen:•¶Žš—ñ‚Ì’·‚³,[a,b]:a•¶Žš–Ú‚©‚çb•¶Žš–Ú‚Ü‚Å‚ð‚©‚¦‚·
    mun = strsearch(DataTitle," ",0)
    if (mun != -1)  //Comment exists.
        GraphName = DataTitle[0,mun-1]
        Comment   = DataTitle[mun+1,strlen(DataTitle)-1]
    else            //Comment dosen't exist.
        GraphName = DataTitle[0,strlen(TextFileName)-1]
        Comment   = ""
    endif
//    datatitle= StringFromList(6, Path, ":")//‚±‚Ìs‚Ì‚·‚¤‚¶‚ð•Ï‚¦‚Äƒtƒ@ƒCƒ‹–¼‚¾‚¯‚ðŽw’è

//set parameters
    GraphTitle = DataTitle
    newFolderName = DataTitle
    newFolderPath = "root:" + newFolderName
    tmpFolderName = "tmpDataFolder"
    tmpFolderPath = "root:" + tmpFolderName
//error handling
//  if (WindowExists(GraphName,0)==1)
//      DoAlert 0, "same name graph exists."
    //  Print "same name graph exists."
        //return 0
//  endif
    Printf "@%s\r",newFolderPath
    if (DataFolderExists(newFolderPath))
        DoAlert 0, "same name data folder exists."
        Print "same name data folder exists."
        return 0
    endif
//make date folder and load waves
    NewDataFolder/O/S $tmpFolderPath
    LoadWave/A/J/D/W/Q/E=1/K=0 TextFilePath
//make graph
  TableName = WinName(0,2)
  N = Countobjects("",1) / 2
  Display/N=$GraphName as GraphTitle
  
    for (w=0; w<N; w+=1)
        WAVE X = WaveRefIndexed(TableName,2*w,3)
        WAVE Y = WaveRefIndexed(TableName,2*w+1,3)
        pnts = numpnts(X)
        if (numtype(X[pnts-1])!=0)
    for (i=pnts-1; i>=0; i-=1)
          if (numtype(X[i])==0)
              break
                endif
                      endfor
      DeletePoints i+1, pnts-(i+1), X, Y
  endif
    AppendToGraph/W=$GraphName Y vs X
    endfor
    Graph_Default2(GraphName)
 //   GPR2()
    //Legend/C/N=text0/A=RT
//others
    SetDataFolder currentFolder
    KillWindow $TableName
//    printf "Read Text File : %s\r", TextFileName
//rename folder name
    sprintf cmd, "RenameDataFolder %s, %s", tmpFolderPath, PossiblyQuoteName(newFolderName)
    Execute cmd
End


Function Graph_Default2(GraphName)
    String GraphName
    ModifyGraph/W=$GraphName fSize=10, font="Arial"
    ModifyGraph/W=$GraphName width=0, height=0
    ModifyGraph/W=$GraphName margin=0, lblPosMode=1,lblMargin=0
    ModifyGraph/W=$GraphName standoff=0, nolabel=0, manTick=0, minor=1, tick=2
    ModifyGraph/W=$GraphName mirror=1
    Label left "\\Z14Power (W)"
    Label bottom "\\Z14Current (mA)"
    ModifyGraph lblPosMode(bottom)=1,lblMargin(bottom)=10
    ModifyGraph lblPosMode=1,lblMargin(left)=22
//  SetAxis/W=$WindowName/A/N=0 left
//  SetAxis/W=$WindowName/A/N=0 bottom
End

//Function GPR2()
//    Variable w, Nw, v, Nv, M
//    Variable R, G, B
//    String GraphName, yName
//    GraphName = WinName(0,1)
//    Nw = CountWaves(GraphName)
//    Nv = CountWaves_Trace(GraphName)
//    M = round((Nv-1)/2)
//    if (Nw == 1 || Nv == 1)
//        return -1
//    endif
//    for (w=0; w<Nw; w+=1)
//        yName = TraceNameStr(GraphName,w)
//        if (TraceStats(GraphName,yName) != 0)
//            continue
//        endif
//        if (v<M)
//            R = 65000
//            G = 50000 * (1 - v/M) + 5000
//            B = 50000 * (1 - v/M) + 5000
//        elseif (v==M)
//            R = 65280
//            G = 0
//            B = 0
//        elseif (v>M)
//            R = 60000 - 40000 * (v-M)/(Nv-1-M)
//            G = 10000 * (v-M)/(Nv-1-M)
//            B = 10000 * (v-M)/(Nv-1-M)
//        endif
//        ModifyGraph/W=$GraphName rgb($yName) = (R,G,B)
//        v += 1
//    endfor
//    ModifyGraph/W=$GraphName mode=0, lstyle=0
//End





Function OpenImage1805()
     Variable aa
    string filefilters="Data Files(*.txt,*.dat,*csv):.txt,.dat,.csv;"
    OPEN/D/R/MULT=1/F=filefilters aa
    Print S_fileName
    
    String FilePaths
    FilePaths = S_fileName  //(*)
    
    If(Strlen(FilePaths)!=0)  //(**)
        Variable NumOfPath
        NumOfPath = ItemsInList(FilePaths, "\r")

        String Path
        Variable i
        For (i=0; i<NumOfPath; i+=1)
            Path = StringFromList(i, FilePaths, "\r")
            ReadImageFile1805(Path)
        EndFor
    EndIf
End

//‚±‚±‚Ü‚Å‚Å•¡”ƒtƒ@ƒCƒ‹‚ÌƒpƒX‚ð“¾‚½
Function ReadImageFile1805(Path)
 string Path
//define parameters
    Variable refNum,mode,readMode
    Variable w, N, i, pnts, mun
    variable colum_num,row_num
     String   TextFileName, TextFilePath
    String   currentFolder, newFolderName, newFolderPath, tmpFolderName, tmpFolderPath
    String   GraphName, TableName, Comment, cmd, DataTitle, GraphTitle
    string name0,CP_name0,RP_name0
    string RP_datatitle
    
//define LoadWave parameters
//    textFileName = pathstr(S_filename,0,0)
    textfilename= StringFromList(6, Path, ":")//‚±‚Ìs‚Ì‚·‚¤‚¶‚ð•Ï‚¦‚Äƒtƒ@ƒCƒ‹–¼‚¾‚¯‚ðŽw’è-------------‘åŽ–
    TextFilePath = Path
//read text name string
    DataTitle =TextFileName[0,strlen(TextFileName)-5]//ƒf[ƒ^‚ÌÅ‰‚ª”Žš‚¾‚Æ“{‚ç‚ê‚é‚Ì‚Å"k"‚ð‚Æ‚è‚ ‚¦‚¸‚Â‚¢‚©strlen:•¶Žš—ñ‚Ì’·‚³,[a,b]:a•¶Žš–Ú‚©‚çb•¶Žš–Ú‚Ü‚Å‚ð‚©‚¦‚·
     mun = strsearch(DataTitle," ",0)
    if (mun != -1)  //Comment exists.
        GraphName = DataTitle[0,mun-1]
        Comment   = DataTitle[mun+1,strlen(DataTitle)-1]
    else            //Comment dosen't exist.
        GraphName = DataTitle[0,strlen(TextFileName)-1]
        Comment   = ""
    endif

//set parameters
    GraphTitle = DataTitle
    newFolderName = DataTitle
    newFolderPath = "root:" + newFolderName
    tmpFolderName = "tmpDataFolder"
    tmpFolderPath = "root:" + tmpFolderName
//error handling
    Printf "@%s\r",newFolderPath
 if (DataFolderExists(newFolderPath))
        DoAlert 0, "same name data folder exists."
        Print "same name data folder exists."
        return 0
 endif
//make date folder and load waves
    NewDataFolder/O/S $tmpFolderPath
    name0="wave0";RP_name0="RP_wave0";CP_name0="CP_wave0"
    LoadWave/J/M/U={0,2,0,2}/D/A=wave/E=0/K=0 TextFilePath ;//ƒEƒF[ƒu‚ðƒ[ƒh /E=1‚Ånewtable
    colum_num=DimSiZE($name0,1);row_num=dimsize($name0,0)
    DeletePoints/M=0 row_num-1,1, $name0//-----ÅŒã‚Ìs‚ðÁ‚·
    DeletePoints/M=1 colum_num-1,1, $name0//----ÅŒã‚Ì—ñ‚ðÁ‚·
   
//make graph   
    Display/N=$GraphName as Graphtitle
    AppendImage $name0 vs {$RP_name0,$CP_name0}
    Graph_Default_image1805(GraphName,name0)
 //rename folder name
    sprintf cmd, "RenameDataFolder %s, %s", tmpFolderPath, PossiblyQuoteName(newFolderName)
     execute cmd
    sprintf cmd"rename %s,%s",name0,datatitle
     execute cmd
    sprintf cmd"rename %s,%s",CP_name0,"CP_"+datatitle
     execute cmd
     RP_datatitle="RP_"+datatitle
    sprintf cmd"rename %s,%s",RP_name0,RP_datatitle
    execute cmd
End

//---------------------------ˆÈ‰ºƒOƒ‰ƒt‚Ì‘ÌÙ‚ð®‚¦‚é‚Æ‚±‚ë-----------------------------//
Function Graph_Default_image1805(GraphName,name0)
	string GraphName,name0
	label left"\\Z14Wavelength (nm)"
	label bottom "\\Z14time (ps)"
	ModifyGraph mirror=1,standoff=0,minor=1
	ModifyImage $name0 ctab= {*,*,Spectrum,0}//ƒOƒ‰ƒt‚Ìcolor‚ðŽw’è
	//ColorScale/C/N=text0/B=1/A=MC image=wave0//’Žß‚ðŽw’è
	//ColorScale/C/N=text0/X=30.00/Y=2.56//’ŽßˆÊ’u
	//‹KŠi‰»
	//”½‘ÎŽ²‚ÉeV
end
