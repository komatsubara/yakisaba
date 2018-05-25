fukuda#pragma rtGlobals=1		// Use modern global access method.

Menu "Mochi"
	"Yoshita_Okada Method/6", Yoshita_Okada()
	"Append Dashed line to active graph /S3", Dashedline()
	"Append Vertical line to active graph /S4", Vertical_line()
	"Pick one point", PickOnePoint()
	"Pickup KS", PickupKS()
	"G to Table", graph2table()
	"Pick and Delete laser", PickLaser()
	"MultiPeakSubsetFit", SubsetPeakFit()
	"PL array style ", PLstyle()
	"PLE style ", PLEstyle()
	"Reflecstyle", Reflecstyle()
	"Trim Active Table", TrimTables()
	"Rescale PLE using Excitation Power", ExcitationScalingPLE()
	"Rescale PLE to modal gain", AbsorptionRescalingPLE()
	"absorption area with rescale",  absarea()
	"absorption area",  absarearaw()
	"make windows for KS plot", makeKSwin()
	"make WinforKS no rescale", makeKSwin2()
	"KS plot style", KSplotstyle()
	"extrapolate F function", extrapolate()
	 "Display KS plot", KSplot120130()
	 "KS no rescale", KSplot120204()
	 "Chatajee_like_PL",  Chatajee_like_PL()
	 "SaveKSWave", PickupKSTable()
	 "SplitWave",  SplitWave_Csr()
	 "DeletePoint_Cursor",  DeletePoint_Csr2()
	 "Change offset using Cursor A/S1",  Cursoroffset()
	 "Select sgm/S2", selectsgm()
End
Menu "Mochi2"
	 "Display FEM Contour/S5", DisplayFEMWaves()
	 "Stylize FEM Contour/S6", ModifyFEMContours()
	 "Clear Contour Tags/S7",ClearTags()
End

Function Yoshita_Okada()
	//define strings and variables
	String xwavetemp, y1wavetemp, y2wavetemp, awavename, awinname, PL1, PL2
	Variable  x1, x2, R, L, BG, maxabsorption,maxgain, i,CCD, smoothpoints, ex1, ex2, PLex1, PLex2, BGPL
	Variable Intloss, Intlossfrom, Intlossupto, Xfrom, Xupto
	Variable renormPL, renormloss, renormfactor
	//recall saved experimental parameters (see "Set Experimental Parameters in Fukuda.ipf)
	SetDataFolder root:ExpParameters
	NVAR gVar_R, gVar_L, gVar_BG
	R =gVar_R
	L = gVar_L
	BG = gVar_BG
	BGPL = gVar_BG
	SetDataFolder root:
	if (DataFolderExists("root:PreviousParameter") ==0)
		NewDataFolder/O/S root:PreviousParameter
		Variable /G prevloss, prevfrom, prevupto
	endif
	SetDataFolder root:PreviousParameter
	NVAR prevloss, prevfrom, prevupto
	Intloss = prevloss; Intlossfrom = prevfrom; Intlossupto = prevupto
	SetDataFolder root:
	
	maxabsorption = 300
	smoothpoints = 15
	renormPL = 0
	renormloss = 0
	ex1 = 1
	ex2 = 1
	
	//load xwavename from the active graph window
	xwavetemp = xwavename("","")

	//input wavenames of y1, y2
	Prompt x1, "x1 [um]"
	Prompt x2, "x2 [um]"
	Prompt y1wavetemp, "y1 wave",popup, WaveList("x*y*",";","")
	Prompt y2wavetemp, "y2 wave",popup, WaveList("x*y*",";","")
	Prompt ex1, "exposure 1"
	Prompt ex2, "exposure 2"
	Prompt R, "R"
	Prompt L, "L"
	Prompt BG, "BG"
	Prompt smoothpoints "smoothpoints"
	DoPrompt "input x1, x2, y waves and so", x1, x2, y1wavetemp, y2wavetemp,ex1, ex2,BG,  smoothpoints, R,L
	if (V_flag==1)
	//cancel procedure
		Print "Cancel"
		return -1
	endif
	//set length scale to cm
	x1 = x1 * 1E-4
	x2 = x2 * 1E-4
	L = L * 1E-4
	DoAlert 1, "Renoralize with internal loss?"
	if (V_flag == 1)
		Prompt Intloss, "Internal loss acquired by Cassidy's method"
		Prompt Intlossfrom, "Internal loss range from (eV)"
		Prompt Intlossupto, "Internal loss range upto (eV)"
		DoPrompt "input internal loss info." Intloss, Intlossfrom, Intlossupto
		SetDataFolder root:PreviousParameter
		NVAR prevfrom, prevupto, prevloss
		prevloss = Intloss; prevfrom = Intlossfrom ;prevupto = Intlossupto
		SetDataFolder root:
		if (V_flag==1)
		//cancel procedure
			Print "Cancel"
			return -1
		endif
		Make /O/N=(CCD) xww
		Duplicate /O $xwavetemp, xww
		Xfrom = BinarySearch(xww, Intlossfrom)
		Xupto = BinarySearch(xww, Intlossupto)
		killwaves xww
		renormloss = 1
	endif
	DoAlert 1, "Renoralize with PL?"
	if (V_flag == 1)
		Prompt PL1, "PL1 wave",popup, WaveList("!*x",";","")
		Prompt PL2, "PL2 wave",popup, WaveList("!*x",";","")
		Prompt PLex1, "PL exposure 1"
		Prompt PLex2, "PL exposure 2"
		Prompt BGPL, "BGPL"
		DoPrompt "input PL data" PL1, PL2, PLex1, PLex2,BGPL
		if (V_flag==1)
		//cancel procedure
			Print "Cancel"
			return -1
		endif	
		renormPL = 1
	endif
	//automatically name and make absorption wave
	awavename =  "x1_" + num2str(x1*1E4) + "_x2_" + num2str(x2*1E4) + "_ex_" + num2str(ex1) + "_" + num2str(ex2)
	if (renormloss == 1) 
		awavename = "L_"+awavename
	endif
	if (renormPL == 1)
		awavename = "PL_" + awavename
	endif
	//check number of CCD pixels
	CCD = numpnts($y1wavetemp)
	//make temporary absorption wave, copied to awave if this procedure go well
	Make /O/N=(CCD) y1,y2,awavetemp
	Duplicate/O $y1wavetemp, y1
	Duplicate/O $y2wavetemp, y2
	y1 = (y1 - BG) / ex1
	y2 = (y2 - BG) / ex2
	if (renormPL == 1)
		Make /O/N=(CCD) PLwave1, PLwave2
		Duplicate /O $PL1, PLwave1
		Duplicate /O $PL2, PLwave2
		PLwave1 = (PLwave1 - BGPL) / PLex1
		PLwave2 = (PLwave2 - BGPL) / PLex2 
		y1 = y1/PLwave1
		y2 = y2/PLwave2
		killwaves PLwave1, PLwave2
	endif
	if (renormloss == 1)
		WaveStats/Q/R=[Xfrom, Xupto] y1
		renormfactor = V_sum
		WaveStats/Q/R=[Xfrom, Xupto] y2
		renormfactor = V_sum/renormfactor
		y1 = y1 * renormfactor * Exp( ln(  ( 1+R*Exp(-2*(Intloss)*(L-x1)) ) / ( 1+R*Exp(-2*(Intloss)*(L-x2))) ) -(x1 - x2) * (Intloss))
	endif
	smooth smoothpoints, y1
	smooth smoothpoints, y2
	awavetemp = y1 / y2
	//killwaves y1,y2
	//make I1 / I2 vs alpha wave,  numpnts = 300
	Make /O/N=(maxabsorption+1) I1overI2
	for (i=0; i<(maxabsorption+1); i+=1)
		I1overI2[i] = Exp( ln(  ( 1+R*Exp(-2*(i)*(L-x1)) ) / ( 1+R*Exp(-2*(i)*(L-x2))) ) -(x1 - x2) * (i))
	endfor
	for (i=0; i<CCD; i+=1)
		awavetemp[i] = -Binarysearchinterp(I1overI2, awavetemp[i] )
	endfor
	Duplicate /O awavetemp, $awavename
	// kill temporary waves
	killwaves awavetemp
	//display gain wave
	awinname = awavename +"g"
	print awinname
	print xwavetemp
	print awavename
	Display as awinname+"_"
	DoWindow/C $awinname
	AppendToGraph/W=$awinname $awavename vs $xwavetemp
	ModifyGraph/Z tick=2
	ModifyGraph/Z mirror=1
	ModifyGraph/Z font="Arial"
	ModifyGraph/Z fSize=10
	ModifyGraph/Z lblMargin=5
	ModifyGraph/Z standoff=0
End

Function SubsetPeakFit()
	String ActiveWindowName
	Variable NumberOfWaves, n, xfrom, xto, temp, pfrom, pto
	ActiveWindowName = WinName(0,1)
	NumberOfWaves = CountWaves(ActiveWindowName)
	Print ActiveWindowName, NumberOfWaves
	xfrom = xcsr(A)
	xto = xcsr(B)
	For (n = 0; n < NumberOfWaves; n+=1)
		
	endFor
End

Function Dashedline()
	variable level
	String ExistingBGWindowName = WinName(0,1)
	String xlevel
	prompt level "Dashed line level : axis left"
	doprompt "input level", level
	if (V_flag==1)
	return -1
	endif
	xlevel = num2str(level)
	SetDrawEnv/W=$ExistingBGWindowName ycoord = left, linefgc = (0,0,0), dash = 0
	DrawLine/W=$ExistingBGWindowName 0,level,1,level
End

Function Vertical_line()
	variable position
	String ExistingBGWindowName = WinName(0,1)
	string positionstr
	prompt position "Dashed line position : axis bottom"
	doprompt "input position", position
	if (V_flag==1)
	return -1
	endif
	sprintf positionstr,  "%.4f", position
	SetDrawEnv/W=$ExistingBGWindowName xcoord = bottom, linefgc = (34816,34816,34816), dash = 3
	DrawLine/W=$ExistingBGWindowName position, 0, position, 1
	SetDrawEnv/W=$ExistingBGWindowName xcoord = bottom
	DrawText/W=$ExistingBGWindowName position, 0.08, positionstr
End

Function PLstyle()
	ModifyGraph minor=1, lsize=1.5, width = 360, height = 600, fSize = 12
end

Proc Reflecstyle() : GraphStyle
	PauseUpdate; Silent 1		// modifying window...
	ModifyGraph/Z lSize=1.5
	ModifyGraph/Z rgb[0]=(65280,0,0),rgb[1]=(65280,43520,0),rgb[2]=(52224,52224,0)
	ModifyGraph/Z tick=2
	ModifyGraph/Z mirror=1
	ModifyGraph/Z minor=1
	ModifyGraph/Z fSize=16
	ModifyGraph/Z lblMargin(bottom)=8
	ModifyGraph/Z standoff=0
	ModifyGraph/Z lblLatPos(bottom)=-8
	Label/Z bottom "Photon energy (eV)"
	SetAxis/Z left 0,1
EndMacro



Function choosewavetest()
	string reference
	Prompt reference, "test reference",popup, WaveList("*ref*",";","")
	DoPrompt "choose reference", reference
	reftest($reference)
End

Function reftest(ref)
	Wave ref
	Print numpnts(ref)
End

Function TrimTables()
	Variable WaveExistsFlag, Column
	String TopTable
	Toptable = WinName(0,2)
	print Toptable
	Column = 0
	Do
		Wave WaveOnTable = WaveRefIndexed(Toptable, Column, 1)
		if (WaveExists(WaveOnTable)==1)
			WaveExistsFlag = 1
			TrimWave(WaveOnTable)
			Column +=1
		else
			WaveExistsFlag = 0
		endif
	While (WaveExistsFlag ==1)
End

Function TrimWave(WaveToTrim)
	Wave WaveToTrim
	Variable WaveLength, Index, VariableLength
	VariableLength = 0
	WaveLength = numpnts(WaveToTrim)
	for(Index = 0;(Index <WaveLength);Index+=1)
	if (numtype(WaveToTrim[Index]) == 0)
		VariableLength += 1
	endif
	endfor
	if(VariableLength != WaveLength)
	deletepoints VariableLength, (WaveLength - VariableLength), WaveToTrim
	endif
End

Function ExcitationScalingPLE()
	SetDataFolder root:
	String ReferencePower, ReferenceOMEC, CheckerReference, CheckerSample, CheckerOMEC
	String PLEyWave, PLExWave, ScaledPLEyWave, ScaledPLExWave, PLEFolder,ExcitationPowerWave
	String GraphName
	String PLxName, PLyName
	Variable MeasuredPoints, CheckerIndex,i, PLindex
	Prompt ReferencePower, "Reference Power in the PLE measurement", popup, WaveList("*ref*",";","")
	Prompt ReferenceOMEC,  "OMEC channels in the PLE measurement", popup, WaveList("*OMEC*",";","")
	Prompt CheckerReference, "Reference Power in the optics check measurement", popup, WaveList("*ref*",";","")
	Prompt CheckerSample, "Excitation Power in the optics check measurement" popup, WaveList("*sample*",";","")
	Prompt CheckerOMEC, "OMEC channels in the optics check measurement", popup, WaveList("*OMEC*",";","")
	Prompt PLEFolder, "PLE data directory in Maruyama System", popup,  ReplaceString(",", RemoveFromList("FOLDERS", DataFolderDir(1)  ,":"),";")
	Prompt PLindex, "Good PL index"
	Doprompt "Choose reference, OMEC, excitation waves", ReferencePower, ReferenceOMEC, CheckerReference, CheckerSample, CheckerOMEC, PLEFolder,PLindex
	if (V_flag==1)
	return -1
	endif
	Duplicate /O $ReferenceOMEC, PowerRatio
	Duplicate/O $ReferencePower, PowerWave
	MeasuredPoints = numpnts(PowerRatio)
	PLEyWave = "slPLE_y_" + PLEFolder
	PLExWave = "PLE_x_" + PLEFolder
	SetDataFolder PLEFolder
	Duplicate/O $PLEyWave, PLEyMove
	Duplicate/O $PLExWave, PLExMove
	MoveWave PLEyMove, root:
	MoveWave PLExMove, root:
	SetDataFolder root:
	ScaledPLEyWave = PLEFolder + "y_N"
	ScaledPLExWave = PLEFolder + "x"
	ExcitationPowerWave =  PLEFolder + "p"
	Make /O/N=(MeasuredPoints) $ScaledPLEyWave
	Make /O/N=(MeasuredPoints) $ScaledPLExWave
	Make /O/N=(MeasuredPoints) $ExcitationPowerWave
	Wave ScaledPLEy = $ScaledPLEyWave
	Wave ScaledPLEx = $ScaledPLExWave
	Wave Excitation = $ExcitationPowerWave
	Wave CheckerReferenceWave = $CheckerReference
	Wave CheckerSampleWave = $CheckerSample
	for (i=0; i<MeasuredPoints; i+=1)
		CheckerIndex = BinarySearch($CheckerOMEC, PowerRatio[i])
		PowerRatio[i] = CheckerSampleWave[CheckerIndex]/CheckerReferenceWave[CheckerIndex]
	endfor
	Powerwave = PowerWave * PowerRatio 
	WaveTransform/O flip Powerwave
	Print "PLE "+num2str(numpnts(PLEyMove))+", Power "+num2str(numpnts(PowerWave))
	ScaledPLEy = PLEyMove/PowerWave
	ScaledPLEx = PLExMove
	Excitation = PowerWave
	GraphName = PLEFolder + "_N"
	Display/N=$GraphName as GraphName
	AppendToGraph/W=$GraphName ScaledPLEy vs ScaledPLEx
	PLyName = ReplaceString("_BG", PLEFolder, "")+"_y"+num2str(PLindex)+"_BG"
	PLxName =  ReplaceString("_BG", PLEFolder, "")+"_x"
	AppendToGraph/W=$GraphName/R $PLyName vs $PLxName
	KillWaves PowerRatio, PLEyMove, PLExMove, PowerWave
End

Function makeKSwin()
	String Energy, PLE, Error, Power
	Prompt Energy, "Photon energy wave", popup, WaveList("PLE_x_*", ";", "WIN:")
	Prompt PLE, "PLE intensity wave", popup, WaveList("slPLE*", ";", "WIN:")
	Prompt Error, "PLE error wave", popup, WaveList("erPLE*", ";", "WIN:")
	Prompt Power, "Excitation", popup, WaveList("*power*", ";", "WIN:")
	DoPrompt "Choose waves" , Energy, PLE, Error,Power
	Wave EnergyW =$Energy
	Wave PLEW = $PLE
	Wave ErrorW = $Error
	Wave PowerW = $Power
	PLEW /= PowerW
	ErrorW /= PowerW
	Display/N=WinforKS as "WinforKS"
	AppendToGraph/W=WinforKS PLEW ErrorW vs EnergyW
End
Function makeKSwin2()
	String Energy, PLE, Error
	Prompt Energy, "Photon energy wave", popup, WaveList("PLE_x_*", ";", "WIN:")
	Prompt PLE, "PLE intensity wave", popup, WaveList("slPLE*", ";", "WIN:")
	Prompt Error, "PLE error wave", popup, WaveList("erPLE*", ";", "WIN:")
	DoPrompt "Choose waves" , Energy, PLE, Error
	Wave EnergyW =$Energy
	Wave PLEW = $PLE
	Wave ErrorW = $Error
	Display/N=WinforKS as "WinforKS"
	AppendToGraph/W=WinforKS PLEW ErrorW vs EnergyW
End

Function AbsorptionRescalingPLE()
	String PLEyWave, PLExWave, GainGraph, OutputWave
	Variable InternalLoss, PositionOfInternalLoss, Continuum, PositionOfContinuum
	if(DataFolderExists("root:PreviousParameter")==1)
	SetDataFolder root:PreviousParameter
	NVAR prevloss, prevupto
	InternalLoss = -prevloss
	PositionofInternalLoss = prevupto
	SetDataFolder root:
	endif
	Prompt PLEyWave, "PLE y wave", popup, WaveList("*N",";","")
	Prompt PLExWave, "PLE x wave", popup, WaveList("*x",";","")
	Prompt InternalLoss, "Modal gain at transparent region"
	Prompt PositionofInternalLoss , "Position of Internal loss (eV)"
	Prompt Continuum, "Modal gain at continnum"
	Prompt PositionOfContinuum, "Position of Continuum (eV)"
	DoPrompt "Input param.",PLEyWave, PLExWave, InternalLoss, PositionofContinuum, Continuum, PositionOfContinuum
	OutputWave = PLEyWave + "G"
	Make /O/N=(numpnts($PLEyWave)) $OutputWave
	Wave OutWave = $OutputWave
	Wave PLEy = $PLEyWave
	Wave PLEx = $PLExWave
	OutWave = InternalLoss + PLEy * ( Continuum - InternalLoss ) / (PLEy[binarysearch(PLEx, PositionofContinuum)] - PLEy[binarysearch(PLEx, PositionofInternalLoss)])
End

Function absarea()
//input parameter
	Variable Xfrom, Xupto, Cfrom, Cupto, temp, Cheight
	Prompt Xfrom , "exciton from (X value)"
	Prompt Xupto , "exciton upto (X value)"
	Prompt Cfrom , "continuum from"
	Prompt Cupto , "continuum upto"
	Prompt Cheight, "continuum absorption"
	DoPrompt "Exciton range, Continuum range" Xfrom, Xupto, Cfrom, Cupto, Cheight
//error handling
	if(V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
//print data
	string dataarea
	if (Xfrom==0 && Xupto==0)
		sprintf dataarea "all area"
	else
		sprintf dataarea "%g - %g", Xfrom, Xupto
	endif
	string datatype
	sprintf datatype "absorption areas"
	String WindowName = WinName(0,1)
	printf "%s : %s ( %s )\r", WindowName, datatype, dataarea
//main plot
	Variable w, N = CountWaves(WindowName)
	for (w=0; w<N; w+=1)
		WAVE y = WaveRefIndexed(WindowName,w,1)
		WAVE x = XWaveRefFromTrace(WindowName,NameOfWave(y))
		temp = areaxy(x, y, Cfrom, Cupto) / (abs(Cupto - Cfrom))
		//continuum height of raw data
		y = Cheight * y / temp
	//auto parameter set up
		if (Xfrom==0 && Xupto==0)
			Xfrom = x[0]
			Xupto = x[numpnts(x) - 1]
		endif
		if (Xupto<Xfrom)
			temp = Xfrom
			Xfrom = Xupto
			Xupto = temp	
		endif
		print areaxy(x,y,Xfrom,Xupto)
	endfor
End

Function absarearaw()
//input parameter
	Variable Xfrom, Xupto, temp
	Prompt Xfrom , "exciton from (X value)"
	Prompt Xupto , "exciton upto (X value)"
	DoPrompt "Exciton range, Continuum range" Xfrom, Xupto
	if(V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
//print data
	string dataarea
	if (Xfrom==0 && Xupto==0)
		sprintf dataarea "all area"
	else
		sprintf dataarea "%g - %g", Xfrom, Xupto
	endif
	string datatype
	sprintf datatype "absorption areas"
	String WindowName = WinName(0,1)
	printf "%s : %s ( %s )\r", WindowName, datatype, dataarea
//main plot
	Variable w, N = CountWaves(WindowName)
	for (w=0; w<N; w+=1)
		WAVE y = WaveRefIndexed(WindowName,w,1)
		WAVE x = XWaveRefFromTrace(WindowName,NameOfWave(y))
	//auto parameter set up
		if (Xfrom==0 && Xupto==0)
			Xfrom = x[0]
			Xupto = x[numpnts(x) - 1]
		endif
		if (Xupto<Xfrom)
			temp = Xfrom
			Xfrom = Xupto
			Xupto = temp	
		endif
		print areaxy(x,y,Xfrom,Xupto)
	endfor
End

Proc tempstyle() : GraphStyle
	PauseUpdate; Silent 1		// modifying window...
	ModifyGraph/Z lSize=1.5
	ModifyGraph/Z rgb[1]=(26112,0,0),rgb[2]=(0,0,0)
	ModifyGraph/Z tick=2
	ModifyGraph/Z mirror=1
	ModifyGraph/Z font="Arial"
	ModifyGraph/Z minor=1
	ModifyGraph/Z fSize=14
	ModifyGraph/Z lblMargin(left)=11
	ModifyGraph/Z standoff=0
	ModifyGraph/Z lblPosMode=1
	ModifyGraph/Z lblLatPos(left)=3
	Label/Z left "Rescaled PLE intensity (cm\\S-1\\M)"
	Label/Z bottom "Photon energy - GaAs gap (eV)"
	SetAxis/Z left 0,600
	SetAxis/Z bottom 0.075,0.115
EndMacro
Proc areastyle() : GraphStyle
	PauseUpdate; Silent 1		// modifying window...
	ModifyGraph/Z mode=4
	ModifyGraph/Z marker[0]=5
	ModifyGraph/Z lSize=1.25
	ModifyGraph/Z rgb[0]=(0,0,0),rgb[1]=(0,0,0)
	ModifyGraph/Z mrkThick[1]=1
	ModifyGraph/Z tick=2
	ModifyGraph/Z mirror=1
	ModifyGraph/Z font="Arial"
	ModifyGraph/Z minor=1
	ModifyGraph/Z fSize=16
	ModifyGraph/Z lblMargin(left)=17,lblMargin(bottom)=9
	ModifyGraph/Z standoff=0
	ModifyGraph/Z lblPosMode=1
	ModifyGraph/Z lblLatPos(left)=5,lblLatPos(bottom)=-7
	Label/Z left "Exciton absroption area (meV/cm)"
	Label/Z bottom "Temperature (K)"
	SetAxis/Z left 0,800
	SetAxis/Z bottom 0,90
EndMacro

Proc KSplotStyle() : GraphStyle
	PauseUpdate; Silent 1		// modifying window...
	ModifyGraph/Z mode[0]=4,mode[3]=2
	ModifyGraph/Z marker[0]=17
	ModifyGraph/Z lSize[0]=0.5,lSize[2]=0.5,lSize[3]=1.5
	ModifyGraph/Z lStyle[0]=1
	ModifyGraph/Z rgb[0]=(0,26112,0),rgb[1]=(39168,0,0),rgb[2]=(0,9472,39168),rgb[3]=(0,0,0)
	ModifyGraph/Z msize[0]=1.5
	ModifyGraph/Z log(left)=1
	ModifyGraph/Z tick=2
	ModifyGraph/Z mirror(bottom)=1
	ModifyGraph/Z nticks(bottom)=3
	ModifyGraph/Z font="Arial"
	ModifyGraph/Z minor=1
	ModifyGraph/Z fSize=14
	ModifyGraph/Z lblMargin(left)=13,lblMargin(bottom)=6,lblMargin(right)=11
	ModifyGraph/Z standoff=0
	ModifyGraph/Z lblLatPos(bottom)=-1
	ModifyGraph/Z lblRot(right)=180
	Label/Z left "PL intensity (arb. Units)"
	Label/Z bottom "Photon energy (eV)"
	Label/Z right "F + offset"
	SetAxis/Z left 2e-05,2
	SetAxis/Z right -24,-16
EndMacro

Function extrapolate()
//input parameter
	Variable Xfrom, Xupto, temp, X1, X2, Y1, Y2, Yfrom, Yupto
	String xname, exname, exyname
	Prompt Xfrom , "Fitline from (X value)"
	Prompt Xupto , "Fitline upto (X value)"
	DoPrompt "Fitline range" Xfrom, Xupto
	if(V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
	X1 = hcsr(A)
	X2 = hcsr(B)
	Y1 = vcsr(A)
	Y2 = vcsr(B)
	xname = CsrWave(A)
	exname = xname + "_ex"
	exyname = exname + "y"
	Yfrom = Y1 + (Xfrom - X1)*(Y2 - Y1) / (X2 - X1)
	Yupto = Y1 + (Xupto - X1)*(Y2 - Y1) / (X2 - X1)
	Make/O/N=2 $exname, $exyname
	Wave X = $exname
	Wave Y = $exyname
	X[0] = Xfrom
	X[1] = Xupto
	Y[0] = Yfrom
	Y[1] = Yupto
	ReplaceWave trace=$xName, Y
	ReplaceWave/X trace=$exyName, X
end

Function extrapolate2()
//input parameter
	Variable temp, X1, X2, Y1, Y2, Yfrom, Yupto, Xpnts
	String xname, exname
	Prompt exname "PLE x wave", popup, WaveList("*x*",";","")
	DoPrompt "Specify X wave" exname
	if(V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
	X1 = hcsr(A)
	X2 = hcsr(B)
	Y1 = vcsr(A)
	Y2 = vcsr(B)
	xname = CsrWave(A)
	Xpnts = numpnts($exname)
	Make/O/N=(Xpnts) $xname
	Wave X = $exname
	Wave Y = $xname
	Y = Y1 + (X - X1)*(Y2 - Y1) / (X2 - X1)
	AppendToGraph/R Y vs X
	RemoveFromGraph $xname
end

Function Chatajee_like_PL()
	Wave F = CsrWaveRef(A)
	Wave W = CsrXWaveRef(B)
	Wave A = CsrWaveRef(B)
	String PLwave = CsrWave(A) + "PL"
	Prompt PLwave "Chatajee like PL wave name"
	DoPrompt "Modify PL name if you like" PLwave
	Duplicate/O F, $PLwave
	Wave I = $PLwave
	I = W^2 * A * Exp(F)
	AppendToGraph I vs W
End

Function KSplot120130()
	WaveStats PLE_y
	Wave PLE_y 
	PLE_y/= V_max
	WaveStats PLy
	Wave PLy
	PLy /= V_max
	Display/N=KSplot PLE_y vs PLE_x
	AppendToGraph/R fit1 vs PLE_x
	AppendToGraph PLy vs PLx
	AppendToGraph/R KSln_y vs PLE_x
	ErrorBars/T=0/L=1.5 KSln_y Y,wave=(sgmKS,sgmKS)
End

Function KSplot120204()
	Display/N=KSplot PLE_y vs PLE_x
	AppendToGraph/R fit1 vs PLE_x
	AppendToGraph PLy vs PLx
	AppendToGraph/R KSln_y vs PLE_x
	ErrorBars/T=0/L=1.5 KSln_y Y,wave=(sgmKS,sgmKS)
End

Function KS(w,E) : FitFunc
	Wave w
	Variable E

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(E) = -E/(8.617*10^-5 * T) + C
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ E
	//CurveFitDialog/ Coefficients 2
	//CurveFitDialog/ w[0] = C
	//CurveFitDialog/ w[1] = T

	return -E/(8.617*10^-5 * w[1]) + w[0]
End

Function PickupKS()
	SetDataFolder root:KSwin:
	Duplicate/O PLE_y LogPLE
	Duplicate/O PLy LogPL
	LogPLE = Log( LogPLE )
	LogPL = Log( LogPL )
	Display/N=Pickup LogPLE vs PLE_x
	AppendToGraph LogPL vs PLx
	AppendToGraph/R fit1 vs PLE_x
	AppendToGraph/R KSln_y vs PLE_x
	ErrorBars/T=0 KSln_y Y,wave=(sgmKS,sgmKS)
	ModifyGraph/Z mode[3]=2
	ModifyGraph/Z lSize[0]=1.5,lSize[1]=1.5,lSize[2]=1.5
	ModifyGraph/Z rgb[0]=(0,12800,52224),rgb[1]=(39168,0,0),rgb[2]=(0,39168,0),rgb[3]=(0,0,0)
	ModifyGraph/Z offset[0]={0,-8}
	ModifyGraph/Z tick=2
	ModifyGraph/Z mirror(bottom)=1
	ModifyGraph/Z nticks(left)=3
	ModifyGraph/Z font="Arial"
	ModifyGraph/Z minor=1
	ModifyGraph minor(left)=0
	ModifyGraph/Z fSize=14
	ModifyGraph/Z standoff=0
	Label/Z left "PL intensity (arb. unit)"
	Label/Z bottom "Photon Energy (eV)"
	Label/Z right "F-function"
	SetAxis/Z left 0,3.5
	Wave Tw1, dTw1
	NVAR PLdataNum
	String Annotation
	Prompt Annotation, "Input Condition/Annotation"
	Doprompt "Conditions", Annotation
	TextBox/F=0/B=1 "\\F'Arial'\\Z12"+ Annotation + "\rT* = " + num2str(Tw1[PLdataNum]) + " ± " + num2str(dTw1[PLdataNum]) + " K"
	TextBox/F=0/B=1 "\\F'Arial'\\Z14 PL"
	TextBox/F=0/B=1 "\\F'Arial'\\Z14 PLE"
	TextBox/F=0/B=1 "\\F'Arial'\\Z14 F"
	ModifyGraph width=300,height=300
	SetDataFolder root:
End

Function PickOnePoint()
//Define Parameter
	String WindowName, yName, delyName
	Variable csrA, csrB, i, pnt, from, upto, xoffset, yoffset
	Variable mode, x1, x2, y1, y2
//Error Handling
	csrA = strlen(CsrInfo(A)); csrB = strlen(CsrInfo(A))
	if (csrA == 0 && csrB == 0)
		DoAlert 0, "Not select wave."
		return -1
	elseif (csrA != 0 && csrB != 0)
		if (stringmatch(CsrWave(A),CsrWave(A)) != 1)
			DoAlert 0, "put cursor A and B on one wave."
			return -210
		endif
	elseif (csrA == 0)
		DoAlert 0, "put cursor A, not B."
		return -1
	endif
//Attention or Interpolation Mode
	if (csrA != 0 && csrB != 0)
		mode = 1
	else
		DoAlert 1, "Delete Point [by useing cursor]\r\rContinue ?"
		if (V_flag == 2)
			DoAlert 0, "Cancel"
			Print "Cancel"
			return -1
		endif
	endif
//Set Range to Delete
	WindowName = WinName(0,1)
	yName = CsrWave(A)
	WAVE y = CsrWaveRef(A,WindowName)
	WAVE x = XWaveRefFromTrace(WindowName,yName)
	if (csrB == 0)
		pnt = numpnts(x)
		from = (abs(pnt-pcsr(A))<pcsr(A)) ? pcsr(A) : 0
		upto = (abs(pnt-pcsr(A))<pcsr(A)) ? pnt : pcsr(A)
	else
		from = (pcsr(A)<pcsr(A)) ? pcsr(A) : pcsr(A)
		upto = (pcsr(A)<pcsr(A)) ? pcsr(A) : pcsr(A)
	endif
//Interpolation Setup
	if (mode == 1)	
		x1 = x[from-1]; x2 = x[upto+1]
		y1 = y[from-1]; y2 = y[upto+1]
		if (abs(y1)>=0 && abs(y2)>=0)
		else		//can't intterpolation
			mode = 0
		endif
	endif
//Main Plot
	Duplicate/O y, dely
	for (i=from; i<=upto; i+=1)
		if (mode == 1)	//interpolation
			dely[i] = (y1*(x2-x[i])+y2*(x[i]-x1))/(x2-x1)
		else				//not interpolation
			dely[i] = NaN
		endif
	endfor
	if (stringmatch(yName[strlen(yName)-2,strlen(yName)],"_d") != 1)
		delyName = yName + "_d"
		Rename dely, $delyName
		ReplaceWave trace=$yName, $delyName
		BackupWaveData(yName,":OriginWaveData")
	else
		Duplicate/O dely, y
		KillWaves dely
	endif
End

Function PickLaser()
//Define Parameter
	String WindowName, yName, delyName
	Variable csrA, i, pnt, from, upto, xoffset, yoffset, laserw
	Variable mode, x1, x2, y1, y2
//Error Handling
	csrA = strlen(CsrInfo(A))
	if (csrA == 0)
		DoAlert 0, "Wave not selected"
		return -1
	endif
	laserw = 10
	Prompt laserw "laser width"
	Doprompt "Prompting laser width" laserw
//Set Range to Delete
	WindowName = WinName(0,1)
	yName = CsrWave(A)
	WAVE y = CsrWaveRef(A,WindowName)
	WAVE x = XWaveRefFromTrace(WindowName,yName)
	pnt = numpnts(x)
	from = pcsr(A)-laserw
	upto =  pcsr(A)+laserw
//Main Plot
	Duplicate/O y, dely
	for (i=from; i<=upto; i+=1)
		dely[i] = NaN
	endfor
	if (stringmatch(yName[strlen(yName)-2,strlen(yName)],"_d") != 1)
		delyName = yName + "_d"
		Duplicate/O dely, $delyName
		ReplaceWave trace=$yName, $delyName
		KillWaves dely
		BackupWaveData(yName,":OriginWaveData")
	else
		Duplicate/O dely, y
		KillWaves dely
	endif
End

Function Cursoroffset()
//Define Parameter
	String yName
	Variable csrA, yoffset
	csrA = strlen(CsrInfo(A))
	if (csrA == 0)
		DoAlert 0, "Wave not selected"
		return -1
	endif
	Prompt yoffset "Y axis offset"
	Doprompt "Prompting offset" yoffset
	yName = CsrWave(A)
	ModifyGraph offset($yname)={0,yoffset}
End

Function PickupKSTable()
	String Datalabel
	Prompt Datalabel "Tag this table :"
	DoPrompt "Input Tag:" Datalabel
	SetDataFolder root:KSwin:
	String PLE_x_renamed = nameofwave(PLE_x) + Datalabel
	String PLE_y_renamed = nameofwave(PLE_y) + Datalabel
	String PLx_renamed = nameofwave(PLx) + Datalabel
	String PLy_renamed = nameofwave(PLy) + Datalabel
	String KSln_y_renamed = nameofwave(KSln_y) + Datalabel
	String sgmKS_renamed = nameofwave(sgmKS) + Datalabel
	String fit1_renamed = nameofwave(fit1) + Datalabel
	Duplicate/O PLE_x $PLE_x_renamed
	Duplicate/O PLE_y $PLE_y_renamed
	Duplicate/O PLx $PLx_renamed
	Duplicate/O PLy $PLy_renamed
	Duplicate/O KSln_y $KSln_y_renamed
	Duplicate/O sgmKS $sgmKS_renamed
	Duplicate/O fit1 $fit1_renamed
	Save/O/J/W $PLE_x_renamed, $PLE_y_renamed, $KSln_y_renamed, $sgmKS_renamed, $fit1_renamed as Datalabel+"PLE.dat"
	Save/O/J/W $PLx_renamed, $PLy_renamed as Datalabel+"PL.dat"
	SetDataFolder root:
End

Function SplitWave_Csr()
//Define Parameter
	String WindowName, yName, delyName
	Variable csrA, csrB, i, pnt, from, upto, xoffset, yoffset
	Variable mode, x1, x2, y1, y2
//Error Handling
	csrA = strlen(CsrInfo(A)); csrB = strlen(CsrInfo(B))
	if (csrA == 0 && csrB == 0)
		DoAlert 0, "Not select wave."
		return -1
	elseif (csrA != 0 && csrB != 0)
		if (stringmatch(CsrWave(B),CsrWave(A)) != 1)
			DoAlert 0, "put cursor A and B on one wave."
			return -210
		endif
	elseif (csrA == 0)
		DoAlert 0, "put cursor A, not B."
		return -1
	endif
//Set Range to Delete
	WindowName = WinName(0,1)
	yName = CsrWave(A)
	WAVE y = CsrWaveRef(A,WindowName)
	WAVE x = XWaveRefFromTrace(WindowName,yName)
	if (csrB == 0)
		pnt = numpnts(x)
		from = (abs(pnt-pcsr(A))<pcsr(A)) ? pcsr(A) : 0
		upto = (abs(pnt-pcsr(A))<pcsr(A)) ? pnt : pcsr(A)
	else
		from = (pcsr(A)<pcsr(B)) ? pcsr(A) : pcsr(B)
		upto = (pcsr(A)<pcsr(B)) ? pcsr(B) : pcsr(A)
	endif
//Main Plot
	Duplicate/O y, lefty
	Duplicate/O y, pickedy
	pickedy = NaN
	for (i=from; i<=upto-1; i+=1)
			lefty[i] = NaN
			pickedy[i] = y[i]
	endfor
	pickedy[upto] = y[upto]
	if (stringmatch(yName[strlen(yName)-2,strlen(yName)],"_d") != 1)
		delyName = yName + "_d"
		Duplicate/O lefty, $delyName
		killwaves lefty
		ReplaceWave trace=$yName, $delyName
		BackupWaveData(yName,":OriginWaveData")
	else
		Duplicate/O lefty, y
		KillWaves lefty
	endif
	mode = 0
	Prompt mode "input 0 : axis left, 1 : axis right"
	Doprompt "Select axis to plot" mode
	delyName = yName + "_l"
	Duplicate pickedy, $delyName
	killwaves pickedy
	if (mode == 0)
		AppendToGraph  $delyName vs x
	else
		AppendToGraph/R  $delyName vs x
	endif
End

Function DeletePoint_Csr2()
//Define Parameter
	String WindowName, yName, delyName
	Variable csrA, csrB, i, pnt, from, upto, xoffset, yoffset
	Variable mode, x1, x2, y1, y2
//Error Handling
	csrA = strlen(CsrInfo(A)); csrB = strlen(CsrInfo(B))
	if (csrA == 0 && csrB == 0)
		DoAlert 0, "Not select wave."
		return -1
	elseif (csrA != 0 && csrB != 0)
		if (stringmatch(CsrWave(B),CsrWave(A)) != 1)
			DoAlert 0, "put cursor A and B on one wave."
			return -210
		endif
	elseif (csrA == 0)
		DoAlert 0, "put cursor A, not B."
		return -1
	endif
//Attention or Interpolation Mode
	if (csrA != 0 && csrB != 0)
		mode = 2
		Prompt mode, "interpolation", popup, " 1 : Yes; 2 : No;"
		DoPrompt "Delete Point [by useing cursor]", mode
		if (V_flag==1)
			DoAlert 0, "Cancel"
			Print "Cancel"
			return -1
		endif
	else
		DoAlert 1, "Delete Point [by useing cursor]\r\rContinue ?"
		if (V_flag == 2)
			DoAlert 0, "Cancel"
			Print "Cancel"
			return -1
		endif
	endif
//Set Range to Delete
	WindowName = WinName(0,1)
	yName = CsrWave(A)
	WAVE y = CsrWaveRef(A,WindowName)
	WAVE x = XWaveRefFromTrace(WindowName,yName)
	if (csrB == 0)
		pnt = numpnts(x)
		from = (abs(pnt-pcsr(A))<pcsr(A)) ? pcsr(A) : 0
		upto = (abs(pnt-pcsr(A))<pcsr(A)) ? pnt : pcsr(A)
	else
		from = (pcsr(A)<pcsr(B)) ? pcsr(A) : pcsr(B)
		upto = (pcsr(A)<pcsr(B)) ? pcsr(B) : pcsr(A)
	endif
//Interpolation Setup
	if (mode == 1)	
		x1 = x[from-1]; x2 = x[upto+1]
		y1 = y[from-1]; y2 = y[upto+1]
		if (abs(y1)>=0 && abs(y2)>=0)
		else		//can't intterpolation
			mode = 0
		endif
	endif
//Main Plot
	Duplicate/O y, dely
	for (i=from; i<=upto; i+=1)
		if (mode == 1)	//interpolation
			dely[i] = (y1*(x2-x[i])+y2*(x[i]-x1))/(x2-x1)
		else				//not interpolation
			dely[i] = NaN
		endif
	endfor
	if (stringmatch(yName[strlen(yName)-2,strlen(yName)],"_d") != 1)
		delyName = yName + "_d"
		Duplicate/O dely, $delyName
		ReplaceWave trace=$yName, $delyName
		BackupWaveData(yName,":OriginWaveData")
		killwaves dely
	else
		Duplicate/O dely, y
		KillWaves dely
	endif
End

Function selectsgm()
	String sgm, ks
	ks = CsrWave(A)
	Prompt sgm, "errorbar wave",popup, WaveList("sgm*",";","")
	DoPrompt "Select errorbar wave" sgm
	ErrorBars/T=0/L=1.5 $ks Y,wave=($sgm,$sgm)
End

Function DisplayFEMWaves()
	LoadWave/N=conditions/G
	Wave cond = conditions0
	String basename = "a" + num2str(cond[7]*2) + "t" + num2str(cond[10])
	LoadWave/N=photonmap/G
	String xname = basename + "x"
	String yname = basename + "y"
	String photonname = basename+"ph"
	Duplicate/O photonmap2 $photonname
	Duplicate/O photonmap0 $xname
	Duplicate/O photonmap1 $yname
	killwaves photonmap0, photonmap1, photonmap2
	Wave x = $xname
	Wave y = $yname
	Wave photon = $photonname
	WaveStats/Q/Z photon
	photon = photon / V_max
	Display/N=$basename; AppendXYZContour photon vs {x, y} ;ModifyContour $photonname autoLevels={*,*,9}
End

Function ModifyFEMContours()
	Wave cond = conditions0
	Variable nair = cond[0]
	Variable nsub = cond[1]
	Variable ncore = cond[2]
	Variable xsep = cond[3]
	Variable ysep = cond[4]
	Variable LX = cond[5]
	Variable LY = cond[6]
	Variable a = cond[7]
	Variable h = cond[8]
	Variable d = cond[9]
	Variable t = cond[10]
	Variable PE = cond[11]
	Variable tsub = cond[12]
	Variable neff = cond[13]
	Tag/K/N=acontour0
	Tag/K/N=acontour1
	Tag/K/N=acontour2
	Tag/K/N=acontour3
	Tag/K/N=acontour4
	Tag/K/N=acontour5
	Tag/K/N=acontour6
	Tag/K/N=acontour7
	Tag/K/N=acontour8
	Tag/K/N=acontour9
	ModifyGraph lsize=1,rgb=(0,0,0),standoff=0,tick=2,minor=1,mirror=1
	ModifyGraph width={Plan,1,bottom,left}, font='Arial', fsize=12
	SetAxis left, 0, ysep*LY
	SetAxis bottom, -xsep*LX, xsep*LX
	Label left, "y (nm)"
	Label bottom, "x (nm)"
	SetDrawEnv xcoord = bottom,dash=1, ycoord = left,linefgc=(39168,39168,39168), save
	DrawLine  -xsep*LX, tsub,  xsep*LX, tsub
	DrawLine  -xsep*LX, tsub+d,  xsep*LX, tsub+d
	DrawLine a, tsub+d+t,  xsep*LX, tsub+d+t
	DrawLine -a, tsub+d+t, -xsep*LX, tsub+d+t
	DrawLine a, tsub+d+t, a, tsub+d+h
	DrawLine -a, tsub+d+t, -a, tsub+d+h
	DrawLine  a, tsub+d+h, -a, tsub+d+h
	TextBox/C/N=text0/F=0/B=2/A=MC "\\F'Arial'\\Z10Ridge width : " + num2str(a*2) + " nm\rEtching depth : "+num2str(h-t) + " nm\rFWHM x axis : " +num2str(hcsr(A)*2)+" nm"
	TextBox/C/N=text1/F=0/B=2/A=MC "\\F'Arial'\\Z08Elements X axis spacing : " + num2str(LX) + " nm\rY axis spacing : " + num2str(LY) +"nm\rPropagation constant : " + num2str(neff) 
End
Function ClearTags()
	Tag/K/N=acontour0
	Tag/K/N=acontour1
	Tag/K/N=acontour2
	Tag/K/N=acontour3
	Tag/K/N=acontour4
	Tag/K/N=acontour5
	Tag/K/N=acontour6
	Tag/K/N=acontour7
	Tag/K/N=acontour8
	Tag/K/N=acontour9
End