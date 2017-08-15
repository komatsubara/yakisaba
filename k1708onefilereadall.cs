Function ReadFile1708kai()
//define parameters
	Variable mode, readMode
//select mode
	Prompt readMode, "select read mode", popup, " 1 : One file; 2 : All files;"
	DoPrompt "Read SPE File", readMode
	if (V_flag==1)
		Print "canceled by user"
		return -1
	endif
//set mode parameters
	if (readMode==1)
		mode = 0
	else
		mode = 1
	endif
//main proc
	ReadFile1708_MainProc(mode)
End


Function ReadFile1708_MainProc(mode)
	Variable mode
//define parameters
	Variable refNum, i, N
	String   FileName, FilePath, FolderPath, FileList
//choose csv file
	Open/Z=2/R/T=".csv"/M="Choose WinSpec file " refNum
	if (V_flag == -1)					//
		Print "canceled by user"		// user canceled
		return -1						//
	endif								//
	if (V_flag != 0)					//
		DoAlert 0, "Error in Opening"	// unexpected error
		return V_flag					//
	endif								//
	Close refNum
//read csv data (main proc)
	printf "%s",S_filename
	end
	if (mode==0)	//Reading only one wave choosen
		FilePath = S_filename
		ReadFile1708_Spectra(FilePath)
	else			//Reading all waves in directry
		FolderPath = filename
		NewPath/O/Q SPEFolderPath FolderPath
		FileList = IndexedFile(SPEFolderPath,-1,".csv")
		N = ItemsInList(FileList)
		for(i=0; i<N; i+=1)
			FileName = StringFromList(i,FileList)
			FilePath = FolderPath + ":" + FileName
			ReadFile1708_Spectra(FilePath)
		endfor
		KillPath/Z SPEFolderPath
	endif
	
End







//////////////////
//1708Read Text File　Fukudaさんのreadtextfileをさんこう//
//////////////////
Function ReadFile1708_spectra(FilePath)
string FilePath
//define parameters
	Variable refNum,mode,readMode
	Variable w, N, i, pnts, mun
	String   TextFileName, TextFilePath
	String   currentFolder, newFolderName, newFolderPath, tmpFolderName, tmpFolderPath
	String   GraphName, TableName, Comment, cmd, DataTitle, GraphTitle
	
//define LoadWave parameters
	//TextFileName = path2str(S_filename,0,0)
	TextFilePath = FilePath
	Printf "　%s %s\r","TextFileName:",TextFileName
//read text name string
	DataTitle = TextFileName[0,strlen(TextFileName)-5]//strlen:文字列の長さ,[a,b]:a文字目からb文字目までをかえす
	mun = strsearch(DataTitle," ",0)
	if (mun != -1)	//Comment exists.
		GraphName = DataTitle[0,mun-1]
		Comment   = DataTitle[mun+1,strlen(DataTitle)-1]
	else			//Comment dosen't exist.
		GraphName = DataTitle[0,strlen(TextFileName)-1]
		Comment   = ""
	endif
//set parameters
	GraphTitle = DataTitle
	currentFolder = GetDataFolder(1)
	newFolderName = DataTitle
	newFolderPath = currentFolder + newFolderName
	tmpFolderName = "tmpDataFolder"
	tmpFolderPath = currentFolder + tmpFolderName
//error handling
	if (WindowExists(GraphName,0)==1)
		DoAlert 0, "same name graph exists."
		Print "same name graph exists."
		return 0
	endif
	Printf "　%s\r",newFolderPath
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
	N = CountWaves(TableName) / 2
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
	Graph_Default(GraphName)
	GPR()
	Legend/C/N=text0/A=RT
//others
	SetDataFolder currentFolder
	KillWindow $TableName
	printf "Read Text File : %s\r", TextFileName
//rename folder name
	sprintf cmd, "RenameDataFolder %s, %s", tmpFolderPath, PossiblyQuoteName(newFolderName)
	Execute cmd
End

