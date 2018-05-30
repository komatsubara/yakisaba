####################################################################################################
//////////=====     Read SPE File     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function ReadFile1708()
//define parameters
	Variable mode, readMode
//いったんコメントアウト
//select mode	Prompt readMode, "select read mode", popup, " 1 : One file; 2 : All files;"
//	DoPrompt "Read csv File", readMode
//	if (V_flag==1)
//		Print "canceled by user"
//		return -1
//	endif
//set mode parameters
//	if (readMode==1)
//		mode = 0
//	else
//		mode = 1
//	endif
//ここまで	
	mode=0
//main proc
	ReadFile1708_MainProc(mode)
End

Function ReadFile1708_MainProc(mode)
	Variable mode
//define parameters
	Variable refNum, i, N
	String   FileName, FilePath, FolderPath, FileList

//choose csv file
	Open/Z=2/R/T=".csv"/M="Choose csv file " refNum
	if (V_flag == -1)					//
		Print "canceled by user"		// user canceled
		return -1						//
	endif								//
	if (V_flag != 0)					//
		DoAlert 0, "Error in Opening"	// unexpected error
		return V_flag					//
	endif								//
	Close refNum
	Printf "%d\r",refNum
//read csv data (main proc)
	if (mode==0)	//Reading only one wave choosen
		FilePath = S_filename
		ReadFile1708_Spectra(FilePath)
	else			//Reading all waves in directry
		FolderPath = path2str(S_filename,1,1)
		NewPath/O/Q csvFolderPath FolderPath
		FileList = IndexedFile(csvFolderPath,-1,".csv")
		N = ItemsInList(FileList)
		for(i=0; i<N; i+=1)
			FileName = StringFromList(i,FileList)
			FilePath = FolderPath + ":" + FileName
			ReadFile1708_Spectra(FilePath)
		endfor
		KillPath/Z csvFolderPath
	endif
End

Function ReadFile1708_Spectra(FilePath)
	String FilePath
//comment
	//look at WinSpec manual. (Program Files/Roper Scientific/WinSpec32/Documentation/Winhead.txt)
//define parameters
	Variable NumROI, x_group, datatype, frameNum
	Variable xdim, ydim, x_s, x_e, coef, polynom_order, polynom_unit
	Variable refNum, i, j, n
	String   FileName, FolderName, wv_prefix, wv_xName, wv_yName, GraphName
//set parameters
	FileName   = path2str(FilePath,0,0)
	FolderName = path2str(FilePath,1,0)
	if (stringmatch(num2str(str2num(FileName[0])),num2str(NaN)))
		wv_prefix = FileName[0,strlen(FileName)-5]
	else
		wv_prefix = "a" + FileName[0,strlen(FileName)-5]
	endif
	wv_xName  = wv_prefix + "_x"
	wv_yName  = wv_prefix + "_y"
	GraphName = wv_prefix
//open csv file
	Open/R/Z=1 refNum as FilePath
	if (ItemsInList(WaveList(wv_prefix+"_x",";",""))==1)
		print filename + ":already exist"
		Close refNum
		return -1
	endif
	
//error handling (ydim)
	FSetPos refNum, 656		;	FBinRead/F=2/U refNum, ydim
	if (ydim != 1)
		Print filename + ":cannot read"
		Close refNum
		return -1
	endif
//error handling (NumROI)
	FSetPos refNum, 1510	;	FBinRead/F=1   refNum, NumROI
	if (NumROI !=1)
		Print "stopped"
		Close refNum
		return -1
	endif
//error handling (x_group)
	FSetPos refNum, 1516	;	FBinRead/F=2/U refNum, x_group
	if(x_group != 1)
		Print "stopped"
		Close refNum
		return -1
	endif
//read datatype
	FSetPos refNum,  108	;	FBinRead/F=2   refNum, datatype
//read frameNum
	FSetPos refNum, 1446	;	FBinRead/F=3   refNum, frameNum
//read x wave
	FSetPos refNum,   42	;	FBinRead/F=2/U refNum, xdim
	FSetPos refNum, 1512	;	FBinRead/F=2/U refNum, x_s
	FSetPos refNum, 1514	;	FBinRead/F=2/U refNum, x_e
	FSetPos refnum, 3100	;	FBinRead/F=1   refNum, polynom_unit
	FSetPos refnum, 3101	;	FBinRead/F=1   refNum, polynom_order
	Make/D/O/N=(xdim) wv_x
	SetScale/I x x_s, x_e, "", wv_x
	wv_x = 0
	for(n=0; n<=polynom_order; n+=1)	//load x data (use calibration value)
		FSetPos refNum, 3263+n*8; FBinRead/F=5 refNum, coef
		wv_x += coef * (x^n)
	endfor
	wv_x = 1239.5 / wv_x
	Rename wv_x $wv_xName; Note wv_x, FolderName+":"+FileName
//make graph
	Display/N=$GraphName as GraphName+" x "+num2str(frameNum)
//read y data
	for(i=1; i<=frameNum; i+=1)
		Make/D/O/N=(xdim) wv_y
		for(j=0; j<xdim; j+=1)		//laod y data
			wv_y[j] = ReadFile1708_GetData(refNum,(i-1)*xdim+j,datatype)
		endfor
		if (frameNum!=1)
			sprintf wv_yName, "%s_y%03d", wv_prefix, i
		endif
		Rename wv_y $wv_yName; Note wv_y, FolderName+":"+FileName
		Appendtograph/W=$GraphName wv_y vs wv_x
	endfor
//others
	Graph_WinSpec()
	ChangeOffset(GraphName,0,5000,0)
	printf "Read csv File : %s\r", FilePath
	Close refNum
End

Static Function ReadFile1708_GetData(refNum,datanum,datatype)
	Variable refNum, datanum, datatype
	Variable data
	if    (datatype == 3)
		FSetPos refNum, 4100 + datanum*2; FBinRead/F=2/U refNum, data
		return data
	elseif(datatype == 1)
		FSetPos refNum, 4100 + datanum*4; FBinRead/F=3   refNum, data
		return data
	elseif(datatype == 0)
		FSetPos refNum, 4100 + datanum*4; FBinRead/F=4   refNum, data
		return data
	elseif(datatype == 2)
		FSetPos refNum, 4100 + datanum*2; FBinRead/F=2   refNum, data
		return data
	else
		return -1
	endif
End
