#pragma rtGlobals = 1       // Use modern global access method.
#pragma IgorVersion = 5.05A

//Fukuda Keisuke
//Igor Pro 5.05A ver.
//Last Update : 2011/12/11/03:24
//              2011/11/10/18:20

####################################################################################################
//////////=====     User-defined Menus     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Menu "|"
End

Menu "Fukuda Menu"
	Submenu "Graph Style"
		"Default"							, Graph_Default("")
		"Default [double]"					, GraphStyle_DefaultDouble("")
		"WinSpec data"						, Graph_WinSpec()
		"PL"								, Graph_PL()
		"Waveguide Emission"				, Graph_WaveguideEmission()
		"Gain"								, Graph_Gain("")
		"Peak gain and Internal loss"		, Graph_GainLoss()
		"IL curve [arb. unit]"				, Graph_ILcurve1()
		"IL curve [mW]"						, Graph_ILcurve2()
		"IL curve [PowerMeter and CCD]"		, Graph_ILcurve3()
		"Line Profile"						, Graph_Lineprofile()
		"BG count"							, Graph_BGcount()
	End
	SubMenu "Color Set"
		"Default"							, DP()
		"Gradually [Red]"					, TraceColor("",1,1)
		"Gradually [Blue]"					, TraceColor("",2,1)
		"Gradually [Green]"					, TraceColor("",3,1)
		"Rainbow"							, TraceColor("",4,1)
		"Monoton"							, MP()
	End
	SubMenu "Change Graph Size"
		"Auto"								, ModifyGraph width=0, height=0
		"Default [320x200]"					, ModifyGraph width=320, height=200
		"Expand [480x300]"					, ModifyGraph width=480, height=300
		"Shrink [160x100]"					, ModifyGraph width=160, height=100
	End
	"Change Offset"							, ChangeOffset_Caller()
	"-"
	"Back Ground"							, CorrectBG_Caller()
	"Height Normalize"						, NormalizeWaves_Caller()
	"Smoothing Waves in Graph"				, SmoothWaves_Caller()
	"Convert Waves in Graph"				, ConvertWaves()
	SubMenu "Average Waves"
		"Average Waves [integral ave.]"		, AverageWaves_IntAve()
		"Average Waves [point ave.]"		, AverageWaves_PntAve()
		"Average All Waves"					, AverageAllWaves("")
		"Average Showing Waves"				, AverageShowingWaves("")
	End
	"Average and Smoothing Waves"			, AverageSmoothWaves()
	"Graph Operation"						, GraphOperation()
	"-"
	"Wave Infomation [General]"				, WaveInfomation_General()
	"wave Infomation [Peak]"				, PickupFWHM()
	SubMenu "Delete Point"
		"Delete Point [by useing cursor]"	, DeletePoint_Csr()
		"Delete Point [edge of all waves]"	, DeletePoint_AllEdge()
	End
	"Combine 3 Waves"						, Combine3Waves()
	"-"
	"Append Graph to Other Graph"			, AppendGraph()
	"Duplicate and Replace Waves in Graph"	, DuplicateReplaceWaves()
	"Rename Waves in Graph"					, RenameWaves()
	"-"
	"Cassidy's Method"						, Cassidy_Caller()
	"KMS Analysis"							, KMS_MakeWindow()
	Submenu "KS"
		"KS plot"							, KS_plot()
		"KS fit"							, KS_fit()
	End
	"-"
	"Read SPE File"							, ReadSPEFile()
	"Read Text File"						, ReadTextFile()
	"-"
	"Display Matrix"						, DisplayMatrix()
	"Devide Matrix into Waves"				, DevideMatrix()
End

Menu "Exp. and Cal."
	"Read and Cassidy/1"						, Read_Cassidy()
	"Set Experimental Parameters"			, SetParameters()
	"Get CCD Back Ground Count"				, GetBGcount()
	"Unit Converter [eV - nm]"				, UnitConvert()
	"-"
	"Read shf1d File"						, Readshf1dFile()
	"shf1d Viewer"							, shf1dViewer()
	"shf1d Analysis"						, shf1dAnalysis()
End

Menu "Others"
	StrVarOrDefault("root:IgorSetupFolder:IgorSetupMenuStr","Igor Setup"), IgorSetup()
	StrVarOrDefault("root:IgorSetupFolder:IgorAutoSaveMenuStr","Igor Auto Save Experiment"), IgorAutoSave_Caller()
	"-"
	"Duplicate Waves by use Clipboard"		, DuplicateClipboardWaves()
	"Get Window Waves Data Folder"			, GetWinWavesDataFolder()
	"-"
	"Read ID Poisson File"					, Read1DPoisson()
	"Read 2D Opt File"						, Read2Dopt()
	"AlGaAs Value Getter"					, AlGaAsValueGetter()
	"Find mu"								, Find_mu()
	"Graph Convert to Table"				, graph2table()
	"Table Convert to Graph"				, table2graph_Caller()
	"-"
	"QW carrier [Potential]"				, QWcarrierEnergy_Caller()
	"-"
	"Make X Wave"							, Make_XWave_Caller()
	"Convert Y wave"						, COnvertYwave_Caller()
	"Make Fringe Wave"						, Make_FringeWave_Caller()
	"Cassidy Test"							, Cassidy_Test()
	"-"
	"Inverse Waves"							, InverseWaves()
	"Absorption Combert to Gain"			, abs2gain()
	"Gain Combert to Absorption"			, gain2abs()
	"Draw Mirror Loss Line"					, DrawMirrorLossLine("",0,0)
	"Print Window and Wane Name"			, Print_WinWaveName("")
	"Print Wave Name"						, Print_WaveName()
	"Igor Command List"						, IgorCommandList()
End

Menu "[Shortcut List]"
	"Read and Cassidy"					, Read_Cassidy()
	"Wave Infomation /2"					, WaveInfomation_General()
	"Read SPE File /3"						, ReadSPEFile()
	"Read Text File /4"						, ReadTextFile()
	"Read shf1d File /5"					, Readshf1dFile()
	"Append Graph to Other Graph /7"		, AppendGraph()
	"Color Set /8"							, TraceStyle_Caller()
	"Change Graph Size /9"					, GraphSize()
	"-"
	"Save Graph to Graphic File"		, SaveGraph_GraphicFile()
	"Save Waves from Graph to Text File", SaveGraph_TextFile()
	"Kill Graph and Buckup Waves /S8"		, KillGraph_BackupWaves()
	"Kill All Items /S9"					, KillAllItems()
End


####################################################################################################
//////////=====     Graph Style     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function Graph_Default(GraphName)
	String GraphName
	ModifyGraph/W=$GraphName fSize=10, font="Arial"
	ModifyGraph/W=$GraphName width=0, height=0
	ModifyGraph/W=$GraphName margin=0, lblPosMode=1,lblMargin=0
	ModifyGraph/W=$GraphName standoff=0, nolabel=0, manTick=0, minor=1, tick=2
	ModifyGraph/W=$GraphName mirror=1
//	SetAxis/W=$WindowName/A/N=0 left
//	SetAxis/W=$WindowName/A/N=0 bottom
End

Function GraphStyle_DefaultDouble(WindowName)
	String WindowName
	ModifyGraph/W=$WindowName fSize=10, font="Arial"
	ModifyGraph/W=$WindowName width=0, height=0
	ModifyGraph/W=$WindowName margin=0, lblPosMode=1,lblMargin=0
	ModifyGraph/W=$WindowName standoff=0, nolabel=0, manTick=0, tick=2, minor=1
	ModifyGraph/W=$WindowName mirror(bottom)=1
	SetAxis/W=$WindowName/A/N=0 left
	SetAxis/W=$WindowName/A/N=0 right
	SetAxis/W=$WindowName/A/N=0 bottom
End

Function Graph_WinSpec()
	Graph_Default("")
	Label bottom "\\Z12 Wavelength (nm)"
	Label left "\\Z12Intensity (count)"
End

Function Graph_PL()
	Graph_Default("")
	ModifyGraph manTick(bottom)={0,0.01,0,2}, manMinor(bottom)={9,5}
	ModifyGraph margin(left)=25, margin(bottom)=30, margin(right)=20, margin(top)=20
	ModifyGraph nolabel(bottom)=0, nolabel(left)=1
//	SetAxis bottom 1.48, 1.64
//	SetAxis left
	Label bottom "\\Z12Photon Energy (eV)"
	Label left "\\Z12PL Intensity (arb. unit)"
End


Function Graph_WaveguideEmission()
	Graph_Default("")
	ModifyGraph width=0, height=0
	ModifyGraph manTick(bottom)={0,0.01,0,2} , manMinor(bottom)={9,5}
	ModifyGraph manTick(left)=0
	ModifyGraph margin(left)=25, margin(bottom)=30, margin(right)=20, margin(top)=20
	ModifyGraph nolabel(bottom)=0, nolabel(left)=1
	Label bottom "\\Z12Photon Energy (eV)"
	Label left "\\Z12Waveguide Emission (arb. unit)"
End

Function Graph_ILcurve1()
	Graph_Default("")
	ModifyGraph width=200, height=320
	ModifyGraph manTick(bottom)={0,20,0,0}, manMinor(bottom)={3,0}
	ModifyGraph margin(left)=30, margin(bottom)=40, margin(right)=20, margin(top)=20
	ModifyGraph nolabel(bottom)=0 , nolabel(left)=1
	SetAxis bottom 0 , 180
//	SetAxis left 0 , 20
	Label bottom "\\Z12Excitation Power (mW)"
	Label left "\\Z12Integrated Intensity (arb. unit)"
End

Function Graph_ILcurve2()
	Graph_Default("")
	ModifyGraph width=200, height=320
	ModifyGraph manTick(bottom)={0,50,0,0}, manMinor(bottom)={4,0}
	ModifyGraph manTick(left)={0,10,0,0}, manMinor(left)={9,5}
	ModifyGraph margin(left)=40, margin(bottom)=40, margin(right)=20, margin(top)=20
	ModifyGraph nolabel(bottom)=0, nolabel(left)=0
	SetAxis bottom 0, 260
	SetAxis left 0, 90
	Label bottom "\\Z12Excitation Power (mW)"
	Label left "\\Z12Output Power (uW)"
End

Function Graph_ILcurve3()
	Graph_Default("")
	ModifyGraph margin(left)=40, margin(bottom)=40, margin(top)=20, margin(right)=30
	ModifyGraph width=200, height=320
	ModifyGraph mirror(bottom)=1
	ModifyGraph nticks(bottom)=10
	ModifyGraph minor(left)=1,minor(bottom)=1
	ModifyGraph noLabel(right)=1
	ModifyGraph lblLatPos(right)=21
	ModifyGraph manTick(bottom)={0,20,0,0},manMinor(bottom)={3,0}
	ModifyGraph manTick(left)={0,5,0,0},manMinor(left)={4,0}
	ModifyGraph manTick(right)={0,50,6,0},manMinor(right)={4,0}
	Label bottom "\\Z12Excitation Power (mW)"
	Label left "\\Z12Output Power (uW)"
	Label right "\\Z12Integrated Intensity (arb. unit)"
	SetAxis/N=2 bottom 0, 180
	SetAxis/N=2 left 0, 20
	SetAxis right 0, 300000000
End

Function Graph_Gain(WindowName)
	String WindowName
	Graph_Default(WindowName)
//	ModifyGraph/W=$WindowName width=320, height=200
	ModifyGraph/W=$WindowName manTick(bottom)={0,0.01,0,2}, manMinor(bottom)={9,5}
	ModifyGraph/W=$WindowName manTick(left)={0,5,0,0}, manMinor(left)={4,0}
	ModifyGraph/W=$WindowName margin(left)=40, margin(bottom)=30, margin(right)=20, margin(top)=20
//	SetAxis/W=$WindowName left -50 , 0
//	SetAxis/W=$WindowName bottom 1.540, 1.600
	Label/W=$WindowName bottom "\\Z12Photon Energy (eV) "
	Label/W=$WindowName left "\\Z12Modal Gain (cm\\S-1\\M\\Z12)"
//	SetDrawEnv ycoord= left, linefgc= (34816,34816,34816), dash= 3
//	DrawLine 0,0,1,0
//	SetDrawEnv ycoord= left, linefgc= (56576,56576,56576), dash= 0
//	DrawLine 0,-5,1,-5
End

Function Graph_GainLoss()
	Graph_Default("")
	ModifyGraph width=320, height=200
	ModifyGraph manTick(bottom)={0,5,0,0}, manMinor(bottom)={4,0}
	ModifyGraph manTick(left)={0,5,0,0}, manMinor(left)={4,0}
	ModifyGraph margin(left)=50, margin(bottom)=40, margin(right)=20, margin(top)=20
	SetAxis bottom, 0,20
	SetAxis left, -10, 5
	Label bottom "\\Z12Excitation Power (mW)"
	Label left "\\Z12Modal Gain (cm\\S-1\\M)"
	SetDrawEnv ycoord= left, linefgc= (34816,34816,34816), dash= 3
	DrawLine 0,0,1,0
	Variable R = 0.922		//default reflectance [um]
	Variable L = 500		//default cavity length
	Variable m_loss = (ln(1/R)/(L/10000))
	SetDrawEnv ycoord= left, linefgc= (0,0,0), dash= 3
	DrawLine 0,m_loss,1,m_loss
	printf "mirror loss = %g ( R = %g , L = %g [um] )\r", m_loss, R, L
End

Function Graph_Lineprofile()
	Graph_Default("")
	ModifyGraph margin(left)=25, margin(bottom)=30, margin(top)=20, margin(right)=20
	ModifyGraph width=240,height=160
	ModifyGraph mode=4, marker=19, msize=2, rgb=(65280,0,0)
	ModifyGraph mirror=1
	ModifyGraph noLabel(left)=1
	ModifyGraph manTick(left)={0,0.2,0,1}, manMinor(left)={3,2}
	ModifyGraph manTick(bottom)={0,250,0,0}, manMinor(bottom)={4,0}
	Label left "\\Z12Power (nomalized)"
	Label bottom "\\Z12Position (um)"
	SetAxis/N=2 left       0,     1.4
	SetAxis/N=2 bottom -1000, +1000
	DrawLine -250,0,-250,1
	SetDrawEnv xcoord=bottom, ycoord=prel, linefgc= (34816,34816,34816),dash= 3
	DrawLine   - 250, 0, - 250, 1
	SetDrawEnv xcoord=bottom, ycoord=prel, linefgc= (34816,34816,34816),dash= 3
	DrawLine   + 250, 0, + 250, 1
	SetDrawEnv xcoord=prel,   ycoord=left, linefgc= (34816,34816,34816),dash= 3
	DrawLine       0, 1,     1, 1
	Legend/C/N=text0/A=MB/X=0.00/Y=5.00
End

	SetDrawEnv xcoord=bottom, ycoord=prel, linefgc= (34816,34816,34816),dash= 3
	DrawLine   - 250, 0, - 250, 1
	SetDrawEnv xcoord=bottom, ycoord=prel, linefgc= (34816,34816,34816),dash= 3
	DrawLine   + 250, 0, + 250, 1
	SetDrawEnv xcoord=bottom, ycoord=left, linefgc= (34816,34816,34816),dash= 3
	DrawLine   -1000, 1, +1000, 1

Function GraphStyle_KMS(KMSGraphName,Efrom,Eupto)
	String KMSGraphName
	Variable Efrom, Eupto
	Variable PLfrom, PLupto, Gainfrom, Gainupto
	Variable Elow, Ehigh
	WAVE PLy = WaveRefIndexed(KMSGraphName,0,1)
	WAVE PLx = XWaveRefFromTrace(KMSGraphName,NameOfWave(PLy))
	WAVE Gainy = WaveRefIndexed(KMSGraphName,1,1)
	WAVE Gainx = XWaveRefFromTrace(KMSGraphName,NameOfWave(Gainy))
//set PL and Abs range
	Elow = Efrom+(Eupto-Efrom)*0.2; Ehigh = Eupto-(Eupto-Efrom)*0.2
	WaveStats/Q/R=[BinarySearch(PLx,Elow),BinarySearch(PLx,Ehigh)]/Z PLy
	PLupto = V_max*1.2; PLfrom = -V_max*1.2
	WaveStats/Q/R=[BinarySearch(Gainx,Elow),BinarySearch(Gainx,Ehigh)]/Z Gainy
	 Gainupto = -V_min*1.2; Gainfrom = V_min*1.2
//modify graph
	GraphStyle_DefaultDouble(KMSGraphName)
	SetAxis/W=$KMSGraphName bottom Efrom, Eupto
	SetAxis/W=$KMSGraphName left PLfrom, PLupto
	SetAxis/W=$KMSGraphName right Gainfrom, Gainupto
	SetAxis/W=$KMSGraphName left_F -5, 5
	Label/W=$KMSGraphName bottom "\\Z12Photon Energy (eV)"
	Label/W=$KMSGraphName left "\\Z12PL Intensity (arb. unit)"
	Label/W=$KMSGraphName right "\\Z12Gain (cm\\S-1\\M)"
	ModifyGraph/W=$KMSGraphName margin(left)=20, margin(bottom)=30, margin(right)=40, margin(top)=20
//color
	ModifyGraph/W=$KMSGraphName rgb($NameOfWave(PLy))=(65280,0,0), lsize($NameOfWave(PLy))=1.5
	ModifyGraph/W=$KMSGraphName rgb($NameOfwave(Gainy))=(0,0,65280), lsize($NameOfWave(Gainy))=1.5
	ModifyGraph/W=$KMSGraphName hideTrace($NameOfWave(PLy))=1, hideTrace($NameOfWave(Gainy))=1
	GPG()
	ModifyGraph hideTrace=0
//axis bottom
	ModifyGraph/W=$KMSGraphName manTick(bottom)={0,0.01,0,2}, manMinor(bottom)={9,5}
//axis left
	ModifyGraph/W=$KMSGraphName noLabel(left)=1, tickEnab(left)={0,inf}
	ModifyGraph/W=$KMSGraphName manTick(left)={0,PLupto/1.2,0,0}, manMinor(left)={9,5}
//axis left_F
	ModifyGraph nolabel(left_F) = 1
	ModifyGraph tick(left_F)=3
	ModifyGraph freePos(left_F)={Efrom,bottom}
//draw line
	SetDrawEnv linefgc= (34816,34816,34816), dash= 3
	DrawLine 0,0.5,1,0.5
//others
	ShowInfo/W=$KMSGraphName
	Legend/W=$KMSGraphName/C/N=text0/A=LB
End

Function GraphStyle_KS(KSGraphName,Efrom,Eupto)
	String KSGraphName
	Variable Efrom, Eupto
	Variable PLfrom, PLupto, Absfrom, Absupto
	Variable Elow, Ehigh
	WAVE PLy = WaveRefIndexed(KSGraphName,0,1)
	WAVE PLx = XWaveRefFromTrace(KSGraphName,NameOfWave(PLy))
	WAVE Absy = WaveRefIndexed(KSGraphName,1,1)
	WAVE Absx = XWaveRefFromTrace(KSGraphName,NameOfWave(Absy))
	WAVE Fy = WaveRefIndexed(KSGraphName,2,1)
	WAVE Fx = XWaveRefFromTrace(KSGraphName,NameOfWave(Fy))
//set PL and Abs range
	Elow = Efrom+(Eupto-Efrom)*0.2; Ehigh = Eupto-(Eupto-Efrom)*0.2
	WaveStats/Q/R=[BinarySearch(PLx,Elow),BinarySearch(PLx,Ehigh)]/Z PLy
	PLupto = V_max*1.2; PLfrom = -V_max*1.2
	WaveStats/Q/R=[BinarySearch(Absx,Elow),BinarySearch(Absx,Ehigh)]/Z Absy
	Absupto = V_max*2.0; Absfrom = -0.5
//modify graph
	GraphStyle_DefaultDouble(KSGraphName)
	SetAxis/W=$KSGraphName bottom Efrom, Eupto
	SetAxis/W=$KSGraphName left PLfrom, PLupto
	SetAxis/W=$KSGraphName right Absfrom, Absupto
	Label/W=$KSGraphName bottom "\\Z12Photon Energy (eV)"
	Label/W=$KSGraphName left "\\Z12PL Intensity (arb. unit)"
	Label/W=$KSGraphName right "\\Z12Absorption (cm\\S-1\\M)"
	ModifyGraph/W=$KSGraphName rgb($NameOfWave(PLy))=(65280,0,0)
	ModifyGraph/W=$KSGraphName rgb($NameOfwave(Absy))=(0,0,65280)
	ModifyGraph/W=$KSGraphName rgb($NameOfWave(Fy))=(0,0,0)
	ModifyGraph/W=$KSGraphName margin(left)=20, margin(bottom)=30, margin(right)=40, margin(top)=20
//axis bottom
	ModifyGraph/W=$KSGraphName manTick(bottom)={0,0.01,0,2}, manMinor(bottom)={9,5}
//axis left
	ModifyGraph/W=$KSGraphName noLabel(left)=1, tickEnab(left)={0,inf}
	ModifyGraph/W=$KSGraphName manTick(left)={0,PLupto/1.2,0,0}, manMinor(left)={9,5}
//axis left_F
	ModifyGraph nolabel(left_F) = 1
	ModifyGraph tick(left_F)=3
	ModifyGraph freePos(left_F)={Efrom,bottom}
//others
	ShowInfo/W=$KSGraphName
	Legend/W=$KSGraphName/C/N=text0/A=LB
End



####################################################################################################
//////////=====     Trace Style     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////
//Trace Style Caller//
//////////////////////
Function TraceStyle_Caller()
	Variable ColorMode, PaintMode
	String ColorList, PaintList
	ColorMode = 6
	PaintMode = 2
	ColorList = " 1 : Gradually [Red]; 2 : Gradually [Blue]; 3 : Gradually [Green]; 4 : Rainbow; 5 : Monotone; 0 : Default;"
	PaintList = " 1 : all waves; 2 : only showing waves;"
	Prompt ColorMode, "select color mode", popup, ColorList
	Prompt PaintMode, "select paint mode", popup, PaintList
	DoPrompt "Trace Style", ColorMode, PaintMode
	if(V_flag==1)
		Print "Cancel"
		return -1
	endif
	TraceColor("",ColorMode,PaintMode)
End


//////////////
//Trace Mode//
//////////////
Function TraceMode(GraphName,Mode)
	Variable Mode
	String GraphName
End


///////////////
//Trace Color//
///////////////
Function TraceColor(GraphName,ColorMode,PaintMode)
	Variable ColorMode, PaintMode
	String GraphName
//define parameters
	Variable i, N, j, M
	Variable R, G, B
	Variable traceNum,totalNum
	Variable/G V_red, V_green, V_blue
	String traceName
//set parameters
	if (strlen(GraphName)==0)
		GraphName = WinName(0,1)
	endif
	N = CountWaves(GraphName)
	M = CountWaves_Trace(GraphName)
//main loop
	for (i=0; i<N; i+=1)
		traceName = TraceNameStr(GraphName,i)
	//select Paint Mode
		if     (PaintMode==1)	//paint all waves
			traceNum = i
			totalNum = N
		elseif (PaintMode==2)	//paint only showing waves
			if (TraceStats(GraphName,traceName) != 0)
				continue
			endif
			traceNum = j
			totalNum = M
			j += 1
		endif
	//select Color Mode
		if     (ColorMode==1)	//Gradually Red
			TraceRGB_GraduallyRed(traceNum,totalNum)
		elseif (ColorMode==2)	//Gradually Blue
			TraceRGB_GraduallyBlue(traceNum,totalNum)
		elseif (ColorMode==3)	//Gradually Green
			TraceRGB_GraduallyGreen(traceNum,totalNum)
		elseif (ColorMode==4)	//Rainbow
			TraceRGB_Rainbow(traceNum,totalNum)
		elseif (ColorMode==5)	//Monotone
			TraceRGB_GraduallyMonotone(traceNum,totalNum)
		endif
	//change color
		R = V_red
		G = V_green
		B = V_blue
		ModifyGraph/W=$GraphName rgb($traceName) = (R,G,B)
	endfor
//others
	KillVariables/Z V_red, V_green, V_blue 
End


/////////////////////////////
//Trace RGB Gradually [Red]//
/////////////////////////////
Function TraceRGB_GraduallyRed(traceNum,totalNum)
	Variable traceNum, totalNum
	Variable R, G, B
	Variable/G V_red, V_green, V_blue
	if (traceNum<0 || traceNum>totalNum-1)
		V_red   = 0
		V_green = 0
		V_blue  = 0
		return -1
	endif
//main program start
	Variable i, N, M
	i = traceNum
	N = totalNum
	M = round((N-1)/2)
	if (i<M)
		R = 65000
		G = 45000 * (1 - i/M) + 5000
		B = 45000 * (1 - i/M) + 5000
	elseif (i==M)
		R = 65280
		G = 0
		B = 0
	elseif (i>M)
		R = 60000 - 40000 * (i-M)/(N-1-M)
		G = 10000 * (i-M)/(N-1-M)
		B = 10000 * (i-M)/(N-1-M)
	endif
//main program end
	V_red   = R
	V_green = G
	V_blue  = B
End


//////////////////////////////
//Trace RGB Gradually [Blue]//
//////////////////////////////
Function TraceRGB_GraduallyBlue(traceNum,totalNum)
	Variable traceNum, totalNum
	Variable R, G, B
	Variable/G V_red, V_green, V_blue
	if (traceNum<0 || traceNum>totalNum-1)
		V_red   = 0
		V_green = 0
		V_blue  = 0
		return -1
	endif
//main program start
	Variable i, N, M
	i = traceNum
	N = totalNum
	M = round((N-1)/2)
	if (i<M)
		R = 45000 * (1 - i/M) + 5000
		G = 45000 * (1 - i/M) + 5000
		B = 65000
	elseif (i==M)
		R = 0
		G = 0
		B = 65280
	elseif (i>M)
		R = 10000 * (i-M)/(N-1-M)
		G = 10000 * (i-M)/(N-1-M)
		B = 60000 - 40000 * (i-M)/(N-1-M)
	endif
//main program end
	V_red   = R
	V_green = G
	V_blue  = B
End


///////////////////////////////
//Trace RGB Gradually [Green]//
///////////////////////////////
Function TraceRGB_GraduallyGreen(traceNum,totalNum)
	Variable traceNum, totalNum
	Variable R, G, B
	Variable/G V_red, V_green, V_blue
	if (traceNum<0 || traceNum>totalNum-1)
		V_red   = 0
		V_green = 0
		V_blue  = 0
		return -1
	endif
//main program start
	Variable i, N, M
	i = traceNum
	N = totalNum
	M = round((N-1)/2)
	if (i<M)
		R = 45000 * (1 - i/M) + 5000
		G = 65000
		B = 45000 * (1 - i/M) + 5000
	elseif (i==M)
		R = 0
		G = 65280
		B = 0
	elseif (i>M)
		R = 10000 * (i-M)/(N-1-M)
		G = 60000 - 40000 * (i-M)/(N-1-M)
		B = 10000 * (i-M)/(N-1-M)
	endif
//main program end
	V_red   = R
	V_green = G
	V_blue  = B
End


/////////////////////
//Trace RGB Rainbow//
/////////////////////
Function TraceRGB_Rainbow(traceNum,totalNum)
	Variable traceNum, totalNum
	Variable R, G, B
	Variable/G V_red, V_green, V_blue
	if (traceNum<0 || traceNum>totalNum-1)
		V_red   = 0
		V_green = 0
		V_blue  = 0
		return -1
	endif
//main program start
	switch(mod(traceNum,6))
		case 0:	//red
			R = 65280; G =     0; B =     0
			break
		case 1:	//orange
			R = 65280; G = 43520; B =     0
			break
		case 2:	//yellow
			R = 52224; G = 52224; B =     0
			break
		case 3:	//green
			R =     0; G = 52224; B =     0
			break
		case 4:	//blue
			R =     0; G =     0; B = 65280
			break
		case 5:	//violet
			R = 26368; G =     0; B = 52224
			break
	endswitch
//main program end
	V_red   = R
	V_green = G
	V_blue  = B
End


//////////////////////////////////
//Trace RGB Gradually [Monotone]//
//////////////////////////////////
Function TraceRGB_GraduallyMonotone(traceNum,totalNum)
	Variable traceNum, totalNum
	Variable R, G, B
	Variable/G V_red, V_green, V_blue
	if (traceNum<0 || traceNum>totalNum-1)
		V_red   = 0
		V_green = 0
		V_blue  = 0
		return -1
	endif
//main program start
	Variable i, N
	i = traceNum
	N = totalNum
	R = 55000*((N-1-i)/(N-1))^0.75
	G = 55000*((N-1-i)/(N-1))^0.75
	B = 55000*((N-1-i)/(N-1))^0.75
//main program end
	V_red   = R
	V_green = G
	V_blue  = B
End

####################################################################################################
//////////=====     Graph Color     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////
//Graph Color Caller//
//////////////////////
Function GraphColor_Caller()
	Variable mode=6
	String ColorList = " 1 : Gradually [Red]; 2 : Gradually [Blue]; 3 : Gradually [Green]; 4 : Rainbow; 5 : Monoton; 0 : Default"
	Prompt mode, "select color mode", popup, ColorList
	DoPrompt "Graph Color", mode
	if(V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
	if (mode==1)		//Gradually [Red]
		GPR()
	elseif (mode==2)	//Gradually [Blue]
		GPB()
	elseif (mode==3)	//Gradually [Green]
		GPG()
	elseif (mode==4)	//Rainbow
		Rainbow("",0,0)
	elseif (mode==5)	//Monoton
		MP()
	else				//Default
		DP()
	endif
End

///////////
//Rainbow//
///////////
Function Rainbow(WindowName,offset,mode)
	String WindowName
	Variable offset, mode
	String yName
	Variable w, Nw, v, Nv
	Nw = CountWaves(WindowName)
	Nv = CountWaves_Trace(WindowName)
	if (Nw == 1 || Nv == 1)
		return -1
	endif
	for(w=0; w<Nw; w+=1)
		yName = WaveName(WindowName,w,1)
		if (TraceStats(WindowName,yName) != 0)
			continue
		endif
		switch(mod(v+offset, 6))
			case 0:
				ModifyGraph/W=$WindowName rgb($yName) = (65280,0,0)		//red
				break
			case 1:
				ModifyGraph/W=$WindowName rgb($yName) = (65280,43520,0)	//orange
				break
			case 2:
				ModifyGraph/W=$WindowName rgb($yName) = (52224,52224,0)	//yellow
				break
			case 3:
				ModifyGraph/W=$WindowName rgb($yName) = (0,52224,0)		//green
				break
			case 4:
				ModifyGraph/W=$WindowName rgb($yName) = (0,0,65280)		//blue
				break
			case 5:
				ModifyGraph/W=$WindowName rgb($yName) = (26368,0,52224)	//violet
				break
		endswitch
		v += 1
	endfor
	if (mode == 0)
		ModifyGraph/W=$WindowName mode=0, lstyle=0, lsize=1
	endif
End

///////////////////////////
//gradually painter [Red]//
///////////////////////////
Function GPR()
	Variable w, Nw, v, Nv, M
	Variable R, G, B
	String GraphName, yName
	GraphName = WinName(0,1)
	Nw = CountWaves(GraphName)
	Nv = CountWaves_Trace(GraphName)
	M = round((Nv-1)/2)
	if (Nw == 1 || Nv == 1)
		return -1
	endif
	for (w=0; w<Nw; w+=1)
		yName = TraceNameStr(GraphName,w)
		if (TraceStats(GraphName,yName) != 0)
			continue
		endif
		if (v<M)
			R = 65000
			G = 50000 * (1 - v/M) + 5000
			B = 50000 * (1 - v/M) + 5000
		elseif (v==M)
			R = 65280
			G = 0
			B = 0
		elseif (v>M)
			R = 60000 - 40000 * (v-M)/(Nv-1-M)
			G = 10000 * (v-M)/(Nv-1-M)
			B = 10000 * (v-M)/(Nv-1-M)
		endif
		ModifyGraph/W=$GraphName rgb($yName) = (R,G,B)
		v += 1
	endfor
	ModifyGraph/W=$GraphName mode=0, lstyle=0
End

/////////////////////////////
//gradually painter [Green]//
/////////////////////////////
Function GPG()
	Variable w, Nw, v, Nv, M
	Variable R, G, B
	String GraphName, yName
	GraphName = WinName(0,1)
	Nw = CountWaves(GraphName)
	Nv = CountWaves_Trace(GraphName)
	M = round((Nv-1)/2)	
	if (Nw == 1 || Nv == 1)
		return -1
	endif
	for (w=0; w<Nw; w+=1)
		yName = TraceNameStr(GraphName,w)
		if (TraceStats(GraphName,yName) != 0)
			continue
		endif
		if (v<M)
			R = 50000 * (1 - v/M) + 5000
			G = 65000
			B = 50000 * (1 - v/M) + 5000
		elseif (v==M)
			R = 0
			G = 65280
			B = 00
		elseif (v>M)
			R = 10000 * (v-M)/(Nv-1-M)
			G = 60000 - 40000 * (v-M)/(Nv-1-M)
			B = 10000 * (v-M)/(Nv-1-M)
		endif
		ModifyGraph/W=$GraphName rgb($yName) = (R,G,B)
		v += 1
	endfor
	ModifyGraph/W=$GraphName mode=0, lstyle=0
End

////////////////////////////
//gradually painter [Biue]//
////////////////////////////
Function GPB()
	Variable w, Nw, v, Nv, M
	Variable R, G, B
	String GraphName, yName
	GraphName = WinName(0,1)
	Nw = CountWaves(GraphName)
	Nv = CountWaves_Trace(GraphName)
	M = round((Nv-1)/2)	
	if (Nw == 1 || Nv == 1)
		return -1
	endif
	for (w=0; w<Nw; w+=1)
		yName = TraceNameStr(GraphName,w)
		if (TraceStats(GraphName,yName) != 0)
			continue
		endif
		if (v<M)
			R = 50000 * (1 - v/M) + 5000
			G = 50000 * (1 - v/M) + 5000
			B = 65000
		elseif (v==M)
			R = 0
			G = 0
			B = 65280
		elseif (v>M)
			R = 10000 * (v-M)/(Nv-1-M)
			G = 10000 * (v-M)/(Nv-1-M)
			B = 60000 - 40000 * (v-M)/(Nv-1-M)
		endif
		ModifyGraph/W=$GraphName rgb($yName) = (R,G,B)
		v += 1
	endfor
	ModifyGraph/W=$GraphName mode=0, lstyle=0
End

//////////////////////
//periodical painter//
//////////////////////
Function PP(offset)
	Variable offset
	Variable i = CountWaves("")
	Variable j
	String WindowName = WinName(0,1)
	String y
	if(i == 1)
		return -1
	endif
	for(j=0;j<i;j+=1)
		y = WaveName(WindowName,j,1)
		switch(mod(j+offset, 10))
			case 0:
				ModifyGraph rgb($y) = (65280,0,0) //red
				break
			case 1:
				ModifyGraph rgb($y) = (65280,43520,0) //orange
				break
			case 2:
				ModifyGraph rgb($y) = (52224,52224,0) //dark yellow
				break
			case 3:
				ModifyGraph rgb($y) = (0,52224,0) //green
				break
			case 4:
				ModifyGraph rgb($y) = (0,43520,65280) //light blue
				break
			case 5:
				ModifyGraph rgb($y) = (0,0,65280) //blue
				break
			case 6:
				ModifyGraph rgb($y) = (26368,0,52224) //violet
				break
			case 7:
				ModifyGraph rgb($y) = (52224,0,41728) //red violet
				break
			case 8:	
				ModifyGraph rgb($y) = (45000,45000,45000) //gray
				break
			case 9:	
				ModifyGraph rgb($y) = (0,0,0) //black
				break
		endswitch
	endfor
	ModifyGraph mode=0,lstyle=0
End

/////////////////////
//Monotonic painter//
/////////////////////
Function MP()
	variable i
	i = CountWaves("")
	variable j
	String WindowName = WinName(0,1)
	String y
	if(i == 1)
		return -1
	endif
	Variable b
	ModifyGraph mode = 4, rgb = (0,0,0)
	for(j=0;j<i;j+=1)
		y = WaveName(WindowName,j,1)
		ModifyGraph lstyle($y) = b*3
		switch(mod(j, 8))
			case 0:
				ModifyGraph marker($y) = 8 //circle
				break
			case 1:
				ModifyGraph marker($y) = 7 //rhomb
				break
			case 2:
				ModifyGraph marker($y) = 6 //triangle
				break
			case 3:
				ModifyGraph marker($y) = 5 //square
				break
			case 4:
				ModifyGraph marker($y) = 4 //bow
				break
			case 5:
				ModifyGraph marker($y) = 0 //cross
				break
			case 6:
				ModifyGraph marker($y) = 1 //times
				break
			case 7:
				ModifyGraph marker($y) = 2 //Union Flag
				b += 1
				break
		endswitch
	endfor
End

///////////////////
//Default painter//
///////////////////
Function DP()
	ModifyGraph mode=0, lsize=1, lstyle=0, rgb=(65280,0,0)
End



####################################################################################################
//////////=====     Modify Graph     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////
//Graph Size//
//////////////
Function GraphSize()
//input parameter
	Variable mode=4
	String SizeList = " 1 : Default [320x200]; 2 : Expand [480x300]; 3 : Shrink [160x100]; 0 : Auto"
	Prompt mode, "select size mode", popup, SizeList
	DoPrompt "Change Graph Size", mode
//error handling
	if(V_flag==1)
		print "Cancel"
		return -1
	endif
//main
	if (mode == 1)	//Default [320x200]
		ModifyGraph width=320, height=200
	elseif (mode == 2)	//Expand [480x300]
		ModifyGraph width=480, height=300
	elseif (mode == 3)	//Shrink [160x100]
		ModifyGraph width=160, height=100
	else				//Auto
		ModifyGraph width=0, height=0
	endif
End

/////////////////////////
//Draw Mirror Loss Line//
/////////////////////////
Function DrawMirrorLossLine(WindowName,R,L)
//parameter set
	String WindowName
	Variable R, L //R=reflectance, L=cavity length [um]
//input data
	if (R==0 & L==0)
		Prompt R, "refrectance"
		Prompt L, "cavity length [um]"
		DoPrompt "Draw Mirror Loss Line", R, L
	//error handling
		if (V_flag==1)
			DoAlert 0, "Cancel"
			Print "Cancel"
			return -1
		endif
	endif
//main
	Variable m_loss = (ln(1/R)/(L/10000))
	SetDrawEnv/W=$WindowName ycoord= left, linefgc= (0,0,0), dash= 3
	DrawLine/W=$WindowName 0,m_loss,1,m_loss
	printf "mirror loss = %g [/cm] ( R = %g , L = %g [um] )\r", m_loss, R, L
End



####################################################################################################
//////////=====     Save Graph     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////////
//Save Graph to Graphic File//
//////////////////////////////
Function SaveGraph_GraphicFile()
//define parameters
	String   GraphName, FileName
	Variable fileMode, e
	Variable colorMode, c
//set parameters
	GraphName = WinName(0,1)
	fileMode = 1
	colorMode = 2
	Prompt fileMode, "select graphics format", popup, " 1 : EMF; 2 : EPS"
	Prompt colorMode, "select color mode", popup, " 1 : black & white; 2 : RGB; 3 : CMYK;"
	Prompt GraphName, "select graph", popup, WinList("*", ";", "WIN:1")
	DoPrompt "Save Graphic File", fileMode, colorMode, GraphName
//error handling
	if (V_flag==1)
		Print "Ccanceled by user"
		return -1
	endif
//main program
	if    (fileMode==1)	//EMF format
		e = -2
	elseif(fileMode==2)	//EPS format
		e = -3
	endif
	if    (colorMode==1)//brack & white
		c = 0
	elseif(colorMode==2)//RGB
		c = 1
	elseif(colorMode==3)//CMYK
		c = 2
	endif
	sprintf FileName, "Graph %s.emf", GraphName
	SavePICT/C=(c)/E=(e) as FileName
End


####################################################################################################
//////////=====     Change Offset     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

////////////////////////
//Change Offset Caller//
////////////////////////
Function ChangeOffset_Caller()
//define parameters
	String   GraphName
	Variable Xoffset, Yoffset, mode
//input paramters
	GraphName = WinName(0,1)
	mode = 2
	Prompt Yoffset, "input Y offset"
	Prompt Xoffset, "input X offset"
	Prompt GraphName, "select graph", popup, WinList("*",";","WIN:1")
	Prompt mode, "select offset mode", popup, " all waves; only showing waves;"
	DoPrompt "Change Offset", Yoffset, Xoffset, GraphName, mode
//error handling
	if (V_flag==1)
		Print "Ccanceled by user"
		return -1
	endif
//main program
	mode -= 1
	ChangeOffset(graphName,Xoffset,Yoffset,mode)
//print data
	printf "%s : Xoffset %g, Yoffset %g\r", GraphName, Xoffset, Yoffset
End


/////////////////
//Change Offset//
/////////////////
//mode 0 : all
//     1 : only showing
Function ChangeOffset(GraphName,Xoffset,Yoffset,mode)
	String   GraphName
	Variable Xoffset, Yoffset, mode
//define parameters
	variable w, Nw, s
	String   traceName
//set paramters
	if (strlen(GraphName) == 0)
		GraphName = WinName(0,1)
	endif
	Nw = CountWaves(GraphName)
//main program
	for(w=0; w<Nw; w+=1)
		traceName = traceNameStr(GraphName,w)
		if(mode==1 && TraceStats(GraphName,traceName)!=0)
			continue
		endif
		ModifyGraph/W=$GraphName offset($traceName)={Xoffset*s,Yoffset*s}
		s += 1
	endfor
End



####################################################################################################
//////////=====     Correct Back Ground     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////////
//Correct Back Ground Caller//
//////////////////////////////
Function CorrectBG_Caller()
//define parameters
	String   GraphName, bgGraphName
	String   bgWaveName
	Variable mode
	Variable BG
//set parameters
	GraphName = WinName(0,1)
	bgGraphName = GraphName + "_BG"
//input parameters
	Prompt mode, "select BG mode", popup, " 1 : count; 2 : wave;"
	DoPrompt "Correct Back Ground", mode
//error handling
	if (V_flag==1)
		Print "canceled by user"
		return -1
	endif
//main program
	if    (mode == 1) 	//BG count
		BG = (numtype(GetParameter_Var("BG"))==0) ? GetParameter_Var("BG") : 108
		Prompt BG, "input background value"
		DoPrompt "Correct Back Ground [count]", BG
		if (V_flag==1)
			Print "canceled by user"
			return -1
		endif
		printf "%s = %s ( BG : %g [count] )\r", bgGraphName, GraphName, BG
		CorrectBGcount(GraphName,BG)
	elseif(mode ==2)	//BG wave
		Prompt bgWaveName, "select background wave name", popup, WaveList("!*_x*",";","")
		DoPrompt "Correct Back Ground [wave]", bgWaveName
		if(V_flag==1)
			Print "canceled by user"
			return -1
		endif
		printf "%s = %s ( BG wave : %s )\r", bgGraphName, GraphName, bgWaveName
		CorrectBGwave(GraphName,bgWaveName)
	endif
//modify graph
	Graph_Default(bgGraphName)
	Label/W=$bgGraphName left   GetAxisLabel(GraphName,"left"  ,1)
	Label/W=$bgGraphName bottom GetAxisLabel(GraphName,"bottom",1)
	ChangeOffset(bgGraphName,0,5000,0)
	GPR()
End

///////////////////////////////
//Correct Back Ground [count]//
///////////////////////////////
Function CorrectBGcount(GraphName,BG)
	String   GraphName
	Variable BG
//define parameters
	String   bgGraphName
	String   srcYName, srcXName, bgYName
	String   tmpStr
	Variable w, Nw
//set parameters
	bgGraphName = GraphName + "_BG"
	Nw = CountWaves(GraphName)
//main program
	Display/N=$bgGraphName as bgGraphName
	for(w=0; w<Nw; w+=1)
		WAVE/D srcY = WaveRefIndexed(GraphName,w,1)				; srcYName = NameOfWave(srcY)
		WAVE/D srcX = XWaveRefFromTrace(GraphName,srcYName))	; srcXName = NameOfWave(srcX)
		bgYName = srcYName + "_BG"
		Make/D/N=(numpnts(srcX)) bgY; Duplicate/D/O srcY, bgY; Rename bgY, $bgYName
		bgY -= BG
		AppendToGraph/W=$bgGraphName bgY vs srcX
		sprintf tmpStr, "%s = %s ( BG : %g [count] )", bgYName, srcYName, BG
		Note bgY, tmpStr
		Print tmpStr+"\r"
	endfor
End

//////////////////////////////
//Correct Back Ground [wave]//
//////////////////////////////
Function CorrectBGwave(GraphName,bgWaveName)
	String   GraphName, bgWaveName
//define parameters
	String   bgGraphName
	String   srcYName, srcXName, bgYName
	String   tmpStr
	Variable w, Nw
	Variable Np
//set parameters
	bgGraphName = GraphName + "_BG"
	Nw = CountWaves(GraphName)
	WAVE bgWave = $bgWaveName
	Np = numpnts(bgWave)
//main program
	Display/N=$bgGraphName as bgGraphName
	for(w=0; w<Nw; w+=1)
		WAVE/D srcY = WaveRefIndexed(GraphName,w,1)				; srcYName = NameOfWave(srcY)
		WAVE/D srcX = XWaveRefFromTrace(GraphName,srcYName))	; srcXName = NameOfWave(srcX)
		if (numpnts(srcX)==Np)
			bgYName = srcYName + "_BG"
		else
			bgYName = srcYName + "_BGfailure"
		endif
		Make/D/N=(numpnts(srcX)) bgY; Duplicate/D/O srcY, bgY; Rename bgY, $bgYName
		bgY -= bgWave
		AppendToGraph/W=$bgGraphName bgY vs srcX
		sprintf tmpStr, "%s = %s ( BG wave : %s )", bgYName, srcYName, bgWaveName
		Note bgY, tmpStr
		Print tmpStr+"\r"
	endfor
End



####################################################################################################
//////////=====     Height Normalize     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////
//normalize Waves Caller//
//////////////////////////
Function NormalizeWaves_Caller()
//define parameters
	Variable Xfrom, Xupto
	Variable csrApnt, csrBpnt
	String   GraphName
//set parameters
	GraphName = WinName(0,1)
	if (csrExists("A",GraphName)==1 && csrExists("B",GraphName)==1)
		WAVE xA = CsrXWaveRef(A,GraphName);	csrApnt = pcsr(A,GraphName)
		WAVE xB = CsrXWaveRef(B,GraphName);	csrBpnt = pcsr(B,GraphName)
		Xfrom = (xA[csrApnt]<xB[csrBpnt]) ? xA[csrApnt] : xB[csrBpnt]
		Xupto = (xA[csrApnt]<xB[csrBpnt]) ? xB[csrBpnt] : xA[csrApnt]
	endif
//input parameters
	Prompt GraphName, "select graph", popup, WinList("*", ";", "WIN:1")
	Prompt Xfrom, "from (X value)"
	Prompt Xupto, "upto (X value)"
	DoPrompt "Normalize Waves", GraphName, Xfrom, Xupto
//error handling
	if    (V_flag==1)
		Print "canceled by user"
		return -1
	elseif(Xfrom>Xupto)
		DoAlert 0, "Xfrom is more than Xupto"
		Print "incorrect parameters"
		return -1
	endif
//main program
	NormalizeWaves(GraphName,Xfrom,Xupto)
End


///////////////////
//Normalize Waves//
///////////////////
Function NormalizeWaves(GraphName,Xfrom,Xupto)
	String   GraphName
	Variable Xfrom, Xupto
//define parameters
	Variable w, Nw	//number of all waves
	Variable Pfrom, Pupto
	Variable Ymax
	String   srcYName, srcXName, normYName
	String   normGraphName
	String   areaStr, tmpStr
	String   leftLabel
//main program	
	Nw = CountWaves(GraphName)
	normGraphName = GraphName + "_Norm"
	if (Xfrom==Xupto)
		sprintf areaStr, "all range"
	else
		sprintf areaStr, "%g - %g", Xfrom, Xupto
	endif
	printf "%s = %s ( normalize area : %s )\r", normGraphName, GraphName, areaStr
	Display/N=$normGraphName as normGraphName
	for (w=0; w<Nw; w+=1)
		WAVE/D srcY = WaveRefIndexed(GraphName,w,1)			; srcYName = NameOfWave(srcY)
		WAVE/D srcX = XWaveRefFromTrace(GraphName,srcYName)	; srcXName = NameOfWave(srcX)
		if(TraceStats(GraphName,srcYName)!=0)
			continue
		endif
	//set Pfrom, Pupto, Ymax
		if (Xfrom==Xupto)
			Pfrom = 0
			Pupto = numpnts(srcX) - 1
		else
			Pfrom = BinarySearch(srcX,Xfrom)
			Pupto = BinarySearch(srcX,Xupto)
		endif
		WaveStats/Q/R=[Pfrom,Pupto]/Z srcY; Ymax = V_max
	//make nomalazed wave
		normYName = srcYName + "_Norm"
		Make/D/N=(numpnts(srcX)) normY; Duplicate/D/O srcY, normY; Rename normY, $normYName
		normY /= Ymax
		AppendToGraph/W=$normGraphName normY vs srcX
		sprintf tmpStr, "%s = %s ( normalize area : %s )", normYName, srcYName, areaStr
		Note normY, tmpStr
		Print tmpStr+"\r"
	endfor
//modify graph
	leftLabel = GetAxisLabel(GraphName,"left"  ,1)
	if (stringmatch(leftLabel,"*(*"))
		leftLabel = leftLabel[0,strsearch(leftLabel,"(",0)-1] + "(normalized)"
	else
		leftLabel += " (normalized)"
	endif
	Graph_Default(normGraphName)
	Legend/C/N=text0/A=LT
	Label/W=$normGraphName left   leftLabel
	Label/W=$normGraphName bottom GetAxisLabel(GraphName,"bottom",1)
	ChangeOffset(normGraphName,0,1,0)
	GPR()
End


####################################################################################################
//////////=====     Smoothing Waves     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

///////////////////////
//Smooth Waves Caller//
///////////////////////
Function SmoothWaves_Caller()
//define parameters
	Variable Nsmth
	Variable TraceMode
	Variable w, Nw
	String   GraphName, smthGraphName
//set parameters
	GraphName = WinName(0,1)
	Nsmth = 5
//input paramters
	Prompt GraphName, "select graph", popup, WinList("*", ";", "WIN:1")
	Prompt Nsmth, "smoothing points"
	Prompt TraceMode, "select trace mode", popup, " new graph; append to src graph (kill smth graph); appned to src graph (not kill smth graph);"
	DoPrompt "Smoothing Waves", GraphName, Nsmth, TraceMode
//error handling
	if    (V_flag==1)
		Print "canceled by user"
		return -1
	elseif(Nsmth<=1)
		DoAlert 0, "smoothing points is more than 1 point"
		Print "incorrect parameters"
		return -1
	endif
//main program
	SmoothWaves(GraphName,Nsmth)
	if(TraceMode!=1)	//append to src graph
		smthGraphName = GraphName + "_Smth"
		Nw = CountWaves(smthGraphName)
		for(w=0; w<Nw; w+=1)
			WAVE smthY = WaveRefIndexed(smthGraphName,w,1)
			WAVE smthX = XWaveRefFromTrace(smthGraphName,NameOfwave(smthY))
			AppendToGraph/W=$GraphName smthY vs smthX
		endfor
	endif
	if(TraceMode==2)
		KillWindow $smthGraphName
	endif
End


///////////////////
//Smoothing Waves//
///////////////////
Function SmoothWaves(GraphName,Nsmth)
	Variable Nsmth
	String   GraphName
//error handling
	if (Nsmth<1)
		return -1
	endif
//define parameters
	Variable w, Nw	//number of all waves
	String   srcYName, srcXName, smthYName
	String   smthGraphName
	String   tmpStr
//main program
	Nw = CountWaves(GraphName)
	smthGraphName = GraphName + "_Smth"
	printf "%s = %s ( smoothing : %g points )\r", smthGraphName, GraphName, Nsmth
	Display/N=$smthGraphName as smthGraphName
	for(w=0; w<Nw; w+=1)
		WAVE srcY = WaveRefIndexed(GraphName,w,1)			; srcYName = NameOfWave(srcY)
		WAVE srcX = XWaveRefFromTrace(GraphName,srcYName)	; srcXName = NameOfWave(srcX)
		if(TraceStats(GraphName,srcYName)!=0)
			continue
		endif
		smthYName = srcYName + "_Smth"
		Make/N=(numpnts(srcX)) smthY; Duplicate/O srcY, smthY; Rename smthY, $smthYName
		Smooth/E=3 Nsmth, smthY
		AppendToGraph/W=$smthGraphName smthY vs srcX
		sprintf tmpStr, "%s = %s ( smoothing : %g points )", smthYName, srcYName, Nsmth
		Note smthY, tmpStr
		Print tmpStr+"\r"
	endfor
//modify graph
	Graph_Default(smthGraphName)
	Legend/C/N=text0/A=LT
	Label/W=$smthGraphName left   GetAxisLabel(GraphName,"left",1)
	Label/W=$smthGraphName bottom GetAxisLabel(GraphName,"bottom",1)
	GPR()
End



####################################################################################################
//////////=====     Convert Waves [Transfar Y to NewX & Smoothing]    =====\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function ConvertWaves()
//define parameters
	Variable Nsmth
	Variable transMode, graphMode
	Variable w, Nw
	String   GraphName, newGraphName
	String   traceName
	String   srcYName, srcYSpec, srcXName, srcXSpec
	String   newYName, newYSpec, newXName, newXSpec
	String   refXName, refXSpec
//set parameters
	GraphName = WinName(0,1)
	Nsmth = 5
//input paramters
	Prompt GraphName, "select graph", popup, WinList("*", ";", "WIN:1")
	Prompt refXName, "select reference X wave", popup, "use srcX;"+WaveList("!*_y*",";","TEXT:0")
	Prompt Nsmth, "smoothing points"
	Prompt graphMode, "select trace mode", popup, " append to src graph; new graph;"
	DoPrompt "Smoothing Waves", GraphName, refXName, Nsmth, graphMode
//error handling
	if    (V_flag==1)
		Print "canceled by user"
		return -1
	elseif(Nsmth<0)
		DoAlert 0, "smoothing points is more than 0 point"
		Print "incorrect parameters"
		return -1
	endif
//set paramters
	Nw = CountWaves(GraphName)
	newGraphName = GraphName + "_Conv"
	if (stringmatch(refXName,"use srcX"))
		transMode = 0
		refXName = ""; refXSpec = ""
	else
		transMode = 1
		WAVE/D refX = $refXName; refXName = NameOfWave(refX); refXSpec = GetWavesDataFolder(refX,2)
	endif
//main program
	printf "%s (reference X wave : %s, smoothing : %g pnts)\r", GraphName, refXName, Nsmth
	if(graphMode!=1)
		Display/N=$newGraphName as newGraphName
	endif
	for(w=0; w<Nw; w+=1)
		traceName = TraceNameStr(GraphName,w)
		if(TraceStats(GraphName,traceName)!=0)
			continue
		endif
		WAVE/D srcY = TraceNameToWaveRef(GraphName,traceName)	; srcYName = NameOfWave(srcY); srcYSpec = GetWavesDataFolder(srcY,2)
		WAVE/D srcX = XWaveRefFromTrace(GraphName,traceName)	; srcXName = NameOfWave(srcX); srcXSpec = GetWavesDataFolder(srcX,2)
		ConvertYwave(srcYSpec,srcXSpec,refXSpec,Nsmth)
		if(transMode==0)
			newYName = srcYName + "_Conv"; WAVE/D newY = $newYName
			WAVE/D newX = srcX
		else
			newYName = srcYName + "_Conv"; WAVE/D newY = $newYName
			newXName = srcXName + "_Conv"; WAVE/D newX = $newXName
		endif
		if(graphMode==1)	//appned to src graph
			AppendToGraph/W=$GraphName newY vs newX
			//ModifyGraph offset($newYName)={0,10}
			ModifyGraph rgb($newYName)=(0,0,0)
		else				//new graph
			AppendToGraph/W=$newGraphName newY vs newX
		endif
	endfor
//modify new graph
	if(graphMode==2)
		Graph_Default(newGraphName)
		Legend/C/N=text0/A=LT
		Label/W=$newGraphName left   GetAxisLabel(GraphName,"left",1)
		Label/W=$newGraphName bottom GetAxisLabel(GraphName,"bottom",1)
		GPR()
	endif
End

####################################################################################################
//////////=====     Average Waves     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////////
//Average Waves [Point ave.]//
//////////////////////////////
Function AverageWaves_PntAve()
//define parameter
	Variable i, Nw			//origin wave num index
	Variable j, Np			//origin wave pnt index
	Variable k, N			//averae wave pnt index
	Variable mode, RevParameter
	String orgXStr, orgYStr
	String refXStr, refYStr
	String aveXStr, aveYStr
	String PrintData
//input mode
	Prompt mode "input mode", popup, " all; select;"
	DoPrompt "Average Waves [point ave.]", mode
	if (mode==1)		//all
		Nw = CountWaves("")
		Make/O/T/N=(Nw+1) orgYName, orgXName
		for (i=1; i<=Nw; i+=1)
			orgYStr = NameOfWave(WaveRefIndexed("",i-1,1))
			orgXStr = NameOfWave(XWaveRefFromTrace("",orgYStr))
			orgYName[i] = orgYStr
			orgXName[i] = orgXStr
		endfor
		printf "%s : all waves\r", WinName(0,1)
	elseif (mode==2)	//select
	//input number of waves
		Prompt Nw, "number of waves"
		DoPrompt "Average Waves [point ave.]", Nw
		if (V_flag==1)
			DoAlert 0,"Cancel"
			Print "Cancel"
			return -1
		endif
	//input reference wave
		Make/O/T/N=(Nw+1) orgYName, orgXName
		for (i=1; i<=Nw; i+=1)
			sprintf PrintData, "select wave ( %d/%d )", i, Nw
			Prompt orgYStr, PrintData, popup, WaveList("!*_x*",";","DIMS:1,WIN:")
			DoPrompt "Average Waves [point ave.]", orgYStr
			if (V_flag==1)
				DoAlert 0,"Cancel"
				Print "Cancel"
				KillWaves orgXName, orgYName
				return -1
			endif
			printf "%02d/%02d : %s\r", i, Nw, orgYStr
			orgXStr = XWaveName("",orgYStr)
			orgYName[i] = orgYStr
			orgXName[i] = orgXStr
		endfor
	endif
//input average wave
	sprintf aveYStr, "%s_y_ave", WinName(0,1)
	Prompt aveXStr, "select X wave", popup, WaveList("!*_y*",";","TEXT:0")
	Prompt aveYStr, "input Y wave name"
	DoPrompt "Average Waves [point ave.]", aveXStr, aveYStr
	if (V_flag==1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		KillWaves orgXName, orgYName
		return -1
	endif
	WAVE/D aveX = $aveXStr
	if (aveX[0]>aveX[1])
		Reverse_WaveOrder(aveXStr,aveXStr+"_rev")
		WAVE/D aveX = $(aveXStr+"_rev")
		RevParameter = 1
	endif
	N = numpnts(aveX)-1
	Make/D/O/N=(N+1) aveY
//order waves
	Make/O/T/N=(Nw+1) refYName, refXName
	for (i=1; i<=Nw; i+=1)
		WAVE orgX = $orgXName[i]
		WAVE orgY = $orgYName[i]
		if (orgX[0]<orgX[1])
			refXName[i] = NameOfWave(orgX)
			refYName[i] = NameOfWave(orgY)
		else
			Reverse_WaveOrder(NameOfWave(orgX),(NameOfWave(orgX)+"_rev"))
			Reverse_WaveOrder(NameOfWave(orgY),(NameOfWave(orgY)+"_rev"))
			refXName[i] = NameOfWave(orgX)+"_rev"
			refYName[i] = NameOfWave(orgY)+"_rev"
		endif
	endfor
//wave point number
	Make/O/N=(Nw+1) refWavePnt
	for (i=1; i<=Nw; i+=1)
		WAVE refX = $refXName[i]
		refWavePnt[i] = numpnts(refX)-1
	endfor
//move wave value to matrix
	WaveStats/Q refWavePnt
	Np = V_max
	Make/O/N=(Nw+1,Np+1) refXValue
	Make/O/N=(Nw+1,Np+1) refYValue
	for (i=1; i<=Nw; i+=1)
		Np = refWavePnt[i]
		for (j=0; j<=Np; j+=1)
			WAVE refX = $refXName[i]
			WAVE refY = $refYName[i]
			refXValue[i][j] = refX[j]
			refYValue[i][j] = refY[j]
		endfor
	endfor
//fromX wave
	Make/O/N=(N+2) fromX
	for (k=1; k<=N; k+=1)
		fromX[k] = (aveX[k-1]+aveX[k])/2
	endfor
	fromX[0] = aveX[0] - (fromX[1]-aveX[0])
	fromX[N+1] = aveX[N] + (aveX[N]-fromX[N])
//average waves
	Make/O/N=(N+1) avePntNum
	Make/O/N=(Nw+1,N+1) refPntNum
	for (k=0; k<=N; k+=1)
		for (i=1; i<=Nw; i+=1)
			Np = refWavePnt[i]
			for (j=0; j<=Np; j+=1)
				if (fromX[k]<=refXValue[i][j] && refXValue[i][j]<fromX[k+1])
					aveY[k] += (abs(refYValue[i][j]) >= 0) ? refYValue[i][j] : 0
					refPntNum[i][k] += (abs(refYValue[i][j]) >= 0) ? 1 : 0
				endif
			endfor
			avePntNum[k] += refPntNum[i][k]
		endfor
		aveY[k] = (avePntNum[k] != 0) ? aveY[k]/avePntNum[k] : NaN
	endfor
//reorder aveY wave
	if (RevParameter==1)
		Reverse_WaveOrder("aveY","aveY_rev")
		KillWaves aveX, aveY
		WAVE/D aveX = $aveXStr
		WAVE/D aveY = $("aveY_rev")
	endif
//append to graph
	AppendToGraph/W=$WinName(0,1) aveY vs aveX
	String aveYName = NameOfWave(aveY)
	ModifyGraph lsize($aveYName)=1.5, rgb($aveYName)=(0,0,0), lstyle($aveYName)=0
//kill waves
	for (i=1; i<=Nw; i+=1)
		WAVE orgX = $orgXName[i]
		WAVE orgY = $orgYName[i]
		if (orgX[0]>orgX[1])
			KillWaves $(NameOfWave(orgX)+"_rev")
			KillWaves $(NameOfWave(orgY)+"_rev")
		endif
	endfor
	KillWaves orgXName, orgYName
	KillWaves refXName, refYName, refXValue, refYValue, refWavePnt, refPntNum
	KillWaves fromX, avePntNum
//others
	Rename aveY, $aveYStr
	printf "average wave : %s vs %s\r", NameOfWave(aveY), NameOfwave(aveX)
End

/////////////////////////////////
//Average Waves [Integral ave.]//
/////////////////////////////////
Function AverageWaves_IntAve()
//define parameter
	Variable w, Nw
	Variable v, Nv
	Variable i, Np
	variable mode, RevParameter
	String orgYName, orgXName
	String aveYName, aveXName, aveName, ref_aveXName
	String PrintData
	String WindowName = WinName(0,1)
//input mode and read waves
	Prompt mode "input mode", popup, " all [only showing waves]; select;"
	DoPrompt "Average Waves [integral ave.]", mode
	if (V_flag==1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	if (mode==1)		//all [only showing waves]
		Nw = CountWaves_Trace(WindowName)
		Nv = CountWaves(WindowName)
		Make/O/T/N=(Nw+1) orgYNameList, orgXNameList
		w = 1
		for (v=1; v<=Nv; v+=1)
			orgYName = NameOfWave(WaveRefIndexed(WindowName,v-1,1))
			orgXName = NameOfWave(XWaveRefFromTrace(WindowName,orgYName))
			if (TraceStats(WindowName,orgYName)==0)
				orgYNameList[w] = orgYName
				orgXNameList[w] = orgXName
				printf "%02d/%02d : %s vs %s\r", w, Nw, orgYName, orgXName
				w += 1
			endif
		endfor
	elseif (mode==2)	//select
	//input number of waves
		Prompt Nw, "number of waves"
		DoPrompt "Average Waves [integral ave.]", Nw
		if (V_flag==1)
			DoAlert 0, "Cancel"
			Print "Cancel"
			return -1
		endif
	//input origin waves
		Make/O/T/N=(Nw+1) orgYNameList, orgXNameList
		for (w=1; w<=Nw; w+=1)
			sprintf PrintData, "select wave ( %d/%d )", w, Nw
			Prompt orgYName, PrintData, popup, WaveList("!*_x*",";","DIMS:1,WIN:")
			DoPrompt "Average Waves [integral ave.]", orgYName
			if (V_flag==1)
				DoAlert 0, "Cancel"
				Print "Cancel"
				KillWaves orgYNameList, orgXNameList
				return -1
			endif
			printf "%02d/%02d : %s vs %s\r", w, Nw, orgYName, orgXName
			orgXName = NameOfWave(XWaveRefFromTrace(WindowName,orgYName))
			orgYNameList[w] = orgYName
			orgXNameList[w] = orgXName
		endfor
	endif
//input average wave
	sprintf aveName, "%s_ave", WindowName
	Prompt ref_aveXName, "select X wave", popup, WaveList("!*_y*",";","TEXT:0")
	Prompt aveName, "input average wave name"
	DoPrompt "Average Waves [integral ave.]", ref_aveXName, aveName
	if (V_flag==1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		KillWaves orgYNameList, orgXNameList
		return -1
	endif
	Make/D/O aveX
	Duplicate/D/O $ref_aveXName, aveX
	if (aveX[0]>aveX[1])
		Reverse_WaveOrder("aveX","aveX")
	endif
	Np = numpnts(aveX)
	Make/D/O/N=(Np) aveY, avePntNum
//make orgXmax, orgXmin
	Make/D/O/N=(Nw+1) orgXmax, orgXmin
	for (w=1; w<=Nw; w+=1)
		WAVE orgX = $orgXNameList[w]
		WaveStats/Q orgX
		orgXmax[w] = V_max
		orgXmin[w] = V_min
	endfor
//make Xfrom, Xupto
	Make/D/O/N=(Np) Xfrom
	for (i=1; i<Np; i+=1)
		Xfrom[i] = (aveX[i-1]+aveX[i])/2
	endfor
	Xfrom[0] = aveX[0] - (Xfrom[1]-aveX[0])
	Make/D/O/N=(Np) Xupto
	for (i=0; i<(Np-1); i+=1)
		Xupto[i] = (aveX[i]+aveX[i+1])/2
	endfor
	Xupto[Np-1] = aveX[Np-1] + (aveX[Np-1]-Xupto[Np-2])	
//average waves
	for (i=0; i<Np; i+=1)
		for (w=1; w<=Nw; w+=1)
			WAVE orgY = $orgYNameList[w]
			WAVE orgX = $orgXNameList[w]
			if (Xfrom[i]<orgXmin[w])
				continue
			endif
			if (Xupto[i]>orgXmax[w])
				continue
			endif
			if (numtype(areaXY(orgX,orgY,Xfrom[i],Xupto[i]))==0)
				aveY[i] += areaXY(orgX,orgY,Xfrom[i],Xupto[i])/(Xupto[i]-Xfrom[i])
				avePntNum[i] += 1
			endif
		endfor
		aveY[i] = (avePntNum[i] != 0) ? aveY[i]/avePntNum[i] : NaN
	endfor
//others
	aveYName = aveName + "_y"
	aveXName = aveName + "_x"
	Rename aveY, $(aveYName)
	Rename aveX, $(aveXName)
	printf "average wave : %s vs %s\r", NameOfWave(aveY), NameOfwave(aveX)
//append to graph
	AppendToGraph/W=$WindowName aveY vs aveX
	ModifyGraph/W=$WindowName mode($aveYName)=4, rgb($aveYName)=(0,0,0), lsize($aveYName)=1.2, lstyle($aveYName)=0, marker($aveYName)=19, msize($aveYName)=2.0
//kill waves
	KillWaves orgYNameList, orgXNameList, orgXmax, orgXmin
	KillWaves Xfrom, Xupto, avePntNum
End

/////////////////////
//Average All Waves//
/////////////////////
Function AverageAllWaves(WindowName)
	String WindowName
	Variable N_waves, N_pnts
	Variable w, i
	String NewWaveYName
	if (strlen(WindowName) == 0)
		WindowName = WinName(0,1)
	endif
	WAVE WaveX = WaveRefIndexed(WindowName,0,2)
	N_waves = CountWaves(WindowName)
	N_pnts = numpnts(WaveX)
	Make/O/D/N=(N_pnts) NewWaveY, NumWaves
	for (w=0; w<N_waves; w+=1)
		WAVE WaveY = WaveRefIndexed(Windowname,w,1)
		for (i=0; i<N_pnts; i+=1)
			if (abs(WaveY[i])>=0)
				NewWaveY[i] += WaveY[i]
				NumWaves[i] += 1
			endif
		endfor
	endfor
	for (i=0; i<N_pnts; i+=1)
		NewWaveY[i] = (NumWaves[i] != 0) ? NewWaveY[i]/NumWaves[i] : NaN
	endfor
	sprintf NewWaveYName, "%s_y_ave", WindowName
	Rename NewWaveY, $NewWaveYName
	AppendToGraph/W=$WindowName NewWaveY vs WaveX
	ModifyGraph/W=$WindowName rgb($NewWaveYName)=(0,0,0)
	Printf "%s = average : %s\r", NewWaveYName, WindowName
	KillWaves NumWaves
End


/////////////////////////
//Average Showing Waves//
/////////////////////////
Function AverageShowingWaves(GraphName)
	String GraphName
	Variable N_allwaves, N_showingwaves, N_pnts
	Variable w, i
	String NewWaveYName, TraceName
	if (strlen(GraphName) == 0)
		GraphName = WinName(0,1)
	endif
	WAVE WaveX = WaveRefIndexed(GraphName,0,2)
	N_allwaves = countWaves(GraphName)
	N_showingwaves = CountWaves_Trace(GraphName)
	N_pnts = numpnts(WaveX)
	Make/O/D/N=(N_pnts) NewWaveY, NumWaves
	for (w=0; w<N_allwaves; w+=1)
		WAVE WaveY = WaveRefIndexed(GraphName,w,1)
		TraceName = TraceNameStr(GraphName,w)
		if (TraceStats(GraphName,TraceName)==0)
			for (i=0; i<N_pnts; i+=1)
				if (numtype(WaveY[i])==0)
					NewWaveY[i] += WaveY[i]
					NumWaves[i] += 1
				endif
			endfor
		endif
	endfor
	for (i=0; i<N_pnts; i+=1)
		NewWaveY[i] = (NumWaves[i] != 0) ? NewWaveY[i]/NumWaves[i] : NaN
	endfor
	sprintf NewWaveYName, "%s_y_ave", GraphName
	Rename NewWaveY, $NewWaveYName
	AppendToGraph/W=$GraphName NewWaveY vs WaveX
	ModifyGraph/W=$GraphName rgb($NewWaveYName)=(0,0,0)
	Printf "%s = average : %s\r", NewWaveYName, GraphName
	KillWaves NumWaves
End



####################################################################################################
//////////=====     Average & Smooth Waves     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

/////////////////////////////
//Average & Smoothing Waves//
/////////////////////////////
Function AverageSmoothWaves()
//define parameter
	Variable s, Ns	//number of src waves [chosen for average]
	Variable w, Nw	//number of all waves
	Variable i, Np	//number of data points in average X wave
	Variable Nsmth	//number of smoothing points
	variable mode	//wave input mode
	Variable srcAveValue
	String   GraphName, traceName
	String   srcYName, srcXName, srcYSpec, srcXSpec
	String   aveYName, aveXName, aveNameBody, refXName
	String   tmpStr
//input mode and read waves
	GraphName  = WinName(0,1)
	sprintf tmpStr, "average waves in \"%s\"  select input mode", GraphName
	Prompt mode , tmpStr, popup, " showing all waves; choose waves by oneself;"
	DoPrompt "Average & Smoothing Waves", mode
	if (V_flag==1)
		Print "canceled by user"
		return -1
	endif
	Nw = CountWaves(GraphName)
	Make/O/T/N=(Nw,2) WaveNameList
	if (mode==1)		//all
		for(w=0; w<Nw; w+=1)
			traceName = TraceNameStr(GraphName,w)
			srcYSpec  = GetWavesDataFolder(TraceNameToWaveRef(GraphName,traceName),2)
			srcXSpec  = GetWavesDataFolder(XWaveRefFromTrace(GraphName,traceName),2)
			if (TraceStats(GraphName,traceName)!=0)
				continue
			endif
			WaveNameList[s][0] = srcYSpec
			WaveNameList[s][1] = srcXSpec
			s += 1
		endfor
		Ns = CountWaves_Trace(GraphName)
	elseif (mode==2)	//choose
		for(w=0; w<=Nw; w+=1)
			sprintf tmpStr, "choose wave ( number of chosen waves : %d )\rIf end choice of waves, click cancel buttun.", s
			Prompt srcYName, tmpStr, popup, WaveList("!*_x*",";","DIMS:1,WIN:")
			DoPrompt "Average & Smoothing Waves", srcYName
			if    (V_flag==1 && w!=0)
				break
			elseif(V_flag==1 && w==0)
				KillWaves WaveNameList
				Print "canceled by user"
				return -1
			endif
			srcXName = NameOfWave(XWaveRefFromTrace(GraphName,srcYName))
			WaveNameList[s][0] = srcYName
			WaveNameList[s][1] = srcXName
			s += 1
		endfor
		Ns = s
	endif
//input average wave parameters
	sprintf aveNameBody, "%s_ave", GraphName
	Prompt refXName, "choose X wave", popup, WaveList("!*_y*",";","TEXT:0")
	Prompt aveNameBody,  "input average wave name body"
	Prompt Nsmth, "input smoothing points"
	DoPrompt "Average & Smoothing Waves", refXName, aveNameBody, Nsmth
	if (V_flag==1)
		KillWaves WaveNameList
		Print "canceled by user"
		return -1
	endif
	Nsmth = (Nsmth>0) ? Nsmth : 0.5
	Make/D/O aveX; Duplicate/D/O $refXName, aveX
	if (aveX[0]>aveX[inf])
		Reverse_WaveOrder("aveX","aveX")
	endif
	Np = numpnts(aveX)
	Make/D/O/N=(Np) aveY, avePntNum
//make Xfrom, Xupto
	Make/D/O/N=(Np) Xfrom, Xupto
	for(i=0; i<Np; i+=1)
		Xfrom[i] = aveX[i-Nsmth]
		Xupto[i] = aveX[i+Nsmth]
	endfor
//make srcXmax, srcXmin
	Make/D/O/N=(Nw) srcXmax, srcXmin
	for (s=0; s<Ns; s+=1)
		WAVE/D srcX = $WaveNameList[s][1]
		WaveStats/Q srcX
		srcXmax[s] = V_max
		srcXmin[s] = V_min
	endfor
//average waves
	for (i=0; i<Np; i+=1)
		for(s=0; s<Ns; s+=1)
			WAVE/D srcY = $WaveNameList[s][0]
			WAVE/D srcX = $WaveNameList[s][1]
			if (Xfrom[i]<srcXmin[s] || Xupto[i]>srcXmax[s])
				continue
			endif
			srcAveValue = faverageXY(srcX,srcY,Xfrom[i],Xupto[i])
			if (numtype(srcAveValue)==0)
				aveY[i] += srcAveValue
				avePntNum[i] += 1
			endif
		endfor
		aveY[i] = (avePntNum[i] != 0) ? aveY[i]/avePntNum[i] : NaN
	endfor
//others
	aveYName = aveNameBody + "_y"
	aveXName = aveNameBody + "_x"
	Rename aveY, $aveYName
	Rename aveX, $aveXName
//print note & histry
	sprintf tmpStr, "average wave : %s vs %s", aveYName, aveXName
	Note aveY, tmpStr; Note aveX, tmpStr
	Print tmpStr+"\r"
	if (Nsmth>0.5)
		sprintf tmpStr, "%d waves in %s, smoothing %d points", Ns, GraphName, 2*Nsmth
	else
		sprintf tmpStr, "%d waves in %s, no smoothing", Ns, GraphName		
	endif
	Note aveY, tmpStr; Note aveX, tmpStr
	Print tmpStr+"\r"
	for(s=0; s<Ns; s+=1)
		srcYName = WaveNameList[s][0]
		srcXName = WaveNameList[s][1]
		sprintf tmpStr, "%02d : %s vs %s", s+1, srcYName, srcXName
		Note aveY, tmpStr; Note aveX, tmpStr
		Print tmpStr+"\r"
	endfor
//append to graph
	AppendToGraph/W=$GraphName aveY vs aveX
	ModifyGraph/W=$GraphName mode($aveYName)=0, rgb($aveYName)=(0,0,0), lsize($aveYName)=1.2
//kill waves
	KillWaves WaveNameList, srcXmax, srcXmin, Xfrom, Xupto, avePntNum
End



####################################################################################################
//////////=====     Wave Analysis     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

/////////////////////////////
//Wave Infomation [General]//
/////////////////////////////
Function WaveInfomation_General()
//define parameters
	Variable Xfrom, Xupto, mode
	Variable Pfrom, Pupto, Pstart, Pend
	Variable w, N
	Variable csrApnt, csrBpnt
	Variable maxX, minX
	String   modeList
	string   areaStr, typeStr
	String   GraphName, TraceName
//set parameters
	GraphName = WinName(0,1)
	if (csrExists("A",GraphName)==1 && csrExists("B",GraphName)==1)
		WAVE xA = CsrXWaveRef(A,GraphName);	csrApnt = pcsr(A,GraphName)
		WAVE xB = CsrXWaveRef(B,GraphName);	csrBpnt = pcsr(B,GraphName)
		Xfrom = (xA[csrApnt]<xB[csrBpnt]) ? xA[csrApnt] : xB[csrBpnt]
		Xupto = (xA[csrApnt]<xB[csrBpnt]) ? xB[csrBpnt] : xA[csrApnt]
	endif
	mode=9	
	modeList = " 1 : average; 2 : standard deviation; 3 : sum; 4 : integral; 5 : max; 6 : maxX; 7 : min; 8 : minX; 0 : all"
//input parameter
	Prompt GraphName, "select graph", popup, WinList("*",";","WIN:1")
	Prompt mode , "select mode", popup, modeList
	Prompt Xfrom , "from (X value)"
	Prompt Xupto , "upto (X value)"
	DoPrompt "Wave Infomation [General]", GraphName, mode, Xfrom, Xupto
//error handling
	if    (V_flag==1)
		Print "canceled by user"
		return -1
	elseif(Xfrom>Xupto)
		DoAlert 0, "Xfrom is more than Xupto"
		Print "incorrect parameters"
		return -1
	endif
//print data
	if     (Xfrom==Xupto)
		sprintf areaStr "all area"
	else
		sprintf areaStr "%g - %g", Xfrom, Xupto
	endif
	if     (mode==1)
		sprintf typeStr "average" 
	elseif (mode==2)
		sprintf typeStr "standerd deviation"
	elseif (mode==3)
		sprintf typeStr "summation"
	elseif (mode==4)
		sprintf typeStr "integral"
	elseif (mode==5)
		sprintf typeStr "max"
	elseif (mode==6)
		sprintf typeStr "maxX"
	elseif (mode==7)
		sprintf typeStr "min"
	elseif (mode==8)
		sprintf typeStr "minX"
	else
		sprintf typeStr "all statistics"
	endif
	printf "%s : %s ( %s )\r", GraphName, typeStr, areaStr
//main program
	N = CountWaves(GraphName)
	for(w=0; w<N; w+=1)
		TraceName = TraceNameStr(GraphName,w)
		WAVE y = TraceNameToWaveRef(GraphName,TraceName)
		WAVE x = XWaveRefFromTrace(GraphName,TraceName)
	//range set up
		if (Xfrom==Xupto)
			Pfrom = 0
			Pupto = numpnts(x) - 1
		else
			Pfrom = BinarySearchInterp(x,Xfrom)
			Pupto = BinarySearchInterp(x,Xupto)
		endif
	//read data
		WaveStats/Q/R=[Pfrom,Pupto] y
		if (pnt2x(y,0)==0 && pnt2x(y,numpnts(y)-1)==numpnts(y)-1)	//y wave is not scaled.
			maxX = x[V_maxloc]; minX = x[V_minloc]
		else														//y wave is scaled.
			maxX = V_maxloc   ; minX = V_minloc
		endif
		if    (mode==1)
			Print V_avg
		elseif(mode==2)
			Print V_sdev
		elseif(mode==3)
			Print V_sum
		elseif(mode==4)
			Print areaXY(x,y,Xfrom,Xupto)
		elseif(mode==5)
			Print V_max
		elseif(mode==6)
			Print maxX
		elseif(mode==7)
			Print V_min
		elseif(mode==8)
			Print minX
		else
			printf "%s (%gpnts) average : %g , standard deviation : %g , summation : %g , integral : %g , max : %g , maxX : %g , min : %g , minX : %g\r", NameOfWave(y), V_npnts, V_avg, V_sdev, V_sum, areaXY(x,y,Xfrom,Xupto), V_max, maxX, V_min, minX
		endif
	endfor
End


///////////////////////
//WaveInfomation_Peak//
///////////////////////
Function PickupFWHM()
//define parameters
	Variable w, N
	Variable csrApnt, csrBpnt
	Variable Xfrom, Xupto, Pfrom, Pupto
	Variable Vmax , Vhalf, Ypeak, Yhalf, Ppeak, Speak
	Variable Xpeak, Xlow , Xhigh
	Variable FWHM , lHWHM, hHWHM
	Variable Ymax , Yo
	Variable order
	String   GraphName, TraceName
//set parameters
	GraphName = WinName(0,1)
	N = CountWaves(GraphName)
	if (csrExists("A",GraphName)==1 && csrExists("B",GraphName)==1)
		WAVE xA = CsrXWaveRef(A,GraphName);	csrApnt = pcsr(A,GraphName)
		WAVE xB = CsrXWaveRef(B,GraphName);	csrBpnt = pcsr(B,GraphName)
		Xfrom = (xA[csrApnt]<xB[csrBpnt]) ? xA[csrApnt] : xB[csrBpnt]
		Xupto = (xA[csrApnt]<xB[csrBpnt]) ? xB[csrBpnt] : xA[csrApnt]
	endif
//input parameters	
	Prompt GraphName, "select graph", popup, WinList("*",";","WIN:1")
	Prompt Xfrom , "from (X value)"
	Prompt Xupto , "upto (X value)"
	Prompt Yo, "input base line"
	DoPrompt "Wave Infomation [Peak]", GraphName, Xfrom, Xupto, Yo
//main program
	Print "Wave Name : Xpeak, Ypeak, Speak, FWHM, lowHWHM, highHWHM"
	for(w=0; w<N; w+=1)
		TraceName = TraceNameStr(GraphName,w)
		WAVE y = TraceNameToWaveRef(GraphName,TraceName)
		WAVE x = XWaveRefFromTrace(GraphName,TraceName)
		Pfrom = BinarySearchInterp(x,Xfrom)
		Pupto = BinarySearchInterp(x,Xupto)
		order = (Pfrom<Pupto) ? +1 : -1
	//find peak
		WaveStats/Q/R=[Pfrom,Pupto]/Z y
		Vmax  = V_max		; Vhalf = (V_max+Yo)/2	; Ppeak = V_maxloc
		Ypeak = Vmax - Yo	; Yhalf = Ypeak/2	;	 Xpeak = x[Ppeak]
	//cal. FWHM & Speak
		if (order==+1)
			FindLevel/P/Q/R=[Ppeak]   y, Vhalf; Xhigh = x[V_LevelX]
			FindLevel/P/Q/R=[Ppeak,0] y, Vhalf; Xlow  = x[V_LevelX]
		else
			FindLevel/P/Q/R=[Ppeak,0] y, Vhalf; Xhigh = x[V_LevelX]
			FindLevel/P/Q/R=[Ppeak]   y, Vhalf; Xlow  = x[V_LevelX]
		endif
		FWHM  = Xhigh - Xlow
		hHWHM = Xhigh - Xpeak
		lHWHM = Xpeak - Xlow
		Speak = areaXY(x,y,Xfrom,Xupto) - Yo*(Xupto-Xfrom)
	//print
		printf "%s :\t%g\t%g\t%g\t%g\t%g\t%g\r", TraceName, Xpeak, Ypeak, Speak, FWHM, lHWHM, hHWHM
	endfor
End



####################################################################################################
####################################################################################################

///////////////////
//Combine 3 Waves//
///////////////////
Function Combine3Waves()
//error handling
	String CsrAWaveStr, CsrBWaveStr
	CsrAWaveStr = CsrWave(A,"")
	CsrBWaveStr = CsrWave(B,"")
	if (strlen(CsrAWaveStr) == 0 && strlen(CsrBWaveStr) == 0)
		DoAlert 0, "Not select wave."
		Print "Cancel"
		return -1
	elseif (stringmatch(CsrAWaveStr,CsrBWaveStr)==0)
		DoAlert 0, "put cursor A and B on same wave."
		Print "Cancel"
		return -1
	endif
//input parameter
	String orgWave1yStr, orgWave3yStr, NewWaveStr
	NewWaveStr = WinName(0,1)
	prompt orgWave1yStr, "input low range wave", popup, WaveList("!*_x*",";","WIN:")
	prompt orgWave3yStr, "input high range wave", popup, WaveList("!*_x*",";","WIN:")
	prompt NewWaveStr, "input new wave name"
	doprompt "Combine 3 Waves", orgWave1yStr, orgWave3yStr, NewWaveStr
//error handling
	if(V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
//define wave name
	WAVE/Z orgWave1x = $XWaveName("",orgWave1yStr)
	WAVE/Z orgWave1y = $orgWave1yStr
	WAVE/Z orgWave2x = $XWaveName("",CsrAWaveStr)
	WAVE/Z orgWave2y = $CsrAWaveStr
	WAVE/Z orgWave3x = $XWaveName("",orgWave3yStr)
	WAVE/Z orgWave3y = $orgWave3yStr
//order waves
	if (orgWave1x[0]<orgWave1x[1])
		WAVE/Z Wave1x = $NameOfWave(orgWave1x)
		WAVE/Z Wave1y = $NameOfWave(orgWave1y)
	else
		Reverse_WaveOrder(NameOfWave(orgWave1x),(NameOfWave(orgWave1x)+"_rev"))
		Reverse_WaveOrder(NameOfWave(orgWave1y),(NameOfWave(orgWave1y)+"_rev"))
		WAVE/Z Wave1x = $(NameOfWave(orgWave1x)+"_rev")
		WAVE/Z Wave1y = $(NameOfWave(orgWave1y)+"_rev")
	endif
	if (orgWave2x[0]<orgWave2x[1])
		WAVE/Z Wave2x = $NameOfWave(orgWave2x)
		WAVE/Z Wave2y = $NameOfWave(orgWave2y)
	else
		Reverse_WaveOrder(NameOfWave(orgWave2x),(NameOfWave(orgWave2x)+"_rev"))
		Reverse_WaveOrder(NameOfWave(orgWave2y),(NameOfWave(orgWave2y)+"_rev"))
		WAVE/Z Wave2x = $(NameOfWave(orgWave2x)+"_rev")
		WAVE/Z Wave2y = $(NameOfWave(orgWave2y)+"_rev")
	endif
	if (orgWave3x[0]<orgWave3x[1])
		WAVE/Z Wave3x = $NameOfWave(orgWave3x)
		WAVE/Z Wave3y = $NameOfWave(orgWave3y)
	else
		Reverse_WaveOrder(NameOfWave(orgWave3x),(NameOfWave(orgWave3x)+"_rev"))
		Reverse_WaveOrder(NameOfWave(orgWave3y),(NameOfWave(orgWave3y)+"_rev"))
		WAVE/Z Wave3x = $(NameOfWave(orgWave3x)+"_rev")
		WAVE/Z Wave3y = $(NameOfWave(orgWave3y)+"_rev")
	endif
//set range
	variable Pfrom1, Pupto1, Pfrom2, Pupto2, Pfrom3, Pupto3
	if (orgWave2x[0]<orgWave2x[1])
		Pfrom2 = pcsr(A)
		Pupto2 = pcsr(B)
	else
		Pfrom2 = numpnts(orgWave2x)-1-pcsr(A)
		Pupto2 = numpnts(orgWave2x)-1-pcsr(B)
	endif
	variable Xa, Xb
	Xa = Wave2x[Pfrom2]
	Xb = Wave2x[Pupto2]
	Pfrom1 = 0
	Pupto1 = BinarySearch(wave1x, Xa)
	Pfrom3 = BinarySearch(wave3x, Xb)
	Pupto3 = numpnts(Wave3x)-1
//make new wave
	variable n1, n2, n3
	n1 = Pupto1-Pfrom1
	n2 = Pupto2-Pfrom2+1
	n3 = Pupto3-Pfrom3
	make/N=(n1+n2+n3) NewWavex
	make/N=(n1+n2+n3) NewWavey
	variable i
	for (i=0; i<=(n1-1); i+=1)
		NewWavex[i] = Wave1x[i]
		NewWavey[i] = Wave1y[i]
	endfor
	for (i=(n1); i<=(n1+n2-1); i+=1)
		NewWavex[i] = Wave2x[Pfrom2+i-n1]
		NewWavey[i] = Wave2y[Pfrom2+i-n1]
	endfor
	for (i=(n1+n2); i<=(n1+n2+n3-1); i+=1)
		NewWavex[i] = Wave3x[Pfrom3+i-(n1+n2-1)]
		NewWavey[i] = Wave3y[Pfrom3+i-(n1+n2-1)]
	endfor
//append to graph
	AppendToGraph NewWavey vs NewWavex
	ModifyGraph rgb(NewWavey)=(0,0,0), lsize(NewWavey)=1.2, lstyle(NewWavey)=7
//rename
	rename NewWavex $NewWaveStr + "_x"
	rename NewWavey $NewWaveStr + "_y"
//print data
	printf "%s = low:%s + middle:%s + high:%s\r" NameOfWave(NewWavex), NameOfWave(orgWave1x), NameOfWave(orgWave2x), NameOfWave(orgWave3x)
	printf "%s = low:%s + middle:%s + high:%s\r" NameOfWave(NewWavey), NameOfWave(orgWave1y), NameOfWave(orgWave2y), NameOfWave(orgWave3y)
//kill waves
	if (orgWave1x[0]>orgWave1x[1])
		KillWaves $NameOfWave(orgWave1x)+"_rev"
		KillWaves $NameOfWave(orgWave1y)+"_rev"
	endif
	if (orgWave2x[0]>orgWave2x[1])
		KillWaves $NameOfWave(orgWave2x)+"_rev"
		KillWaves $NameOfWave(orgWave2y)+"_rev"
	endif
	if (orgWave3x[0]>orgWave3x[1])
		KillWaves $NameOfWave(orgWave3x)+"_rev"
		KillWaves $NameOfWave(orgWave3y)+"_rev"
	endif
End



####################################################################################################
//////////=====     Read and Cassidy     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function Read_Cassidy()
//read experimental value
	String DataFolder = GetDataFolder(1)
	Variable BG, R, L, Xfrom, Xupto, Gfrom, Gupto
	BG = (numtype(GetParameter_Var("BG"))==0) ? GetParameter_Var("BG") : 108
	R = (numtype(GetParameter_Var("R"))==0) ? GetParameter_Var("R") : 0.5
	L = (numtype(GetParameter_Var("L"))==0) ? GetParameter_Var("L") : 500
	Xfrom = (numtype(GetParameter_Var("Xfrom"))==0) ? GetParameter_Var("Xfrom") : 1.56
	Xupto = (numtype(GetParameter_Var("Xupto"))==0) ? GetParameter_Var("Xupto") : 1.60
	Gfrom = (numtype(GetParameter_Var("Gfrom"))==0) ? GetParameter_Var("Gfrom") : -40
	Gupto = (numtype(GetParameter_Var("Gupto"))==0) ? GetParameter_Var("Gupto") : 10
//input parameters
	Variable mode, OriginMode, BGMode, GainMode
	Prompt mode, "select mode", popup, " 1 : Append to Active Window; 2 : New Window"
	Prompt BG, "background [count]"
	Prompt R, "reflectivity"
	Prompt L, "cavity length [um]"
	Prompt Xfrom, "Photon Energy range : from [eV]"
	Prompt Xupto, "Photon Energy range : upto [eV]"
	Prompt Gfrom, "Gain range : from [/cm]"
	Prompt Gupto, "Gain range : upto [/cm]"
	DoPrompt "Read and Cassidy", mode, BG, R, L, Xfrom, Xupto, Gfrom, Gupto
	if(V_flag==1)
		Print "canceled by user"
		return -1
	endif
	if (mode == 1)		//append to active window
		OriginMode = 0; BGMode = 0; GainMode = 0
	elseif (mode == 2)		//new window
		OriginMode = 0; BGMode = 1; GainMode = 1
	endif
//define parameters
	String WindowName, x, y
	Variable i, j
	if (mode==1)
		String ExistingBGWindowName = WinName(1,1)
		String ExistingGainWindowName = WinName(0,1)
		DoWindow/F $ExistingBGWindowName
		DoWindow/F $ExistingGainWindowName
	endif
//read wave -> make Origin Wave Window
	Variable readwavestat = ReadSPEFile_MainProc(0)
	if (readwavestat == -1)
		Print "canceled by user"
		return -1
	endif
	String OriginWindowName = WinName(0,1)
	String Originy = WaveName(OriginWindowName,0,1)
//background -> make BG Wave Window
	CorrectBGcount(OriginWindowName,BG)
	String BGWindowName = WinName(0,1)
	String BGy = WaveName(BGWindowName,0,1)
	Graph_WinSpec()
	ModifyGraph width=0, height=0
	ModifyGraph margin(left)=45, margin(bottom)=40, margin(top)=20, margin(right)=20
	ModifyGraph manTick(bottom)={0,0.01,0,2}, manMinor(bottom)={9,5}
	ModifyGraph manTick(left)={0,1,4,0}, manMinor(left)={9,5}
	SetAxis bottom Xfrom, Xupto
	ShowInfo
	Legend/C/N=text0/A=LT
	MoveWindow/W=$BGWindowName 380, 0, 740, 480
//Cassidy -> make Gain Wave Window
	Variable from, upto, step, min_limit
	from = 1
	upto = CountWaves(BGWindowName)
	step = 1			//default
	min_limit = 11	//default
	CassidySinFit_kf(from,upto,min_limit,L,R,step,BGWindowName,"")
	String GainWindowName = WinName(0,1)
	String Gainy = WaveName(GainWindowName,0,1)
	Graph_Gain("")
	DrawMirrorLossLine("",R,L)
	ModifyGraph width=0, height=0
	SetAxis bottom Xfrom, Xupto
	SetAxis left Gfrom, Gupto
	ShowInfo
	Legend/C/N=text0/A=LB
	MoveWindow/W=$GainWindowName 5, 0, 365, 240
//append to existing background graph
	if (BGMode == 0)
		Rainbow(ExistingBGWindowName,0,0)
		i = CountWaves(BGWindowName)
		for (j=0; j<i; j+=1)
			x = WaveName(BGWindowName,j,2)
			y = WaveName(BGWindowName,j,1)
			AppendTograph/W=$ExistingBGWindowName $y vs $x
			ModifyGraph/W=$ExistingBGWindowName rgb($y)=(0,0,0)
		endfor
		i = CountWaves(ExistingBGWindowName)
		ChangeOffset(ExistingBGWindowName,0,10000,0)
		for (j=2; j<=i; j+=1)
			SetDrawEnv/W=$ExistingBGWindowName ycoord = left, linefgc = (34816,34816,34816), dash = 3
			DrawLine/W=$ExistingBGWindowName 0,10000*(j-1),1,10000*(j-1)
		endfor
	endif
//append to existing gain graph
	if (GainMode == 0)
		Rainbow(ExistingGainWindowName,0,0)
		i = CountWaves(GainWindowName)
		for (j=0; j<i; j+=1)
			x = WaveName(GainWindowName,j,2)
			y = WaveName(GainWindowName,j,1)
			AppendToGraph/W=$ExistingGainWindowName $y vs $x
			ModifyGraph/W=$ExistingGainWindowName rgb($y)=(0,0,0), lsize($y)=1.2
		endfor
	endif
//kill wave and window
	if (OriginMode == 1) //Origin waves
	else
		i = CountWaves(OriginWindowName)
		killwindow $OriginWindowName
		if (i == 1)
			killwaves $Originy
		else
			for (j=0; j<i; j+=1)
				sprintf Originy, "%s_y%03d", OriginWindowName, j+1
				killwaves $Originy
			endfor
		endif
	endif
	if (BGMode == 0) //BG waves
		killwindow $BGWindowName
	elseif (BGMode == 1)
	else
		i = CountWaves(BGWindowName)
		killwindow $BGWindowName
		if (i == 1)
			killwaves $BGy
		else
			for (j=0; j<i; j+=1)
				sprintf BGy, "%s_y%03d_BG", BGWindowName, j+1
				killwaves $BGy
			endfor
		endif
	endif
	if (GainMode == 0) //Gain waves
		killwindow $GainWindowName
	elseif (GainMode == 1)
	else
		i = CountWaves(GainWindowName)
		killwindow $GainWindowName
		if (i == 1)
			killwaves $Gainy
		else
			for (j=0; j<i; j+=1)
				sprintf Gainy, "%s_y%03d_BG_gain", GainWindowName, j+1
				killwaves $Gainy
			endfor
		endif
	endif
End



####################################################################################################
####################################################################################################

/////////////////////////////
//Get CCD Back Ground Count//
/////////////////////////////
//(CCDのBGのデータの)SPEファイルを読み込み、waveの平均値を出すことでBG countを求める
//waveが複数あればすべてのwaveを平均する
//平均する際に、両端100pntsのデータは捨てる
Function GetBGcount()
	Variable N, pnts, BG, BGerror
	String WindowName, BGdata
	Variable ReadWaveStat = ReadSPEFile_MainProc(0)
	if (ReadWaveStat == -1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	WindowName = WinName(0,1)
	ChangeOffset(WindowName,0,5,0)
	AverageAllWaves(WindowName)
	N = CountWaves(WindowName)
	WAVE BGwave = WaveRefIndexed(WindowName,N-1,1)
	pnts = numpnts(BGwave)
	WaveStats/Q/R=[100,pnts-101] BGwave
	BG = V_avg;	BGerror = V_sdev
	sprintf BGdata, "CCD Back Gound count = %.3f +/- %.3f [count]", BG, BGerror
	TextBox/C/N=text0/A=LT BGdata
	print BGdata
End


####################################################################################################
####################################################################################################

Function UnitConvert()
//define parameters
	String   PanelName, PanelTitle
	Variable ConvCoefficient
//set paramters
	PanelName  = "UnitConverter"
	PanelTitle = "Unit Converter [eV - nm]"
	ConvCoefficient = 1239.5
//error handling
	KillVariables/Z eV, nm
	if (WindowExists(PanelName,0)==1)
		KillWindow $PanelName
	endif
//make panel
	Variable/G eV, nm
	eV = 1.58; nm = ConvCoefficient / eV
	NewPanel/W=(5,0,360,90)/K=1/N=$PanelName as PanelTitle
	SetVariable ctrl_eV title="Photon Energy [eV]", pos={10,10}, size={334,26}, bodyWidth=114, value=eV, limits={1.23950,9.99999,0.001}, format="%6.5f", font="Courier New", fSize=20, fstyle=1, proc=UnitConvert_SetVarProc
	SetVariable ctrl_nm title="Wave Length [nm]",   pos={34,50}, size={310,26}, bodyWidth=114, value=nm, limits={123.950,999.999,1.000}, format="%6.3f", font="Courier New", fSize=20, fstyle=1, proc=UnitConvert_SetVarProc
End

Function UnitConvert_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String   ctrlName
	Variable varNum
	String   varStr
	String   varName
//define parameters
	Variable ConvCoefficient = 1239.5
	NVAR     eV, nm
//main proc
	if    (stringmatch(ctrlName,"ctrl_eV"))
		nm = ConvCoefficient / eV
	elseif(stringmatch(ctrlName,"ctrl_nm"))
		eV = ConvCoefficient / nm
	endif
End


####################################################################################################
####################################################################################################

///////////////////////////////
//Append Graph to Other Graph//
///////////////////////////////
Function AppendGraph()
//define parameter
	Variable TraceMode, WinMode, YMode, XMode
	Variable i, N, j, N_trace, k
	String srcWinName, destWinName, yName
	String TraceList, PrintData
	srcWinName = WinName(1,1)
	destWinName = WInName(0,1)
	WinMode = 2
//input mode
	Prompt srcWinName, "source Window Name", popup, WinList("*",";","WIN:1")
	Prompt destWinName, "destination Window Name", popup, WinList("*",";","WIN:1")
	Prompt YMode, "Y Axis", popup, " 1 : left; 2 : right;"
	Prompt XMode, "X Axis", popup, " 1 : bottom; 2 : top;"
	Prompt TraceMode, "trace mode", popup, " 1 : all; 2 : only showing wave; 3 : select;"
	Prompt WinMode, "kill source graph", popup, " 1 : Yes; 2 : No;"
	DoPrompt "Append Graph to Other Graph", srcWinName, destWinName, YMode, XMode, TraceMode, WinMode
	if (V_flag==1)
		print "canceled by user"
		return -1
	endif
//make trace list
	N = CountWaves(srcWinName)
	Make/O/N=(N) AppendCheck
	if (TraceMode==1)			//all
		AppendCheck = 1
	elseif (TraceMode==2)		//only showing wave
		for (i=0 ;i<N; i+=1)
			yName = NameOfWave(WaveRefIndexed(srcWinName,i,1))
			if (TraceStats(srcWinName,yName)==0)
				AppendCheck[i] = 1
			endif
		endfor
	elseif (TraceMode==3)		//select mode
		Prompt N_trace, "number of waves"
		DoPrompt "Append to Other Graph", N_trace
		if (V_flag==1 || N_trace>CountWaves(srcWinName))
			DoAlert 0,"Cancel"
			Print "Cancel"
			KillWaves AppendCheck
			return -1
		endif
		TraceList = TraceNameList(srcWinName,";",1)
		for (j=1; j<=N_trace; j+=1)
			sprintf PrintData, "select wave ( %d/%d )", j, N_trace
			Prompt k, PrintData, popup, TraceList
			DoPrompt "Append to Other Graph", k
			if (V_flag==1)
				DoAlert 0,"Cancel"
				Print "Cancel"
				KillWaves AppendCheck
				return -1
			endif
			appendCheck[k-1] = 1
		endfor
	endif
//append to graph
	for (i=0; i<N; i+=1)
		if (AppendCheck[i]==1)
			WAVE y = WaveRefIndexed(srcWinName,i,1)
			WAVE x = XWaveRefFromTrace(srcWinName,NameOfWave(y))
			if     (YMode==1 && XMode==1)
				AppendToGraph/W=$destWinName y vs x
			elseif (YMode==2 && XMode==1)
				AppendToGraph/W=$destWinName/R y vs x
			elseif (YMode==1 && XMode==2)
				AppendToGraph/W=$destWinName/T y vs x
			elseif (YMode==2 && XMode==2)
				AppendToGraph/W=$destWinName/R/T y vs x
			endif
		endif
	endfor
//kill src window
	if (WinMode==1)
		KillWindow $srcWinName
	endif
//others
	KillWaves AppendCheck
End


////////////////////////////////
//Get Window Waves Data Folder//
////////////////////////////////
Function GetWinWavesDataFolder()
//define parameters
	Variable w, N, mode
	String WindowName, wvName, FolderPath, wvList
	WindowName = WinName(0,3)
	N = CountWaves(WindowName)
//main program
	Prompt mode, "mode", popup, " 1 : all; 2 : select;"
	DoPrompt "Get Window Waves Data Folder", mode
	if (V_flag == 1)
		Print "Cancel"
		return -1
	endif
	if (mode == 1)		//all
		printf "Window Name  %s\r", WindowName
		for (w=0; w<N; w+=1)
			WAVE wv = WaveRefIndexed(WindowName,w,1)
			wvName = NameOfWave(wv)
			FolderPath = GetWavesDataFolder(wv,1)
			printf " %02d %s -> %s\r", w+1, wvName, FolderPath[0,strlen(FolderPath)-2]
		endfor
	endif
	if (mode == 2)		//select
		wvList = ""
		for (w=0; w<N; w+=1)
			WAVE wv = WaveRefIndexed(WindowName,w,1)
			wvName = NameOfWave(wv)
			wvList += wvName + ";"
		endfor
		Prompt w, "select wave name", popup, wvList
		DoPrompt "Get Window Waves Data Folder", w
		if (V_flag == 1)
			Print "Cancel"
			return -1
		endif
		WAVE wv = WaveRefIndexed(WindowName,w,1)
		wvName = NameOfWave(wv)
		FolderPath = GetWavesDataFolder(wv,1)
		SetDataFolder FolderPath
		printf "Set Data Folder -> %s\r", FolderPath
	endif
End


//////////////////////
//Make X Wave Caller//
//////////////////////
Function Make_XWave_Caller()
	String WaveStr
	Variable from, upto, step, pnt, mode
	Prompt from, "from"
	Prompt upto, "upto"
	Prompt step, "step (input ether step or points)"
	Prompt pnt, "points (input ether step or points)"
	Prompt mode, "make table", popup, " 1: Yes; 2 : No"
	Prompt WaveStr, "input new X wave name"
	DoPrompt "Make X Wave", from, upto, step, pnt, WaveStr, mode
//error handling
	if (V_flag==1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	Make_XWave(WaveStr,from,upto,step,pnt)
	printf "%s : %g - %g , %g step, %g pnt\r", WaveStr, from, upto, step, pnt
	if (mode==1)
		WAVE XWave = $WaveStr
		Edit/K=1 XWave
	endif
End


Function ConvertYwave_Caller()
//define parameters
	String   srcYName, srcXName, destYName, destXName, destName
	Variable mode, ConvertMode, XwaveMode, graphSwitch
	Variable Xfrom, Xupto, Xstep
//input parameters
	Prompt XwaveMode, "use existing wave or new wave ?", popup, "1 : existing wave;2 : new wave;"
	DoPrompt "Convert Y wave", XwaveMode
	if    (XwaveMode==1)	//existing wave
		Prompt srcXName, "select source X wave.", popup, WaveList("*",";","")
		Prompt srcYName, "select source Y wave.", popup, WaveList("*",";","")
		Prompt destXName, "select destination X wave.", popup, WaveList("*",";","")
		Prompt destYName, "input destination Y wave name."
		Prompt ConvertMode, "select convert mode.", popup, "1 : interpolation;2 : integral;"
		Prompt graphSwitch, "make graph.", popup, "1 : Yes;2 : No;"
		DoPrompt "Convert Y wave", srcXName, srcYName, destXName, destYName, ConvertMode, graphSwitch
		mode = (ConvertMode==1) ? 0 : 1
		ConvertYwave_old(srcYName,srcXName,destYName,destXName,mode)
		if (graphSwitch==1)
			Display/K=1
			AppendToGraph  $srcYName vs  $srcXName
			AppendToGraph $destYName vs $destXName; ModifyGraph mode($destYName)=4, marker($destYName)=19, msize($destYName)=1.2, rgb($destYName)=(0,0,0)
			Graph_Default("")
		endif
	elseif(XwaveMode==2)	//new wave
		Prompt srcXName, "select source X wave.", popup, WaveList("*",";","")
		Prompt srcYName, "select source Y wave.", popup, WaveList("*",";","")
		Prompt Xfrom, "start X"
		Prompt Xupto, "end X"
		Prompt Xstep, "step X"
		Prompt destName, "destination wave name."
		Prompt ConvertMode, "select convert mode.", popup, "1 : interpolation;2 : integral;"
		Prompt graphSwitch, "make graph.", popup, "1 : Yes;2 : No;"
		DoPrompt "Convert Y wave", srcXName, srcYName, Xfrom, Xupto, Xstep, destName, ConvertMode, graphSwitch
		destXName = destName + "_x"
		destYName = destName + "_y"
		Make_XWave(destXName,Xfrom,Xupto,Xstep,0)
		mode = (ConvertMode==1) ? 0 : 1
		ConvertYwave_old(srcYName,srcXName,destYName,destXName,mode)
		if (graphSwitch==1)
			Display/K=1
			AppendToGraph  $srcYName vs  $srcXName
			AppendToGraph $destYName vs $destXName; ModifyGraph mode($destYName)=4, marker($destYName)=19, msize($destYName)=1.2, rgb($destYName)=(0,0,0)
			Graph_Default("")
		endif
	endif
End


//////////////////
//Kill All Items//
//////////////////
Function KillAllItems()
	DoAlert 1, "kill all items not in use"
	if (V_flag == 1)
		KillWaves/A/Z
		KillStrings/A/Z
		KillVariables/A/Z
	else
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
End


///////////////////////////////
//Kill Graph and Backup Waves//
///////////////////////////////
Function KillGraph_BackupWaves()
	String WindowName, YPath, XPath
	String srcDataFolderPath, destDataFolderPath, destDataFolderName
	Variable i, N
	WindowName = WinName(0,1)
	destDataFolderName = "OriginWaveData"
	Prompt WindowName, "Select Graph", popup, WinList("*", ";","WIN:1")
	Prompt destDataFolderName, "Input dest Data Folder"
	DoPrompt "Kill Graph and Buckup Waves", WindowName, destDataFolderName
	if (V_flag == 1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	srcDataFolderPath = GetDataFolder(1)
	destDataFolderPath = srcDataFolderPath + destDataFolderName
	N = CountWaves(WindowName)
//store wave name
	Make/O/T/N=(N) YPathList, XPathList
	for (i=0; i<N; i+=1)
		WAVE y = WaveRefIndexed(WindowName,i,1)
		WAVE x = XWaveRefFromTrace(WindowName,NameOfWave(y))
		YPathList[i] = GetWavesDataFolder(y,2)
		XPathList[i] = GetWavesDataFolder(x,2)
	endfor
	KillWindow $WindowName
//backup waves
	for (i=0; i<N; i+=1)
		YPath = YPathList[i]
		XPath = XPathList[i]
		BackupWaveData(YPath,destDataFolderPath)
		BackupWaveData(XPath,destDataFolderPath)
	endfor
	printf "%s -> %s\r", WindowName,destDataFolderPath
	KillWaves YPathList, XPathList
End



####################################################################################################
//////////=====     Graph <-> Table     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////
//Graph convert to Table//
//////////////////////////
Function graph2table()
//define parameter
	String GraphName, TableName
	Variable i, N
	GraphName = WinName(0,1)
	TableName = GraphName + "_to_table"
	N = CountWaves(GraphName)
//make table
	Edit/N=$TableName as TableName
	for(i=0; i<N; i+=1)
		WAVE waveY = WaveRefIndexed(GraphName,i,1)
		WAVE waveX = XWaveRefFromTrace(GraphName,NameOfWave(waveY))
		AppendToTable/W=$TableName waveX
		AppendToTable/W=$TableName waveY
	endfor
	printf "Graph : %s -> Table : %s\r", GraphName, TableName
End


//////////////////////////
//Table convert to Graph//
//////////////////////////
Function table2graph_Caller()
	Variable mode
	Prompt mode, "select mode", popup, " 1 : common X wave; 2 : incommon X wave" 
	DoPrompt "Table Convert to Graph", mode
	if (V_flag==1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	table2graph(mode)
End

Function table2graph(mode)
	Variable mode
//define parameter
	String GraphName, TableName
	Variable i, N
	TableName = WinName(0,2)
	GraphName = TableName + "_to_graph"
	N = CountWaves(TableName)
//make graph
	Display/N=$GraphName as GraphName
	if (mode == 1)		//common X wave
		WAVE waveX = WaveRefIndexed(TableName,0,1)
		for(i=1; i<N; i+=1)
			WAVE waveY = WaveRefIndexed(TableName,i,1)
			AppendToGraph/W=$GraphName waveY vs waveX
		endfor
	elseif (mode == 2)		//incommon X wave
		for(i=0; i<N;i+=2)
			WAVE waveX = WaveRefIndexed(TableName,i,1)
			WAVE waveY = WaveRefIndexed(TableName,i+1,1)
			AppendToGraph/W=$GraphName waveY vs waveX
		endfor
	endif
	Graph_Default(GraphName)
	printf "Table : %s -> Graph : %s\r", TableName, GraphName
End



####################################################################################################
//////////=====     Graph Operation     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

///////////////////
//Graph Operation//
///////////////////
Function GraphOperation()
//define parameters
	Variable a, w, N, waveMode, operationMode
	String GraphName, operationStr, noteStr
//input parameters
	GraphName = WinName(0,1)
	Prompt GraphName, "select graph", popup, WinList("*", ";", "WIN:1")
	Prompt waveMode, "y or x", popup, " y wave; x wave;"
	Prompt operationMode, "select operation", popup, " + ; - ; * ; / ;"
	Prompt a, "number"
	DoPrompt "Graph Operation", GraphName, waveMode, operationMode, a
	if (V_flag==1 || a==0)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
//main program
	N = CountWaves(GraphName)
	for (w=0; w<N; w+=1)
		if (waveMode==1)
			WAVE wv = WaveRefIndexed(GraphName,w,1)
		else
			WAVE wv = XWaveRefFromTrace(GraphName,NameOfWave(WaveRefIndexed(GraphName,w,1)))
		endif
		if    (operationMode==1)
			wv += a; operationStr = "+"
		elseif(operationMode==2)
			wv -= a; operationStr = "-"
		elseif(operationMode==3)
			wv *= a; operationStr = "*"
		elseif(operationMode==4)
			wv /= a; operationStr = "/"
		endif
		sprintf noteStr, "%s %s= %g", NameOfWave(wv), operationStr, a
		Note wv, noteStr
	endfor
//print
	if (waveMode==1)
		printf "%s : y wave %s= %g\r", GraphName, operationStr, a
	else
		printf "%s : x wave %s= %g\r", GraphName, operationStr, a
	endif
End



####################################################################################################
//////////=====     Cassidy Simulation     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function Make_FringeWave_Caller()
	String FringeWaveStr, XWaveStr
	Variable R, L, g, FSR
	Prompt R, "reflectance [geometric mean]"
	Prompt L, "cavity length [um]"
	Prompt g, "modal gain [/cm]"
	Prompt FSR, "Free Stectral Range [eV]"
	Prompt XWaveStr, "select X Wave [eV]", popup, WaveList("*",";","")
	Prompt FringeWaveStr, "input new Fringe Wave name"
	DoPrompt "Make Fringe Wave", R, L, g, FSR, XWaveStr, FringeWaveStr
//error handling
	if (V_flag==1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	Make_FringeWave(FringeWaveStr,XWaveStr,R,L,g,FSR)
End

Function Make_FringeWave(FringeWaveStr,XWaveStr,R,L,g,FSR)
//set parameter
	String FringeWaveStr	//normalized fringe wave
	String XWaveStr		//photon energy [eV]
	Variable R			//reflectance [geometric mean]
	Variable L			//cavity length [um]
	Variable g			//modal gain [/cm]
	Variable FSR			//Free Spectral Range [eV]
	WAVE/D XWave = $XWaveStr
	Duplicate/D/O XWave, FringeWave
	Variable i, N, E, S
	N = numpnts(XWave)
//main
	for (i=0; i<=(N-1); i+=1)
		E = R*exp(g*L/10^4)
		S = sin(Pi*XWave[i]/FSR)^2
		FringeWave[i] = (1-E)^2 / ((1-E)^2 + 4*E*S)
	endfor
	Display FringeWave vs XWave
	Graph_Default("")
	Rename FringeWave, $FringeWaveStr
	printf "%s : Xwave=%s, R=%g, L=%g[um], g=%g[/cm], FSR=%g[meV]\r", NameOfwave(FringeWave), NameOfWave(XWave), R, L, g, FSR*1000
End


	
Function Make_NoiseWave(NoiseWaveStr,a,b,c,d,e)
	String NoiseWaveStr
	Variable a, b, c, d, e
	Make/D/O/N=1340 NoiseWave
	NoiseWave = a*gnoise(b) + c*exp(-abs(enoise(1))/d) + e
	Rename NoiseWave, $NoiseWaveStr
	WAVE X_pixel
	Display NoiseWave vs X_pixel
End



Function Cassidy_Test()
	String XwaveStr, FwaveStr, AwaveStr, NwaveStr, IwaveStr
	Variable i, N, C
	Prompt XwaveStr, "X Wave", popup, WaveList("X_exp*",";","")
	Prompt FwaveStr, "Fringe Wave", popup, WaveList("exp_F*",";","")
	Prompt AwaveStr, "PLshape Wave", popup, WaveList("A*",";","")
	Prompt NwaveStr, "Noise Wave", popup, WaveList("N*",";","")
	Prompt IwaveStr, "input wave name"
	DoPrompt "Cassidy Test", XwaveStr, FwaveStr, AwaveStr, NwaveStr, IwaveStr
//error handling
	if (V_flag==1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	WAVE Xwave = $XwaveStr
	WAVE Fwave = $FwaveStr
	WAVE Awave = $AwaveStr
	WAVE Nwave = $NwaveStr
//make I wave
	N = numpnts(Xwave)
	Make/N=(N) Iwave
	Iwave = Fwave * Awave * Nwave
	WaveStats/Q Iwave
	C = 50000
	Iwave = round(C*Iwave) + round(gnoise(1.2))
	Rename Iwave, $IwaveStr
	printf "%s = X wave = %s, Fringe wave = %s, PL wave = %s, Noise wave = %s\r", NameOfWave(Iwave), NameOfWave(Xwave), NameOfWave(Fwave), NameOfWave(Awave), NameOfWave(Nwave)
	Display Iwave vs Xwave
	Graph_WinSpec()
//gain
	Cassidy_Caller()
End	



####################################################################################################
//////////=====     Matrix Operation     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////
//Display Matrix//
//////////////////
Function DisplayMatrix()
//define parameter
	String matXStr, matYStr, WindowName
	Variable i, mode, numXrow, numYrow, numXcol, numYcol
//input data
	Prompt mode, "select mode", popup, " 1 : New Window; 2 : Append to Active Window"
	Prompt matYStr, "Y matrix", popup, WaveList("*",";","DIMS:2")
	Prompt matXStr, "X matrix", popup, WaveList("*",";","DIMS:2")
	DoPrompt "Display Matrix", mode, matYStr, matXStr
	if (V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif	
//define matrix
	WAVE matX = $matXStr
	WAVE matY = $matYStr
	numXrow = DimSize(matX,0); numYrow = DimSize(matY,0)
	numXcol = DimSize(matX,1); numYcol = DimSize(matY,1)
//error handring
	if (V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
	if (numXrow != numYrow || numXcol != numYcol)
		DoAlert 0, "Cancel"
		print "Cancel"
		return -1
	endif
//main
	if (mode == 1)
		Prompt WindowName, "Window Name"
		DoPrompt "Display_Matrix", WindowName
		if (V_flag==1)
			DoAlert 0,"Cancel"
			Print "Cancel"
			return -1
		endif
		Display/N=$WindowName as WindowName
		for (i=0; i<numXrow; i+=1)
			AppendToGraph/W=$WindowName matY[i][] vs matX[i][]
		endfor
		Graph_Default("")
		Legend/C/N=text0/A=LT
		printf "Display : %s vs %s\r", matYStr, matXStr
	elseif (mode == 2)
		WindowName = WinName(0,1)
		for (i=0; i<numXrow; i+=1)
			AppendToGraph/W=$WindowName matY[i][] vs matX[i][]
		endfor
		printf "Apppend to %s : %s vs %s\r", WindowName, matYStr, matXStr
	endif
End

////////////////
//Devide Marix//
////////////////
Function DevideMatrix()
	String wvName, matName
	Variable rowNum, colNum, mode, i, j
	Prompt matName, "select matrix", popup, WaveList("*",";","DIMS:2")
	Prompt mode, "select mode", popup, " 1 : row; 2 : column"
	DoPrompt "Devide Matrix into Waves", matName, mode
	if (V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
	WAVE mat = $matName
	rowNum = DimSize(mat,0)
	colNum = DimSize(mat,1)
	if (mode==1)
		for (i=0; i<rowNum; i+=1)
			Make/O/N=(colNum) wv
			for (j=0; j<colNum; j+=1)
				wv[j] = mat[i][j]
			endfor
			sprintf wvName, "%s%02d", matName, i+1
			Rename wv, $wvName
		endfor
	elseif (mode==2)
		for (j=0; j<colNum; j+=1)
			Make/O/N=(rowNum) wv
			for (i=0; i<rowNum; i+=1)
				wv[i] = mat[i][j]
			endfor
			sprintf wvName, "%s%02d", matName, j+1
			Rename wv, $wvName
		endfor
	endif
End



####################################################################################################
//////////=====     Experimental Parameters     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

///////////////////////////////
//Set Experimental Parameters//
///////////////////////////////
Function SetParameters()
//get ready
	String   FolderName = "ExpParameters"
	String   currentDataFolder = GetDataFolder(1)
	String   ExpDate, ExpDateString
	Variable BG, R, L, Xfrom, Xupto, Gfrom, Gupto
	if (DataFolderExists(":"+FolderName) == 0)
		NewDataFolder/O/S :$FolderName
		String/G gStr_ExpDate, gStr_ExpDateString
		Variable/G gVar_BG, gVar_L, gVar_R, gVar_Xfrom, gVar_Xupto, gVar_Gfrom, gVar_Gupto
	else
		SetDataFolder :$FolderName
		SVAR gStr_ExpDate, gStr_ExpDateString
		NVAR gVar_BG, gVar_R, gVar_L, gVar_Xfrom, gVar_Xupto, gVar_Gfrom, gVar_Gupto
		ExpDate = gStr_ExpDate	; BG = gVar_BG
		R = gVar_R				; L = gVar_L
		Xfrom = gVar_Xfrom		; Xupto = gVar_Xupto
		Gfrom = gVar_Gfrom		; Gupto = gVar_Gupto
	endif
//input parameters
	Prompt ExpDate, "date (1988/01/14->880114)"
	Prompt BG, "background [count]"
	Prompt R, "reflectivity"
	Prompt L, "cavity length [um]"
	Prompt Xfrom, "Photon Energy range : from [eV]"
	Prompt Xupto, "Photon Energy range : upto [eV]"
	Prompt Gfrom, "Gain range : from [/cm]"
	Prompt Gupto, "Gain range : upto [/cm]"
	DoPrompt "Set Experimental Parameters", ExpDate, BG, R, L, Xfrom, Xupto, Gfrom, Gupto
//error handling
	if (V_flag==1)
		DoAlert 0,"Cancel"
		print "Cancel"
		SetDataFolder currentDataFolder
		return -1
	endif
	if (strlen(ExpDate) != 6)
		DoAlert 0,"please enter a 6-digit number into ''date''."
		SetDataFolder currentDataFolder
		return -1
	endif	
	if (Xfrom > Xupto)
		DoAlert 0,"please one more time\rX from < X upto"
		Print "Cancel"
		SetDataFolder currentDataFolder
		return -1
	endif
	if (Gfrom > Gupto)
		DoAlert 0,"please one more time\rG from < G upto"
		Print "Cancel"
		SetDataFolder currentDataFolder
		return -1
	endif
//set date
	Variable year = (str2num(ExpDate)<=500000) ? 20 : 19
	sprintf ExpDateString, "%s%s/%s/%s", num2istr(year), ExpDate[0,1], ExpDate[2,3], ExpDate[4,5]
//set parameters
	gStr_ExpDateString = ExpDateString
	gStr_ExpDate = ExpDate	; printf "date : %s\r", ExpDateString
	gVar_BG = BG			; printf "background : BG = %g [count]\r", BG
	gVar_R = R				; printf "reflectance : R = %g\r", R
	gVar_L = L				; printf "cavity length : L = %g [um]\r", L
	gVar_Xfrom = Xfrom		; printf "Photon Energy range : X from = %g [eV] (%*.*fnm)\r", Xfrom, 0, 1, 1239.5/Xfrom
	gVar_Xupto = Xupto		; printf "Photon Energy range : X upto = %g [eV] (%*.*fnm)\r", Xupto, 0, 1, 1239.5/Xupto
	gVar_Gfrom = Gfrom		; printf "Gain range : G from = %g [/cm]\r", Gfrom
	gVar_Gupto = Gupto		; printf "Gain range : G upto = %g [/cm]\r", Gupto
	SetDataFolder currentDataFolder
End

///////////////////////////////////////////
//Read Experimental Parameters [Variable]//
///////////////////////////////////////////
Function   GetParameter_Var(ParameterName)
	String ParameterName
	String FolderName = "ExpParameters"
	String currentDataFolderPath = GetDataFolder(1)
	if (DataFolderExists(":"+FolderName) == 1)
		SetDataFolder :$FolderName
	else
		SetDataFolder root:
		if (DataFolderExists(":"+FolderName) == 1)
			SetDataFolder :$FolderName
		else
			SetDataFolder currentDataFolderPath
			return NaN
		endif
	endif
	NVAR gVar = $("gVar_"+ParameterName)
	SetDataFolder currentDataFolderPath
	return gVar
End

/////////////////////////////////////////
//Read Experimental Parameters [String]//
/////////////////////////////////////////
Function/S GetParameter_Str(ParameterName)
	String ParameterName
	String FolderName = "ExpParameters"
	String currentDataFolderPath = GetDataFolder(1)
	if (DataFolderExists(":"+FolderName) == 1)
		SetDataFolder :$FolderName
	else
		SetDataFolder root:
		if (DataFolderExists(":"+FolderName) == 1)
			SetDataFolder :$FolderName
		else
			SetDataFolder currentDataFolderPath
			return ""
		endif
	endif
	SVAR gStr = $("gStr_"+ParameterName)
	SetDataFolder currentDataFolderPath
	return gStr
End



####################################################################################################
//////////=====     Delete Point     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////////////
//Delete Point [by using cursor]//
//////////////////////////////////
Function DeletePoint_Csr()
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
		Rename dely, $delyName
		ReplaceWave trace=$yName, $delyName
		BackupWaveData(yName,":OriginWaveData")
	else
		Duplicate/O dely, y
		KillWaves dely
	endif
End

////////////////////////////////////
//Delete Point [edge of all waves]//
////////////////////////////////////
Function DeletePoint_AllEdge()
	Variable i, j, Nw, Np, Pstart, Pend, xoffset, yoffset
	String WindowName, NewWindowName, yName, delyName
	Prompt Pstart, "Delete Point Number [start]"
	Prompt Pend, "Delete Point Number [end]"
	DoPrompt "Delete Point [edge of all waves]", Pstart, Pend
	if (V_flag==1)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	WindowName = WinName(0,1)
	Nw = CountWaves(WindowName)
	for (i = 0; i<Nw; i+=1)
		WAVE y = WaveRefIndexed(WindowName,i,1)
		WAVE x = XWaveRefFromTrace(WindowName,NameOfWave(y))
		Np = numpnts(x)
		yName = NameOfWave(y)
		Make/N=(Np) dely
		Duplicate/O y, dely
		for (j=0; j<=Pstart; j+=1)
			dely[j] = NaN
		endfor
		for (j=Np-Pend; j<=Np; j+=1)
			dely[j] = NaN
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
	endfor
	printf "%s : delete strat %gpnts, end %gpnts\r", WindowName, Pstart, Pend
End



####################################################################################################
//////////=====     Solve Quantum Well (carrier and opt)     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

/////////////////////////////////////
//QW carrier solve AlGaAs stracture//
/////////////////////////////////////
Function QWsolve_carrierAlGaAs(x_left,x_right,x_center,W,m,T,bandType,stateIndex)
	Variable x_left		//Al ratio (left   region) [nondimension]
	Variable x_right	//Al ratio (right  region) [nondimension]
	Variable x_center	//Al ratio (center region) [nondimension]
	Variable W			//length of center region [nm]
	Variable m			//effective mass (ratio of electron mass) [nondimension]
	Variable T			//temperature [K]
	String   bandType	//band type ("CB" or "VB")
	Variable stateIndex	//state index (0:ground state, 1:1st excited state, ...)
//error handling
	if (x_center<0 || x_center>1 || x_left<0 || x_left>1 || x_right<0 || x_right>1)
		Variable/G stateNum = 0
		return 0
	endif
	if (T<0)
		Variable/G stateNum = 0
		return 0
	endif
	if (!stringmatch(bandType,"CB") && !stringmatch(bandType,"VB"))
		Variable/G stateNum = 0
		return 0
	endif
//define parameters
	Variable V_left, V_right, V_center
	Variable deltaEc, deltaEv
//set patrameters
	deltaEc = 0.65		//conduction band GaAs/AlGaAs hetero junction energy gap (ratio)
	deltaEv = 0.35		//valence    band GaAs/AlGaAs hetero junction energy gap (ratio)
	if    (stringmatch(bandType,"CB"))
		V_left   = (AlGaAsBandGap(x_left  ,T)-AlGaAsBandGap(0,T))*deltaEc	//V=0 : GaAs(Al:0%) conduction band bottom energy
		V_right  = (AlGaAsBandGap(x_right ,T)-AlGaAsBandGap(0,T))*deltaEc
		V_center = (AlGaAsBandGap(x_center,T)-AlGaAsBandGap(0,T))*deltaEc
	elseif(stringmatch(bandType,"VB"))
		V_left   = (AlGaAsBandGap(x_left  ,T)-AlGaAsBandGap(0,T))*deltaEv	//V=0 : GaAs(Al:0%) valence    band top    energy
		V_right  = (AlGaAsBandGap(x_right ,T)-AlGaAsBandGap(0,T))*deltaEv
		V_center = (AlGaAsBandGap(x_center,T)-AlGaAsBandGap(0,T))*deltaEv
	endif
//main program
	QWsolve_carrierEnergy(V_left,V_right,V_center,W,m,stateIndex)
End

/////////////////////////////////
//QW opt solve AlGaAs stracture//
/////////////////////////////////
Function QWsolve_optAlGaAs(x_left,x_right,x_center,W,E,T,stateIndex)
	Variable x_left		//Al ratio (left   region) [nondimension]
	Variable x_right	//Al ratio (right  region) [nondimension]
	Variable x_center	//Al ratio (center region) [nondimension]
	Variable W			//length of center region [nm]
	Variable E			//photon energy [eV]
	Variable T			//temperature [K]
	Variable stateIndex	//state index (0:ground state, 1:1st excited state, ...)
//error handling
	if (x_center<0 || x_center>1 || x_left<0 || x_left>1 || x_right<0 || x_right>1)
		Variable/G stateNum = 0
		return 0
	endif
	if (T<0)
		Variable/G stateNum = 0
		return 0
	endif
//define and set parameters
	Variable n_left, n_right, n_center
	n_left   = AlGaAsRefractiveIndex(x_left  ,E)
	n_right  = AlGaAsRefractiveIndex(x_right ,E)
	n_center = AlGaAsRefractiveIndex(x_center,E)
//main program
	QWsolve_optRefIndex(n_left,n_right,n_center,W,E,stateIndex)
End

/////////////////////////////////////
//QW carrier solve potential energy//
/////////////////////////////////////
Function QWsolve_carrierEnergy(V_left,V_right,V_center,W,m,stateIndex)
	Variable V_left		//potential (left   region) [eV]
	Variable V_right	//potential (right  region) [eV]
	Variable V_center	//potential (center region) [eV]
	Variable W			//length of center region [nm]
	Variable m			//effective mass (ratio of electron mass) [nondimension]
	Variable stateIndex	//state index (0:ground state, 1:1st excited state, ...)
//error handling
	if (m<=0)
		Variable/G stateNum = 0
		return 0
	endif
//define parameters
	Variable Vr_left, Vr_right
	Variable Emass, ch, CF
//set parameters
	ch       = PhysicalConstants("c*h_bar")				//speed of light * Dirac constant [eV*nm]
	Emass    = PhysicalConstants("E_mass")				//electron rest mass energy [eV]
	CF       = (2*m*Emass)/ch^2							//conversion factor [1/(eV*nm^2)]
	Vr_left  = (CF*V_left ) - (CF*V_center)				//"reduced" potential (left ) [1/nm^2]
	Vr_right = (CF*V_right) - (CF*V_center)				//"reduced" potential (right) [1/nm^2]
//main program
	QWsolve_ReducedPotential(Vr_left,Vr_right,W,stateIndex)
	WAVE WaveFunc; NVAR EigenValue, stateNum
	Variable/G EigenEnergy
	if (stateNum!=0)	//exist bound state
		EigenEnergy = EigenValue/CF + V_center
	else				//exist bound state
		EigenEnergy = NaN
	endif
//others
	KillVariables/Z EigenValue
End

/////////////////////////////////
//QW opt solve refractive index//
/////////////////////////////////
Function QWsolve_optRefIndex(n_left,n_right,n_center,W,E,stateIndex)
	Variable n_left		//refractive index (left   region) [nondimension]
	Variable n_right	//refractive index (right  region) [nondimension]
	Variable n_center	//refractive index (center region) [nondimension]
	Variable W			//length of center region [nm]
	Variable E			//photon energy [eV]
	Variable stateIndex	//state index (0:ground state, 1:1st excited state, ...)
//error handling
	if (E<=0)
		Variable/G stateNum = 0
		return 0
	endif
//define parameters
	Variable Vr_left, Vr_right
	Variable ch, CF
//set parameters
	ch       = PhysicalConstants("c*h_bar")				//speed of light * Dirac constant [eV*nm]
	CF       = E^2/ch^2									//conversion factor [1/nm^2]
	Vr_left  = (-1*CF*n_left ^2) - (-1*CF*n_center^2)	//"reduced" potential (left ) [1/nm^2]
	Vr_right = (-1*CF*n_right^2) - (-1*CF*n_center^2)	//"reduced" potential (right) [1/nm^2]
//main program
	QWsolve_ReducedPotential(Vr_left,Vr_right,W,stateIndex)
	WAVE WaveFunc; NVAR EigenValue, stateNum
	Variable/G effRefIndex
	if (stateNum!=0)	//exist bound state
		effRefIndex = (n_center^2 - EigenValue/CF)^(0.5)
	else				//not exist bound state
		effRefIndex = NaN
	endif
//others
	KillVariables/Z EigenValue
End


//////////////////////////////
//Solve QW Reduced Potential//
//////////////////////////////
Function QWsolve_ReducedPotential(Vr_left,Vr_right,W,stateIndex)
	Variable Vr_left	//"reduced" potential (left  region) [1/Length^2]
	Variable Vr_right	//"reduced" potential (rught region) [1/Length^2]
	Variable W			//length of center region [Length]
	Variable stateIndex	//state index (0:ground state, 1:1st excited state, ...)
//define parameters
	Variable L, koL, kpL, kqL
	Variable ko, kp, kq, x, delta, Cp, Cq
	Variable koLmax, koLmin, Xmax, Xmin, Pleft, Pright
	Variable i, stepNum, pntNum
//error handling (W,stateIndex)
	if (W<=0 || stateIndex<0)
		Variable/G stateNum = 0
		return 0
	endif
//set paramters
	stateIndex = (mod(stateIndex,1)==0) ? stateIndex : round(stateIndex)
	L      = W/2
	Xmin   = -50*L
	Xmax   = +50*L
	pntNum = 5000*(stateIndex+1)
	Pleft  = (-L-Xmin)/(Xmax-Xmin)*pntNum
	Pright = (+L-Xmin)/(Xmax-Xmin)*pntNum
//error handling (Vr_left,Vr_right)
	if (Vr_left<=0 || Vr_right<=0)	//not exist bound state
		Make/D/O/N=(pntNum+1) WaveFunc = 0  ;  SetScale/I x, Xmin, Xmax, WaveFunc
		Variable/G EigenValue = NaN
		Variable/G stateNum   = 0
		return 0
	endif
//set parameters (for testWave)
	koLmin  = 0
	koLmax  = (min(Vr_left,Vr_right)*L^2)^(0.5)
	stepNum = (koLmax<1) ? 1000 : 1000*round(koLmax)
//make waves and variable
	Make/D/O/N=(stepNum)  testWave
	Make/D/O/N=(pntNum+1) tempWave
	Make/D/O/N=(pntNum+1) WaveFunc
	Variable/G EigenValue
	Variable/G stateNum
//derive ko, kp, kq
	SetScale/P x, koLmin, (koLmax-koLmin)/stepNum, testWave
	for(i=0; i<stepNum; i+=1)
		koL = pnt2x(testWave,i)
		kpL = (Vr_left *L^2-koL^2)^(0.5)
		kqL = (Vr_right*L^2-koL^2)^(0.5)
		testWave[i] = (kpL-koL*tan(koL))*(koL+kqL*tan(koL))+(kqL-koL*tan(koL))*(koL+kpL*tan(koL))
	endfor
	FindLevels/Q/R=[1] testWave, 0  ;  WAVE W_FindLevels
	stateNum = V_LevelsFound
	if    (stateNum==0)				//not exist bound state
		WaveFunc   = 0  ;  SetScale/I x, Xmin, Xmax, WaveFunc
		EigenValue = NaN
		KillWaves/Z testWave, tempWave, W_FindLevels
		return 0
	elseif(stateIndex>stateNum-1)	//not exist "stateIndex"th bound state
		WaveFunc   = 0  ;  SetScale/I x, Xmin, Xmax, WaveFunc
		EigenValue = NaN
		KillWaves/Z testWave, tempWave, W_FindLevels
		return 0
	endif
	koL = W_FindLevels[stateIndex]    ;  ko = koL/L
	kpL = (Vr_left *L^2-koL^2)^(0.5)  ;  kp = kpL/L
	kqL = (Vr_right*L^2-koL^2)^(0.5)  ;  kq = kqL/L
//derive delta, Cp, Cq
	delta = (mod(stateIndex,2)==0) ? (atan(kp/ko)-atan(kq/ko))/2 : (atan(kp/ko)-atan(kq/ko))/2+Pi/2
	Cp = exp(kpL)*cos(ko*L+delta)
	Cq = exp(kqL)*cos(ko*L-delta)
//derive wave function and eigen value
	SetScale/I x, Xmin, Xmax, WaveFunc
	for(i=0; i<Pleft; i+=1)			//left   region
		x = pnt2x(WaveFunc,i)
		WaveFunc[i] = Cp*exp(+kp*x)
	endfor
	for(i=Pleft; i<=Pright; i+=1)	//center region
		x = pnt2x(WaveFunc,i)
		WaveFunc[i] = cos(ko*x-delta)
	endfor
	for(i=Pright+1; i<=pntNum; i+=1)	//right  region
		x = pnt2x(WaveFunc,i)
		WaveFunc[i] = Cq*exp(-kq*x)
	endfor
	tempWave   = WaveFunc^2  ;  WaveStats/Q tempWave
	WaveFunc  /= (W*V_sum)^(0.5)
	EigenValue = ko^2
//others
	KillWaves/Z testWave, tempWave, W_FindLevels
End



####################################################################################################
//////////=====     Quantum Well carrier calcularion     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////////
//QW carrier [AlGaAs] Caller//
//////////////////////////////
Function QWcarrierAlGaAs_Caller()
End

///////////////////////////////
//QW carrier [AlGaAs] Grapher//
///////////////////////////////
Function QWcarrierAlGaAs_Grapher()
End

/////////////////////////////////////////
//QW carrier [AlGaAs] Set Variable Proc//
/////////////////////////////////////////
Function QWcarrierAlGaAs_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String   ctrlName
	Variable varNum			// value of variable as number
	String   varStr			// value of variable as string
	String   varName		// name of variable
End


//////////////////////////////
//QW carrier [energy] Caller//
//////////////////////////////
Function QWcarrierEnergy_Caller()
//define parameters
	String   FolderName, FolderPath, currentFolder
	String   GraphName, PanelName
//set parameters
	currentFolder = GetDataFolder(1)
	FolderName = "QWcarrierEnergy"
	FolderPath = "root:"+FolderName
	GraphName  = "QWcarrierEnergy"
	PanelName  = "QWcarrierEnergy_Panel"
//error handling
	if (WindowExists(GraphName,0)==1)
		KillWindow $GraphName
	endif
	if (WindowExists(PanelName,0)==1)
		KillWindow $PanelName
	endif
	if (DataFolderExists(FolderName))
		KilldataFolder FolderName
	endif
//make folder and variables
	NewDataFolder/O/S $FolderPath
	Variable/G V_left, V_right, V_center, W, m, stateIndex
	Variable/G V_left_meV, V_right_meV, V_center_meV
	V_left_meV   = 200  ;  V_left   = V_left_meV   * 10^(-3)
	V_right_meV  = 100  ;  V_right  = V_right_meV  * 10^(-3)
	V_center_meV =   0  ;  V_center = V_center_meV * 10^(-3)
	W            =  10
	m            =   0.0665
	stateIndex   =   0
//make panel
	NewPanel/N=$PanelName as PanelName
	SetVariable ctrl_V_left_meV		, title="V left  [meV]"	, pos={ 10,10}, size={133,18}, bodyWidth= 59, value=$(FolderPath+":V_left_meV")		, format="%5.1f", limits={-999.9,+999.9, 10.0}	, font="Courier New", fsize=12, proc=QWcarrierEnergy_SetVarProc 
	SetVariable ctrl_V_right_meV	, title="V right [meV]"	, pos={200,10}, size={133,18}, bodyWidth= 59, value=$(FolderPath+":V_right_meV")	, format="%5.1f", limits={-999.9,+999.9, 10.0}	, font="Courier New", fsize=12, proc=QWcarrierEnergy_SetVarProc 
	SetVariable ctrl_W				, title="width [nm]"	, pos={ 10,40}, size={133,18}, bodyWidth= 59, value=$(FolderPath+":W")				, format="%5.1f", limits={   0.1,  99.9,    1}	, font="Courier New", fsize=12, proc=QWcarrierEnergy_SetVarProc 
	SetVariable ctrl_m				, title="mass ratio"	, pos={200,40}, size={133,18}, bodyWidth= 59, value=$(FolderPath+":m")				, format="%5.4f", limits={0.0001,9.9999,0.001}	, font="Courier New", fsize=12, proc=QWcarrierEnergy_SetVarProc 
	SetVariable ctrl_V_center_meV	, title="V center [meV]", pos={ 10,70}, size={133,18}, bodyWidth= 59, value=$(FolderPath+":V_center_meV")	, format="%5.1f", limits={-999.9,+999.9, 10.0}	, font="Courier New", fsize=12, proc=QWcarrierEnergy_SetVarProc 
	SetVariable ctrl_stateNum		, title="state index"	, pos={200,70}, size={133,18}, bodyWidth= 59, value=$(FolderPath+":stateIndex")		, format="%2.0f", limits={     0,    99,    1}	, font="Courier New", fsize=12, proc=QWcarrierEnergy_SetVarProc 
//main program
	QWsolve_carrierEnergy(V_left,V_right,V_center,W,m,stateIndex)
	WAVE WaveFunc; NVAR EigenEnergy, stateNum
	Duplicate/O WaveFunc, Density  ;  Density = WaveFunc^2
	Variable/G  EigenEnergy_meV = EigenEnergy * 10^(+3)
//make graph
	QWcarrierEnergy_Grapher(V_left_meV,V_right_meV,V_center_meV,W,NameOfWave(Density),EigenEnergy_meV,GraphName)
	SetAxis/W=$GraphName bottom -2*W, +2*W
	ModifyGraph margin(left)=35, margin(bottom)=35, margin(top)=15, margin(right)=25
	Label right  "\\Z12Probability Density (nm\\S-1\\M\\Z12)"
	Label left   "\\Z12Potential (meV)"
	Label bottom "\\Z12Position (nm)"
//others
	SetDataFolder currentFolder
End

//////////////////////
//QW carrier Grapher//
//////////////////////
Function QWcarrierEnergy_Grapher(V_left,V_right,V_center,W,wvName,EigenEnergy,GraphName)
	Variable V_left, V_right, V_center, W, EigenEnergy
	String   wvName, GraphName
//define parameters
	Variable pntNum, Pleft, Pright, i
	Variable Xmin, Xmax, Xstep, YLmax, YLmin, YRmax, YRmin
//set parameters
	WAVE wv = $wvName  ;  WaveStats/Q wv
	pntNum = numpnts(wv)-1
	Xmax = pnt2x(wv,pntNum)
	Xmin = pnt2x(wv,0)
	Xstep = (Xmax-Xmin)/pntNum
	Pleft  = x2pnt(wv,-W/2)
	Pright = x2pnt(wv,+W/2)
	YLmin = V_center            - (max(V_left,V_right)-V_center)*(5/90)
	YLmax = max(V_left,V_right) + (max(V_left,V_right)-V_center)*(5/90)
	YRmin = +V_max/(0.95-(EigenEnergy-YLmin)/(YLmax-YLmin))*(0.00-(EigenEnergy-YLmin)/(YLmax-YLmin))
	YRmax = +V_max/(0.95-(EigenEnergy-YLmin)/(YLmax-YLmin))*(1.00-(EigenEnergy-YLmin)/(YLmax-YLmin))
//make potential wave
	Make/O/N=(pntNum) QWshape, stateLevel
	SetScale/P x, Xmin, Xstep, QWshape, stateLevel
	for (i=0; i<Pleft; i+=1)
		QWshape[i] = V_left
	endfor
	for (i=Pleft; i<Pright; i+=1)
		QWshape[i] = V_center
	endfor
	for (i=Pright; i<=pntNum; i+=1)
		QWshape[i] = V_right
	endfor
	stateLevel = EigenEnergy
//make graph
	if (WindowExists(GraphName,0)==0)
		Display/N=$GraphName as GraphName
		AppendToGraph/L QWshape, stateLevel
		AppendToGraph/R wv
	endif
	ModifyGraph mode($NameOfWave(QWshape))=6, rgb($NameOfWave(QWshape))=(0,0,0), lsize($NameOfWave(QWshape))=1.5
	ModifyGraph rgb($NameOfWave(stateLevel))=(34816,34816,34816)
	SetAxis left  YLmin, YLmax
	SetAxis right YRmin, YRmax
	ModifyGraph font(bottom)="Arial", fSize(bottom)=10
	ModifyGraph standoff=0, tick=2, minor=1
	ModifyGraph mirror(bottom)=1
	ModifyGraph noLabel(right)=1
	ModifyGraph manTick(right)={0,V_max/5,0,0}, manMinor(right)={3,2}
	ModifyGraph tickEnab(right)={0,V_max}
End

////////////////////////////////
//QW carrier Set Variable Proc//
////////////////////////////////
Function QWcarrierEnergy_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
    String   ctrlName
    Variable varNum			// value of variable as number
    String   varStr			// value of variable as string
    String   varName		// name of variable
//define parameters
	String   FolderName, FolderPath, currentFolder, GraphName
//set parameters and folder
	currentFolder = GetDataFolder(1)
	FolderName = "QWcarrierEnergy"
	FolderPath = "root:"+FolderName
	GraphName = "QWcarrierEnergy"
	SetDataFolder FolderPath
//read stored parameters
	NVAR V_left			 = $("V_left")
	NVAR V_right		 = $("V_right")
	NVAR V_center		 = $("V_center")
	NVAR W				 = $("W")
	NVAR m				 = $("m")
	NVAR stateIndex		 = $("stateIndex")
	NVAR V_left_meV		 = $("V_left_meV")
	NVAR V_right_meV	 = $("V_right_meV")
	NVAR V_center_meV	 = $("V_center_meV")
	NVAR EigenEnergy_meV = $("EigenEnergy_meV")
//main program
	V_left   = V_left_meV   * 10^(-3)
	V_right  = V_right_meV  * 10^(-3)
	V_center = V_center_meV * 10^(-3)
	QWsolve_carrierEnergy(V_left,V_right,V_center,W,m,stateIndex)
	WAVE WaveFunc; NVAR EigenEnergy, stateNum
	Duplicate/O WaveFunc, Density  ;  Density = WaveFunc^2
	EigenEnergy_meV = EigenEnergy * 10^(+3)
	QWcarrierEnergy_Grapher(V_left_meV,V_right_meV,V_center_meV,W,NameOfWave(Density),EigenEnergy_meV,GraphName)
//others
	SetDataFolder currentFolder
End



####################################################################################################
//////////=====     Quantum Well opt calcularion     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////
//QW opt [AlGaAs] Caller//
//////////////////////////
Function QWoptAlGaAs_Caller()
End

///////////////////////////
//QW opt [AlGaAs] Grapher//
///////////////////////////
Function QWoptAlGaAs_Grapher()
End

/////////////////////////////////////
//QW opt [AlGaAs] Set Variable Proc//
/////////////////////////////////////
Function QWoptAlGaAs_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String   ctrlName
	Variable varNum			// value of variable as number
	String   varStr			// value of variable as string
	String   varName		// name of variable
End


/////////////////////////////
//QW opt [Ref Index] Caller//
/////////////////////////////
Function QWoptRefIndex_Caller()
End

//////////////////////////////
//QW opt [Ref Index] Grapher//
//////////////////////////////
Function QWoptRefIndex_Grapher()
End

////////////////////////////////////////
//QW opt [Ref Index] Set Variable Proc//
////////////////////////////////////////
Function QWoptRefIndex_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String   ctrlName
	Variable varNum			// value of variable as number
	String   varStr			// value of variable as string
	String   varName		// name of variable
End



####################################################################################################
//////////=====     Operations for Igor Procedure     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

////////////////////
//Backup Wave Data//
////////////////////
//destDataFolderPath = root:foo:destDataFolder
Function BackupWaveData(wvPath,destDataFolderPath)
	String wvPath, destDataFolderPath
	String wvName = wvPath[strsearch(wvPath,":",Inf,1)+1,Inf]
	String srcDataFolderPath = GetDataFolder(1)
	WAVE/Z wv = $wvPath
	if (!WaveExists(wv))
		return -1
	endif
	if (DataFolderExists(destDataFolderPath) == 0)
		NewDataFolder/O $destDataFolderPath
	endif
	SetDataFolder destDataFolderPath
	Duplicate/O wv, refwv
	SetDataFolder srcDataFolderPath
	KillWaves/Z wv
	if (WaveExists(wv))
		KillWaves refwv
		return -1
	endif
	SetDataFolder destDataFolderPath
	Duplicate/O refwv, $wvName
	KillWaves refwv
	SetDataFolder srcDataFolderPath
End


//////////////////////
//Reverse Wave Order//
//////////////////////
Function Reverse_WaveOrder(orgWaveStr,revWaveStr)
	String orgWaveStr, revWaveStr
	WAVE/Z orgWave = $orgWaveStr
	Duplicate/O orgWave, revWave
	Variable N = numpnts(orgWave)-1
	Variable i
	if (stringmatch(orgWaveStr,revWaveStr)==0)
		for (i=0; i<=N; i+=1)
			revWave[i] = orgWave[N-i]
		endfor
		Rename revWave, $revWaveStr
	else
		for (i=0; i<=N; i+=1)
			orgWave[i] = revWave[N-i]
		endfor
		KillWaves revWave
	endif
End


///////////////
//Make X Wave//
///////////////
Function Make_XWave(newWaveName,from,upto,step,pnts)
	String   newWaveName
	Variable from, upto, step, pnts
	Variable i
//error handring
	if (step != 0 && pnts !=0)	//input "step" or "pnt"
		Print "Cancel"
		return -1
	endif
	if (from == 0 && upto ==0)
		Print "Cancel"
		return -1
	endif
//main program
	if    (step==0 && pnts==0)
		pnts = 1
		Make/D/O/N=(pnts) tmpWave
		tmpWave[0] = from
	elseif(pnts == 0)
		pnts = round(abs(upto-from)/step) + 1
		Make/D/O/N=(pnts) tmpWave
		for (i=0; i<=(pnts-1); i+=1)
			if (from<upto)
				tmpWave[i] = from + step*i
			else
				tmpWave[i] = from - step*i
			endif
		endfor
	elseif(step == 0)
		step = (upto-from)/(pnts-1)
		Make/D/O/N=(pnts) tmpWave
		for (i=0; i<=(pnts-1); i+=1)
			if (from<upto)
				tmpWave[i] = from + step*i
			else
				tmpWave[i] = from - step*i
			endif
		endfor
	endif
	Duplicate/O tmpWave, $newWaveName
	Killwaves tmpWave
End


//////////////////////////////////
//Convert Y wave into new X wave//
//////////////////////////////////
Function ConvertYwave_old(srcYName,srcXName,destYName,destXName,mode)
	String   srcYName, srcXName, destYName, destXName
	Variable mode
//define parameters
	Variable srcN, destN, i
	Variable srcXmax, srcXmin, from, upto
//read waves and erroer handling
	Wave  srcX =  $srcXName, srcY =  $srcYName
	Wave destX = $destXName
	if (numpnts(srcY)!=numpnts(srcX))
		return 0
	endif
//main program
	WaveStats/Q/Z  srcX;  srcN = V_npnts; srcXmax = V_max; srcXmin = V_min
	WaveStats/Q/Z destX; destN = V_npnts
	Make/D/O/N=(destN) destY
	if (mode==0)	//interpolation
		for (i=0; i<destN; i+=1)
			if (destX[i]<srcXmin || destX[i]>srcXmax)
				destY[i] = NaN
				continue
			endif
			destY[i] = interp(destX[i],srcX,srcY)
		endfor
	else			//integral
		for (i=0; i<destN; i+=1)
			if    (destX[0]<destX[inf])
				from = (i!=0)       ? (destX[i-1]+destX[i])/2 : destX[0] - (destX[1]-destX[0])/2
				upto = (i!=destN-1) ? (destX[i]+destX[i+1])/2 : destX[destN-1] + (destX[destX-1]-destX[destX-2])/2
			elseif(destX[0]>destX[inf])
				from = (i!=destN-1) ? (destX[i]+destX[i+1])/2 : destX[destN-1] + (destX[destX-1]-destX[destX-2])/2
				upto = (i!=0)       ? (destX[i-1]+destX[i])/2 : destX[0] - (destX[1]-destX[0])/2
			endif
			if (from<srcXmin || upto>srcXmax)
				destY[i] = NaN
				continue
			endif
			destY[i] = areaXY(srcX,srcY,from,upto)/(upto-from)
		endfor
	endif
	Duplicate/O destY, $destYName; KillWaves/Z destY
End


///////////////////////////////////////////////////
//Convert Y wave [transfar Y to newX & smoothing]//
///////////////////////////////////////////////////
Function ConvertYwave(srcYSpec,srcXSpec,refXSpec,Nsmth)
	String   srcYSpec, srcXSpec, refXSpec
	Variable Nsmth
//define parameters
	Variable i, Np
	Variable srcXmax, srcXmin
	String   srcYName, srcXName, newYName, newXName, refXName
	String   XnoteStr, YnoteStr
//read src waves and make new waves
	WAVE/D srcY = $srcYSpec; srcYName = NameOfWave(srcY)
	WAVE/D srcX = $srcXSpec; srcXName = NameOfWave(srcX)
	if (strlen(refXSpec)!=0)
		WAVE/D refX = $refXSpec; refXName = NameOfWave(refX)
		Np = numpnts(refX)
		Make/D/O/N=(Np) newX; Duplicate/D/O refX, newX
		Make/D/O/N=(Np) newY
	else
		WAVE/D newX = $srcXSpec; Np = numpnts(newX)
		Make/D/O/N=(Np) newY
	endif
//make srcXmax, srcXmin
	WaveStats/Q/Z srcX; srcXmax = V_max; srcXmin = V_min
//main program
	if(Nsmth==0)	//interpolation
		for(i=0; i<Np; i+=1)
			if (newX[i]<srcXmin || newX[i]>srcXmax)
				newY[i] = NaN
				continue
			endif
			newY[i] = interp(newX[i],srcX,srcY)
		endfor
	else			//integral
		Make/D/O/N=(Np) Xfrom, Xupto
		if(newX[0]<newX[inf])	//forward direction
			for(i=0; i<Np; i+=1)
				Xfrom[i] = newX[i-Nsmth]
				Xupto[i] = newX[i+Nsmth]
			endfor
		else					//reverse direction
			for(i=0; i<Np; i+=1)
				Xfrom[i] = newX[i+Nsmth]
				Xupto[i] = newX[i-Nsmth]
			endfor
		endif
		for(i=0; i<Np; i+=1)
			if (Xfrom[i]<srcXmin || Xupto[i]>srcXmax)
				newY[i] = NaN
				continue
			endif
			newY[i] = faverageXY(srcX,srcY,Xfrom[i],Xupto[i])
		endfor
	endif
//rename & note new waves
	newYName = srcYName + "_Conv"
	newXName = srcXName + "_Conv"
	if (strlen(refXSpec)!=0)
		sprintf YnoteStr, "%s = %s (refX:%s, Nsmth:%dpnts)", newYName, srcYName, refXName, Nsmth
		sprintf XnoteStr, "%s = %s", newXName, refXName
		Rename newY, $newYName; Note newY, YnoteStr
		Rename newX, $newXName; Note newX, XnoteStr
	else
		sprintf YnoteStr, "%s = %s (refX:%s, Nsmth:%dpnts)", newYName, srcYName, srcXName, Nsmth
		Rename newY, $newYName; Note newY, YnoteStr
		
	endif
//others
	KillWaves/Z Xfrom, Xupto
End



//////////////////////////////////////////////
//Duplicate Waves in Graph to destDataFolder//
//////////////////////////////////////////////
Function DuplicateGraphWaves(GraphName,destDataFolder)
	String   GraphName, destDataFolder
//define parameters
	String   TraceName
	String   srcXName, srcYName, newXName, newYName
	String   srcXPath, srcYPath
	String   srcXNameList, srcYNameList
	String   currentDataFolder, newDataFolderName, newDataFolderPath
	Variable w, v, N
//error handling
	if (strlen(GraphName)==0)
		GraphName = WinName(0,1)
	endif
	if (strlen(destDataFolder)==0)
		destDataFolder = "root:tmpDataFolder"
	endif
	if (WindowExists(GraphName,1)==0)
		return 0
	endif
	if (dataFolderExists(destDataFolder)==1)
		return 0
	endif
//set parameters
	currentDataFolder = GetDataFolder(1)
	N = CountWaves(GraphName)
//make trace list
	NewDataFolder/O/S $destDataFolder
	Make/O/T/N=(N+1,7) wvList
	wvList[N][0] = "traceName"
	wvList[N][1] = "srcYName"
	wvList[N][2] = "srcXName"
	wvList[N][3] = "srcYPath"
	wvList[N][4] = "srcXPath"
	wvList[N][5] = "newYName"
	wvList[N][6] = "newXName"
	for (w=0; w<N; w+=1)
		traceName = traceNameStr(GraphName,w)
		WAVE srcY = TraceNameToWaveRef(GraphName,traceName)
		WAVE srcX = XWaveRefFromTrace(GraphName,traceName)
		srcYName = NameOfWave(srcY)
		srcXName = NameOfWave(srcX)
		srcYPath = GetWavesDataFolder(srcY,1)
		srcXPath = GetWavesDataFolder(srcX,1)
		wvList[w][0] = traceName
		wvList[w][1] = srcYName
		wvList[w][2] = srcXName
		wvList[w][3] = srcYPath
		wvList[w][4] = srcXPath
	endfor
//main program
	for (w=0; w<N; w+=1)
		traceName = wvList[w][0]
		srcYName  = wvList[w][1]
		srcXName  = wvList[w][2]
		srcYPath  = wvList[w][3]
		srcXPath  = wvList[w][4]
		WAVE srcY = $(srcYPath+srcYName)
		WAVE srcX = $(srcXPath+srcXName)
	//make list
		srcYNameList = ";"
		srcXNameList = ";"	
		for (v=0; v<N; v+=1)
			if (v!=w)
				srcYNameList += wvList[v][1] + ";"
				srcXNameList += wvList[v][2] + ";"
			endif
		endfor
	//make new wave Y
		Make/O newY; Duplicate/O srcY, newY
		if (!stringmatch(srcYNameList,"*;"+srcYName+";*"))
			newYName = srcYName
		else
			sprintf newYName, "%s%03d", srcYName, w+1
		endif
		Rename newY, $newYName; Note newY, srcYName
		wvList[w][5] = newYName
	//make new wave X
		Make/O newX; Duplicate/O srcX, newX
		if (!stringmatch(srcXNameList,"*;"+srcXName+";*"))
			newXName = srcXName
		else
			sprintf newXName, "%s%03d", srcXName, w+1
		endif
		Rename newX, $newXName; Note newX, srcXName
		wvList[w][6] = newXName
	endfor
	SetDataFolder currentDataFolder
End


####################################################################################################
//////////=====     Functions for Igor Procedure     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

/////////////////////////////////////
//Count Waves in the Graph or Table//
/////////////////////////////////////
//counting the number of waves in a graph or table
Function CountWaves(WindowName)
	String WindowName
	String List = WinList("*",";","WIN:3")
	Variable N = -1
	if (strlen(WindowName)==0)
		WindowName = WinName(0,3)
	endif
	if (!stringmatch(List,WindowName+";*") && !stringmatch(List,"*;"+WindowName+";*"))
		return NaN
	endif
	do
		N += 1
	while (WaveExists(WaveRefIndexed(WindowName,N,1)))
	return N
End




//////////////////////////////////////
//Count "Showing" Waves in the Graph//
//////////////////////////////////////
//counting the number of "showing" waves in a graph
Function CountWaves_Trace(GraphName)
	String graphName
	String yName
	Variable w, Nw, N
	Nw = CountWaves(graphName)
	for (w=0; w<Nw; w+=1)
		yName = TraceNameStr(GraphName,w)
		if (TraceStats(GraphName,yName)==0)
			N += 1
		endif
	endfor
	return N
End


/////////////////////////
//Get Trace Name String//
/////////////////////////
//returns a string contaning the "trace name" of the indexth wave in the GraphName
Function/S TraceNameStr(GraphName,index)
	Variable index
	String   GraphName
	String   TraceList, traceName
	if (index >= CountWaves(graphName))
		traceName = ""
		return traceName
	endif
	TraceList = TraceNameList(GraphName,";",1)
	traceName = StringFromList(index,TraceList,";")
	return traceName
End


///////////////
//Trace Stats//
///////////////
//return = 0 : showing
//		 = 1 : hidden (removes it from autoscale calculations)
//		 = 2 : hidden
Function TraceStats(GraphName,traceName)
	String GraphName, traceName
	Variable TraceParameter
	sscanf StringByKey("hideTrace(x)",traceinfo(GraphName,traceName,0),"="), "%f", TraceParameter
	return TraceParameter
End


///////////////////////
//Read Current Offset//
///////////////////////
Function GetCurrentOffset(WindowName,wv_name,xoffset,yoffset)
	String WindowName, wv_name
	Variable &xoffset, &yoffset
	String t_info = Traceinfo(WindowName, wv_name, 0)
	if(strlen(t_info)==0)
		return 0
	endif
	sscanf StringByKey("offset(x)", t_info, "="), "{%f, %f}" , xoffset, yoffset
	return 1
End

////////////////
//Get X Offset//
////////////////
Function GetOffset(GraphName,traceName,typeStr)
	String GraphName, traceName, typeStr
End

//////////////////
//Get Axis Label//
//////////////////
//return axis label string
//mode=0 : only label string
//    =1 : font & size and label string
Function/S GetAxisLabel(GraphName,axisName,mode)
	String GraphName, axisName
	Variable mode
//define parameters
	String keyStr, list, rawStr, labelStr
	String axisLabel
	Variable from, upto
//set parameters
	keyStr = "Label/Z " + axisName
	list = WinRecreation(GraphName,1)
	from = strsearch(list,keyStr,0)
	upto = strsearch(list,"\r",from)
//error handring
	if (from == -1)
		axisLabel = ""
		return axisLabel
	endif
//main program
	rawStr = list[from,upto]
	labelStr = rawStr[10+strlen(axisName),strlen(rawStr)-3]
	axisLabel = labelStr
	do
		if (stringmatch(axisLabel,"*\\\\*"))
			axisLabel = axisLabel[0,strsearch(axisLabel,"\\\\",0)] + axisLabel[strsearch(axisLabel,"\\\\",0)+2,Inf]
		else
			break
		endif
	while(1)
	if (mode==0)
		do
			if    (stringmatch(axisLabel,"\\Z*"))
				axisLabel = axisLabel[strsearch(axisLabel,"\\Z",0)+4,Inf]
			elseif(stringmatch(axisLabel,"\\F*"))
				axisLabel = axisLabel[strsearch(axisLabel,"'",strsearch(axisLabel,"\\F",0)+4)+1,Inf]
			else
				break
			endif
		while(stringmatch(axisLabel,"\\*"))
	endif
	return axisLabel
End


/////////////////////////////////////////////////
//change S_filename to Folder/File Name or Path//
/////////////////////////////////////////////////
//type = 0 : return Folder/File Name
//     = 1 : return Folder/File Path
Function/S path2str(S_filename,index,type)
	String   S_filename
	Variable index, type
//define parameters
	String   Name, Path
	Variable N
//error handling
	N = ItemsInList(S_filename,":")
	if (index<0 || index>=N ||(type!=0&&type!=1))
		return ""
	endif
//main program
	if    (type==0)
		Name = StringFromList(N-index-1,S_filename,":")
		return Name
	elseif(type==1)
		Name = StringFromList(N-index-1,S_filename,":")
		if  (index==0)
			Path = S_filename[0,Inf]
		else
			Path = S_filename[0,strsearch(S_filename,":"+Name+":",Inf,1)+strlen(Name)]
		endif
		return Path
	endif
End


///////////////////
//Get Date & Time//
///////////////////
//return "year/month/day hour/minute/second"
Function/S Secs2DateTime(seconds)
	Variable seconds
	String   DateStr, TimeStr, DateTimeStr
	DateStr = Secs2Date(seconds,-1)
	TimeStr = Secs2Time(seconds, 3)
	DateTimeStr = DateStr[6,9]+"/"+DateStr[3,4]+"/"+DateStr[0,1]+" "+TimeStr
	return DateTimeStr
End



Static Function scale2pnt(waveNameStr,num,dim)
	String   waveNameStr
	Variable num, dim
	WAVE     wv = $waveNameStr
	Variable pointNum
	pointNum = round((num-DimOffset(wv,dim))/DimDelta(wv,dim))
	return pointNum
End

Static Function pnt2scale(waveNameStr,pointNum,dim)
	String   waveNameStr
	Variable pointNum, dim
	WAVE     wv = $waveNameStr
	Variable num
	num = DimOffset(wv,dim) + pointNum*DimDelta(wv,dim)
	return num
End

Function WindowExists(winNameStr,windowTypes)
	String   winNameStr
	Variable windowTypes
	String   winListStr, existwinStr
	Variable i, N
	if (windowTypes==0)
		winListStr = WinList("*",";","")
	else
		winListStr = WinList("*",";","WIN:"+num2str(windowTypes))
	endif
	N = ItemsInList(winListStr,";")
	for (i=0; i<N; i+=1)
		existwinStr = StringFromList(i,winListStr,";")
		if (stringmatch(winNameStr,existwinStr))
			return 1
		endif
	endfor
	return 0
End

Function CsrExists(csrNameStr,GraphName)
	String   csrNameStr, GraphName
	if    (stringmatch(csrNameStr,"A"))
		if(strlen(CsrInfo(A,GraphName))!=0)
			return 1
		else
			return 0
		endif
	elseif(stringmatch(csrNameStr,"B"))
		if(strlen(CsrInfo(B,GraphName))!=0)
			return 1
		else
			return 0
		endif
	else
		return 0
	endif
End

####################################################################################################
//////////=====     Graph Convert     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

/////////////////
//Inverse graph//
/////////////////
Function InverseWaves()
	String WindowName, NewWindowName, invyName
	Variable i, N, pnts
	N = CountWaves("")
	WindowName = WinName(0,1)
	NewWindowName = WindowName + "_inv"
	Display/N=$NewWindowName as NewWindowName
	for(i=0; i<N; i+=1)
		WAVE y = WaveRefIndexed(WindowName,i,1)
		WAVE x = XWaveRefFromTrace(WindowName,NameOfWave(y))
		pnts = numpnts(x)
		Make/N=(pnts) invy
		invy = 1/y
		invyName = NameOfWave(y) + "_inv"
		Rename invy, $invyName
		AppendToGraph/W=$NewWindowName invy vs x
	endfor
	Graph_Default("")
End

//////////////////////////////
//Absorption Convert to Gain//
//////////////////////////////
Function abs2gain()
	DoAlert 1, "Absorption Convert to Gain"
	if (V_flag==2)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	String WindowName = WinName(0,1)
	Variable i,j
	i = CountWaves("")
	for(j=0;j<i;j+=1)
		Wave y = WaveRefIndexed(WindowName,j,1)
		y *= -1
	endfor
	Label left "\\Z12Gain (cm\\S-1\\M)"
End

//////////////////////////////
//Gain Convert to Absorption//
//////////////////////////////
Function gain2abs()
	DoAlert 1, "Gain Convert to Absorption"
	if (V_flag==2)
		DoAlert 0, "Cancel"
		Print "Cancel"
		return -1
	endif
	String WindowName = WinName(0,1)
	Variable i,j
	i = CountWaves("")
	for(j=0;j<i;j+=1)
		Wave y = WaveRefIndexed(WindowName,j,1)
		y *= -1
	endfor
	Label left "\\Z12Absorption (cm\\S-1\\M)"
End



####################################################################################################
//////////=====     Duplicate/Rename tool    =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

////////////////////////////////////
//Duplicate Waves by use Clipboard//
////////////////////////////////////
Function DuplicateClipboardWaves()
//define parameters
	Variable i, j, N, M
	String List, childList
	String srcItemStr, childItemStr, currentFolder
	String srcFolder, srcWaveName, srcWaveSpec
	String dstFolder, dstWaveName, dstWaveSpec
//set parameters
	List = GetScrapText()
	currentFolder = GetDataFolder(1)
	dstFolder = currentFolder
//error handling
	if (!stringmatch(List,"root:*"))
		Print "Cancel"
		return -1
	endif
	DoAlert 1, "Duplicate Waves by use Clipboard\r\rContinue ?"
	if (V_flag == 2)
		Print "Cancel"
		return -1
	endif
//count number of waves in list
	do
		if (strlen(StringFromList(N,List,","))!=0)
			N += 1
		else
			break
		endif
	while (1)
//main loop
	for (i=0; i<N; i+=1)
		srcItemStr = StringFromList(i,List,",")
		if (DataFolderExists(srcItemStr))
			srcFolder = srcItemStr + ":"
			SetDataFolder srcFolder
			childList = WaveList("*",";","")
			SetDataFolder currentFolder
			M = 0
			do
				if (strlen(StringFromList(M,childList,";"))!=0)
					M += 1
				else
					break
				endif
			while (1)
			for (j=0; j<M; j+=1)
				childItemStr = StringFromList(j,childList,";")
				srcWaveName = childItemStr
				dstWaveName = srcWaveName
				srcWaveSpec = srcFolder + srcWaveName
				dstWaveSpec = dstFolder + dstWaveName
				if (!WaveExists($dstWaveSpec))
					Duplicate/O $srcWaveSpec, $dstWaveSpec
				endif
			endfor
			printf "%s -> %s\r", srcFolder, dstFolder
		else
			srcFolder   = srcItemStr[0,strsearch(srcItemStr,":",Inf,1)]
			srcWaveName = srcItemStr[strsearch(srcItemStr,":",Inf,1)+1,Inf]
			dstWaveName = srcWaveName
			srcWaveSpec = srcFolder + srcWaveName
			dstWaveSpec = dstFolder + dstWaveName
			if (!WaveExists($srcWaveSpec))
				continue
			endif
			if (!WaveExists($dstWaveSpec))
				Duplicate/O $srcWaveSpec, $dstWaveSpec
				printf "%s -> %s\r", srcWaveSpec, dstFolder
			else
				printf "%s : already exists.\r", srcWaveSpec
			endif
		endif
	endfor
End


////////////////////////////////////////
//Duplicate and Replace Waves in Graph//
////////////////////////////////////////
Function DuplicateReplaceWaves()
//define parameters
	String GraphName, traceName, tracePath, newYName, newXName
	String currentDataFolder, newDataFolderName, newDataFolderPath
	Variable w, v, N
	GraphName = WinName(0,1)
	N = CountWaves(GraphName)
	currentDataFolder = GetDataFolder(1)
	newDataFolderName = GraphName
	newDataFolderPath = currentDataFolder + newDataFolderName
//error handling
	DoAlert 1, "Duplicate and Replace Waves in Graph\r\rContinue ?"
	if (V_flag == 2)
		Print "Cancel"
		return -1
	endif
	if (DataFolderExists(newDataFolderPath))
		DoAlert 0, "same name data folder exists."
		Print "same name data folder exists."
		return -1
	endif
//duplicate graph and set wvList
	DuplicateGraphWaves(GraphName,newDataFolderPath)
	SetDataFolder $newDataFolderPath
	WAVE/T wvList = $("wvList")
//main program
	for (w=0; w<N; w+=1)
		traceName = wvList[w][0]
		newYName  = wvList[w][5]
		newXName  = wvList[w][6]
		WAVE newY = $newYName
		WAVE newX = $newXName
		ReplaceWave/W=$GraphName/X trace=$traceName, newX
		ReplaceWave/W=$GraphName   trace=$traceName, newY
	endfor
	KillWaves wvList
	SetDataFolder currentDataFolder
	TextBox/C/N=text/A=RT "DUPLICATE"
End


/////////////////////////
//Rename Waves in Graph//
/////////////////////////
Function RenameWaves()
//define parameters
	String   GraphName, bodyStr
	String   srcXname, srcYname, newXname, newYname
	Variable NameMode, NoteMode
	Variable w, N
//set parameters
	GraphName = WinName(0,1)
	N = CountWaves(GraphName)
//select mode
	NameMode = 3
	NoteMode = 2
	bodyStr  = GraphName
	Prompt bodyStr, "input body string."
	Prompt NameMode, "select name mode.", popup, " 1 : Y wave only; 2 : X wave only; 0 : Both X and Y wave;"
	Prompt NoteMode, "append origin wave name to wave note.", popup, " 1 : Yes; 2 : No;"
	DoPrompt "Rename Waves in Graph", bodyStr, NameMode, NoteMode
//error handling
	if (V_flag==1)
		Print "Cancel"
		return -1
	endif
//main program
	for (w=0; w<N; w+=1)
		WAVE Y = WaveRefIndexed(GraphName,w,1)
		WAVE X = XWaveRefFromTrace(GraphName,NameOfWave(Y))
		srcYName = NameOfWave(Y)
		srcXName = NameOfWave(X)
		if (N==1)
			newYName = bodyStr + "_y"
			newXName = bodyStr + "_x"
		else
			sprintf newYName, "%s%02d_y", bodyStr, w+1
			sprintf newXName, "%s%02d_x", bodyStr, w+1
		endif
		if    (NoteMode==1)	//appned note
			if     (NameMode==3)	//both X and Y wave
				Rename Y, $newYName; Note Y, srcYName
				Rename X, $newXName; Note X, srcXName
			elseif (NameMode==1)	//Y wave
				Rename Y, $newYName; Note Y, srcYName
			elseif (NameMode==2)	//X wave
				Rename X, $newXName; Note X, srcXName
			endif
		elseif(NoteMode==2)	//rename only
			if     (NameMode==3)	//both X and Y wave
				Rename Y, $newYName
				Rename X, $newXName
			elseif (NameMode==1)	//Y wave
				Rename Y, $newYName
			elseif (NameMode==2)	//X wave
				Rename X, $newXName
			endif
		endif
	endfor
End


####################################################################################################
//////////=====     Cassidy Method [Fukuda ver.]    =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

///////////////////
//Cassidy Sin Fit//
///////////////////
Function CassidySinFit_kf(from,upto,min_limit,L,R,step,WindowName,index)		//岡野さんのCassidySinFitを自分が読みやすいように変えたもの。
	String WindowName, index
	Variable from, upto, min_limit, L, R, step
//define parameters
	String Yname, Xname, gainYname, gainXname
	String NewWindowName = WindowName + "_gain" + index
	Variable w, i, j, k, pnts, N											//for main plot
	Variable p, g, FSR, Imin, Isum											//for Cassidy's equation
	Variable bf_e, af_e, bf_int, af_int, bf_pnt, af_pnt, bf_sum, af_sum 	//from fitting
	Variable V_FitOptions = 4												//suppress the curve fit window
	Variable V_FitNumIters													//Igor stores the number of iterations actually done
//get ready
	L /= 10000
	pnts = numpnts($WaveName(WindowName,0,1))
	N = pnts/min_limit
	Make/O/N=((upto-from)/step+1, N) EnergyMatrix, GainMatrix, IsumMatrix, IminMatrix, FSRMatrix		//to check calculation
	Display/N=$NewWindowName as NewWindowName
//main plot
	for(w=from-1; w<upto; w+=step)
	//define parameter
		WAVE Y = WaveRefIndexed(WindowName,w,1)
		WAVE X = XWaveRefFromTrace(WindowName,NameOfWave(Y))
		Yname = NameOfWave(Y)
		Xname = NameOfWave(X)
		if (strsearch(Yname,"_y",inf,1)!=-1)
			gainYname = Yname[0,strsearch(Yname,"_y",inf,1)-1] + "_gain" + index + "_y" + Yname[strsearch(Yname,"_y",inf,1)+2,inf]
			gainXname = Yname[0,strsearch(Yname,"_y",inf,1)-1] + "_gain" + index + "_x" + Yname[strsearch(Yname,"_y",inf,1)+2,inf]
		else
			gainYname = Yname + "_gain" + index + "_y"
			gainXname = Yname + "_gain" + index + "_x"
		endif
		pnts = numpnts(x)
		N = pnts/min_limit
		Make/O/N=(N) GainWave, EnergyWave
	//create invY : inverse Y
		Make/O/N=(pnts) invY
		Duplicate/O Y, invY
		invY = 1/invY
	//redimension
		if (WaveType(X) != WaveType(invY))
			Redimension/D X, invY
		endif
	//create difY : derivatives of invY
		Differentiate invY/X=X/D=difY
	//loop start						
		i = 0; j = -min_limit; k = 0
		for (i=0; i<pnts; i+=1)
			if (i-j<=min_limit)								//min_limitの中には極大点がないのでスキップ
				continue
			endif
			if (difY[i]*difY[i+1]<=0 && difY[i]>=0)			//Xwaveの値とpntの向きが逆向きじゃないと使えない。
				i += (invY[i]>invY[i+1])
				if (j == -min_limit)						//１つめの(originyの)極大点のpntをjに受け渡す
					j = i
					continue
				endif
			//fitting start and define fit_invY
				CurveFit/Q/N/B=(i-j)/W=0/L=((i-j)*20) sin, invY[j,i]/X=X/D		//fitting start
				if (V_FitNumIters == 40)										//ここがよくわかんない・・・			
					j = i														//このparameterはfittingの試行回数？
					continue													//うまくfittingできなかったらあきらめて次に進むってこと？
				endif															//
				WAVE fit_invY = $("fit_invY")									
			//create fit_Y
				Make/O/N=((i-j)*20) fit_Y
				Duplicate/O fit_invY, fit_Y
				fit_Y = 1/fit_Y
			//calculate min points
				WaveStats/Q fit_invY
				if (k == 0)
					bf_e = V_maxloc
					bf_int = 1 / V_max
					bf_pnt = MinSearch(x,bf_e,j,i)
					bf_sum = area(fit_Y, x[bf_pnt], bf_e)
					k += 1
					continue
				endif
				af_e = V_maxloc
				af_int = 1 / V_max
				af_pnt = MinSearch(X,af_e,j,i) - 1
				af_sum = area(fit_Y, X[af_pnt] ,af_e)
			//calculate cassidy parameters
				Isum = abs(areaXY(X, Y, X[bf_pnt], X[af_pnt] )) + abs(bf_sum) + abs(af_sum)
				Imin = (bf_int + af_int)/2
				FSR = (bf_e - af_e)
				p = abs(Isum/(FSR*Imin))
				g = (p>1) ? (ln((p-1)/(R*(p+1))))/L : NaN
				EnergyWave[k-1] = (bf_e + af_e)/2
				GainWave[k-1] = g
				EnergyMatrix[w][k-1] = EnergyWave[k-1]; GainMatrix[w][k-1] = GainWave[k-1]			//to check calculation
				IsumMatrix[w][k-1] = Isum; IminMatrix[w][k-1] = Imin; FSRMatrix[w][k-1] = FSR		//to check calculation
	 		//move parameter
	 			bf_e = af_e
				bf_int = af_int
				bf_pnt = af_pnt + 1
				bf_sum = area(fit_Y, X[bf_pnt] ,af_e)
	 			j = i; k += 1
			endif
		endfor
	//make gain wave
		Make/O/N=(N) gainY, gainX
		Duplicate/O GainWave, gainY
		Duplicate/O EnergyWave, gainX
		for (k=0; k<N; k+=1)
			if (gainX[k] == 0)
				break
			endif
		endfor
		DeletePoints k, N-k+1, gainY, gainX
		Rename gainY, $gainYname
		Rename gainX, $gainXname
		printf "%s = %s ( R : %g , L : %g [um] )\r", gainYname, Yname, R, L*10000
		AppendToGraph/W=$NewWindowName gainY vs gainX
	//killwaves
		KillWaves invY, difY, fit_invY, fit_Y
		KillWaves GainWave, EnergyWave
		KillWaves W_coef, W_sigma, W_ParamConfidenceInterval	//fitting parameter
	endfor
//kill or save matrix
	if (strlen(index) == 0)
		KillWaves EnergyMatrix, GainMatrix, IsumMatrix, IminMatrix, FSRMatrix
	else
		Rename EnergyMatrix, $(NewWindowName+"_Energy")
		Rename   GainMatrix, $(NewWindowName+"_Gain")
		Rename   IsumMatrix, $(NewWindowName+"_Isum")
		Rename   IminMatrix, $(NewWindowName+"_Imin")
		Rename    FSRMatrix, $(NewWindowName+"_FSR")
	endif
End

//////////////////////////
//Cassidy Sin Fit [test]//
//////////////////////////
Function CassidySinFit_kf_test(from,upto,min_limit,L,R,step,WindowName,index)		//岡野さんのCassidySinFitを自分が読みやすいように変えたもの。
	String WindowName, index
	Variable from, upto, min_limit, L, R, step
//define parameters
	String NewWindowName = WindowName + index + "_gain"
	Variable w, i, j, k, pnts, N										//for main plot
	Variable p, g, FSR, Imin, Isum									//for Cassidy's equation
	Variable bf_e, af_e, bf_int, af_int, bf_pnt, af_pnt, bf_sum, af_sum 		//from fitting
	Variable V_FitOptions = 4										//suppress the curve fit window
	Variable V_FitNumIters											//Igor stores the number of iterations actually done
	Variable Xmid, invYmax, invYmin, invYmid	
//get ready
	L /= 10000
	pnts = numpnts($WaveName(WindowName,0,1))
	N = pnts/min_limit
	Make/O/N=((upto-from)/step+1, N) EnergyMatrix, GainMatrix, IsumMatrix, IminMatrix, FSRMatrix		//to check calculation
	Display/N=$NewWindowName as NewWindowName
	Display/N=$(WindowName+index+"_inv") as WindowName+index+"_inv"
	Display/N=$(WindowName+index+"_dif") as WindowName+index+"_dif"
//main plot
	for(w=from-1; w<upto; w+=step)
	//define parameter
		WAVE Y = WaveRefIndexed(WindowName,w,1)
		WAVE X = XWaveRefFromTrace(WindowName,NameOfWave(Y))
		String Yname = NameOfWave(Y)
		String Xname = NameOfWave(X)
		String name = Xname[0,strlen(Xname)-3]
		String gainYname = name + "_gain" + index + "_y"
		String gainXname = name + "_gain" + index + "_x"
		String invYname = Yname + "_inv"
		String difYname = Yname + "_dif"
		String fit_invYname, fit_Yname
		pnts = numpnts(x)
		N = pnts/min_limit
		Make/O/N=(N) GainWave, EnergyWave
	//create invY : inverse Y
		Make/O/N=(pnts) invY
		Duplicate/O Y, invY
		invY = 1/invY
		Rename invY, $invYname
		AppendToGraph/W=$(WindowName+index+"_inv") invY vs X
	//redimension
		if (WaveType(X) != WaveType(invY))
			Redimension/D X, invY
		endif
	//create difY : derivatives of invY
		Differentiate invY/X=X/D=difY
		Rename difY, $difYname
		AppendToGraph/W=$(WindowName+index+"_dif") difY vs X
	//loop start						
		i = 0; j = -min_limit; k = 0
		for (i=0; i<pnts; i+=1)
			if (i-j<=min_limit)								//min_limitの中には極大点がないのでスキップ
				continue
			endif
			if (difY[i]*difY[i+1]<=0 && difY[i]>=0)				//Xwaveの値とpntの向きが逆向きじゃないと使えない。
				i += (invY[i]>invY[i+1])
				if (j == -min_limit)							//１つめの(originyの)極大点のpntをjに受け渡す
					j = i
					continue
				endif
			//make initial parameter wave
				Make/O/N=4 FitCoefficients
				Xmid = (x[i]+x[j])/2
				invYmin = (invy[i]+invy[j])/2
				invYmax = interp(Xmid, x,invy)
				invYmid = (invYmax+invYmin)/2
				FitCoefficients[0] = invYmid						//K0 : offset
				FitCoefficients[1] = invYmax-invYmin				//K1 : amplitude
				FitCoefficients[2] = 20000							//K2 : frecuency
				FitCoefficients[3] = mod(20000*(X[i]+Xmid)/2,2*pi)	//K3 : phase
			//fitting start and define fit_invY
				CurveFit/Q/N/B=(i-j+1)/W=0/L=((i-j)*20)/G sin kwCWave=FitCoefficients, invY[j,i]/X=X/D/F={0.99,4}
				if (V_FitNumIters == 40)										//ここがよくわかんない・・・			
					printf "Fitting NG %d, %d\r", j, i
					j = i														//このparameterはfittingの試行回数？
					continue													//うまくfittingできなかったらあきらめて次に進むってこと？
				endif														//
				WAVE fit_invY = $("fit_"+invYname)
				sprintf fit_invYname, "fit_invY%03d_%04d_%04d", k, j, i								
				Rename fit_invY, $fit_invYname
				AppendToGraph/W=$(WindowName+index+"_inv") fit_invY
				ModifyGraph/W=$(WindowName+index+"_inv") rgb($fit_invYname)=(0,0,65280)	
			//create fit_Y
				Make/O/N=((i-j)*20) fit_Y
				Duplicate/O fit_invY, fit_Y
				fit_Y = 1/fit_Y
				sprintf fit_Yname, "fit_Y%03d_%04d_%04d", k, j, i
				Rename fit_Y, $fit_Yname
				AppendToGraph/W=$WindowName fit_Y
				ModifyGraph/W=$WindowName rgb($fit_Yname)=(0,0,65280)
			//calculate min points
				WaveStats/Q fit_invY
				if (k == 0)
					bf_e = V_maxloc
					bf_int = 1 / V_max
					bf_pnt = MinSearch(x,bf_e,j,i)
					bf_sum = area(fit_Y, x[bf_pnt], bf_e)
					k += 1
					continue
				endif
				af_e = V_maxloc
				af_int = 1 / V_max
				af_pnt = MinSearch(X,af_e,j,i) - 1
				af_sum = area(fit_Y, X[af_pnt] ,af_e)
			//calculate cassidy parameters
				Isum = abs(areaXY(X, Y, X[bf_pnt], X[af_pnt] )) + abs(bf_sum) + abs(af_sum)
				Imin = (bf_int + af_int)/2
				FSR = (bf_e - af_e)
				p = abs(Isum/(FSR*Imin))
				g = (p>1) ? (ln((p-1)/(R*(p+1))))/L : NaN
				EnergyWave[k-1] = (bf_e + af_e)/2
				GainWave[k-1] = g
				EnergyMatrix[w][k-1] = EnergyWave[k-1]; GainMatrix[w][k-1] = GainWave[k-1]		//to check calculation
				IsumMatrix[w][k-1] = Isum; IminMatrix[w][k-1] = Imin; FSRMatrix[w][k-1] = FSR			//to check calculation
	 		//move parameter
	 			bf_e = af_e
				bf_int = af_int
				bf_pnt = af_pnt + 1
				bf_sum = area(fit_Y, X[bf_pnt] ,af_e)
	 			j = i; k += 1
			endif
		endfor
	//make gain wave
		Make/O/N=(N) gainY, gainX
		Duplicate/O GainWave, gainY
		Duplicate/O EnergyWave, gainX
		for (k=0; k<N; k+=1)
			if (gainX[k] == 0)
				break
			endif
		endfor
		DeletePoints k, N-k+1, gainY, gainX
		Rename gainY, $gainYname
		Rename gainX, $gainXname
		printf "%s = %s ( R : %g , L : %g [um] )\r", gainYname, Yname, R, L*10000
		AppendToGraph/W=$NewWindowName gainY vs gainX
	//killwaves
//		KillWaves invY, difY, fit_invY, fit_Y
		KillWaves GainWave, EnergyWave
		KillWaves FitCoefficients, W_coef, W_sigma, W_ParamConfidenceInterval			//fitting parameter
	endfor
//save matrix
	Rename EnergyMatrix, $(NewWindowName+"_Energy")
	Rename GainMatrix, $(NewWindowName+"_Gain")
	Rename IsumMatrix, $(NewWindowName+"_Isum")
	Rename IminMatrix, $(NewWindowName+"_Imin")
	Rename FSRMatrix, $(NewWindowName+"_FSR")
End



####################################################################################################
//////////=====     Cassidy Method [by Okano san]     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////
///CassidyCaller//
//////////////////
Function Cassidy_Caller()
//define parameters
	String WindowName, index
	Variable mode, from, upto, min_limit, L, R, step, Xfrom, Xupto, Gfrom, Gupto
//read experimental value
	R = (numtype(GetParameter_Var("R"))==0) ? GetParameter_Var("R") : 0.5
	L = (numtype(GetParameter_Var("L"))==0) ? GetParameter_Var("L") : 500
	Xfrom = (numtype(GetParameter_Var("Xfrom"))==0) ? GetParameter_Var("Xfrom") : 1.56
	Xupto = (numtype(GetParameter_Var("Xupto"))==0) ? GetParameter_Var("Xupto") : 1.60
	Gfrom = (numtype(GetParameter_Var("Gfrom"))==0) ? GetParameter_Var("Gfrom") : -40
	Gupto = (numtype(GetParameter_Var("Gupto"))==0) ? GetParameter_Var("Gupto") : 10
//input data
	mode = 3; min_limit = 5; step = 1	//default parameter
	Prompt from, "OriginNumber"
	Prompt upto, "DestinationNumber"
	Prompt step, "step"
	Prompt min_limit, "FSR-minnimum limit (pnts:defalt=5)"
	Prompt L, "cavity length [um]"
	Prompt R, "reflectance"
	Prompt mode, "FittingMode (0:Poly, 1:Sin, 2;Both)"
	Prompt index, "index"
	DoPrompt "Choose Fitting Mode & Input parameter", R, L, mode, min_limit, from, upto, step, index
//error handling
	if (V_flag==1)
		DoAlert 0,"Who is Cassidy?"
		Print "Cancel"
		return -1
	endif
	if (upto<from)
		DoAlert 0,"Where on earth are your eyes!?"
		Print "Cancel"
		return -9
	endif
	if (from==0 && upto==0)
		from = 1
		upto = CountWaves("")
	endif
//Call Algorithm
	WindowName = WinName(0,1)
	if (mode==0)
		CassidyPolyFit(from,upto,min_limit,L,R,step,WindowName)
		Graph_Gain("")
		DrawMirrorLossLine("",R,L)
		GPR()
		ModifyGraph width=0, height=0
		SetAxis bottom Xfrom, Xupto
		SetAxis left Gfrom, Gupto
	elseif (mode==1)
		CassidySinFit(from,upto,min_limit,L,R,step,WindowName)
		Graph_Gain("")
		DrawMirrorLossLine("",R,L)
		GPR()
		ModifyGraph width=0, height=0
		SetAxis bottom Xfrom, Xupto
		SetAxis left Gfrom, Gupto
	elseif (mode==2)
		CassidySinFit(from,upto,min_limit,L,R,step,WindowName)	
		Graph_Gain("")
		DrawMirrorLossLine("",R,L)
		GPR()
		ModifyGraph width=0, height=0
		SetAxis bottom Xfrom, Xupto
		SetAxis left Gfrom, Gupto
		CassidyPolyFit(from,upto,min_limit,L,R,step,WindowName)
		Graph_Gain("")
		DrawMirrorLossLine("",R,L)
		GPR()
		ModifyGraph width=0, height=0
		SetAxis bottom Xfrom, Xupto
		SetAxis left Gfrom, Gupto
	elseif (mode==3)
		CassidySinFit_kf(from,upto,min_limit,L,R,step,WindowName,index)
		Graph_Gain("")
		DrawMirrorLossLine("",R,L)
		GPR()
		ModifyGraph width=0, height=0
		SetAxis bottom Xfrom, Xupto
		SetAxis left Gfrom, Gupto
	elseif (mode==4)
		upto = from; step = 1
		CassidySinFit_kf_test(from,upto,min_limit,L,R,step,WindowName,index)
		Graph_Default(WindowName+index+"_inv")
		Graph_Default(WindowName+index+"_dif")
		Graph_Gain(WindowName+index+"_gain")
		DrawMirrorLossLine(WindowName+index+"_gain",R,L)
		ModifyGraph/W=$(WindowName+index+"_gain") width=0, height=0
		SetAxis/W=$(WindowName+index+"_gain") bottom Xfrom, Xupto
		SetAxis/W=$(WindowName+index+"_gain") left Gfrom, Gupto
	endif
End

////////////////////////
//Cassidy poly fitting//
////////////////////////
Function CassidyPolyFit(from,upto,min_limit,L,R,step,WindowName)
	Variable from,upto,min_limit,L,R,step
	String WindowName
	Variable al = 2
//get ready
	Wave x = WaveRefIndexed(WindowName,0,2)
	String NewWindow = "cp" + WindowName
	Variable pnts = numpnts(x)
	L /= 10000
	Variable w,i,j,k //for main plot
	Variable bf_e,bf_int //raw intensity at extremum
	Variable af_e,af_int //raw energy at extremum
	Variable p,alpha,FSR,imin,alphaeve,isum // for cassidy's equation
//main plot
	for(w=from-1;w<upto;w+=step)
		String originy = WaveName(WindowName,w,1)
		String caswavey = "CP" + originy 
		Duplicate/O $originy,refy
		Differentiate refy/X=x/D=dify 	
		Make/O/N=(pnts/min_limit) energywave, tempwavey
		Make/O/N=(pnts/min_limit) sumwave,minwave,fwave
		
		j = -min_limit
		k = 0
				
		for(i=0;i<pnts;i+=1)
			if(dify[i]*dify[i+1]<=0 && dify[i]>=0)
				i += (refy[i]>refy[i+1])				
				if(i-j<=min_limit)
					continue
				endif
				if(j == -min_limit)
					j = i
					CurveFit/Q/N/W=0 poly 3,refy[j-al,j+al] /X=x 
					Wave W_coef
					bf_e = -W_coef[1]/(2*W_coef[2])
				else
					CurveFit/Q/N/W=0 poly 3,refy[i-al,i+al] /X=x 
					Wave W_coef
					af_e = -W_coef[1]/(2*W_coef[2])
					isum = abs(areaXY(x,refy,bf_e,af_e))
					FSR = (bf_e - af_e)
					bf_int = interp(bf_e,x,refy)
					af_int = interp(af_e,x,refy)
					imin = (bf_int + af_int)/2
					p = abs(isum/(FSR*imin))
					alpha = (p<=1) ? NaN : (ln((p-1)/(R*(p+1))))/L
					tempwavey[k] = alpha
					energywave[k] = (bf_e + af_e)/2
					////to check error	
					sumwave[k] = isum;minwave[k] = imin;fwave[k] = FSR
					j = i
					k += 1
					bf_e = af_e
				endif
			endif
		endfor
		DeletePoints k-1,((pnts/min_limit)-k+1), energywave, tempwavey
		DeletePoints 0,1, energywave, tempwavey
//interpolation
		Make/N=(pnts) destwavey
		Variable s
		for(s=0;s<pnts;s+=1)
			destwavey[s] = interp(x[s],energywave,tempwavey)
		endfor
		Rename destwavey,$caswavey
//Make graph
		if(w == from-1)
			Display/N=$NewWindow $caswavey vs x as NewWindow 
		else
			Appendtograph/W=$NewWindow $caswavey vs x
		endif
		KillWaves refy, fwave, minwave, sumwave, W_sigma, WOaramConfidenceInterval
		KillWaves tempwavey,energywave,dify,W_coef
	endfor
End

////////////////////////
///Cassidy sin fitting//
////////////////////////
Function CassidySinFit(from,upto,min_limit,L,R,step,WindowName)
	String WindowName
	Variable from,upto,min_limit,L,R,step
//get ready
	Wave x = WaveRefIndexed(WindowName,0,2)
	String NewWindow = WindowName + "_gain"				//change from [ NewWindow = "cs_" + WindowName ] //
	Variable pnts
	pnts = numpnts(x)
	L /= 10000
	Variable w,i,j,k,len,m									//for main plot
	Variable p,alpha,FSR,imin,isum							// for Cassidy's equation
	Variable bf_e,af_e,bf_int,af_int,bf_pnt,af_pnt,bf_sum,af_sum 		// from fitting
	Variable V_FitOptions = 4
	Variable V_FitNumIters
	Make/O/N=200 inv_fity
	Variable chi,min_chi,min_m
//main plot
	for(w=from-1;w<upto;w+=step)
		Wave x = WaveRefIndexed(WindowName,w,2)
		pnts = numpnts(x)
		Wave originy = WaveRefIndexed(WindowName,w,1)
		String originyname = NameOfWave(originy)
		String caswavey = NameOfWave(originy) + "_gain"		//change from [ caswavey = "q_" + NameOfWave(originy) ]//
		Duplicate/O originy,invy
		invy = 1/invy
		String fity = "fit_invy"
		Differentiate invy/X=x/D=dify
		Make/O/N=(pnts/min_limit) energywave, tempwavey
		Make/O/N=(pnts/min_limit) minwave, sumwave, fwave	//To check calculation
		j = -min_limit
		k = 0
		for(i=0;i<pnts;i+=1)
			if(dify[i]*dify[i+1]<=0 && dify[i]>=0)
				i += (invy[i]>invy[i+1])
				if(i-j<=min_limit)
					continue
				endif
				if(j == -min_limit)
					j = i
				else
					len = (i-j) * 20
					CurveFit/Q/N/B=(i-j)/W=0/L=(len) sin ,invy[j,i] /X=x /D
					if(V_FitNumIters == 40)
						j = i
						continue
					endif
					WaveStats/Q $fity
					Duplicate/O $fity,inv_fity
					inv_fity = 1/inv_fity
					if(k == 0)
						bf_e = V_maxloc
						bf_int = 1 / V_max
						bf_pnt = MinSearch(x,bf_e,j,i)
						bf_sum = area(inv_fity, x[bf_pnt], bf_e)
						k += 1
						continue
					endif
					af_e = V_maxloc
					af_int = 1 / V_max
					af_pnt = MinSearch(x,af_e,j,i) - 1
					af_sum = area(inv_fity, x[af_pnt] ,af_e)
					isum = abs(areaXY(x, originy, x[bf_pnt], x[af_pnt] )) + abs(bf_sum) + abs(af_sum)
					imin = (bf_int + af_int)/2
					FSR = (bf_e - af_e)
					p = abs(isum/(FSR * imin))
					alpha = (p<=1) ? NaN : (ln((p-1)/(R*(p+1))))/L
					tempwavey[k-1] = alpha
					energywave[k-1] = (bf_e + af_e)/2
					minwave[k] = imin; sumwave[k] = isum; fwave[k] = FSR
		 			bf_e = af_e
					bf_int = af_int
					bf_pnt = af_pnt + 1
					bf_sum = area(inv_fity, x[bf_pnt] ,af_e)
		 			j = i
					k += 1
				endif
			endif
		endfor
		DeletePoints k-1,((pnts/min_limit)-k+1), energywave, tempwavey
	//interpolation
		Make/N=(pnts) destwavey
		Variable s
		for(s=0;s<pnts;s+=1)
			destwavey[s] = interp(x[s],energywave,tempwavey)
		endfor
		Rename destwavey,$caswavey
		printf "%s = %s ( R : %g , L : %g [um] )\r", caswavey, originyname, R, L*10000
	//Append to graph
		if(w == from-1)
			Display/N=$NewWindow $caswavey vs x as WindowName + "_gain"		//change from [ as "cs_" + WindowName ]//
		else
			AppendToGraph/W=$NewWindow $caswavey vs x
		endif	
		KillWaves $fity, tempwavey, energywave, invy, dify
	endfor
	KillWaves W_coef, W_sigma, W_ParamConfidenceInterval
	KillWaves inv_fity, fwave, sumwave, minwave
End

//////////////
//Min Search//
//////////////
Function MinSearch(wv,ene,s_pnt,e_pnt)
	Wave wv
	Variable ene,s_pnt,e_pnt
	Variable i
	for(i=s_pnt;i<=e_pnt;i+=1)
		if(wv[i]<=ene)
			break
		endif
	endfor
	return i
End



####################################################################################################
//////////=====     Cassidy Error     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function CassidyErrorWave(yName, xName, alpha_i, R, L)
	String   yName, xName
	Variable alpha_i, R, L
//define parameters
	String   errorName
	Variable p, g, alpha_m
	Variable i, N
	Variable Npixel, Npoint, CCDerror
//
	Npixel = 24
	Npoint = 15
	CCDerror = 0.05
	WAVE y = $yName
	WAVE x = $xName
	N = numpnts(x)
	Make/D/O/N=(N) error
	alpha_m = ln(1/R)/L
	for(i=0; i<N; i+=1)
		if (numtype(y[i])==2)	//if y is NaN
			error[i] = NaN
			continue
		endif
		g = y[i] - alpha_i - alpha_m
		p = (g<0) ? (1+R*exp(g*L))/(1-R*exp(g*L)) : inf
		error[i] = (2*CCDerror)/(sqrt(Npixel)*sqrt(Npoint))*(2/L)*(p/(p^2-1))
	endfor
End



####################################################################################################
//////////=====     KMS relation     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

///////////////////
//KMS make window//
///////////////////
Function KMS_MakeWindow()
//define parameters
	String 	 PLGraphName, GainGraphName
	String   KMSFolderName, KMSFolderPath, currentFolder
	String   KMSGraphName, Index
	Variable PLWaveNum, GainWaveNum
	Variable axisEmax, axisEmin
	Variable axisImax, axisImin
	Variable axisGmax, axisGmin
	Variable axisFmax, axisFmin
//set parameters (initial value)
	PLGraphName   = WinName(1,1) ; PLWaveNum = 1
	GainGraphName = WinName(0,1) ; GainWaveNum = 1
	axisEmin = 1.56 ; axisEmax = 1.60
//input parameters
	Prompt PLGraphName, "PL Graph", popup, WinList("*",";","WIN:1")
	Prompt GainGraphName, "Gain Graph", popup, WinList("*",";","WIN:1")
	Prompt PLWaveNum, "PL Wave Number"
	Prompt GainWaveNum, "Gain Wave Number"
	Prompt axisEmin, "X range from [eV]"
	Prompt axisEmax, "X range upto [eV]"
	Prompt Index, "graph & folder name index"
	DoPrompt "KMS relation", PLGraphName, GainGraphName, PLWaveNum, GainWaveNum, axisEmin, axisEmax, Index
	if (V_flag==1)
		Print "canceled by user"
		return -1
	endif
//set string and wave
	KMSGraphName = "KMS_" + Index
	currentFolder = GetdataFolder(1)
	KMSFolderName = "KMS_" + Index
	KMSFolderPath = "root:KMS_Folder:" + KMSFolderName
	WAVE/Z orgIy = WaveRefIndexed(PLGraphName,PLWaveNum-1,1)
	WAVE/Z orgIx = XWaveRefFromTrace(PLGraphName,NameOfWave(orgIy))
	WAVE/Z orgGy = WaveRefIndexed(GainGraphName,GainWaveNum-1,1)
	WAVE/Z orgGx = XWaveRefFromTrace(GainGraphName,NameOfWave(orgGy))
//error handling
	if (!WaveExists(orgIy) || !WaveExists(orgIx) || !WaveExists(orgGy) || !WaveExists(orgGx))
		Print "can't wave reference."
		return -1
	endif
	if (axisEmin>=axisEmax)
		Print "input Emin < Emax"
		return -1
	endif
	if (WindowExists(KMSGraphName,0)==1)
		Print "same name window exists."
		return -1
	endif
	if (DataFolderExists(KMSFolderPath))
		Print "same name data folder exists."
		return -1
	endif
//make folder, wave, variable
	NewDataFolder/O   root:KMS_Folder
	NewDataFolder/O/S $KMSFolderPath
	Duplicate/O orgIy, srcIy; Note/K srcIy, GetWavesDataFolder(orgIy,2); Duplicate/O srcIy, Iy
	Duplicate/O orgIx, srcIx; Note/K srcIx, GetWavesDataFolder(orgIx,2); Duplicate/O srcIx, Ix
	Duplicate/O orgGy, srcGy; Note/K srcGy, GetWavesDataFolder(orgGy,2); Duplicate/O srcGy, Gy
	Duplicate/O orgGx, srcGx; Note/K srcGx, GetWavesDataFolder(orgGx,2); Duplicate/O srcGx, Gx
	Variable/G  Ioffset, Goffset
	Variable/G  Tini, Tfit, Texp
	Variable/G  Cini, Cfit, Cexp
	Variable/G  mu
	Variable/G  Emax, Emin
	Variable/G  fitMode
	Emax = axisEmax	; Emin = axisEmin
	Ioffset  = 0 	; Goffset  = 0
	fitMode  = 0	; Tini = 60
//set I & G axis parameters
	WaveStats/Q/R=[binarysearch(Ix,Emin+(Emax-Emin)*0.2),binarysearch(Ix,Emax-(Emax-Emin)*0.2)] Iy ; Iy *= 100/V_max ; srcIy *= 100/V_max
	axisImax = 105
	axisImin = 0
	WaveStats/Q/R=[binarysearch(Gx,Emin+(Emax-Emin)*0.2),binarysearch(Gx,Emax-(Emax-Emin)*0.2)] Gy
	axisGmax = ceil(V_max)+1
	axisGmin = axisGmax*(-2)
//make KMS window
	Display/W=(5,0,365,520)/N=$KMSGraphName as KMSGraphName
//KMS fitting
	KMS_Fit(fitMode)
//set F axis parameters
	WAVE Fx       = $("Fx")
	WAVE Fy       = $("Fy")
	WAVE Fy_fit   = $("Fy_fit")
	WAVE Fexp     = $("Fexp")
	WAVE Fexp_cal = $("Fexp_cal")
	WAVE Fexp_fit = $("Fexp_fit")
	WAVE Fconst   = $("Fconst")
	WaveStats/Q/R=[BinarySearch(Fx,mu-0.01),BinarySearch(Fx,mu+0.01)]/Z Fy
	axisFmax = (V_max-V_min)*1.5 ; axisFmin = (V_max-V_min)*(-1.0)
//modify KMS window
	AppendToGraph/L        Iy       vs Ix	; ModifyGraph rgb(Iy)      =(65280,    0,    0), lsize(Iy)      =1.5
	AppendToGraph/R        Gy       vs Gx	; ModifyGraph rgb(Gy)      =(    0,    0,65280), lsize(Gy)      =1.5
	AppendToGraph/L=F      Fy       vs Fx	; ModifyGraph rgb(Fy)      =(    0,65280,    0), lsize(Fy)      =1.5
	AppendToGraph/L=F      Fy_fit	vs Fx		; ModifyGraph rgb(Fy_fit)  =(    0,    0,    0), lsize(Fy_fit)  =1.0
	AppendToGraph/L=Fexp   Fexp     vs Fx	; ModifyGraph rgb(Fexp)    =(    0,39168,    0), lsize(Fexp)    =3.0
	AppendToGraph/L=Fexp   Fexp_fit	vs Fx		; ModifyGraph rgb(Fexp_fit)=(65280,43520,    0), lsize(Fexp_fit)=2.0
	AppendToGraph/L=Fexp   Fexp_cal vs Fx	; ModifyGraph rgb(Fexp_cal)=(    0,    0,    0), lsize(Fexp_cal)=1.0
	AppendToGraph/R=Fconst Fconst   vs Fx	; ModifyGraph rgb(Fconst)  =(    0,    0,    0), lsize(Fconst)  =1.5
	SetAxis bottom, axisEmin, axisEmax; Label bottom "\\Z12Photon Energy (eV)"
	SetAxis left  , axisImin, axisImax; Label left   "\\Z12PL Intensity (arb. unit)"
	SetAxis right , axisGmin, axisGmax; Label right  "\\Z12Modal Gain (cm\\S-1\\M\\Z12)"
	SetAxis F     , axisFmin, axisFmax
	SetAxis Fexp  ,     -0.2,      1.8
	SetAxis Fconst,       -4,        6
	ModifyGraph margin(left)=20, margin(bottom)=30, margin(right)=40, margin(top)=10	
	ModifyGraph tick=2, minor=1, standoff=0, fsize=10
	ModifyGraph 														  mirror(bottom)=1
	ModifyGraph axisEnab(left)  ={0.76,1.00}								  , noLabel(left)  =1
	MOdifyGraph axisEnab(right) ={0.40,0.76}
	ModifyGraph axisEnab(F)     ={0.40,1.00}, tick(F)     =3, mirror(F)     =1, noLabel(F)     =2, freePos(F)     ={  0,bottom}
	ModifyGraph axisEnab(Fexp)  ={0.15,0.40}, tick(Fexp)  =2, mirror(Fexp)  =1, noLabel(Fexp)  =2, freePos(Fexp)  ={  0,bottom}
	ModifyGraph axisEnab(Fconst)={0.00,0.15}, tick(Fconst)=2, mirror(Fconst)=1, noLabel(Fconst)=1, freePos(Fconst)={100,bottom}
	SetDrawEnv  xcoord=prel,ycoord=prel  ,linefgc=(    0,    0,    0)       ; DrawLine 0,0.24,1,0.24	
	SetDrawEnv  xcoord=prel,ycoord=prel  ,linefgc=(    0,    0,    0)       ; DrawLine 0,0.60,1,0.60
	SetDrawEnv  xcoord=prel,ycoord=prel  ,linefgc=(    0,    0,    0)       ; DrawLine 0,0.85,1,0.85
	SetDrawEnv  xcoord=prel,ycoord=right ,linefgc=(34816,34816,34816),dash=3; DrawLine 0,0.00,1,0.00
	SetDrawEnv  xcoord=prel,ycoord=Fexp  ,linefgc=(34816,34816,34816),dash=3; DrawLine 0,0.00,1,0.00
	SetDrawEnv  xcoord=prel,ycoord=Fconst,linefgc=(34816,34816,34816),dash=3; DrawLine 0,1.00,1,1.00
	ControlBar  60
	SetVariable ctrl_Ioffset title="Ioffset"       , pos={ 30,10}, size={105,18}, bodyWidth=52, value=$(KMSfolderPath+":Ioffset"), format="%+4.1f", limits={-9.9,9.9,0.1 }, font="Courier New", proc=KMS_SetVarProc
	SetVariable ctrl_Goffset title="Goffset"       , pos={ 30,35}, size={105,18}, bodyWidth=52, value=$(KMSfolderPath+":Goffset"), format="%+4.1f", limits={-9.9,9.9,0.1 }, font="Courier New", proc=KMS_SetVarProc
	SetVariable ctrl_Tini    title="Tinitial [K]"  , pos={160,10}, size={161,18}, bodyWidth=73, value=$(KMSfolderPath+":Tini")   , format="%7.3f" , limits={0.01,999,1   }, font="Courier New", proc=KMS_SetVarProc
	SetVariable ctrl_Cini    title="Cinitial [K]"  , pos={160,35}, size={161,18}, bodyWidth=73, value=$(KMSfolderPath+":Cini")   , format="%7.3f" , limits={0.01,999,0.05}, font="Courier New", proc=KMS_SetVarProc
	PopupMenu   ctrl_fitMode title=""			   , pos={352, 9}, size={ 80,18}, bodyWidth= 0, value="T mode;C mode;"													  , font="Courier New", proc=KMS_PopMenuProc
	Button      ctrl_PlotFit title="KMS Fitting"   , pos={350,34}, size={ 78,20}																						  , font="Arial"      , proc=KMS_ButtonProc
	ShowInfo
//others
	SetDataFolder currentFolder
End

///////////////
//KMS fitting//
///////////////
Function KMS_Fit(fitMode)
	Variable fitMode
//define parameters
	String   KMSFolderName, KMSFolderPath, currentFolder
	String   KMSGraphName
	String   text
	Variable Efrom, Eupto
	Variable Pfrom, Pupto
	Variable findmuPfrom, findmuPupto
	Variable pnts, p
	Variable k, E, I, g
//set parameters
	k = PhysicalConstants("k_B")	//Boltzmann constant [eV/K]
	KMSGraphName  = WinName(0,1)
	currentFolder = GetDataFolder(1)
	KMSFolderName = KMSGraphName
	KMSfolderPath = "root:KMS_Folder:" + KMSGraphName
	SetDataFolder KMSFolderPath
//read parameters
	WAVE srcIy = $(KMSfolderPath+":srcIy"), Iy = $(KMSfolderPath+":Iy")
	WAVE srcIx = $(KMSfolderPath+":srcIx"), Ix = $(KMSfolderPath+":Ix")
	WAVE srcGy = $(KMSfolderPath+":srcGy"), Gy = $(KMSfolderPath+":Gy")
	WAVE srcGx = $(KMSfolderPath+":srcGx"), Gx = $(KMSfolderPath+":Gx")
	NVAR Emax = $(KMSfolderPath+":Emax"), Emin = $(KMSfolderPath+":Emin")
	NVAR Ioffset = $(KMSfolderPath+":Ioffset"), Goffset = $(KMSfolderPath+":Goffset")
	NVAR Tini = $(KMSfolderPath+":Tini")
	NVAR Tfit = $(KMSfolderPath+":Tfit")
	NVAR Cini = $(KMSfolderPath+":Cini")
	NVAR Cfit = $(KMSfolderPath+":Cfit")
	NVAR Texp = $(KMSfolderPath+":Texp")
	NVAR Cexp = $(KMSfolderPath+":Cexp")
	NVAR mu   = $(KMSfolderPath+":mu")
//derive mu
	WaveStats/Q/R=[binarysearch(Gx,Emin+(Emax-Emin)*0.2),binarysearch(Gx,Emax-(Emax-Emin)*0.2)] Gy
	findmuPfrom = V_maxloc
	findmuPupto = binarysearch(Gx,Emax)
	FindLevel/P/Q/R=[findmuPfrom,findmuPupto] Gy, 0
	mu = Gx[V_LevelX]
//put text box for mu
	sprintf text, "\\Z10\\F'Courier New'mu : %8.6f eV", mu
	TextBox/A=RT/C/N=text0/X=2/Y=2 text
//make Fx wave
	Make_XWave("Fx",Emin,Emax,0.0001,0); WAVE Fx = $("Fx")
	pnts = numpnts(Fx)
//set Efrom & Eupto (fitting range)
	if (WaveExists(CsrXWaveRef(A))&&WaveExists(CsrXWaveRef(B)))
		Efrom = (CsrXWaveRef(A,KMSGraphName)[pcsr(A)]<CsrXWaveRef(B,KMSGraphName)[pcsr(B)]) ? CsrXWaveRef(A,KMSGraphName)[pcsr(A)] : CsrXWaveRef(B,KMSGraphName)[pcsr(B)]
		Eupto = (CsrXWaveRef(A,KMSGraphName)[pcsr(A)]<CsrXWaveRef(B,KMSGraphName)[pcsr(B)]) ? CsrXWaveRef(B,KMSGraphName)[pcsr(B)] : CsrXWaveRef(A,KMSGraphName)[pcsr(A)]
	else
		Efrom = mu - 0.005
		Eupto = mu + 0.005
	endif
	Pfrom = BinarySearch(Fx,Efrom)
	Pupto = BinarySearch(Fx,Eupto)
//culculate C_initial
	if (fitMode == 0)
	Make/D/O/N=(pnts) wvCini
	for (p=0; p<pnts; p+=1)
		E = Fx[p]
		I = interp(E,Ix,Iy)
		g = interp(E,Gx,Gy)
		if (E != mu)
			wvCini[p] = I*(1-Exp((E-mu)/(k*Tini)))/(E^2*g)
		else
			wvCini[p] = NaN
		endif
	endfor
	WaveStats/Q/R=[Pfrom,Pupto]/Z wvCini
	Cini = V_avg
	endif
//make Fy wave
	Make/D/O/N=(pnts) Fy
	for(p=0; p<pnts; p+=1)
		E = Fx[p]
		I = interp(E,Ix,Iy)
		g = interp(E,Gx,Gy)
		Fy[p] = ln(1-Cini*E^2*g/I)
	endfor
//fitting F wave & culculate T_fitting
	Make/D/O/N=(pnts) Fy_fit
	Make/D/O/N=2      W_coef
	CurveFit/N/Q line, Fy[Pfrom,Pupto] /X=Fx/D=Fy_fit
	for (p=0; p<Pfrom; p+=1)
		Fy_fit[p] = NaN
	endfor
	for (p=pnts; p>Pupto; p-=1)
		Fy_fit[p] = NaN
	endfor
	Tfit = 1/(k*W_coef[1])
//culculate C_fitting
	Make/D/O/N=(pnts) wvCfit
	for (p=0; p<pnts; p+=1)
		E = Fx[p]
		I = interp(E,Ix,Iy)
		g = interp(E,Gx,Gy)
		if (E != mu)
			wvCfit[p] = I*(1-Exp((E-mu)/(k*Tfit)))/(E^2*g)
		else
			wvCfit[p] = NaN
		endif
	endfor
	WaveStats/Q/R=[Pfrom,Pupto]/Z wvCfit
	Cfit = V_avg
//put text box for Cini, Tini
	sprintf text, "\\Z10\\F'Courier New'Tfit :%7.3f\rCfit :%7.3f", Tfit, Cfit
	TextBox/A=LB/C/N=text1/X=2/Y=41 text
//make Fexp wave
	Make/D/O/N=(pnts) Fexp
	for(p=0; p<pnts; p+=1)
		E = Fx[p]
		I = interp(E,Ix,Iy)
		g = interp(E,Gx,Gy)
		Fexp[p] = -1*E^2*g/I
	endfor
//fitting Fexp wave & culculate Cexp, Texp
	Make/D/O/N=(pnts) Fexp_fit
	Make/D/O/N=3      W_coef
	W_coef[0] = Cini
	W_coef[1] = 1/(k*Tfit)
	W_coef[2] = mu
	FuncFit/N/Q/H="001" KMS_FitFunc W_coef  Fexp[Pfrom,Pupto] /X=Fx /D=Fexp_fit
	for (p=0; p<Pfrom; p+=1)
		Fexp_fit[p] = NaN
	endfor
	for (p=pnts; p>Pupto; p-=1)
		Fexp_fit[p] = NaN
	endfor
	Cexp = W_coef[0]
	Texp = 1/(k*W_coef[1])
//make Fexp_cal wave
	Make/D/O/N=(pnts) Fexp_cal
	for(p=0; p<pnts; p+=1)
		E = Fx[p]
		Fexp_cal[p] = (exp((E-mu)/(k*Tfit))-1)/Cini
	endfor
//put text box for Cexp, Texp
	sprintf text, "\\Z10\\F'Courier New'Texp :%7.3f\rCexp :%7.3f", Texp, Cexp
	TextBox/A=LT/C/N=text2/X=2/Y=61 text
//make Fconst wave
	Make/D/O/N=(pnts) Fconst
	for(p=0; p<pnts; p+=1)	
		E = Fx[p]
		I = interp(E,Ix,Iy)
		g = interp(E,Gx,Gy)
		Fconst[p] = Cini*E^2*g/I + exp((E-mu)/(k*Tfit))
	endfor
//others
	SetDataFolder currentFolder
End


Function KMS_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String   ctrlName
	Variable varNum
	String   varStr
	String   varName
//define parameters
	String   KMSGraphName, currentFolder, KMSFolderName, KMSfolderPath
//set parameters
	KMSGraphName = WinName(0,1)
	currentFolder = GetDataFolder(1)
	KMSFolderName = KMSGraphName
	KMSfolderPath = "root:KMS_Folder:" + KMSGraphName
//read parameters
	WAVE srcIy = $(KMSfolderPath+":srcIy"), Iy = $(KMSfolderPath+":Iy")
	WAVE srcIx = $(KMSfolderPath+":srcIx"), Ix = $(KMSfolderPath+":Ix")
	WAVE srcGy = $(KMSfolderPath+":srcGy"), Gy = $(KMSfolderPath+":Gy")
	WAVE srcGx = $(KMSfolderPath+":srcGx"), Gx = $(KMSfolderPath+":Gx")
	NVAR Emax = $(KMSfolderPath+":Emax"), Emin = $(KMSfolderPath+":Emin")
	NVAR Ioffset = $(KMSfolderPath+":Ioffset"), Goffset = $(KMSfolderPath+":Goffset")
	NVAR Tini = $(KMSfolderPath+":Tini")
	NVAR Tfit = $(KMSfolderPath+":Tfit")
	NVAR Cini = $(KMSfolderPath+":Cini")
	NVAR Cfit = $(KMSfolderPath+":Cfit")
	NVAR Texp = $(KMSfolderPath+":Texp")
	NVAR Cexp = $(KMSfolderPath+":Cexp")
	NVAR mu   = $(KMSfolderPath+":mu")
	NVAR fitMode = $(KMSfolderPath+":fitMode")
//main proc
	if    (stringmatch(ctrlName,"ctrl_Ioffset"))
		Iy = srcIy + Ioffset
		KMS_Fit(fitMode)
	elseif(stringmatch(ctrlName,"ctrl_Goffset"))
		Gy = srcGy + Goffset
		KMS_Fit(fitMode)
	elseif(stringmatch(ctrlName,"ctrl_Tini"))
		fitMode = 0
		KMS_Fit(fitMode)
	elseif(stringmatch(ctrlName,"ctrl_Cini"))
		fitMode = 1
		KMS_Fit(fitMode)
	endif
End


Function KMS_PopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
    String ctrlName
    Variable popNum		// which item is currently selected (1-based)
    String popStr		// contents of current popup item as string
//define parameters
	String   KMSGraphName, currentFolder, KMSFolderName, KMSfolderPath
//set parameters
	KMSGraphName = WinName(0,1)
	currentFolder = GetDataFolder(1)
	KMSFolderName = KMSGraphName
	KMSfolderPath = "root:KMS_Folder:" + KMSGraphName
//read parameters
	NVAR fitMode = $(KMSfolderPath+":fitMode")
//main proc
	if    (stringmatch(popStr,"T mode"))
		fitMode = 0
	elseif(stringmatch(popStr,"C mode"))
		fitMode = 1
	endif
End


Function KMS_ButtonProc(ctrlName) : ButtonControl
	String ctrlName
//define parameters
	String   KMSGraphName, currentFolder, KMSFolderName, KMSfolderPath
//set parameters
	KMSGraphName = WinName(0,1)
	currentFolder = GetDataFolder(1)
	KMSFolderName = KMSGraphName
	KMSfolderPath = "root:KMS_Folder:" + KMSGraphName
//read parameters
	NVAR fitMode = $(KMSfolderPath+":fitMode")
//main proc
	KMS_Fit(fitMode)
End


Function KMS_FitFunc(w,E) : FitFunc
	Wave     w
	Variable E
	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(E) = C^(-1)*(exp(beta*(E-mu))-1)
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ E
	//CurveFitDialog/ Coefficients 3
	//CurveFitDialog/ w[0] = C
	//CurveFitDialog/ w[1] = beta
	//CurveFitDialog/ w[2] = mu
	return w[0]^(-1)*(exp(w[1]*(E-w[2]))-1)
End



####################################################################################################
//////////=====     KS relation     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

/////////////
//KS [plot]//
/////////////
Function KS_plot()
//define parameters
	String PLGraphName, AbsGraphName, KSGraphName, index
	String FxName, FyName
	String FolderName, currentDataFolder
	Variable PLNum, AbsNum
	Variable i, pnts
	Variable E, PL, Abs
	Variable Efrom, Eupto
	PLGraphName = WinName(1,1)
	AbsGraphName = WinName(0,1)
	Efrom = 1.56; Eupto = 1.60
//Read PL and Gain Wave
	Prompt PLGraphName, "PL Graph", popup, WinList("*",";","WIN:1")
	Prompt AbsGraphName, "Abs. Graph", popup, WinList("*",";","WIN:1")
	Prompt PLNum, "PL Wave Number"
	Prompt AbsNum, "Abs. Wave Number"
	Prompt Efrom, "Photon Energy from [eV]"
	Prompt Eupto, "Photon Energy upto [eV]"
	Prompt index, "KS index"
	DoPrompt "KS plot" PLGraphName, AbsGraphName, PLNum, AbsNum, Efrom, Eupto, index
	if (V_flag==1)
		DoAlert 0,"Cancel"
		Print "Cancel"
		return -1
	endif
	WAVE PLy = WaveRefIndexed(PLGraphName,PLNum-1,1)
	WAVE PLx = XWaveRefFromTrace(PLGraphName,NameOfWave(PLy))
	WAVE Absy = WaveRefIndexed(AbsGraphName,AbsNum-1,1)
	WAVE Absx = XWaveRefFromTrace(AbsGraphName,NameOfWave(Absy))
//make data folder
	currentDataFolder = GetDataFolder(1)
	FolderName = "KS_"+index
	NewDataFolder/O/S :$FolderName
//make Fx wave
	sprintf FxName, "F%s_x", index
	Make_XWave(FxName,Efrom,Eupto,0.0001,0)
	WAVE Fx = $FxName
	pnts = numpnts(Fx)
//make Fy wave
	sprintf FyName, "F%s_y", index
	Make/D/O/N=(pnts) $FyName
	WAVE Fy = $FyName
	for (i=0; i<pnts; i+=1)
		E = Fx[i]
		PL = interp(E,PLx,PLy)
		Abs = interp(E,Absx,Absy)
		Fy[i] = ln((E^2*Abs)/PL)
	endfor
//make KMS plot Graph
	KSGraphName = "KS_"+index
	Display/N=$KSGraphName as KSGraphName
	AppendToGraph/W=$KSGraphName/L PLy vs PLx
	AppendToGraph/W=$KSGraphName/R Absy vs Absx
	AppendToGraph/W=$KSGraphName/L=left_F Fy vs Fx
	GraphStyle_KS(KSGraphName,Efrom,Eupto)
//Others
	SetDataFolder currentDataFolder
End

////////////
//KS [fit]//
////////////
Function KS_fit()
//define parameters
	Variable E, PL, Abs, k, Tfit
	Variable Pfrom, Pupto
	Variable mode
	String KSGraphName, index
	String FolderName, currentDataFolder
	String text
	String CsrAWaveStr, CsrBWaveStr
//error handling
	CsrAWaveStr = CsrWave(A,"")
	CsrBWaveStr = CsrWave(B,"")
	if (strlen(CsrAWaveStr) == 0 && strlen(CsrBWaveStr) == 0)
		DoAlert 0, "Not select wave."
		Print "Cancel"
		return -1
	elseif (stringmatch(CsrAWaveStr,CsrBWaveStr)==0)
		DoAlert 0, "put cursor A and B on same wave."
		Print "Cancel"
		return -1
	endif
//set parameters
	KSGraphName = WinName(0,1)
	index = KSGraphName[4,inf]
	currentDataFolder = GetDataFolder(1)
	FolderName = KSGraphName
	k = 8.618*10^(-5)
	SetDataFolder :$FolderName
//fit check
	NVAR/Z gVar_Tfit
	if (!NVAR_Exists(gVar_Tfit))
		mode = 0
		Variable/G gVar_Tfit
	else
		mode = 1
		WAVE Fy_fit_old = WaveRefIndexed(KSGraphName,0,1)
		RemoveFromGraph $NameOfWave(Fy_fit_old)
		KillWaves Fy_fit_old
	endif
//read wave
	WAVE PLy = WaveRefIndexed(KSGraphName,0,1)
	WAVE PLx = XWaveRefFromTrace(KSGraphName,NameOfWave(PLy))
	WAVE Absy = WaveRefIndexed(KSGraphName,1,1)
	WAVE Absx = XWaveRefFromTrace(KSGraphName,NameOfWave(Absy))
	WAVE Fy = WaveRefIndexed(KSGraphName,2,1)
	WAVE Fx = XWaveRefFromTrace(KSGraphName,NameOfWave(Fy))
//fitting and set Tfit
	Pfrom = (pcsr(A) < pcsr(B)) ? pcsr(A) : pcsr(B)
	Pupto = (pcsr(A) < pcsr(B)) ? pcsr(B) : pcsr(A)
	CurveFit/Q/N line, Fy[Pfrom,Pupto] /X=Fx/D
	WAVE Fy_fit = $("fit_"+NameOfWave(Fy))
	WAVE W_coef = $("W_coef")
	Tfit = 1/(W_coef[1]*k); gVar_Tfit = Tfit
	Rename Fy_fit, $(NameOfWave(Fy)+"_fit")
//modify graph
	ReorderTraces $(NameOfwave(PLy)), {$(NameOfWave(Fy_fit))}
	ModifyGraph lsize($(NameOfWave(Fy_fit)))=10, rgb($(NameOfWave(Fy_fit)))=(48896,65280,48896)
//put textbox
	sprintf text, "%1.1fK\r%1.4feV-%1.4feV", Tfit, Fx[Pfrom], Fx[Pupto]
	TextBox/C/N=Tfit/A=RT text
//Others
	KillWaves W_coef, W_sigma
	SetDataFolder currentDataFolder
End


####################################################################################################
//////////=====     Save and Read Text File    =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////////////////////////////
//Save Waves from Graph to Text File//
//////////////////////////////////////
Function SaveGraph_TextFile()
//define parameters
	Variable w, N, RenameMode
	String   srcXName, srcYName, srcGraphName
	String   XName, YName, GraphName, Comment, DataTitle
	String   list, TextFileName
	String   currentFolder, tmpFolderPath, tmpFolderName
	String   tmpStr
//set parameters
	srcGraphName = WinName(0,1)
	N = CountWaves(srcGraphName)
	currentFolder = GetDataFolder(1)
	tmpFolderName = "tmpDataFolder"
	tmpFolderPath = currentFolder + tmpFolderName
//input file name
	GraphName  = srcGraphName
	RenameMode = 2
	sprintf tmpStr, "Save waves in \"%s\" graph to Text File", srcGraphName
	Prompt GraphName, "input graph name."
	Prompt Comment, "input comment, if necessary."
	Prompt RenameMode, "rename wave name.", popup, " 1 : Yes; 2 : No;"
	DoPrompt tmpStr, GraphName, Comment, RenameMode
	if (V_flag == 1)
		Print "canceled by user"
		Return -1
	endif
	if (strlen(GraphName)>28)	//
		DoAlert 0, "graph name too long (less than 27 letters)"
		Print "graph name too long (less than 27 letters)"
		Return -1
	endif
//set up text file name
	if (strlen(Comment)!=0)	//Comment exists.
		DataTitle = GraphName + " " + Comment
	else					//Comment dosen't exist.
		DataTitle = GraphName
	endif
	sprintf TextFileName, "WaveData %s.txt", DataTitle
//set up list and save waves
	DuplicateGraphWaves(srcGraphName,tmpFolderPath)
	SetDataFolder tmpFolderPath
	WAVE/T wvList = $("wvList")
	list = ""
	for (w=0; w<N; w+=1)
		srcYName = wvList[w][5]
		srcXName = wvList[w][6]
		if (N==1)
			YName = GraphName + "_y"
			XName = GraphName + "_x"
		else
			sprintf YName, "%s%02d_y", GraphName, w+1
			sprintf XName, "%s%02d_x", GraphName, w+1
		endif
		if    (RenameMode==1)	//rename waves
			Rename $srcYName, $YName; WAVE Y = $YName
			Rename $srcXName, $XName; WAVE X = $XName
		elseif(RenameMode==2)	//not rename
			WAVE Y = $srcYName
			WAVE X = $srcXName
		endif
		list += GetWavesDataFolder(X,2) + ";" + GetWavesDataFolder(Y,2) + ";"
	endfor
	if (strlen(list) > 0)
		Save/O/J/W/I/B list as TextFileName
	endif
//others
	KillWaves/A/Z
	KillDataFolder/Z tmpFolderPath
	SetDataFolder currentFolder
End


//////////////////
//Read Text File//
//////////////////
Function ReadTextFile()
//define parameters
	Variable refNum
	Variable w, N, i, pnts, mun
	String   TextFileName, TextFilePath
	String   currentFolder, newFolderName, newFolderPath, tmpFolderName, tmpFolderPath
	String   GraphName, TableName, Comment, cmd, DataTitle, GraphTitle
//choose text file
	Open/Z=2/R/T=".txt"/M="Choose text file" refNum
	if (V_flag == -1)					//
		Print "canceled by user"		// user canceled
		Return -1						//
	endif								//
	if (V_flag != 0)					//
		DoAlert 0, "Error in Opening"	// unexpected error
		Return V_flag					//
	endif								//
	Close refNum
//define LoadWave parameters
	TextFileName = path2str(S_filename,0,0)
	TextFilePath = path2str(S_filename,0,1)
//read text name string
	DataTitle = TextFileName[9,strlen(TextFileName)-5]
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



####################################################################################################
//////////=====     Read Other File     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function ReadOtherFile()
	Variable mode
	Prompt mode, "select file type", popup, " 1 : 1D Poisson; 2 : 2D opt;"
	DoPrompt "Read Other File", mode
	if (V_flag==1)
		Print "canceled by user"
		return 0
	endif
	if    (mode==1)	//1D Poisson
		Read1DPoisson()
	elseif(mode==2)	//2D opt
		Read2Dopt()
	endif
End



####################################################################################################
//////////=====     Read 1D Poisson File     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

////////////////////////
//Read 1D Poisson File//
////////////////////////
Function Read1DPoisson()
//defin parameters
	Variable refNum
	String   currentDataFolder, newDataFolderName, newDataFolderPath
	String   FileName, PathName, FileIndex, out_FileName, waveFileName
	String   CBGraphName
//choose text file
	Open/Z=2/R/T=".txt"/M="Choose 1D Poisson file" refNum
	if (V_flag == -1)					//
		Print "canceled by user"		// user canceled
		Return -1						//
	endif								//
	if (V_flag != 0)					//
		DoAlert 0, "Error in Opening"	// unexpected error
		Return V_flag					//
	endif								//
	Close refNum
//define LoadWave parameters
	PathName = path2str(S_filename,1,1)
	FileName = path2str(S_filename,0,0)
	if    (stringmatch(FileName,"*_Out.txt"))
		FileIndex = FileName[0,strlen(FileName)- 9]
	elseif(stringmatch(FileName,"*_Wave.txt"))
		FileIndex = FileName[0,strlen(FileName)-10]
	elseif(stringmatch(FileName,"*_Status.txt"))
		FileIndex = FileName[0,strlen(FileName)-12]
	else
		FileIndex = FileName[0,strlen(FileName)- 5]
	endif
	Out_FileName = FileIndex + "_Out.txt"
	WaveFileName = FileIndex + "_Wave.txt"
	NewPath/O/Q Path PathName
//make new data folder
	currentDataFolder = GetDataFolder(1)
	newDataFolderName = "Poisson_" + FileIndex
	newDataFolderPath = currentDataFolder + newDataFolderName
	NewDataFolder/O/S $newDataFolderPath
//load Out.txt
	LoadWave/A/J/D/W/Q/K=0/P=Path Out_FileName
	Rename $("Y__ang_") , $("x_nm")		; WAVE x  = $("x_nm")		; x /= 10
	Rename $("Ec__eV_") , $("Ec")		; WAVE Ec = $("Ec")
	Rename $("Ev__eV_") , $("Ev")		; WAVE Ev = $("Ev")
	Rename $("Ef__eV_") , $("Ef")		; WAVE Ef = $("Ef")
	Rename $("n__cm_3_"), $("carrier_n"); WAVE n  = $("carrier_n")	; n /= 10^18
	Rename $("p__cm_3_"), $("carrier_p"); WAVE p  = $("carrier_p")	; p /= 10^18
//make conduction band graph
	CBGraphName = "Poisson_"+FileIndex + "_CB"
	Display/N=$CBGraphName as CBGraphName
	AppendToGraph/W=$CBGraphName/L Ec vs x	; ModifyGraph rgb($NameOfWave(Ec))=(0,0,65280)
	AppendToGraph/W=$CBGraphName/L Ef vs x	; ModifyGraph rgb($NameOfWave(Ef))=(0,0,0)
	AppendToGraph/W=$CBGraphName/R n  vs x	; ModifyGraph rgb($NameOfwave(n)) =(65280,43520,0)
	GraphStyle_DefaultDouble(CBGraphName)
	Legend/C/N=text0/A=RT
	ShowInfo
	Label bottom "\\Z12Position (nm)"
	Label left   "\\Z12Conduction Band (eV)"
	Label right  "\\Z12Negative Carrier Density (10\\S18\\M\\Z12cm\\S-3\\M\\Z12)"
//others
	SetDataFolder currentDataFolder
	KillPath Path
	printf "Read 1D Poisson File : %s\r", FileIndex
End



####################################################################################################
//////////=====     Read 2D Opt File     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

////////////////////
//Read 2D Opt File//
////////////////////
Function Read2Dopt()
//defin parameters
	Variable refNum, rowNum, byteNum
	Variable tmpVar, Value, pnt, i, j
	Variable Nx, Ny, Nx_center, Ny_center, dx, dy, Lx, Ly, nodeNum, elementNum
	Variable Xmax, Xmin, Ymax, Ymin
	Variable Xc, Yc, Zc, PXc, PYc, Xo, Yo, Zo, PXo, PYo
	Variable Parmtop, Parmbottom, Pstemleft, Pstemright
	String   FolderName, FileIndex
	String   inputFileName, inputFilePath, lightRef_FileName, lightRef_FilePath, lightWaveFileName, lightWaveFilePath
	String   rowStr, GraphName, textInput, textOutput
	String   currentDataFolder, newDataFolderName
//choose text file
	Open/Z=2/R/T=".exp"/M="Choose 2D opt file" refNum
	if (V_flag == -1)					//
		Print "canceled by user"		// user canceled
		return -1						//
	endif								//
	if (V_flag != 0)					//
		DoAlert 0, "Error in Opening"	// unexpected error
		return V_flag					//
	endif								//
	Close refNum
//define parameters
	FolderName = path2str(S_filename,1,0)
	FileIndex = FolderName[strlen(folderName)-2,Inf]
	    inputFileName = "input.txt"
	    inputFilePath = path2str(S_filename,2,1) + ":" + inputFileName
	lightRef_FileName = "light.exp"
	lightRef_FilePath = path2str(S_filename,1,1) + ":" + lightRef_FileName
	lightWaveFileName = "light1.exp"
	lightWaveFilePath = path2str(S_filename,1,1) + ":" + lightWaveFileName
	GraphName = "Opt_"+path2str(S_filename,2,0)+"_"+FileIndex
//make new data folder
	currentDataFolder = GetDataFolder(1)
	newDataFolderName = "Opt_"+path2str(S_filename,2,0)+"_"+FileIndex
	NewDataFolder/O/S $newDataFolderName
//make variable and wave
	Variable/G W_arm, W_stem, Ref_arm, Ref_stem, Ref_barrier, Ref_eff, confine
//load input.txt file (read input parameters) only first row
	Open/R/Z refNum as inputFilePath
	byteNum = 0
	for(rowNum=1; rowNum<=str2num(FileIndex); rowNum+=1)
		FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rowStr
		byteNum += strlen(rowStr)
	endfor
	Close refNum
	sscanf rowStr, "%f%f%f%f%f%f%f%f%f%f%f", Ny, Nx, dy, dx, Ny_center, Nx_center, W_stem, W_arm, Ref_stem, Ref_arm, Ref_barrier
	dx    /= 10; dy     /= 10	//angstrom -> nm
	W_arm /= 10; W_stem /= 10	//angstrom -> nm
	nodeNum = Nx * Ny
	elementNum = (Nx-1)*(Ny-1)*2
//load light.exp file (read eigen value) only first row
	Open/R/Z refNum as lightRef_FilePath
	rowNum  = 1; byteNum  = 0
	FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rowStr
	Close refNum
	sscanf rowStr, "%f%f", tmpVar, Ref_eff
//load light.exp file (read wave function) from 2nd to (nodeNum+1)th row
	Make/D/O/N=(Nx,Ny) ElectricField, Intensity
	Open/R/Z refNum as lightWaveFilePath
	rowNum  = 1; byteNum  = 0
	FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rowStr
	byteNum += strlen(rowStr)
	for(rowNum=2; rowNum<=nodeNum+1; rowNum+=1)
		FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rowStr
		sscanf rowStr, "%f%f%f%f", tmpVar, Ly, Lx, Value
		ElectricField[Nx-round(Lx/10/dx)][Ny-round(Ly/10/dy)] = Value
		byteNum += strlen(rowStr)
	endfor
	Close refNum
//modify waves and set value
	Intensity = ElectricField^2
	Parmtop    = (Ny-Ny_center)+W_arm/dy/2	; Pstemleft  = Nx_center-1-W_stem/dx/2
	Parmbottom = (Ny-Ny_center)-W_arm/dy/2	; Pstemright = Nx_center-1+W_stem/dx/2
//	for (j=0; j<=Parmbottom-1; j+=1)
//		for (i=0; i<=Pstemleft-1; i+=1)
//			Intensity[i][j] *= Ref_barrier^2
//		endfor
//		for (i=Pstemleft; i<=Pstemright; i+=1)
//			Intensity[i][j] *= Ref_stem^2
//		endfor
//		for (i=Pstemright+1; i<=Nx-1; i+=1)
//			Intensity[i][j] *= Ref_barrier^2
//		endfor
//	endfor
//	for (j=Parmbottom; j<=Parmtop; j+=1)
//		for (i=0; i<=Nx-1; i+=1)
//			Intensity[i][j] *= Ref_arm^2
//		endfor
//	endfor
//	for (j=Parmtop+1; j<=Ny-1; j+=1)
//		for (i=0; i<=Nx-1; i+=1)
//			Intensity[i][j] *= Ref_barrier^2
//		endfor
//	endfor
	Xmin = -((Nx-1)*dx/2)	; Ymin = -((Ny-Ny_center)*dy-W_arm/2)
	Xmax = +((Nx-1)*dx/2)	; Ymax = +((Ny_center -1)*dy+W_arm/2)
	SetScale/I x Xmin, Xmax, ElectricField, Intensity
	SetScale/I y Ymin, Ymax, ElectricField, Intensity
	WaveStats/Q Intensity; Intensity /= (V_sum*dx*dy); WaveStats/Q Intensity
	Xo = 0			; PXo = scale2pnt(NameOfWave(Intensity),Xo,0)	//x location of origin (position of T-wire)
	Yo = 0			; PYo = scale2pnt(NameOfWave(Intensity),Yo,1)	//y location of origin (position of T-wire)
	Xc = V_maxRowLoc; PXc = scale2pnt(NameOfWave(Intensity),Xc,0)	//x location of max intensity
	Yc = V_maxColLoc; PYc = scale2pnt(NameOfWave(Intensity),Yc,1)	//y location of max intensity
	Zo = Intensity[PXo][PYo]										//intensity of T-wire position
	Zc = V_max														//max intensity
	confine = Zo * 14 * 6
//make vertical and horizontal wave
	Make/D/O/N=(Nx) Intensity_Xc, Intensity_Xo
	Make/D/O/N=(Ny) Intensity_Yc
	for (pnt=0; pnt<Ny; pnt+=1)
		Intensity_Yc[pnt] = Intensity[PXc][pnt]
	endfor
	for (pnt=0; pnt<Nx; pnt+=1)
		Intensity_Xc[pnt] = Intensity[pnt][PYc]
		Intensity_Xo[pnt] = Intensity[pnt][PYo]
	endfor
	SetScale/I x Xmin, Xmax, Intensity_Xc, Intensity_Xo
	SetScale/I x Ymin, Ymax, Intensity_Yc
//make dummy wave
	Make/O/N=2 dummy_arm_top, dummy_arm_bottom, dummy_stem_left, dummy_stem_right
	SetScale/I x Xmin, Xmax, dummy_arm_top    ; dummy_arm_top    =  W_arm
	SetScale/I x Xmin, Xmax, dummy_arm_bottom ; dummy_arm_bottom =  0
	SetScale/I x Ymin, 0   , dummy_stem_left  ; dummy_stem_left  = -W_stem/2
	SetScale/I x Ymin, 0   , dummy_stem_right ; dummy_stem_right = +W_stem/2
//make graph
	Display/N=$GraphName as GraphName
	AppendToGraph      dummy_arm_top  , dummy_arm_bottom
	AppendToGraph/VERT dummy_stem_left, dummy_stem_right
	ModifyGraph rgb=(0,0,0)
	AppendMatrixContour Intensity
	ModifyContour Intensity, manLevels={Zc/10,Zc/10,9}, labels=0, ctabLines={*,*,red,1}
	AppendToGraph/L=left_sub        Intensity_Xc,Intensity_Xo
	AppendToGraph/B=bottom_sub/VERT Intensity_Yc
	ModifyGraph rgb($("Intensity_Xc"))=(13056,0,0), rgb($("Intensity_Xo"))=(65280,0,0)
	ModifyGraph rgb($("Intensity_Yc"))=(13056,0,0)
	ModifyGraph width=320, height={Aspect,1}; ModifyGraph width=0
	ModifyGraph margin(left)=40, margin(bottom)=30, margin(right)=20, margin(top)=20
	ModifyGraph font="Arial", fsize=10, tick=2, mirror=1, minor=1, lblPosMode=1, standoff=0
	DrawLine 0.0,0.2,1.0,0.2 ; DrawLine 0.8,0.0,0.8,1.0
	ModifyGraph axisEnab(bottom)    ={0,0.8}
	ModifyGraph axisEnab(left)      ={0,0.8}
	ModifyGraph axisEnab(bottom_sub)={0.8,1}, freePos(bottom_sub)={0,kwFraction}, noLabel(bottom_sub)=2, mirror(bottom_sub)=0, nticks(bottom_sub)=0, minor(bottom_sub)=0
	ModifyGraph axisEnab(left_sub)  ={0.8,1}, freePos(left_sub)  ={0,kwFraction}, noLabel(left_sub)  =2, mirror(left_sub)  =0, nticks(left_sub)  =0, minor(left_sub)  =0
	SetAxis bottom -1000, 1000 ; Label bottom "\\Z12Position (nm)"
	SetAxis left   -1000, 1000 ; Label left   "\\Z12Position (nm)"
	textInput   =   " \\Z10n\\Barm    \\M\\Z10\t: " + num2str(Ref_arm)  + " ,  W\\Barm \\M\\Z10\t: " + num2str(W_arm)  + "nm"
	textInput  += "\r \\Z10n\\Bstem   \\M\\Z10\t: " + num2str(Ref_stem) + " ,  W\\Bstem\\M\\Z10\t: " + num2str(W_stem) + "nm"
	textInput  += "\r \\Z10n\\Bbarrier\\M\\Z10\t: " + num2str(Ref_barrier)
	textOutput  =   " \\Z10confine\t: " + num2str(confine)
	textOutput += "\r \\Z10n\\Beff    \\M\\Z10\t: " + num2str(Ref_eff)
	TextBox/C/N=textInput /A=LT/X=2.5/Y=22.5 textInput
	TextBox/C/N=textOutput/A=LB/X=2.5/Y= 2.5 textOutput
	ShowInfo
//others
	SetDataFolder currentDataFolder
	printf "Read 2D opt File : %s > %s\r", path2str(S_filename,2,0), FolderName
End



####################################################################################################
//////////=====     Igor Program     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

//////////////
//Igor Setup//
//////////////
Function IgorSetup()
//make folder and set global patrameter
	if (DataFolderExists("root:IgorSetupFolder"))
		NVAR/Z IgorSetupSwitch = $("root:IgorSetupFolder:IgorSetupSwitch")
		SVAR/Z IgorSetupMenuStr = $("root:IgorSetupFolder:IgorSetupMenuStr")
		if(!NVAR_Exists(IgorSetupSwitch))
			Variable/G root:IgorSetupFolder:IgorSetupSwitch  = 0			; NVAR IgorSetupSwitch  = $("root:IgorSetupFolder:IgorSetupSwitch")
			String  /G root:IgorSetupFolder:IgorSetupMenuStr = "Igor Setup"	; SVAR IgorSetupMenuStr = $("root:IgorSetupFolder:IgorSetupMenuStr")
		endif
	else
		NewDataFolder/O root:IgorSetupFolder
		Variable/G root:IgorSetupFolder:IgorSetupSwitch  = 0				; NVAR IgorSetupSwitch  = $("root:IgorSetupFolder:IgorSetupSwitch")
		String  /G root:IgorSetupFolder:IgorSetupMenuStr = "Igor Setup"		; SVAR IgorSetupMenuStr = $("root:IgorSetupFolder:IgorSetupMenuStr")
	endif
//main program
	if    (IgorSetupSwitch==0)	//Igor Setup OFF -> ON
		IgorSetupSwitch = 1
	//set hook function
		SetIgorHook  AfterFileOpenHook=IgorOpenHookFunc
		SetIgorHook IgorBeforeQuitHook=IgorQuitHookFunc
	//set preferences
		Preferences/Q 1
	//set default font
		DefaultFont "Arial"
	elseif(IgorSetupSwitch==1)	//Igor Setup ON  -> OFF
		IgorSetupSwitch = 0
		SetIgorHook/K
	endif
//set menu
	IgorSetup_Menu()
End

Function IgorSetup_Menu()
//define parameter
	NVAR IgorSetupSwitch  = $("root:IgorSetupFolder:IgorSetupSwitch")
	SVAR IgorSetupMenuStr = $("root:IgorSetupFolder:IgorSetupMenuStr")
//main program
	if    (IgorSetupSwitch==1)	//Igor Setup ON
		IgorSetupMenuStr = "Igor Setup!" + num2char(18)
		BuildMenu "Others"
	elseif(IgorSetupSwitch==0)	//Igor Setup OFF
		IgorSetupMenuStr = "Igor Setup"
		BuildMenu "Others"
	endif
End


/////////////////////////////
//Auto Save Igor Experiment//
/////////////////////////////
Function IgorAutoSave()
//error handling
	if (!DataFolderExists("root:IgorSetupFolder"))
		return 0
	endif
	NVAR/Z IgorAutoSaveSwitch = $("root:IgorSetupFolder:IgorAutoSaveSwitch")
	if (!NVAR_Exists(IgorAutoSaveSwitch))
		return 0
	endif
//define parameter
	NVAR/Z IgorAutoSaveSwitch = $("root:IgorSetupFolder:IgorAutoSaveSwitch")
	NVAR IgorAutoSavePeriod = $("root:IgorSetupFolder:IgorAutoSavePeriod")
//main program
	if    (IgorAutoSaveSwitch==1)
		 SetBackground IgorAutoSave_Proc()
		CtrlBackground period=IgorAutoSavePeriod*3600, start
	elseif(IgorAutoSaveSwitch==0)
		KillBackGround
	endif
End

Function IgorAutoSave_Proc()
	String DateTimeStr
	DateTimeStr = Secs2DateTime(DateTime)
	SaveExperiment
	printf "---- Save Igor Experiment  %s ----\r", DateTimeStr
	return 0
End

Function IgorAutoSave_Caller()
//define parameters
	Variable SwitchVar, PeriodVar = 5
//read parameters
	Prompt SwitchVar, "auto save switch", popup, " ON; OFF;"
	Prompt PeriodVar, "save period time [minute]"
	DoPrompt "Auto Save Igor Experiment", SwitchVar, PeriodVar
	if (V_flag==1)
		Print "canceled by user."
		return 0
	endif
//value check
	SwitchVar = (SwitchVar==1) ? 1 : 0
	if (PeriodVar<=0)
		PeriodVar = 1
	endif
//set folder and global parameters
	if (DataFolderExists("root:IgorSetupFolder"))
		NVAR/Z IgorAutoSaveSwitch  = $("root:IgorSetupFolder:IgorAutoSaveSwitch")
		NVAR/Z IgorAutoSavePeriod  = $("root:IgorSetupFolder:IgorAutoSavePeriod")
		SVAR/Z IgorAutoSaveMenuStr = $("root:IgorSetupFolder:IgorAutoSaveMenuStr")
		if (NVAR_Exists(IgorAutoSaveSwitch))
			IgorAutoSaveSwitch = SwitchVar
			IgorAutoSavePeriod = PeriodVar
		else
			Variable/G root:IgorSetupFolder:IgorAutoSaveSwitch  = SwitchVar						; NVAR IgorAutoSaveSwitch  = $("root:IgorSetupFolder:IgorAutoSaveSwitch")
			Variable/G root:IgorSetupFolder:IgorAutoSavePeriod  = PeriodVar						; NVAR IgorAutoSavePeriod  = $("root:IgorSetupFolder:IgorAutoSavePeriod")
			String  /G root:IgorSetupFolder:IgorAutoSaveMenuStr = "Igor Auto Save Experiment"	; SVAR IgorAutoSaveMenuStr = $("root:IgorSetupFolder:IgorAutoSaveMenuStr")
		endif
	else
		NewDataFolder/O root:IgorSetupFolder
		Variable/G root:IgorSetupFolder:IgorAutoSaveSwitch  = SwitchVar							; NVAR IgorAutoSaveSwitch  = $("root:IgorSetupFolder:IgorAutoSaveSwitch")
		Variable/G root:IgorSetupFolder:IgorAutoSavePeriod  = PeriodVar							; NVAR IgorAutoSavePeriod  = $("root:IgorSetupFolder:IgorAutoSavePeriod")
		String  /G root:IgorSetupFolder:IgorAutoSaveMenuStr = "Igor Auto Save Experiment"		; SVAR/Z IgorAutoSaveMenuStr = $("root:IgorSetupFolder:IgorAutoSaveMenuStr")
	endif
//main program
	IgorAutoSave()
	IgorAutoSave_Mune()
	if    (SwitchVar==1)
		printf "Auto Save ON [period : %g minute]\r", PeriodVar
	elseif(SwitchVar==0)
		printf "Auto Save OFF\r"
	endif
End

Function IgorAutoSave_Mune()
//define parameter
	NVAR IgorAutoSaveSwitch  = $("root:IgorSetupFolder:IgorAutoSaveSwitch")
	NVAR IgorAutoSavePeriod  = $("root:IgorSetupFolder:IgorAutoSavePeriod")
	SVAR IgorAutoSaveMenuStr = $("root:IgorSetupFolder:IgorAutoSaveMenuStr")
//main program
	if    (IgorAutoSaveSwitch==1)	//Igor Setup ON
		IgorAutoSaveMenuStr = "Igor Auto Save Experiment  [" + num2istr(IgorAutoSavePeriod) + " min]!" + num2char(18)
		BuildMenu "Others"
	elseif(IgorAutoSaveSwitch==0)	//Igor Setup OFF
		IgorAutoSaveMenuStr = "Igor Auto Save Experiment"
		BuildMenu "Others"
	endif
End


//////////////////////
//Igor Start Program//
//////////////////////
Function IgorStartOrNewHook(igorApplicationNameStr)
	String igorApplicationNameStr
//define parameters
	String DateTimeStr = Secs2DateTime(DateTime)
	printf "---- New  Igor Experiment  %s ----\r", DateTimeStr
	IgorSetup()
End

/////////////////////
//Igor Open Program//
/////////////////////
Function IgorOpenHookFunc(refNum,fileNameStr,pathNameStr,fileTypeStr,fileCreatorStr,fileKind)
	String   fileNameStr, pathNameStr, fileTypeStr, fileCreatorStr
	Variable refNum, fileKind
//define parameters
	String   DateTimeStr = Secs2DateTime(DateTime)
	printf "---- Open Igor Experiment  %s ----\r", DateTimeStr
	IgorAutoSave()
////others
	KillVariables/Z V_Flag
	KillStrings  /Z S_info
End

/////////////////////
//Igor Quit Program//
/////////////////////
Function IgorQuitHookFunc(unsavedExp,unsavedNotebooks,unsavedProcedures)
	Variable unsavedExp,unsavedNotebooks,unsavedProcedures
//define parameters
	String   DateTimeStr = Secs2DateTime(DateTime)
	if (unsavedExp==0)
		printf "---- Quit Igor Experiment  %s ----\r\r", DateTimeStr
		SaveExperiment
	endif
End



/////////////////////
//Igor Command List//
/////////////////////
Function IgorCommandList()
	NewPanel /K=1 /W=(450,60,930,250) as "Igor Command List"
	DoWindow/C Igor_Command_List
	SetDrawEnv/W=Igor_Command_List fname = "Arial", fsize = 14, textrgb= (0,0,0), fstyle= 1, save
	DrawText 12,20,"Ctrl+Enter Igor icon : Open New Igor Window"
End


//Ctrl+Alt+W : delete Window



####################################################################################################
//////////=====     Read SPE File     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function ReadSPEFile()
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
	ReadSPEFile_MainProc(mode)
End

Function ReadSPEFile_MainProc(mode)
	Variable mode
//define parameters
	Variable refNum, i, N
	String   FileName, FilePath, FolderPath, FileList
//choose SPE file
	Open/Z=2/R/T=".spe"/M="Choose WinSpec file " refNum
	if (V_flag == -1)					//
		Print "canceled by user"		// user canceled
		return -1						//
	endif								//
	if (V_flag != 0)					//
		DoAlert 0, "Error in Opening"	// unexpected error
		return V_flag					//
	endif								//
	Close refNum
//read SPE data (main proc)
	if (mode==0)	//Reading only one wave choosen
		FilePath = S_filename
		ReadSPEFile_Spectra(FilePath)
	else			//Reading all waves in directry
		FolderPath = path2str(S_filename,1,1)
		NewPath/O/Q SPEFolderPath FolderPath
		FileList = IndexedFile(SPEFolderPath,-1,".spe")
		N = ItemsInList(FileList)
		for(i=0; i<N; i+=1)
			FileName = StringFromList(i,FileList)
			FilePath = FolderPath + ":" + FileName
			ReadSPEFile_Spectra(FilePath)
		endfor
		KillPath/Z SPEFolderPath
	endif
End

Function ReadSPEFile_Spectra(FilePath)
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
//open SPE file
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
//|	wv_x = 1239.5 / wv_x
	Rename wv_x $wv_xName; Note wv_x, FolderName+":"+FileName
//make graph
	Display/N=$GraphName as GraphName+" x "+num2str(frameNum)
//read y data
	for(i=1; i<=frameNum; i+=1)
		Make/D/O/N=(xdim) wv_y
		for(j=0; j<xdim; j+=1)		//laod y data
			wv_y[j] = ReadSPEFile_GetData(refNum,(i-1)*xdim+j,datatype)
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
	printf "Read SPE File : %s\r", FilePath
	Close refNum
End

Static Function ReadSPEFile_GetData(refNum,datanum,datatype)
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



####################################################################################################
//////////=====     Read shf1d File     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

///////////////////
//Read shf1d File//
///////////////////
Function Readshf1dFile()
//define parameters
	String   FolderName, FolderPath, parentFolderName, parentFolderPath
	String   currentFolder, mode
	String   messageStr, rawStr
	Variable refNum, i, N, byteNum
	Variable readMode, graphMode, pl_Mode, absMode, refMode, Vs_Mode, Vc_Mode, WF_Mode
//set parameters
	currentFolder = GetDataFolder(1)
	readMode = 1; graphMode = 2
	 pl_Mode = 1;   absMode = 1
	 refMode = 2;   Vs_Mode = 2
	 Vc_Mode = 2;   WF_Mode = 2
//select read mode
	Prompt  readMode, "select read mode"	, popup, " one folder; all folders;"
	Prompt graphMode, "Display Graph"		, popup, " ON; OFF"
	Prompt   pl_Mode, "pl  wave"			, popup, " ON; OFF"
	Prompt   absMode, "abs wave"			, popup, " ON; OFF"
	Prompt   refMode, "ref wave"			, popup, " ON; OFF"
	Prompt   Vs_Mode, "screened Coulomb"	, popup, " ON; OFF"
	Prompt   Vc_Mode, "bare Coulomb"		, popup, " ON; OFF"
	Prompt   WF_Mode, "wave function"		, popup, " ON; OFF"
	DoPrompt "Read shf1d File", readMode, graphMode, pl_Mode, absMode, refMode, Vs_Mode, Vc_Mode, WF_Mode
	if (V_flag==1)
		Print "canceled by user"
		Return -1
	endif
//set "mode parameter"
	mode = num2istr(readMode)
	if    (pl_Mode==2)
		mode += "0"
	elseif(pl_Mode==1 && graphMode==2)
		mode += "1"
	elseif(pl_Mode==1 && graphMode==1)
		mode += "2"
	endif
	if    (absMode==2)
		mode += "0"
	elseif(absMode==1 && graphMode==2)
		mode += "1"
	elseif(absMode==1 && graphMode==1)
		mode += "2"
	endif
	if    (refMode==2)
		mode += "0"
	elseif(refMode==1 && graphMode==2)
		mode += "1"
	elseif(refMode==1 && graphMode==1)
		mode += "2"
	endif
	if    (Vs_Mode==2)
		mode += "0"
	elseif(Vs_Mode==1 && graphMode==2)
		mode += "1"
	elseif(Vs_Mode==1 && graphMode==1)
		mode += "2"
	endif
	if    (Vc_Mode==2)
		mode += "0"
	elseif(Vc_Mode==1 && graphMode==2)
		mode += "1"
	elseif(Vc_Mode==1 && graphMode==1)
		mode += "2"
	endif
	if    (WF_Mode==2)
		mode += "0"
	elseif(WF_Mode==1 && graphMode==2)
		mode += "1"
	elseif(WF_Mode==1 && graphMode==1)
		mode += "2"
	endif
//choose dat file
	if    (readMode==1)	//one folder
		messageStr = "Choose ''.dat file''"
	elseif(readMode==2)	//all folders
		messageStr = "Choose ''ParaUser_List file''"
	endif
	Open/Z=2/R/T=".dat"/M=messageStr refNum
	if (V_flag == -1)	// user canceled
		Print "canceled by user"
		Return -1
	endif
	if (V_flag != 0)	// unexpected error
		DoAlert 0, "Error in Opening"
		Return V_flag
	endif
//set folder name and read shf1d data
	if    (readMode==1)	//one folder
		FolderName = path2str(S_filename,1,0)
		FolderPath = path2str(S_filename,1,1)
		Readshf1dFile_MainProc(FolderPath,mode)
	elseif(readMode==2)	//all folders
		parentFolderName = path2str(S_filename,1,0)
		parentFolderPath = path2str(S_filename,1,1)
		NewDataFolder/O/S $parentFolderName
		Make/O/T/N=100 CalTitleList
		//read cal title
		byteNum = 0; N = 0
		do
			FSetPos refNum, byteNum ; FReadLine/T=(num2char(10)) refNum, rawStr
			if (stringmatch(rawStr,"Title*"))
				CalTitleList[i] = rawStr[14,strlen(rawStr)-2]		//Title :::::::: 'title string'
				i += 1
			endif
			byteNum += strlen(rawStr)
		while(strlen(rawStr)!=0)
		N = i
		//error handling
		if  (N==0)
			Close refNum
			SetDataFolder currentFolder
			KillDataFolder $parentFolderName
			Print "not found ParaUser_List file."
			return 0
		endif
		//main loop
		for (i=0; i<N; i+=1)
			FolderName = CalTitleList[i]
			FolderPath = parentFolderPath + ":" +CalTitleList[i]
			Readshf1dFile_MainProc(FolderPath,mode)
		endfor
		printf "shf1d folder : %s [%g folders]\r", parentFolderName, N
		KillWaves CalTitleList
	endif
//others
	Close refNum
	KillPath/Z path
	SetDataFolder currentFolder
End

//////////////////
//Main Procedure//
//////////////////
Static Function Readshf1dFile_MainProc(FolderPath,mode)
	String   FolderPath, mode
//defin parameters
	String   FolderName, parentFolderName, currentFolder
	String   datFileList, pl_FileName
//set parameters
	currentFolder = GetDataFolder(1)
	FolderName = path2str(FolderPath,0,0)
	parentFolderName = path2str(FolderPath,1,0)
	NewPath/O/Q path FolderPath
//error handling
	datFileList = IndexedFile(path,-1,".dat")
	pl_FileName = ListMatch(datFileList,"*pl_out*",";"); pl_FileName = pl_FileName[0,strlen(pl_FileName)-2]
	if (strlen(pl_FileName)==0)
		printf "not found shf1d file in ''%s''.\r", FolderName
		return 0
	endif
//main program
	NewDataFolder/O/S $FolderName
	Readshf1dFile_parameters(FolderPath)
	if (stringmatch(mode[1],"1")||stringmatch(mode[1],"2"))	// pl_out.dat
		Readshf1dFile_Spectra(FolderPath, "pl",str2num(mode[1])-1)
	endif
	if (stringmatch(mode[2],"1")||stringmatch(mode[3],"2"))	//abs_out.dat
		Readshf1dFile_Spectra(FolderPath,"abs",str2num(mode[3])-1)
	endif
	if (stringmatch(mode[3],"1")||stringmatch(mode[3],"2"))	//ref_out.dat
		Readshf1dFile_Spectra(FolderPath,"ref",str2num(mode[3])-1)
	endif
//others
	if (stringmatch(mode[0],"1"))	//read only one folder
		printf "shf1d folder : %s [in %s]\r", FolderName, parentFolderName
	endif
	SetDataFolder currentFolder
End

///////////////////
//Read Parameters//
///////////////////
Static Function Readshf1dFile_Parameters(FolderPath)
	String   FolderPath
//define parameters
	String   FolderName, datFileList, datFileName, datFilePath
	String   rawStr, tmpStr, methodStr, dataStr
	Variable refNum, byteNum, i, N
//set patrameters
	 FolderName = path2str(FolderPath,0,0)
	datFileList = IndexedFile(path, -1, ".dat")
	datFileName = ListMatch(datFileList,"*pl_out*",";"); datFileName = datFileName[0,strlen(datFileName)-2]
	datFilePath = FolderPath + ":" + datFileName
//make parameter string, variable, wave
	Variable/G   lx, ly, m_e, m_h, epsilon_0, r_dipole, E_0, a_0
	String  /G   CalMethod, Screening, LineShape, StartTime
	Make/O/N=500 wv_t, wv_damp, wv_ne, wv_nh, wv_ue, wv_uh, wv_BGR, wv_Ech, wv_Eexe, wv_Eexh, wv_pole, wv_qs, wv_u, wv_ues, wv_uhs
//read dat file data
	Open/R/Z=1/p=path refNum as datFilePath
	//read rectangle parameters
	byteNum=0
	do
		FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rawStr
		if    (stringmatch(rawStr,"*size of wire*"))
			sscanf rawStr, "%f%f%s", lx, ly, tmpStr
		elseif(stringmatch(rawStr,"*Mass of Electron*"))
			sscanf rawStr, "%f%s", m_e, tmpStr
		elseif(stringmatch(rawStr,"*Mass of Heavy Hole in plane*"))
			sscanf rawStr, "%f%s", m_h, tmpStr
		elseif(stringmatch(rawStr,"*Background Dielectronic Constant*"))
			sscanf rawStr, "%f%s", epsilon_0, tmpStr
		elseif(stringmatch(rawStr,"*dipole moment*"))
			sscanf rawStr, "%f%s", r_dipole, tmpStr
		elseif(stringmatch(rawStr,"*Exciton Binding Energy of 3D*"))
			sscanf rawStr, "%f%s", E_0, tmpStr
		elseif(stringmatch(rawStr,"*Excition Bohr Radius of 3D*"))
			sscanf rawStr, "%f%s", a_0, tmpStr
		elseif(stringmatch(rawStr,"*Calculation Method*"))
			CalMethod = rawStr[strsearch(rawStr,":",1)+2,strlen(rawStr)-2]
		elseif(stringmatch(rawStr,"*Screening Switch*"))
			Screening = rawStr[strsearch(rawStr,":",1)+2,strlen(rawStr)-2]
		elseif(stringmatch(rawStr,"*Line Shape*"))
			LineShape = rawStr[strsearch(rawStr,"=",1)+2,strlen(rawStr)-2]
		elseif(stringmatch(rawStr,"*Program is started*"))
			StartTime = rawStr[strsearch(rawStr,":",1)+2,strlen(rawStr)-2]
		endif
		byteNum += strlen(rawStr)
	while(!stringmatch(rawStr,"*Omega(meV)*"))
	//read shf1d parameters
	byteNum=0; i=0
	do
		FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rawStr
		if       (stringmatch(rawStr,"*T/K*"))
			Readshf1dFile_Get(rawStr, "T/K",wv_t,i)
		elseif   (stringmatch(rawStr,"*damping/meV*"))
			Readshf1dFile_Get(rawStr, "damping/meV",wv_damp,i)
		elseif   (stringmatch(rawStr,"*ne/10^6cm^-1*"))
			Readshf1dFile_Get(rawStr, "ne/10^6cm^-1",wv_ne,i)
		elseif   (stringmatch(rawStr,"*nh/10^6cm^-1*"))
			Readshf1dFile_Get(rawStr, "nh/10^6cm^-1",wv_nh,i)
		elseif   (stringmatch(rawStr,"*mu_e/meV*"))
			Readshf1dFile_Get(rawStr, "mu_e/meV",wv_ue,i)
		elseif   (stringmatch(rawStr,"*mu_h/meV*"))
			Readshf1dFile_Get(rawStr, "mu_h/meV",wv_uh,i)
		elseif   (stringmatch(rawStr,"*BGR/mev*"))
			Readshf1dFile_Get(rawStr, "BGR/mev",wv_BGR,i)
		elseif   (stringmatch(rawStr,"*E_CH/meV*"))
			Readshf1dFile_Get(rawStr, "E_CH/meV",wv_Ech,i)
		elseif   (stringmatch(rawStr,"*E_ex_e/meV*"))
			Readshf1dFile_Get(rawStr, "E_ex_e/meV",wv_Eexe,i)
		elseif   (stringmatch(rawStr,"*E_ex_h/meV*"))	
			Readshf1dFile_Get(rawStr, "E_ex_h/meV",wv_Eexh,i)
		elseif   (stringmatch(rawStr,"*Pole/meV*"))
			Readshf1dFile_Get(rawStr, "Pole/meV",wv_pole,i)
		elseif   (stringmatch(rawStr,"*q_s/10^6cm^-1*"))
			Readshf1dFile_Get(rawStr, "q_s/10^6cm^-1",wv_qs,i)
		elseif   (stringmatch(rawStr,"*Omega(meV)*"))
			i += 1
		endif
		byteNum += strlen(rawStr)
	while(strlen(rawStr)!=0)
	N = i
	Close refNum
//others
	DeletePoints N, 500-N, wv_t, wv_damp, wv_ne, wv_nh, wv_ue, wv_uh, wv_BGR, wv_Ech, wv_Eexe, wv_Eexh, wv_pole, wv_qs, wv_u, wv_ues, wv_uhs
	wv_ne *= 10^6
	wv_nh *= 10^6
	wv_qs *= 10^6
	wv_u   = (wv_uh + wv_ue) - wv_BGR
	wv_ues = (1 + m_e/m_h) * (wv_ue - (wv_Eexe + wv_Ech))
	wv_uhs = (1 + m_h/m_e) * (wv_uh - (wv_Eexh + wv_Ech))
	if(stringmatch(CalMethod,"*free carrier*"))
		methodStr = "FE_"
	else
		methodStr = "SHF"
	endif
//make parameter list
	Make/O/T/N=(25,N+1) wv_List
	wv_List[ 0][0] = "Wave Name"
	wv_List[ 1][0] = "Program Start Time"					; sprintf tmpStr, "%s"  , StartTime	; wv_List[ 1][1] = tmpStr
	wv_List[ 2][0] = "size of wire lx [nm]"					; sprintf tmpStr, "%.1f", lx		; wv_List[ 2][1] = tmpStr
	wv_List[ 3][0] = "size of wire ly [nm]"					; sprintf tmpStr, "%.1f", ly		; wv_List[ 3][1] = tmpStr
	wv_List[ 4][0] = "Mass of Electron m_e [m_0]"			; sprintf tmpStr, "%.4f", m_e		; wv_List[ 4][1] = tmpStr
	wv_List[ 5][0] = "Mass of Heavy Hole in plane [m_e0]"	; sprintf tmpStr, "%.4f", m_h		; wv_List[ 5][1] = tmpStr
	wv_List[ 6][0] = "Background Dielectronic Constant"		; sprintf tmpStr, "%.2f", epsilon_0	; wv_List[ 6][1] = tmpStr
	wv_List[ 7][0] = "dipole moment [A]"					; sprintf tmpStr, "%.2f", r_dipole	; wv_List[ 7][1] = tmpStr
	wv_List[ 8][0] = "Exciton Binding Energy of 3D [meV]"	; sprintf tmpStr, "%.3f", E_0		; wv_List[ 8][1] = tmpStr
	wv_List[ 9][0] = "Excition Bohr Radius of 3D [10^6 cm]"	; sprintf tmpStr, "%.3f", a_0		; wv_List[ 9][1] = tmpStr
	wv_List[10][0] = "Calcuration Method"					; sprintf tmpStr, "%s"  , CalMethod	; wv_List[10][1] = tmpStr
	wv_List[11][0] = "Screening Switch"						; sprintf tmpStr, "%s"  , Screening	; wv_List[11][1] = tmpStr
	wv_List[12][0] = "Line Shape"							; sprintf tmpStr, "%s"  , LineShape	; wv_List[12][1] = tmpStr
	wv_List[13][0] = "T [K]"
	wv_List[14][0] = "damping [meV]"
	wv_List[15][0] = "ne [10^6 /cm]"
	wv_List[16][0] = "nh [10^6 /cm]"
	wv_List[17][0] = "mu_e [meV]"
	wv_List[18][0] = "mu_h [meV]"
	wv_List[19][0] = "BGR [meV]"
	wv_List[20][0] = "E_CH [meV]"
	wv_List[21][0] = "E_ex_e [meV]"
	wv_List[22][0] = "E_ex_h [meV]"
	wv_List[23][0] = "Pole [meV]"
	wv_List[24][0] = "q_s [10^6 /cm]"
	for (i=0; i<N; i+=1)
		sprintf dataStr,"T%04dg%04de%06dh%06d", round(wv_t[i]*10^1), round(wv_damp[i]*10^3), round(wv_ne[i]/10^1), round(wv_nh[i]/10^1)
		sprintf tmpStr, "%s_%s", methodStr, dataStr	; wv_List[ 0][i+1] = tmpStr
		sprintf tmpStr, "%.1f", wv_t[i]				; wv_List[13][i+1] = tmpStr
		sprintf tmpStr, "%.3f", wv_damp[i]			; wv_List[14][i+1] = tmpStr
		sprintf tmpStr, "%.5f", wv_ne[i]/10^6		; wv_List[15][i+1] = tmpStr
		sprintf tmpStr, "%.5f", wv_nh[i]/10^6		; wv_List[16][i+1] = tmpStr
		sprintf tmpStr, "%.6f", wv_ue[i]			; wv_List[17][i+1] = tmpStr
		sprintf tmpStr, "%.6f", wv_uh[i]			; wv_List[18][i+1] = tmpStr
		sprintf tmpStr, "%.6f", wv_BGR[i]			; wv_List[19][i+1] = tmpStr
		sprintf tmpStr, "%.6f", wv_Ech[i]			; wv_List[20][i+1] = tmpStr
		sprintf tmpStr, "%.6f", wv_Eexe[i]			; wv_List[21][i+1] = tmpStr
		sprintf tmpStr, "%.6f", wv_Eexh[i]			; wv_List[22][i+1] = tmpStr
		sprintf tmpStr, "%.4f", wv_pole[i]			; wv_List[23][i+1] = tmpStr
		sprintf tmpStr, "%.6f", wv_qs[i]/10^6		; wv_List[24][i+1] = tmpStr
	endfor
End

/////////////////////////////
//Read Spectra [pl,abs,ref]//
/////////////////////////////
Static Function Readshf1dFile_Spectra(FolderPath,type,graphMode)
	String   FolderPath, type
	Variable graphMode
//define parameters
	String   FolderName, datFileList, datFileName, datFilePath
	String   rawStr, tmpStr
	String   yName, xName, GraphName, textStr, noteStr, typeStr
	Variable refNum, byteNum
	Variable i, j, k, t, N, pnts
	Variable xVar, yVar
//set patrameters
	 FolderName = path2str(FolderPath,0,0)
	datFileList = IndexedFile(path, -1, ".dat")
	datFileName = ListMatch(datFileList,"*"+type+"_out*",";"); datFileName = datFileName[0,strlen(datFileName)-2]
	datFilePath = FolderPath + ":" + datFileName
	if (stringmatch(type,"pl"))
		typeStr = "PL_"
	elseif(stringmatch(type,"abs"))
		typeStr = "Abs"
	elseif(stringmatch(type,"ref"))
		typeStr = "Ref"
	endif
//error handling
	if (strlen(datFileName)==0)
		return 0
	endif
//read parameter string, variable, wave
	NVAR lx, ly, m_e, m_h, epsilon_0, r_dipole, E_0, a_0
	SVAR CalMethod, Screening, LineShape, StartTime
	WAVE wv_t, wv_damp, wv_ne, wv_nh, wv_ue, wv_uh, wv_BGR, wv_Ech, wv_Eexe, wv_Eexh, wv_pole, wv_qs, wv_u, wv_ues, wv_uhs
	WAVE/T wv_List
//read dat file data
	Make/N=1000000/O wv_x, wv_y
	Open/R/Z=1/p=path refNum as datFilePath
	byteNum=0; i=0
	do
		FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rawStr
		if (stringmatch(rawStr,"*Omega(meV)*"))
			byteNum += strlen(rawStr)
			FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rawStr
			do
				sscanf rawStr, "%f , %f", xVar, yVar
				wv_x[k] = xVar
				wv_y[k] = yVar
				byteNum += strlen(rawStr)
				FSetPos refNum, byteNum; FReadLine/T=(num2char(10)) refNum, rawStr
				k += 1
				if(strlen(rawStr)==0)
					break
				endif
			while(char2num(rawStr[0,0])!=102) 	// corresponds to "f" that is for "file"
			pnts = (i==0) ? k : pnts
			i   += 1
		endif
		byteNum += strlen(rawStr)
	while(strlen(rawStr)!=0)
	N = i
	Close refNum
//separate waves
	DeletePoints k, 10001-k, wv_x, wv_y
	wv_y *= 10^3
	xName = "wv_Energy"
	WAVE/Z x = $xName
	if(!WaveExists(x))
		Make/O/N=(pnts) x_tmp
		Duplicate/O/R=(0,pnts-1) wv_x, x_tmp
		Rename x_tmp, $xName
		WAVE x = $xName
	endif
	for (i=0; i<N; i+=1)
		yName = typeStr + wv_List[0][i+1]
		Make/O/N=(pnts) y_tmp
		Duplicate/O/R=(pnts*i,pnts*(i+1)-1) wv_y, y_tmp
		Rename y_tmp, $yName
		WAVE y = $yName
		SetScale/I x x[0], x[Inf], y
	endfor
	KillWaves wv_x, wv_y
//append note to waves
	for (i=0; i<N; i+=1)
		noteStr = ""
		for (t= 1; t<=12; t+=1)
			noteStr += wv_List[t][0] + " : " + wv_List[t][  1] + "\r"
		endfor
		for (t=13; t<=24; t+=1)
			noteStr += wv_List[t][0] + " : " + wv_List[t][i+1] + "\r"
		endfor
		yName = typeStr + wv_List[0][i+1]
		WAVE y = $yName
		Note y, noteStr
	endfor
//make graph
	if (graphMode==1)
		if (numtype(str2num(FolderName[0]))==2)
			GraphName = FolderName + "_" + type
		else
			GraphName = "shf1d_" + FolderName + "_" + type
		endif
		Display/N=$GraphName as GraphName
		WAVE x = $xName
		textStr = "\Z08\\F'Arial'"
		for(i=0; i<N; i+=1)
			yName = typeStr + wv_List[0][i+1]
			WAVE y = $yName
			AppendToGraph/W=$GraphName y vs x
			textStr += "\r\\s(" + yName + ") " + yName
		endfor
		Graph_Default(GraphName)
		Legend/C/N=text0/A=LT/W=$GraphName textStr
		Label/W=$GraphName bottom "\Z12Energy (meV)"
		if    (stringmatch(type, "pl"))
			Label/W=$GraphName left "\Z12Intensity (cm\\S-1\\M)"	; TraceColor(GraphName,1,1)
		elseif(stringmatch(type,"abs"))
			Label/W=$GraphName left "\Z12Absorption (cm\\S-1\\M)"	; TraceColor(GraphName,2,1)
		elseif(stringmatch(type,"ref"))
			Label/W=$GraphName left "\Z12Refraction (cm\\S-1\\M)"	; TraceColor(GraphName,3,1)
		endif
	endif
End

//////////////////////////
//For storing parameters//
//////////////////////////
Static Function Readshf1dFile_Get(listStr,matchStr,wv,num)
	WAVE     wv
	String   listStr, matchStr
	Variable num
//define parameters
	String   tmpStr
	Variable tmpVar, v1,v2,v3,v4,v5,v6,v7,v8,v9
//main program
	if   (!stringmatch(matchStr,"Pole/meV"))	//except Pole
		sscanf StringByKey(matchStr,listStr,","), "%f", tmpVar
		wv[num] = tmpVar
	elseif(stringmatch(matchStr,"Pole/meV"))	//only Pole
		sscanf listStr, "%s%f%f%f%f%f%f%f%f%f%f" ,tmpStr,tmpVar,v1,v2,v3,v4,v5,v6,v7,v8,v9
		wv[num] = tmpVar
	endif
End



####################################################################################################
//////////=====     shf1d Viewer     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

///////////////////////
//shf1d Viewer [Main]//
///////////////////////
Function shf1dViewer()
//define parameters
	String srcGraphName, GraphName
	String DataFolderName, DataFolderPath
	String WorkFolderName, WorkFolderPath
	String currentFolderPath
	String traceName
	String text_expPL, text_expAbs
	String tmp_str
	Variable w, v, srcMode
	Variable tmp_var
//set data folder
	if (!DataFolderExists("root:shf1d_DataFolder"))
		NewdataFolder/S $("root:shf1d_DataFolder")
		NewdataFolder/S $("root:shf1d_DataFolder:test")
		DoAlert 0, "please store calculation date in ''shf1d_DataFolder''."
		Print      "please store calculation date in ''shf1d_DataFolder''."
		return 0
	endif
	if (!stringmatch(GetDataFolder(1),"root:shf1d_DataFolder:*") || strlen(GetDataFolder(1))==22)
		DoAlert 0, "please set current deta folder to ''shf1d_DataFolder''."
		Print      "please set current deta folder to ''shf1d_DataFolder''."
		return 0
	endif
	sprintf tmp_str, "set calsulation data folder\r  ->  %s\r\rOK ??", GetDataFolder(1)
	DoAlert 1, tmp_str
	if (V_flag==2)
		SetDataFolder root:
		Print "Cancel"
		return 0
	endif
	DataFolderName = GetDataFolder(0)
	DataFolderPath = "root:shf1d_DataFolder:" + DataFolderName
//set src graph
	DoAlert 1, "appand calculation wave to ''existing graph'' ?"
	if    (V_flag==1)	//select existing graph -> srcMode=1
		srcMOde = 1
		Prompt srcGraphName, "choose graph", popup, WinList("!*_shf1dPlot",";","WIN:1")
	elseif(V_flag==2)	//only calculation wave -> srcMode=0
		srcMOde = 0
		Prompt srcGraphName, "input new graph name"
	endif
	DoPrompt "shf1d Plotter", srcGraphName
	if (V_flag==1)
		SetDataFolder root:
		Print "Cancel"
		return 0
	endif
	if (srcMode==0 && stringmatch(srcGraphName,WinList("*",";","")))
		SetDataFolder root:
		DoAlert 0, "name already exists."
		Print      "name already sxists."
		return 0
	endif
	if (strlen(srcGraphName)>21)
		SetDataFolder root:
		DoAlert 0, "name too long. (under 21 letters)"
		Print      "name too long. (under 21 letters)"
		return 0
	endif
//make work folder
	if (!DataFolderExists("root:shf1d_WorkFolder"))
		NewDataFolder   $("root:shf1d_WorkFolder")	
	endif
	WorkFolderName = srcGraphName
	WorkFolderPath = "root:shf1d_WorkFolder:" + WorkFolderName
	if (DatafolderExists(WorkFolderPath))
		KillDataFolder/Z $WorkFolderPath
	endif
	NewDataFolder/O/S $WorkFolderPath
//make global parameters
	Variable/G T      = 20, g      = 1.0, ne      = 0.10, nh      = 0.10
	Variable/G T_step = 20, g_step = 0.5, ne_step = 0.05, nh_step = 0.05
	Variable/G n_doped     = 0
	variable/G confine     = 1
	Variable/G expWaveNum  = 0, expPL_WaveNum = 0, expAbsWaveNum = 0
	Variable/G calWaveNum  = 0, calPL_WaveNum = 0, calAbsWaveNum = 0
	Variable/G DoneMode    = 0
	Variable/G updateMode  = 1
	Variable/G traceMode   = 0
	Variable/G carrierMode = 0
	Variable/G expGainMode = 0, calGainMode = 0, calPLnormMode  = 0
	Variable/G E__fixMode  = 0, AbsfixMode  = 0
	Variable/G expPL_max   = 0, expPL_min   = 0, expAbsmax   = 0, expAbsmin   = 0, expE__max   = 0, expE__min   = 0
	Variable/G calPL_max   = 0, calPL_min   = 0, calAbsmax   = 0, calAbsmin   = 0, calE__max   = 0, calE__min   = 0
	Variable/G calEshift   = 0
	String/G   method      = "SHF"
	String/G   DataFolder  = DataFolderPath
//set parameters
	expWaveNum = (numtype(CountWaves(srcGraphName))==0) ? CountWaves(srcGraphName) : 0
//read exp waves
	if (srcMode==1)
		Make/O/N=(expWaveNum,5)/T expWaveList
		DoWindow/F $srcGraphName
	//input PL wave
		Prompt tmp_var, "input number of PL waves."
		DoPrompt "shf1d Plotter", tmp_var
		if (V_flag==1)
			SetDataFolder root:
			KillDataFolder $WorkFolderPath
			Print "Cancel"
			return 0
		endif
		expPL_WaveNum = tmp_var
		if    (tmp_var>=expWaveNum)	//only PL  wave
			expPL_WaveNum = expWaveNum
			expAbsWaveNum = 0
			expWaveList[][0] = "PL"
		elseif(tmp_var<=0)			//only Abs wave
			expPL_WaveNum = 0
			expAbsWaveNum = expWaveNum
			expWaveList[][0] = "Abs"
		else						//both PL & Abs
			expPL_WaveNum = tmp_var
			expAbsWaveNum = expWaveNum - tmp_var
			expWaveList[][0] = "Abs"
			for (v=0; v<tmp_var; v+=1)
				sprintf tmp_str, "select PL wave. (%g/%g)", v+1, tmp_var
				Prompt w, tmp_str, popup, TraceNameList(srcGraphName,";",1)
				DoPrompt "shf1d Plotter", w
				if (V_flag==1)
					SetDataFolder root:
					KillDataFolder $WorkFolderPath
					Print "Cancel"
					return 0
				endif
				expWaveList[w-1][0] = "PL"
			endfor
		endif
	//input Abs or Gain mode
		Prompt tmp_str, "select mode", popup, "absorption;gain;"
		DoPrompt "shf1d Plotter", tmp_str
		if (V_flag==1)
			SetDataFolder root:
			KillDataFolder $WorkFolderPath
			Print "Cancel"
			return 0
		endif
		if    (stringmatch(tmp_str,"absorption"))
			expGainMode = 0
		elseif(stringmatch(tmp_str,"gain"))
			expGainMode = 1
		endif
	//dupulicate exp waves
		for (w=0; w<expWaveNum; w+=1)
			traceName = TraceNameStr(srcGraphName,w)
			WAVE src_expWv__y = TraceNameToWaveRef(srcGraphName,traceName)
			WAVE src_expWv__x =  XWaveRefFromTrace(srcGraphName,traceName)
			expWaveList[w][1] = NameOfWave(src_expWv__y); expWaveList[w][3] = GetWavesDataFolder(src_expWv__y,1)
			expWaveList[w][2] = NameOfWave(src_expWv__x); expWaveList[w][4] = GetWavesDataFolder(src_expWv__x,1)
			Duplicate/O src_expWv__y, $expWaveList[w][1]
			Duplicate/O src_expWv__x, $expWaveList[w][2]
		endfor
	endif
//make window
	GraphName = srcGraphName + "_shf1dPlot"
	Display/N=$GraphName/W=(5,5,580,600) as GraphName
	ControlBar  215
	SetVariable ctrl_T			, title="   T  [K] "			, pos={220, 15}, size={133,18}, bodyWidth= 59, value=$(WorkFolderPath+":T")        , format="%5.1f", limits={0      ,  999.9,20.0}	, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_g			, title="damp [meV]"			, pos={220, 35}, size={133,18}, bodyWidth= 59, value=$(WorkFolderPath+":g")        , format="%5.3f", limits={0      ,  9.999, 0.5}	, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_ne			, title="ne [10^6 /cm]"			, pos={370, 15}, size={168,18}, bodyWidth= 73, value=$(WorkFolderPath+":ne")       , format="%7.5f", limits={0      ,9.99999,0.05}	, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_nh			, title="nh [10^6 /cm]"			, pos={370, 35}, size={168,18}, bodyWidth= 73, value=$(WorkFolderPath+":nh")       , format="%7.5f", limits={0      ,9.99999,0.05}	, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_T_step		, title="   T step "			, pos={220, 60}, size={117,18}, bodyWidth= 43, value=$(WorkFolderPath+":T_step")   , format="%5.1f", limits={0      ,  999.9,0}		, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_g_step		, title="damp step "			, pos={220, 80}, size={117,18}, bodyWidth= 43, value=$(WorkFolderPath+":g_step")   , format="%5.3f", limits={0      ,  9.999,0}		, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_ne_step	, title="ne step      "			, pos={370, 60}, size={152,18}, bodyWidth= 57, value=$(WorkFolderPath+":ne_step")  , format="%7.5f", limits={0      ,9.99999,0}		, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_nh_step	, title="nh step      "			, pos={370, 80}, size={152,18}, bodyWidth= 57, value=$(WorkFolderPath+":nh_step")  , format="%7.5f", limits={0      ,9.99999,0}		, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_n_doped	, title="dope [10^6 /cm]"		, pos={ 15, 80}, size={168,18}, bodyWidth= 58, value=$(WorkFolderPath+":n_doped")  , format="%7.5f", limits={0      ,9.99999,0}		, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_confine	, title="confinement factor"	, pos={558, 80}, size={195,18}, bodyWidth= 65, value=$(WorkFolderPath+":confine")  , format="%8.6f", limits={0.000001,9.999999,0}	, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_expPL_max	, title="expPL  max   [%]"		, pos={ 15,120}, size={168,18}, bodyWidth= 52, value=$(WorkFolderPath+":expPL_max"), format="%4.0f", limits={-999,9999,10}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_expPL_min	, title="expPL  min   [%]"		, pos={ 15,140}, size={168,18}, bodyWidth= 52, value=$(WorkFolderPath+":expPL_min"), format="%4.0f", limits={-999,9999,10}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_expAbsmax	, title="expAbs max [/cm]"		, pos={ 15,165}, size={168,18}, bodyWidth= 52, value=$(WorkFolderPath+":expAbsmax"), format="%4.0f", limits={-999,9999,5}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_expAbsmin	, title="expAbs min [/cm]"		, pos={ 15,185}, size={168,18}, bodyWidth= 52, value=$(WorkFolderPath+":expAbsmin"), format="%4.0f", limits={-999,9999,5}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_expE__max	, title="expE max [ eV]"		, pos={360,185}, size={161,18}, bodyWidth= 59, value=$(WorkFolderPath+":expE__max"), format="%5.3f", limits={0,9.999,0.005}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_expE__min	, title="expE min [ eV]"		, pos={191,185}, size={161,18}, bodyWidth= 59, value=$(WorkFolderPath+":expE__min"), format="%5.3f", limits={0,9.999,0.005}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_calPL_max	, title="calPL  max   [%]"		, pos={529,120}, size={168,18}, bodyWidth= 52, value=$(WorkFolderPath+":calPL_max"), format="%4.0f", limits={-999,9999,10}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_calPL_min	, title="calPL  min   [%]"		, pos={529,140}, size={168,18}, bodyWidth= 52, value=$(WorkFolderPath+":calPL_min"), format="%4.0f", limits={-999,9999,10}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_calAbsmax	, title="calAbs max [/cm]"		, pos={529,165}, size={168,18}, bodyWidth= 52, value=$(WorkFolderPath+":calAbsmax"), format="%4.0f", limits={-999,9999,5}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_calAbsmin	, title="calAbs min [/cm]"		, pos={529,185}, size={168,18}, bodyWidth= 52, value=$(WorkFolderPath+":calAbsmin"), format="%4.0f", limits={-999,9999,5}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_calE__max	, title="calE max [meV]"		, pos={360,165}, size={161,18}, bodyWidth= 59, value=$(WorkFolderPath+":calE__max"), format="%5.1f", limits={-99.9,999.9,5}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_calE__min	, title="calE min [meV]"		, pos={191,165}, size={161,18}, bodyWidth= 59, value=$(WorkFolderPath+":calE__min"), format="%5.1f", limits={-99.9,999.9,5}			, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	SetVariable ctrl_calEshift	, title=" E shift [meV]"		, pos={191,140}, size={161,18}, bodyWidth= 59, value=$(WorkFolderPath+":calEshift"), format="%5.1f", limits={-99.9,999.9,0.1}		, proc=shf1dViewer_SetVarProc , font="Courier New", fsize=12
	PopupMenu   ctrl_method		, title="cal method     "		, pos={ 15, 33}, size={194,18}, bodyWidth= 84, value="SHF;FE;"																		, proc=shf1dViewer_PopMenuProc, font="Courier New", fsize=12
	PopupMenu   ctrl_carrier	, title="ne-nh relation "		, pos={ 15, 58}, size={194,18}, bodyWidth= 84, value="independent;undoped;n-doped;p-doped;"											, proc=shf1dViewer_PopMenuProc, font="Courier New", fsize=12
	PopupMenu   ctrl_trace		, title=""						, pos={675, 13}, size={ 78,18}, bodyWidth= 78, value="overwrite;append to;"															, proc=shf1dViewer_PopMenuProc, font="Courier New", fsize=12
	PopupMenu   ctrl_calPLnorm	, title="calPL  unit type"		, pos={558, 38}, size={195,18}, bodyWidth= 78, value="absolute;normalized;"															, proc=shf1dViewer_PopMenuProc, font="Courier New", fsize=12
	PopupMenu   ctrl_calGain	, title="calAbs wave type"		, pos={558, 58}, size={195,18}, bodyWidth= 78, value="absorption;gain;"																, proc=shf1dViewer_PopMenuProc, font="Courier New", fsize=12
	CheckBox    ctrl_E__fix		, title="E fix"					, pos={375,140}, size={ 53,15}, value=0																								, proc=shf1dViewer_CheckProc  , font="Courier New", fsize=12
	CheckBox    ctrl_Absfix		, title="Abs fix"				, pos={439,140}, size={ 67,15}, value=0																								, proc=shf1dViewer_CheckProc  , font="Courier New", fsize=12
	CheckBox    ctrl_update		, title="Live Update"			, pos={558, 15}, size={ 95,15}, value=1																								, proc=shf1dViewer_CheckProc  , font="Courier New", fsize=12
	Button      ctrl_Done		, title="Done"					, pos={709,120}, size={ 50,38}																										, proc=shf1dViewer_ButtonProc , font="Courier New", fsize=12
	Button      ctrl_Export		, title="Export"				, pos={709,165}, size={ 50,38}																										, proc=shf1dViewer_ButtonProc , font="Courier New", fsize=12
	TitleBox   title_shf1d_para , title="shf1d parameters"      , pos={ 48, 12}, size={128,14}, frame=0, font="Courier New", fSize=14, fstyle=5
	TitleBox   title_axis_menu  , title="Axis Menu"             , pos={320,117}, size={ 72,14}, frame=0, font="Courier New", fSize=14, fstyle=5
	GroupBox   group_shf1d_para , title=""						, pos={  5,  5}, size={540,100}
	GroupBox   group_axis_menu  , title=""						, pos={  5,110}, size={700,100}
	GroupBox   group_others     , title=""						, pos={550,  5}, size={210,100}
//append exp wave
	if (srcMode==1)
	//append PL & Abs wave
		for (w=0; w<expWaveNum; w+=1)
			WAVE expWv__y = $expWaveList[w][1]
			WAVE expWv__x = $expWaveList[w][2]
			if    (stringmatch(expWaveList[w][0],"PL"))		//PL  Wave
				AppendToGraph/W=$GraphName/L=exp_PL /B=exp_E expWv__y vs expWv__x
			elseif(stringmatch(expWaveList[w][0],"Abs"))	//Abs Wave
				AppendToGraph/W=$GraphName/L=exp_Abs/B=exp_E expWv__y vs expWv__x
			endif
		endfor
		ModifyGraph lsize=1.2
	//put legend on exp graph
		text_expPL  = "\\Z08\\F'Courier New'"
		text_expAbs = "\\Z08\\F'Courier New'"
		for (w=0; w<expWaveNum; w+=1)
			if    (stringmatch(expWaveList[w][0],"PL"))		//PL  Wave
				text_expPL  += "\r\\s(" + expWaveList[w][1] + ") " + expWaveList[w][1]
			elseif(stringmatch(expWaveList[w][0],"Abs"))	//Abs Wave
				text_expAbs += "\r\\s(" + expWaveList[w][1] + ") " + expWaveList[w][1]
			endif
		endfor
		if    (expPL_WaveNum!=0)
			TextBox/C/N=text_expPL /A=LT/X=1/Y= 2.5 text_expPL
		endif
		if    (expAbsWaveNum!=0 && expGainMode==0)
			TextBox/C/N=text_expAbs/A=LT/X=1/Y=55.0 text_expAbs
		elseif(expAbsWaveNum!=0 && expGainMode==1)
			TextBox/C/N=text_expAbs/A=LB/X=1/Y= 2.5 text_expAbs
		endif
	endif
//append dummy wave
	Make/O dummy_expPL, dummy_expAbs, dummy_calPL, dummy_calAbs
	AppendToGraph/W=$GraphName/L=exp_PL /B=exp_E dummy_expPL
	AppendToGraph/W=$GraphName/L=exp_Abs/B=exp_E dummy_expAbs
	AppendToGraph/W=$GraphName/R=cal_PL /T=cal_E dummy_calPL
	AppendToGraph/W=$GraphName/R=cal_Abs/T=cal_E dummy_calAbs	
	ModifyGraph hideTrace(dummy_expPL) =1, hideTrace(dummy_expAbs)=1
	ModifyGraph hideTrace(dummy_calPL) =1, hideTrace(dummy_calAbs)=1	
//append cal wave
	shf1dViewer_Plot()
//modify graph
	ModifyGraph fSize=10, font="Arial"
	ModifyGraph margin=40, tick=2, mirror=0, standoff=0, lblPosMode=1
	DrawLine 0,0.525,1,0.525
	DrawLine 0,0.475,1,0.475
	SetDrawEnv ycoord= cal_Abs, dash= 2; DrawLine 0,0,1,0
	//cal axis
	ModifyGraph   freePos(cal_PL)={0,kwFraction}    ,   freePos(cal_Abs)={0,kwFraction}     ,   freePos(cal_E)={0,kwFraction}
	ModifyGraph   manTick(cal_PL)=0, minor(cal_PL)=1,   manTick(cal_Abs)=0, minor(cal_Abs)=1,   manTick(cal_E)={0,10,0,0}, manMinor(cal_E)={9,5}
	ModifyGraph  axisEnab(cal_PL)={0.525,1}         ,  axisEnab(cal_Abs)={0,0.475}
	ModifyGraph   noLabel(cal_PL)=1
	Label cal_PL  "\\Z12PL Intensity (cm\\S-1\\M)"	; ModifyGraph lblMargin(cal_PL) =0
	Label cal_Abs "\\Z12Absorption (cm\\S-1\\M)"	; ModifyGraph lblMargin(cal_Abs)=0
	Label cal_E   "\\Z12Energy (meV)"				; ModifyGraph lblMargin(cal_E)  =5
	//exp axis
	ModifyGraph   freePos(exp_PL)={0,kwFraction}    ,   freePos(exp_Abs)={0,kwFraction}     ,   freePos(exp_E)={0,kwFraction}
	ModifyGraph   manTick(exp_PL)=0, minor(exp_PL)=1,   manTick(exp_Abs)=0, minor(exp_Abs)=1,   manTick(exp_E)={0,0.01,0,2}, manMinor(exp_E)={9,5}
	ModifyGraph  axisEnab(exp_PL)={0.525,1}         ,  axisEnab(exp_Abs)={0,0.475}
	ModifyGraph   noLabel(exp_PL)=1
	Label exp_PL  "\\Z12PL Inetnsity (arb. unit)"	; ModifyGraph lblMargin(exp_PL) =5
	if    (expGainMode==0)
	Label exp_Abs "\\Z12Absorption (cm\\S-1\\M)"	; ModifyGraph lblMargin(exp_Abs)=0
	elseif(expGainMode==1)
	Label exp_Abs "\\Z12Gain (cm\\S-1\\M)"			; ModifyGraph lblMargin(exp_Abs)=0
	endif
	Label exp_E   "\\Z12Photon Energy (eV)"			; ModifyGraph lblMargin(exp_E)  =5
	if    (expWaveNum == 0)
		ModifyGraph nticks(exp_PL) =0, noLabel(exp_PL) =2, mirror(cal_PL) =1
		ModifyGraph nticks(exp_Abs)=0, noLabel(exp_Abs)=2, mirror(cal_Abs)=1
		ModifyGraph nticks(exp_E)  =0, noLabel(exp_E)  =2, mirror(cal_E)  =1
	elseif(expPL_WaveNum == 0)
		ModifyGraph nticks(exp_PL) =0, noLabel(exp_PL) =2, mirror(cal_PL) =1
	elseif(expAbsWaveNum == 0)
		ModifyGraph nticks(exp_Abs)=0, noLabel(exp_Abs)=2, mirror(cal_Abs)=1
	endif
//others
	SetDataFolder root:
End

///////////////////////
//shf1d Viewer [Plot]//
///////////////////////
Function shf1dViewer_Plot()
//define parameters
	String GraphName
	String WorkFolderName, WorkFolderPath, DataFolderPath, currentFolderPath
	String src_calPL_Name, src_calAbsName, traceName
	String text_calPL, text_calAbs
	Variable i, w, allWaveNum
	Variable Pmax, Pmin
	Variable ExistsCheck
//set parameters
	GraphName = WinName(0,1)
	WorkFolderName = GraphName[0,strsearch(GraphName,"_",Inf,1)-1]
	WorkFolderPath = "root:shf1d_WorkFolder:" + WorkFolderName
	currentFolderPath = GetDataFolder(1)
	SVAR DataFolder = $(WorkFolderPath + ":DataFolder")
	DataFolderPath = DataFolder
//read stored parameters
	NVAR T             = $(WorkFolderPath + ":T")
	NVAR g             = $(WorkFolderPath + ":g")
	NVAR ne            = $(WorkFolderPath + ":ne")
	NVAR nh            = $(WorkFolderPath + ":nh")
	SVAR method        = $(WorkFolderPath + ":method")
	NVAR DoneMode      = $(WorkFolderPath + ":DoneMode")
	NVAR traceMode     = $(WorkFolderPath + ":traceMode")
	NVAR calGainMode   = $(WorkFolderPath + ":calGainMode")
	NVAR calPLnormMode = $(WorkFolderPath + ":calPLnormMode")
	NVAR confine       = $(WorkFolderPath + ":confine")
	NVAR expWaveNum    = $(WorkFolderPath + ":expWaveNum")
	NVAR calWaveNum    = $(WorkFolderPath + ":calWaveNum")
	NVAR calPL_WaveNum = $(WorkFolderPath + ":calPL_WaveNum")
	NVAR calAbsWaveNum = $(WorkFolderPath + ":calAbsWaveNum")
	NVAR calPL_max     = $(WorkFolderPath + ":calPL_max")
	NVAR calPL_min     = $(WorkFolderPath + ":calPL_min")
	NVAR calE__max     = $(WorkFolderPath + ":calE__max")
	NVAR calE__min     = $(WorkFolderPath + ":calE__min")
//remove waves
	allWaveNum = CountWaves(GraphName)
	if    (traceMode==0)	//overwrite
		for (w=expWaveNum+4; w<allWaveNum; w+=1)
			traceName = TraceNameStr(GraphName,expWaveNum+4)
			WAVE calWv = TraceNameToWaveRef(GraphName,traceName)
			RemoveFromGraph/Z/W=$GraphName $traceName
			KillWaves/Z calWv
		endfor
	elseif(traceMode==1)	//append to
		for (w=expWaveNum+4+calWaveNum; w<allWaveNum; w+=1)
			traceName = TraceNameStr(GraphName,expWaveNum+4+calWaveNum)
			WAVE calWv = TraceNameToWaveRef(GraphName,traceName)
			RemoveFromGraph/Z/W=$GraphName $traceName
			KillWaves/Z calWv
		endfor
	endif
//read cal waves in data folder
	sprintf src_calPL_Name, "PL_%s_T%04dg%04de%06dh%06d", method, round(T*10^1), round(g*10^3), round(ne*10^5), round(nh*10^5)
	sprintf src_calAbsName, "Abs%s_T%04dg%04de%06dh%06d", method, round(T*10^1), round(g*10^3), round(ne*10^5), round(nh*10^5)
	WAVE/Z src_calPL  = $(DataFolderPath+":"+src_calPL_Name)
	WAVE/Z src_calAbs = $(DataFolderPath+":"+src_calAbsName)
//error handling
	if (!WaveExists(src_calPL) || !WaveExists(src_calAbs))
		if (traceMode==0)
			calWaveNum = 0
		elseif(traceMode==1)
			calWaveNum = CountWaves(GraphName) - (expWaveNum + 4)
		endif
		calPL_WaveNum = calWaveNum/2
		calAbsWaveNum = calWaveNum/2
		return -1
	endif
	if (WaveExists($(WorkFolderPath+":"+src_calPL_Name)) && WaveExists($(WorkFolderPath+":"+src_calAbsName)))
		ExistsCheck = 1
	endif
//duplicate and append cal waves
	SetDataFolder WorkFolderPath
	Duplicate/O src_calPL , $(WorkFolderPath+":"+src_calPL_Name); WAVE calPL  = $(WorkFolderPath+":"+src_calPL_Name)
	Duplicate/O src_calAbs, $(WorkFolderPath+":"+src_calAbsName); WAVE calAbs = $(WorkFolderPath+":"+src_calAbsName)
	AppendToGraph/W=$GraphName/R=cal_PL /T=cal_E calPL
	AppendToGraph/W=$GraphName/R=cal_Abs/T=cal_E calAbs
//modify graph [trace]
	allWaveNum = CountWaves(GraphName)
	if    (traceMode==0)				//overwrite
		ModifyGraph/W=$GraphName rgb($TraceNameStr(GraphName,allWaveNum-2))=(    0,    0,    0)
		ModifyGraph/W=$GraphName rgb($TraceNameStr(GraphName,allWaveNum-1))=(    0,    0,    0)
	elseif(traceMode==1 && DoneMode==0)	//append to
		ModifyGraph/W=$GraphName rgb($TraceNameStr(GraphName,allWaveNum-2))=(32640,32640,32640), lstyle($TraceNameStr(GraphName,allWaveNum-2))=3
		ModifyGraph/W=$GraphName rgb($TraceNameStr(GraphName,allWaveNum-1))=(32640,32640,32640), lstyle($TraceNameStr(GraphName,allWaveNum-1))=3
	elseif(traceMode==1 && DoneMode==1 && ExistsCheck==0)
		ModifyGraph/W=$GraphName rgb($TraceNameStr(GraphName,allWaveNum-2))=(    0,    0,    0)
		ModifyGraph/W=$GraphName rgb($TraceNameStr(GraphName,allWaveNum-1))=(    0,    0,    0)
	elseif(traceMode==1 && DoneMode==1 && ExistsCheck==1)
		RemoveFromGraph/Z/W=$GraphName $TraceNameStr(GraphName,allWaveNum-2)
		RemoveFromGraph/Z/W=$GraphName $TraceNameStr(GraphName,allWaveNum-2)
	endif
//modify graph [calPL  axis label and wave]
	if    (calPLnormMode==0)
		Label cal_PL  "\\Z12PL Intensity (cm\\S-1\\M)"; ModifyGraph lblMargin(cal_PL)=0
	elseif(calPLnormMode==1)
		Label cal_PL  "\\Z12PL Intensity (normalized)"; ModifyGraph lblMargin(cal_PL)=5
		WaveStats/Q/Z calPL; V_max = (V_max!=0) ? V_max : 1
		calPL /= V_max
	endif
//modify graph [calAbs axis label and wave]
	if    (calGainMode==0)
		Label cal_Abs "\\Z12Absorption (cm\\S-1\\M)"
		calAbs *= +confine
	elseif(calGainMode==1)
		Label cal_Abs "\\Z12Gain (cm\\S-1\\M)"
		calAbs *= -confine
	endif
//modify graph [calPL  axis range]
	if    (calPL_max==calPL_min && traceMode==0)
		SetAxis/A cal_PL
	elseif(calPL_max!=calPL_min && traceMode==0)
		WAVE calPL = WaveRefIndexed(GraphName,expWaveNum+4,1)
		if  (calE__max==calE__min)
			WaveStats/Q/Z calPL
		else
			Pmax = (pnt2x(calPL,numpnts(calPL)-1)<calE__max) ? x2pnt(calPL,calE__max) : numpnts(calPL)-1
			Pmin = (pnt2x(calPL,0)               >calE__min) ? x2pnt(calPL,calE__min) : 0
			WaveStats/Q/Z/R=[Pmin,Pmax] calPL
		endif
		SetAxis cal_PL V_max*calPL_min/100,V_max*calPL_max/100
	endif
//set cal wave num parameters
	allWaveNum = CountWaves(GraphName)
	if    (traceMode==0)				//overwrite
		calWaveNum = 2
	elseif(traceMode==1 && DoneMode==0)	//append to
		calWaveNum = allWaveNum - (expWaveNum + 4) - 2
	elseif(traceMode==1 && DoneMode==1)
		calWaveNum = allWaveNum - (expWaveNum + 4)
	endif
	calPL_WaveNum = calWaveNum/2
	calAbsWaveNum = calWaveNum/2
//put legend on cal graph
	text_calPL  = "\\Z08\\F'Courier New'"
	text_calAbs = "\\Z08\\F'Courier New'"
	for (w=expWaveNum+4; w<allWaveNum; w+=1)
		traceName = TraceNameStr(GraphName,w)
		if    (stringmatch(traceName[0,2],"PL_"))	//PL  Wave
			text_calPL  += "\r\\s(" + traceName + ") " + traceName
		elseif(stringmatch(traceName[0,2],"Abs"))	//Abs Wave
			text_calAbs += "\r\\s(" + traceName + ") " + traceName
		endif
	endfor
	TextBox/C/N=text_calPL /A=RT/X=1/Y= 2.5 text_calPL
	if (calGainMode==0)
		TextBox/C/N=text_calAbs/A=RT/X=1/Y=55.0 text_calAbs
	elseif(calGainMode==1)
		TextBox/C/N=text_calAbs/A=RB/X=1/Y= 2.5 text_calAbs
	endif
//others
	SetDataFolder currentFolderPath
End

/////////////////////////
//shf1d Viewer [Export]//
/////////////////////////
Function shf1dViewer_Export()
//define parameters
	String GraphName
	String WorkFolderName, WorkFolderPath, DataFolderPath, currentFolderPath
	String calPL_Name, calAbsName, traceName
	String text_exp, text_cal, text_expPL, text_expAbs, text_calPL, text_calAbs
	String tmp_str, newGraphName, newFolderName, newFolderPath
	Variable i, j, N, w, pnts
	Variable expMode, typeMode=3
	Variable expWv_WaveNum, expWv_ShowNum, expPL_ShowNum, expAbsShowNum
	Variable calWv_WaveNum
	Variable newexpWaveNum, newcalWaveNum, newexpPL_WaveNum, newexpAbsWaveNum, newWaveNum
//set parameters
	GraphName = WinName(0,1)
	WorkFolderName = GraphName[0,strsearch(GraphName,"_",Inf,1)-1]
	WorkFolderPath = "root:shf1d_WorkFolder:" + WorkFolderName
	currentFolderPath = GetDataFolder(1)
	SVAR DataFolder = $(WorkFolderPath + ":DataFolder")
	DataFolderPath = DataFolder
//read stored parameters
	NVAR expGainMode   = $(WorkFolderPath + ":expGainMode")
	NVAR calGainMode   = $(WorkFolderPath + ":calGainMode")
	NVAR expWaveNum    = $(WorkFolderPath + ":expWaveNum")
	NVAR expPL_WaveNum = $(WorkFolderPath + ":expPL_WaveNum")
	NVAR expAbsWaveNum = $(WorkFolderPath + ":expAbsWaveNum")
	NVAR calWaveNum    = $(WorkFolderPath + ":calWaveNum")
	NVAR calPL_WaveNum = $(WorkFolderPath + ":calPL_WaveNum")
	NVAR calAbsWaveNum = $(WorkFolderPath + ":calAbsWaveNum")
//error handling
	if (calWaveNum==0)
		DoAlert 0, "cal wave not exists."
		return 0
	endif
//set exp showing wave number
	for(w=0; w<expWaveNum; w+=1)
		traceName = TraceNameStr(GraphName,w)
		if (TraceStats(GraphName,traceName)==0)
			if (w<expPL_WaveNum)
				expPL_ShowNum += 1
			else
				expAbsShowNum += 1
			endif
		endif
	endfor
//input mode and new graph name
	Prompt typeMode, "choose export wave type.", popup, "only PL;only Abs;both PL & Abs"
	Prompt newGraphName, "input new graph name."
	DoPrompt "shf1d Export", typeMode, newGraphName
	if    (V_flag==1)
		return 0
	elseif(strlen(newGraphName)==0)
		DoAlert 0, "input name."
		return 0
	elseif(stringmatch(WinList("*",";",""),"*;"+newGraphName+";*")||stringmatch(WinList("*",";",""),newGraphName+";*"))
		DoAlert 0, "same name graph already exists."
		return 0
	elseif(DataFolderExists(currentFolderPath+newGraphName))
		DoAlert 0, "same name folder already exists."
		return 0
	endif
	if    (typeMode==1)		//only PL  wave
		if (expPL_ShowNum!=0)
			DoAlert 1, "export exp PL wave."
		endif
		expMode = (V_flag==1) ? 1 : 0
		expWv_WaveNum = expPL_WaveNum; expWv_ShowNum = expPL_ShowNum
		calWv_WaveNum = calPL_WaveNum
		newexpPL_WaveNum = (expMode==1) ? expPL_ShowNum : 0
		newexpAbsWaveNum = 0
		newexpWaveNum = newexpPL_WaveNum + newexpAbsWaveNum
		newcalWaveNum = calWv_WaveNum
		newWaveNum = (expMode==0) ? calWv_WaveNum : expWv_ShowNum + calWv_WaveNum
	elseif(typeMode==2)		//only Abs wave
		if (expAbsshowNum!=0)
			DoAlert 1, "export exp Abs or Gain wave."
		endif
		expMode = (V_flag==1) ? 1 : 0
		expWv_WaveNum = expAbsWaveNum; expWv_ShowNum = expAbsShowNum
		calWv_WaveNum = calAbsWaveNum
		newexpPL_WaveNum = 0
		newexpAbsWaveNum = (expMode==1) ? expAbsShowNum : 0
		newexpWaveNum = newexpPL_WaveNum + newexpAbsWaveNum
		newcalWaveNum = calWv_WaveNum
		newWaveNum = (expMode==0) ? newcalWaveNum : newexpWaveNum + newcalWaveNum
	elseif(typeMode==3)		//both PL & Abs wave [both exp and cal wave]
		expMode = 1
		expWv_WaveNum = expWaveNum; expWv_ShowNum = expPL_ShowNum + expAbsShowNum
		calWv_WaveNum = calWaveNum
		newexpPL_WaveNum = expPL_ShowNum
		newexpAbsWaveNum = expAbsShowNum
		newexpWaveNum = newexpPL_WaveNum + newexpAbsWaveNum
		newcalWaveNum = calWv_WaveNum
		newWaveNum = newexpWaveNum + newcalWaveNum + 4
	endif
//make folder
	newFolderName = newGraphName
	newFolderPath = currentFolderPath + newFolderName
	NewDataFolder/S $newFolderPath
//read and duplicate waves
	Make/O/T/N=(newWaveNum,2) WaveNameList
	for (i=0; i<expWv_WaveNum; i+=1)	//exp wave
		if    (typeMode==1)
			traceName = TraceNameStr(GraphName,i)
		elseif(typeMode==2)
			traceName = TraceNameStr(GraphName,i+expPL_WaveNum)
		elseif(typeMode==3)
			traceName = TraceNameStr(GraphName,i)
		endif
		if (TraceStats(GraphName,traceName)!=0)
			continue
		endif
		WAVE expWv__y = TraceNameToWaveRef(GraphName,traceName)
		WAVE expWv__x =  XWaveRefFromTrace(GraphName,traceName)
		WaveNameList[j][0] = NameOfWave(expWv__y)
		WaveNameList[j][1] = NameOfWave(expWv__x)
		Duplicate/O expWv__y, $WaveNameList[j][0]
		Duplicate/O expWv__x, $WaveNameList[j][1]
		j += 1
	endfor
	for (i=0; i<calWv_WaveNum; i+=1)	//cal wave
		if    (typeMode==1)
			traceName = TraceNameStr(GraphName,expWaveNum+4+i*2)
		elseif(typeMode==2)
			traceName = TraceNameStr(GraphName,expWaveNum+4+i*2+1)
		elseif(typeMode==3)
			traceName = TraceNameStr(GraphName,expWaveNum+4+i)
		endif
		WAVE calWv__y = TraceNameToWaveRef(GraphName,traceName)
		Duplicate/O calWv__y, $NameOfWave(calWv__y)
		pnts = numpnts(calWv__y); sprintf tmp_str, "cal%02d_x", i+1
		Make/O/N=(pnts) calWv__X; Rename calWv__X, $tmp_str
		for (j=0; j<pnts; j+=1)
			calWv__X[j] = pnt2x(calWv__y,j)
		endfor
		WaveNameList[newexpWaveNum+i][0] = NameOfWave(calWv__y)
		WaveNameList[newexpWaveNum+i][1] = NameOfWave(calWv__x)
	endfor
//appned exp and cal waves
	Display/N=$newGraphName as newGraphName
	if    (expMode==0 && typeMode!=3)	//only cal wave
		for (w=0; w<newWaveNum; w+=1)
			WAVE new_calWv__y = $WaveNameList[w][0]
			WAVE new_calWv__x = $WaveNameList[w][1]
			AppendToGraph/W=$newGraphName /L/B new_calWv__y vs new_calWv__x
			ModifyGraph rgb($WaveNameList[w][0])=(    0,    0,    0)
		endfor
	elseif(expMode==1 && typeMode!=3)	//both exp & cal wave
		for (w=0; w<newexpWaveNum; w+=1)
			WAVE new_expWv__y = $WaveNameList[w][0]
			WAVE new_expWv__x = $WaveNameList[w][1]
			AppendToGraph/W=$newGraphName /L/B new_expWv__y vs new_expWv__x
			ModifyGraph rgb($WaveNameList[w][0])=(65280,    0,    0), lsize($WaveNameList[w][0])=1.2
		endfor
		for (w=newexpWaveNum; w<newWaveNum; w+=1)
			WAVE new_calWv__y = $WaveNameList[w][0]
			WAVE new_calWv__x = $WaveNameList[w][1]
			AppendToGraph/W=$newGraphName /R/T new_calWv__y vs new_calWv__x
			ModifyGraph rgb($WaveNameList[w][0])=(    0,    0,    0)
		endfor
	elseif(typeMode==3)					//all wave [both exp & cal, both PL & Abs]
		//exp PL  wave
		for (w=0; w<newexpPL_WaveNum; w+=1)
			WAVE new_expPL__y = $WaveNameList[w][0]
			WAVE new_expPL__x = $WaveNameList[w][1]
			AppendToGraph/W=$newGraphName /L=exp_PL /B=exp_E new_expPL__y vs new_expPL__x
			ModifyGraph rgb($WaveNameList[w][0])=(65280,    0,    0), lsize($WaveNameList[w][0])=1.2
		endfor
		//exp Abs wave
		for (w=newexpPL_WaveNum; w<newexpWaveNum; w+=1)
			WAVE new_expAbs_y = $WaveNameList[w][0]
			WAVE new_expAbs_x = $WaveNameList[w][1]
			AppendToGraph/W=$newGraphName /L=exp_Abs/B=exp_E new_expAbs_y vs new_expAbs_x
			ModifyGraph rgb($WaveNameList[w][0])=(65280,    0,    0), lsize($WaveNameList[w][0])=1.2
		endfor
		//cal PL & Abs wave
		for (w=newexpWaveNum; w<newWaveNum-4; w+=2)
			WAVE new_calPL__y = $WaveNameList[w  ][0]
			WAVE new_calPL__x = $WaveNameList[w  ][1]
			WAVE new_calAbs_y = $WaveNameList[w+1][0]
			WAVE new_calAbs_x = $WaveNameList[w+1][1]
			AppendToGraph/W=$newGraphName /R=cal_PL /T=cal_E new_calPL__y vs new_calPL__x
			AppendToGraph/W=$newGraphName /R=cal_Abs/T=cal_E new_calAbs_y vs new_calAbs_x
			ModifyGraph rgb($WaveNameList[w  ][0])=(    0,    0,    0)
			ModifyGraph rgb($WaveNameList[w+1][0])=(    0,    0,    0)
		endfor
		//dummy wave
		Make/O dummy_expPL, dummy_expAbs, dummy_calPL, dummy_calAbs
		AppendToGraph/W=$newGraphName /L=exp_PL /B=exp_E dummy_expPL ; ModifyGraph hideTrace(dummy_expPL) =1
		AppendToGraph/W=$newGraphName /L=exp_Abs/B=exp_E dummy_expAbs; ModifyGraph hideTrace(dummy_expAbs)=1
		AppendToGraph/W=$newGraphName /R=cal_PL /T=cal_E dummy_calPL ; ModifyGraph hideTrace(dummy_calPL) =1
		AppendToGraph/W=$newGraphName /R=cal_Abs/T=cal_E dummy_calAbs; ModifyGraph hideTrace(dummy_calAbs)=1
	endif
//modify graph
	ModifyGraph fSize=10, font="Arial"
	ModifyGraph tick=2, standoff=0, lblPosMode=1
	if    (expMode==0 && typeMode!=3)	//only cal wave
		ModifyGraph margin(left)=50, margin(bottom)=40, margin(right)=20, margin(top)=20
		SetDrawEnv xcoord= prel, ycoord= left, dash= 2; DrawLine 0,0,1,0
		ModifyGraph mirror=1
		ModifyGraph manTick(bottom)={0,10,0,0}, manMinor(bottom)={9,5}
		ModifyGraph manTick(left)=0, minor(left)=1
	elseif(expMode==1 && typeMode!=3)	//both cal & exp wave
		ModifyGraph margin(left)=50, margin(bottom)=40, margin(right)=50, margin(top)=40
		SetDrawEnv xcoord= prel, ycoord= left, dash= 2; DrawLine 0,0,1,0
		ModifyGraph mirror=0
		ModifyGraph manTick(bottom)={0,0.01,0,2}, manMinor(bottom)={9,5}
		ModifyGraph manTick(top)   ={0,  10,0,0}, manMinor(top)   ={9,5}
		ModifyGraph manTick(left) =0, minor(left) =1
		ModifyGraph manTick(right)=0, minor(right)=1
	elseif(typeMode==3)					//all waves
		ModifyGraph margin=40, mirror=0, lblPosMode=1
		DrawLine 0,0.525,1,0.525
		DrawLine 0,0.475,1,0.475
		SetDrawEnv xcoord= prel, ycoord= cal_Abs, dash= 2; DrawLine 0,0,1,0
		//cal axis
		ModifyGraph   freePos(cal_PL)={0,kwFraction}    ,   freePos(cal_Abs)={0,kwFraction}     ,   freePos(cal_E)={0,kwFraction}
		ModifyGraph   manTick(cal_PL)=0, minor(cal_PL)=1,   manTick(cal_Abs)=0, minor(cal_Abs)=1,   manTick(cal_E)={0,10,0,0}, manMinor(cal_E)={9,5}
		ModifyGraph  axisEnab(cal_PL)={0.525,1}         ,  axisEnab(cal_Abs)={0,0.475}
		ModifyGraph   noLabel(cal_PL)=1
		//exp axis
		ModifyGraph   freePos(exp_PL)={0,kwFraction}    ,   freePos(exp_Abs)={0,kwFraction}     ,   freePos(exp_E)={0,kwFraction}
		ModifyGraph   manTick(exp_PL)=0, minor(exp_PL)=1,   manTick(exp_Abs)=0, minor(exp_Abs)=1,   manTick(exp_E)={0,0.01,0,2}, manMinor(exp_E)={9,5}
		ModifyGraph  axisEnab(exp_PL)={0.525,1}         ,  axisEnab(exp_Abs)={0,0.475}
		ModifyGraph   noLabel(exp_PL)=1
		if    (expWv_ShowNum == 0)
			ModifyGraph nticks(exp_PL) =0, noLabel(exp_PL) =2, mirror(cal_PL) =1
			ModifyGraph nticks(exp_Abs)=0, noLabel(exp_Abs)=2, mirror(cal_Abs)=1
			ModifyGraph nticks(exp_E)  =0, noLabel(exp_E)  =2, mirror(cal_E)  =1
		elseif(expPL_ShowNum == 0)
			ModifyGraph nticks(exp_PL) =0, noLabel(exp_PL) =2, mirror(cal_PL) =1
		elseif(expAbsShowNum == 0)
			ModifyGraph nticks(exp_Abs)=0, noLabel(exp_Abs)=2, mirror(cal_Abs)=1
		endif
	endif
//set axis
	if    (typeMode==1 && expMode==0)	//cal PL
		GetAxis/Q/W=$GraphName cal_PL ; SetAxis/W=$newGraphName left    V_min,V_max
		GetAxis/Q/W=$GraphName cal_E  ; SetAxis/W=$newGraphName bottom  V_min,V_max
		Label /W=$newGraphName left     GetAxisLabel(GraphName,"cal_PL" ,1)	; ModifyGraph lblMargin(left)   =5
		Label /W=$newGraphName bottom   "\\Z12 Energy (meV)"				; ModifyGraph lblMargin(bottom) =5
	elseif(typeMode==2 && expMode==0)	//cal Abs
		GetAxis/Q/W=$GraphName cal_Abs; SetAxis/W=$newGraphName left    V_min,V_max
		GetAxis/Q/W=$GraphName cal_E  ; SetAxis/W=$newGraphName bottom  V_min,V_max
		Label /W=$newGraphName left     GetAxisLabel(GraphName,"cal_Abs",1)	; ModifyGraph lblMargin(left)   =0
		Label /W=$newGraphName bottom   "\\Z12 Energy (meV)"				; ModifyGraph lblMargin(bottom) =5
	elseif(typeMode==1 && expMode==1)	//exp PL  & cal PL
		GetAxis/Q/W=$GraphName exp_PL ; SetAxis/W=$newGraphName left    V_min,V_max
		GetAxis/Q/W=$GraphName exp_E  ; SetAxis/W=$newGraphName bottom  V_min,V_max
		GetAxis/Q/W=$GraphName cal_PL ; SetAxis/W=$newGraphName right   V_min,V_max
		GetAxis/Q/W=$GraphName cal_E  ; SetAxis/W=$newGraphName top     V_min,V_max
		Label /W=$newGraphName left     GetAxisLabel(GraphName,"exp_PL" ,1)	; ModifyGraph lblMargin(left)   =5
		Label /W=$newGraphName bottom   "\\Z12 Photon Energy (eV)"			; ModifyGraph lblMargin(bottom) =5
		Label /W=$newGraphName right    GetAxisLabel(GraphName,"cal_PL" ,1)	; ModifyGraph lblMargin(right)  =5
		Label /W=$newGraphName top      "\\Z12 Energy (meV)"				; ModifyGraph lblMargin(top)    =5
	elseif(typeMode==2 && expMode==1)	//exp Abs & cal Abs
		GetAxis/Q/W=$GraphName exp_Abs; SetAxis/W=$newGraphName left    V_min,V_max
		GetAxis/Q/W=$GraphName exp_E  ; SetAxis/W=$newGraphName bottom  V_min,V_max
		GetAxis/Q/W=$GraphName cal_Abs; SetAxis/W=$newGraphName right   V_min,V_max
		GetAxis/Q/W=$GraphName cal_E  ; SetAxis/W=$newGraphName top     V_min,V_max
		Label /W=$newGraphName left     GetAxisLabel(GraphName,"exp_Abs",1)	; ModifyGraph lblMargin(left)   =0
		Label /W=$newGraphName bottom   "\\Z12 Photon Energy (eV)"			; ModifyGraph lblMargin(bottom) =5
		Label /W=$newGraphName right    GetAxisLabel(GraphName,"cal_Abs",1)	; ModifyGraph lblMargin(right)  =0
		Label /W=$newGraphName top      "\\Z12 Energy (meV)"				; ModifyGraph lblMargin(top)    =5
	elseif(typeMode==3)					//all waves
		GetAxis/Q/W=$GraphName exp_PL ; SetAxis/W=$newGraphName exp_PL  V_min,V_max
		GetAxis/Q/W=$GraphName exp_Abs; SetAxis/W=$newGraphName exp_Abs V_min,V_max
		GetAxis/Q/W=$GraphName exp_E  ; SetAxis/W=$newGraphName exp_E   V_min,V_max
		GetAxis/Q/W=$GraphName cal_PL ; SetAxis/W=$newGraphName cal_PL  V_min,V_max
		GetAxis/Q/W=$GraphName cal_Abs; SetAxis/W=$newGraphName cal_Abs V_min,V_max
		GetAxis/Q/W=$GraphName cal_E  ; SetAxis/W=$newGraphName cal_E   V_min,V_max
		Label /W=$newGraphName exp_PL   GetAxisLabel(GraphName,"exp_PL" ,1)	; ModifyGraph lblMargin(exp_PL) =5
		Label /W=$newGraphName exp_Abs  GetAxisLabel(GraphName,"exp_Abs",1)	; ModifyGraph lblMargin(exp_Abs)=0
		Label /W=$newGraphName exp_E    "\\Z12 Photon Energy (eV)"			; ModifyGraph lblMargin(exp_E)  =5
		Label /W=$newGraphName cal_PL   GetAxisLabel(GraphName,"cal_PL" ,1)	; ModifyGraph lblMargin(cal_PL) =5
		Label /W=$newGraphName cal_Abs  GetAxisLabel(GraphName,"cal_Abs",1)	; ModifyGraph lblMargin(cal_Abs)=0
		Label /W=$newGraphName cal_E    "\\Z12 Energy (meV)"				; ModifyGraph lblMargin(cal_E)  =5
	endif
//put legend
	if    (expMode==0 && typeMode!=3)
		text_cal = "\\Z08\\F'Courier New'"
		for (w=0; w<newWaveNum; w+=1)
			traceName = TraceNameStr(newGraphName,w)
			text_cal += "\r\\s(" + traceName + ") " + traceName
		endfor
		if    (typeMode==1 || calGainMode==0)
			TextBox/C/N=text_cal /A=LT/X=1/Y= 2.5 text_cal
		elseif(typeMode==2 && calGainMode==1)
			TextBox/C/N=text_cal /A=LB/X=1/Y= 2.5 text_cal
		endif
	elseif(expMode==1 && typeMode!=3)
		text_exp = "\\Z08\\F'Courier New'"
		text_cal = "\\Z08\\F'Courier New'"
		for (w=0; w<newWaveNum; w+=1)
			traceName = TraceNameStr(newGraphName,w)
			if (w<expWv_ShowNum)
				text_exp += "\r\\s(" + traceName + ") " + traceName
			else
				text_cal += "\r\\s(" + traceName + ") " + traceName
			endif
		endfor
		if    (typeMode==1 || expGainMode==0 || calGainMode==0)
			TextBox/C/N=text_exp /A=LT/X=1/Y= 2.5 text_exp
			TextBox/C/N=text_cal /A=RT/X=1/Y= 2.5 text_cal
		elseif(typeMode==2 && expGainMode==1 && calGainMode==1)
			TextBox/C/N=text_exp /A=LB/X=1/Y= 2.5 text_exp
			TextBox/C/N=text_cal /A=RB/X=1/Y= 2.5 text_cal
		endif
	elseif(typeMode==3)
		text_expPL  = "\\Z08\\F'Courier New'"
		text_expAbs = "\\Z08\\F'Courier New'"
		text_calPL  = "\\Z08\\F'Courier New'"
		text_calAbs = "\\Z08\\F'Courier New'"
		for (w=0; w<expWv_ShowNum; w+=1)
			traceName = TraceNameStr(newGraphName,w)
			if    (w<expPL_ShowNum)
				text_expPL  += "\r\\s(" + traceName + ") " + traceName
			elseif(w<expWv_ShowNum)
				text_expAbs += "\r\\s(" + traceName + ") " + traceName
			endif
		endfor
		for (w=expWv_ShowNum; w<newWaveNum; w+=2)
			text_calPL  += "\r\\s(" + TraceNameStr(newGraphName,w  ) + ") " + TraceNameStr(newGraphName,w  )
			text_calAbs += "\r\\s(" + TraceNameStr(newGraphName,w+1) + ") " + TraceNameStr(newGraphName,w+1)
		endfor
		TextBox/C/N=text_expPL /A=LT/X=1/Y= 2.5 text_expPL
		TextBox/C/N=text_expAbs/A=LB/X=1/Y= 2.5 text_expAbs
		TextBox/C/N=text_calPL /A=RT/X=1/Y= 2.5 text_calPL
		TextBox/C/N=text_calAbs/A=RB/X=1/Y= 2.5 text_calAbs
	endif
//others
	Killwaves WaveNameList
	SetDataFolder currentFolderPath
End

/////////////////////////////////////////
//shf1d Viewer [Set Variable Procedure]//
/////////////////////////////////////////
Function shf1dViewer_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
    String ctrlName
    Variable varNum       // value of variable as number
    String varStr         // value of variable as string
    String varName        // name of variable
//define parameters
	String GraphName, WorkFolderName, WorkFolderPath
	String traceName
	Variable Pmax, Pmin, i
//set parameters
	GraphName = WinName(0,1)
	WorkFolderName = GraphName[0,strsearch(GraphName,"_",Inf,1)-1]		//GraphName=srcGraphName_shf1dPlot
	WorkFolderPath = "root:shf1d_WorkFolder:" + WorkFolderName
//read stored parameters
	NVAR T             = $(WorkFolderPath + ":T" )
	NVAR g             = $(WorkFolderPath + ":g" )
	NVAR ne            = $(WorkFolderPath + ":ne")
	NVAR nh            = $(WorkFolderPath + ":nh")
	NVAR T_step        = $(WorkFolderPath + ":T_step" )
	NVAR g_step        = $(WorkFolderPath + ":g_step" )
	NVAR ne_step       = $(WorkFolderPath + ":ne_step")
	NVAR nh_step       = $(WorkFolderPath + ":nh_step")
	NVAR n_doped       = $(WorkFolderPath + ":n_doped")
	NVAR updateMode    = $(WorkFolderPath + ":updateMode")
	NVAR carrierMode   = $(WorkFolderPath + ":carrierMode")
	NVAR E__fixMode    = $(WorkFolderPath + ":E__fixMode")
	NVAR AbsfixMode    = $(WorkFolderPath + ":AbsfixMode")
	NVAR expPL_max     = $(WorkFolderPath + ":expPL_max")
	NVAR expPL_min     = $(WorkFolderPath + ":expPL_min")	
	NVAR expAbsmax     = $(WorkFolderPath + ":expAbsmax")
	NVAR expAbsmin     = $(WorkFolderPath + ":expAbsmin")
	NVAR expE__max     = $(WorkFolderPath + ":expE__max")
	NVAR expE__min     = $(WorkFolderPath + ":expE__min")
	NVAR calPL_max     = $(WorkFolderPath + ":calPL_max")
	NVAR calPL_min     = $(WorkFolderPath + ":calPL_min")	
	NVAR calAbsmax     = $(WorkFolderPath + ":calAbsmax")
	NVAR calAbsmin     = $(WorkFolderPath + ":calAbsmin")	
	NVAR calE__max     = $(WorkFolderPath + ":calE__max")
	NVAR calE__min     = $(WorkFolderPath + ":calE__min")
	NVAR calEshift     = $(WorkFolderPath + ":calEshift")
	NVAR expWaveNum    = $(WorkFolderPath + ":expWaveNum")
	NVAR expPL_WaveNum = $(WorkFolderPath + ":expPL_WaveNum")
	NVAR expAbsWaveNum = $(WorkFolderPath + ":expAbsWaveNum")
	NVAR calWaveNum    = $(WorkFolderPath + ":calWaveNum")
	NVAR calPL_WaveNum = $(WorkFolderPath + ":calPL_WaveNum")
	NVAR calAbsWaveNum = $(WorkFolderPath + ":calAbsWaveNum")
//program for ne parameters (carrier mode)
	if    (stringmatch(ctrlName,"ctrl_ne"))
		if    (carrierMode==0)	//independent
		elseif(carrierMode==1)	//undoped
			nh = ne
		elseif(carrierMode==2)	//n-doped
			nh = ne - n_doped
		elseif(carrierMode==3)	//p-doped
			nh = ne + n_doped
		endif
	endif
//program for ne parameters (carrier mode)
	if    (stringmatch(ctrlName,"ctrl_nh"))
		if    (carrierMode==0)	//independent
		elseif(carrierMode==1)	//undoped
			ne = nh
		elseif(carrierMode==2)	//n-doped
			ne = nh + n_doped
		elseif(carrierMode==3)	//p-doped
			ne = nh - n_doped
		endif
	endif
//program for "step" parameters
	if    (stringmatch(ctrlName,"ctrl_T_step"))
		SetVariable ctrl_T,  limits={0,999.9,T_step}
	elseif(stringmatch(ctrlName,"ctrl_g_step"))
		SetVariable ctrl_g,  limits={0,9.999,g_step}
	elseif(stringmatch(ctrlName,"ctrl_ne_step"))
		SetVariable ctrl_ne, limits={0,9.99999,ne_step}
	elseif(stringmatch(ctrlName,"ctrl_nh_step"))
		SetVariable ctrl_nh, limits={0,9.99999,nh_step}
	endif
//program for "axis" parameters
	if    (stringmatch(ctrlName,"ctrl_expPL_max") || stringmatch(ctrlName,"ctrl_expPL_min"))
		if (expPL_WaveNum == 0)
			expPL_max = 0
			expPL_min = 0
			SetAxis/A exp_PL
			return 0
		endif
		if  (expPL_max==expPL_min)
			SetAxis/A exp_PL
		else
			for (i=1; i<=expPL_WaveNum; i+=1)
				traceName = TraceNameStr(GraphName,expPL_WaveNum-i)
				if (TraceStats(GraphName,traceName)==0)
					break
				endif
			endfor
			WAVE expPL = TraceNameToWaveRef(GraphName,traceName)
			WAVE expE  =  XWaveRefFromTrace(GraphName,traceName)
			if  (expE__max==expE__min)
				WaveStats/Q/Z expPL
			else
				Pmax = (expE[0]<expE[Inf]) ? BinarySearch(expE,expE__max) : BinarySearch(expE,expE__min); Pmax = (Pmax!=-2) ? Pmax : numpnts(expE)-1
				Pmin = (expE[0]<expE[Inf]) ? BinarySearch(expE,expE__min) : BinarySearch(expE,expE__max); Pmin = (Pmin!=-1) ? Pmin : 0
				WaveStats/Q/Z/R=[Pmin,Pmax] expPL
			endif
			SetAxis exp_PL V_max*expPL_min/100,V_max*expPL_max/100
		endif
	elseif(stringmatch(ctrlName,"ctrl_calPL_max") || stringmatch(ctrlName,"ctrl_calPL_min"))
		if (calPL_WaveNum == 0)
			calPL_max = 0
			calPL_min = 0
			SetAxis/A cal_PL
			return 0
		endif
		if  (calPL_max==calPL_min)
			SetAxis/A cal_PL
		else
			WAVE calPL = WaveRefIndexed(GraphName,expWaveNum+4,1)
			if  (calE__max==calE__min)
				WaveStats/Q/Z calPL
			else
				Pmax = (pnt2x(calPL,numpnts(calPL)-1)<calE__max) ? x2pnt(calPL,calE__max) : numpnts(calPL)-1
				Pmin = (pnt2x(calPL,0)               >calE__min) ? x2pnt(calPL,calE__min) : 0
				WaveStats/Q/Z/R=[Pmin,Pmax] calPL
			endif
			SetAxis cal_PL V_max*calPL_min/100,V_max*calPL_max/100
		endif
	elseif(stringmatch(ctrlName,"ctrl_expAbsmax") || stringmatch(ctrlName,"ctrl_expAbsmin"))
		if (expAbsWaveNum == 0)
			expAbsmax = 0
			expAbsmin = 0
			SetAxis/A exp_Abs
			return 0
		endif
		if  (expAbsmax==expAbsmin)
			SetAxis/A exp_Abs
		else
			if (AbsfixMode==1)
				calAbsmax = expAbsmax
				calAbsmin = expAbsmin
				SetAxis cal_Abs calAbsmin,calAbsmax
			endif
			SetAxis exp_Abs expAbsmin,expAbsmax
		endif
	elseif(stringmatch(ctrlName,"ctrl_calAbsmax") || stringmatch(ctrlName,"ctrl_calAbsmin"))
		if (calAbsWaveNum == 0)
			calAbsmax = 0
			calAbsmin = 0
			SetAxis/A cal_Abs
			return 0
		endif
		if  (calAbsmax==calAbsmin)
			SetAxis/A cal_Abs
		else
			if (AbsfixMode==1 && expAbsWaveNum!=0)
				expAbsmax = calAbsmax
				expAbsmin = calAbsmin
				SetAxis exp_Abs expAbsmin,expAbsmax
			endif
			SetAxis cal_Abs calAbsmin,calAbsmax
		endif
	elseif(stringmatch(ctrlName,"ctrl_expE__max") || stringmatch(ctrlName,"ctrl_expE__min"))
		if (expWaveNum == 0)
			expE__max = 0
			expE__min = 0
			SetAxis/A exp_E
			return 0
		endif
		if (expE__max==expE__min)
			SetAxis/A exp_E
		else
			if (E__fixMode==1 && expWaveNum!=0)
				calE__max = -calEshift
				calE__min = -(expE__max - expE__min)*10^3 - calEshift
				SetAxis cal_E calE__min,calE__max
			endif
			SetAxis exp_E expE__min,expE__max
		endif
	elseif(stringmatch(ctrlName,"ctrl_calE__max") || stringmatch(ctrlName,"ctrl_calE__min"))
		if (calWaveNum == 0)
			calE__max = 0
			calE__min = 0
			SetAxis/A cal_E
			return 0
		endif
		if (calE__max==calE__min)
			SetAxis/A cal_E
		else
			if (E__fixMode==1 && expWaveNum!=0 && expE__max!=expE__min)
				calE__max = -calEshift
				calE__min = -calEshift -(expE__max - expE__min)*10^3
			endif
			SetAxis cal_E calE__min,calE__max
		endif
	endif
	if  (stringmatch(ctrlName,"ctrl_calEshift"))
		if (expWaveNum==0)
			calEshift = 0
			return 0
		endif
		if (E__fixMode==1 && expE__max!=expE__min)
			calE__max = - calEshift
			calE__min = - calEshift -(expE__max - expE__min)*10^3
			SetAxis cal_E calE__min,calE__max
		endif
	endif
//program for [live update]
	if (updateMode==1)
		if(stringmatch(ctrlName,"ctrl_T")||stringmatch(ctrlName,"ctrl_g")||stringmatch(ctrlName,"ctrl_ne")||stringmatch(ctrlName,"ctrl_nh")||stringmatch(ctrlName,"ctrl_confine"))
			shf1dViewer_Plot()
		endif
	endif
End

/////////////////////////////////////
//shf1d Viewer [Pop Menu Procedure]//
/////////////////////////////////////
Function shf1dViewer_PopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
    String ctrlName
    Variable popNum		// which item is currently selected (1-based)
    String popStr		// contents of current popup item as string
//define parameters
	String GraphName, WorkFolderName, WorkFolderPath
//set parameters
	GraphName = WinName(0,1)
	WorkFolderName = GraphName[0,strsearch(GraphName,"_",Inf,1)-1]
	WorkFolderPath = "root:shf1d_WorkFolder:" + WorkFolderName
//read stored parameters
	SVAR method        = $(WorkFolderPath + ":method")
	NVAR updateMode    = $(WorkFolderPath + ":updateMode")
	NVAR carrierMode   = $(WorkFolderPath + ":carrierMode")
	NVAR traceMode     = $(WorkFolderPath + ":traceMode")
	NVAR calPLnormMode = $(WorkFolderPath + ":calPLnormMode")
	NVAR calGainMode   = $(WorkFolderPath + ":calGainMode")
//program for method, carrierMode, traceMode, calPLnormMode, calGainMode parameter
	if    (stringmatch(ctrlName,"ctrl_method"))
		if    (stringmatch(popStr,"SHF"))
			method = "SHF"
		elseif(stringmatch(popStr,"FE"))
			method = "FE_"
		endif
	elseif(stringmatch(ctrlName,"ctrl_carrier"))
		if    (stringmatch(popStr,"independent"))
			carrierMode = 0
		elseif(stringmatch(popStr,"undoped"))
			carrierMode = 1
		elseif(stringmatch(popStr,"n-doped"))
			carrierMode = 2
		elseif(stringmatch(popStr,"p-doped"))
			carrierMode = 3
		endif
	elseif(stringmatch(ctrlName,"ctrl_trace"))
		if    (stringmatch(popStr,"overwrite"))
			traceMode = 0
		elseif(stringmatch(popStr,"append to"))
			traceMode = 1
		endif
	elseif(stringmatch(ctrlName,"ctrl_calPLnorm"))
		if    (stringmatch(popStr,"absolute"))
			calPLnormMode = 0
		elseif(stringmatch(popStr,"normalized"))
			calPLnormMode = 1
		endif
	elseif(stringmatch(ctrlName,"ctrl_calGain"))
		if    (stringmatch(popStr,"absorption"))
			calGainMode = 0
		elseif(stringmatch(popStr,"gain"))
			calGainMode = 1
		endif
	endif
//program for [live update]
	if (updateMode==1)
		if(stringmatch(ctrlName,"ctrl_method")||stringmatch(ctrlName,"ctrl_trace")||stringmatch(ctrlName,"ctrl_calPLnorm")||stringmatch(ctrlName,"ctrl_calGain"))
			shf1dViewer_Plot()
		endif
	endif
End

//////////////////////////////////////
//shf1d Viewer [Check Box Procedure]//
//////////////////////////////////////
Function shf1dViewer_CheckProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked	// 1 if checked, 0 if not
//define parameters
	String GraphName, WorkFolderName, WorkFolderPath
//set parameters
	GraphName = WinName(0,1)
	WorkFolderName = GraphName[0,strsearch(GraphName,"_",Inf,1)-1]		//GraphName=srcGraphName_shf1dPlot
	WorkFolderPath = "root:shf1d_WorkFolder:" + WorkFolderName
//read stored parameters
	NVAR updateMode    = $(WorkFolderPath + ":updateMode")
	NVAR E__fixMode    = $(WorkFolderPath + ":E__fixMode")
	NVAR AbsfixMode    = $(WorkFolderPath + ":AbsfixMode")
	NVAR expWaveNum    = $(WorkFolderPath + ":expWaveNum")
	NVAR expPL_WaveNum = $(WorkFolderPath + ":expPL_WaveNum")
	NVAR expAbsWaveNum = $(WorkFolderPath + ":expAbsWaveNum")
	NVAR expAbsmax     = $(WorkFolderPath + ":expAbsmax")
	NVAR expAbsmin     = $(WorkFolderPath + ":expAbsmin")
	NVAR calAbsmax     = $(WorkFolderPath + ":calAbsmax")
	NVAR calAbsmin     = $(WorkFolderPath + ":calAbsmin")
	NVAR expE__max     = $(WorkFolderPath + ":expE__max")
	NVAR expE__min     = $(WorkFolderPath + ":expE__min")
	NVAR calE__max     = $(WorkFolderPath + ":calE__max")
	NVAR calE__min     = $(WorkFolderPath + ":calE__min")
	NVAR calEshift     = $(WorkFolderPath + ":calEshift")
//program for update, E__fix, Absfix , calPLnorm parameter
	if    (stringmatch(ctrlName,"ctrl_update"))
		updateMode = checked
	elseif(stringmatch(ctrlName,"ctrl_E__fix"))
		E__fixMode = checked
		if (E__fixMode==1 && expWaveNum!=0 && expE__max!=expE__min)
			calE__max = - calEshift
			calE__min = - calEshift -(expE__max - expE__min)*10^3
			SetAxis cal_E calE__min,calE__max
		endif
	elseif(stringmatch(ctrlName,"ctrl_Absfix"))
		AbsfixMode = checked
		if    (AbsfixMode==1 && expAbsWaveNum!=0 && expAbsmax!=expAbsmin)
			calAbsmax = expAbsmax
			calAbsmin = expAbsmin
			SetAxis cal_Abs calAbsmin,calAbsmax	
		elseif(AbsfixMode==1 && expAbsWaveNum!=0 && calAbsmax!=calAbsmin)
			expAbsmax = calAbsmax
			expAbsmin = calAbsmin
			SetAxis exp_Abs expAbsmin,expAbsmax
		endif
	endif
End

///////////////////////////////////
//shf1d Viewer [Button Procedure]//
///////////////////////////////////
Function shf1dViewer_ButtonProc(ctrlName) : ButtonControl
	String ctrlName
//define parameters
	String GraphName, WorkFolderName, WorkFolderPath
//set parameters
	GraphName = WinName(0,1)
	WorkFolderName = GraphName[0,strsearch(GraphName,"_",Inf,1)-1]
	WorkFolderPath = "root:shf1d_WorkFolder:" + WorkFolderName
//read stored parameters
	NVAR DoneMode      = $(WorkFolderPath + ":DoneMode")
//program for done
	if (stringmatch(ctrlName,"ctrl_Done"))
		DoneMode = 1
		shf1dViewer_Plot()
		DoneMode = 0
	endif
//program for export
	if (stringmatch(ctrlName,"ctrl_Export"))
		shf1dViewer_Export()
	endif
End



####################################################################################################
//////////=====     shf1d data Analysis     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

Function shf1dAnalysis()
//define parameters
	String   GraphName, TraceName
	Variable N, i, Xfrom, Xupto, csrApnt, csrBpnt, Pfrom, Pupto, Ppeak
	Variable Xpeak, Xright, Xleft, Ymax, Yhalf, X0right, X0left
	Variable order
	Variable mu, gradient, GainPeak, GainArea
//set parameters
	GraphName = WinName(0,1)
	N = CountWaves(GraphName)
	csrApnt = pcsr(A,GraphName)
	csrBpnt = pcsr(B,GraphName)
	WAVE xA = CsrXWaveRef(A,GraphName)
	WAVE xB = CsrXWaveRef(B,GraphName)
	Xfrom = (xA[csrApnt]<xB[csrBpnt]) ? xA[csrApnt] : xB[csrBpnt]
	Xupto = (xA[csrApnt]<xB[csrBpnt]) ? xB[csrBpnt] : xA[csrApnt]
//main
	Make/O/N=(N) wv_mu, wv_gradient, wv_GainPeak, wv_GainArea
	for (i=0; i<N; i+=1)
		TraceName = TraceNameStr(GraphName,i)
		WAVE y = TraceNameToWaveRef(GraphName,TraceName)
		WAVE x = XWaveRefFromTrace(GraphName,TraceName)
		Pfrom = BinarySearchInterp(x,Xfrom)
		Pupto = BinarySearchInterp(x,Xupto)
		order = (Pfrom<Pupto) ? +1 : -1
	//find gain peak
		WaveStats/Q/R=[Pfrom,Pupto]/Z y
		Ymax  = V_max				; Yhalf = Ymax/2
		Ppeak = x2pnt(y,V_maxloc)	; Xpeak = x[Ppeak]
		if (Ymax<0)
			wv_mu[i] = NaN
			wv_gradient[i] = NaN
			wv_GainPeak[i] = NaN
			wv_GainArea[i] = NaN
			continue
		endif
		GainPeak = Ymax	; wv_GainPeak[i] = GainPeak
	//find mu
		FindLevel/P/Q/R=[Ppeak] y, 0
		mu = x[V_LevelX]	; wv_mu[i] = mu
	//cal. gradient
		Differentiate y /X=x/D=$("difWave")	; WAVE difWave = $("difWave")
		gradient    = difWave[x2pnt(y,mu)]	; wv_gradient[i] = gradient
		KillWaves difWave
	//cal. gain area
		FindLevel/P/Q/R=[Ppeak]   y, 0 ; X0right = (V_flag==0) ? x[V_LevelX] : x[Inf]
		FindLevel/P/Q/R=[Ppeak,0] y, 0 ; X0left  = (V_flag==0) ? x[V_LevelX] : x[0]
		GainArea = areaXY(x,y,X0left,X0right)	; wv_GainArea[i] = GainArea
	endfor
	Rename wv_mu, $("mu_"+GraphName[4,Inf])
	Rename wv_gradient, $("gradient_"+GraphName[4,Inf])
	Rename wv_GainPeak, $("GainPeak_"+GraphName[4,Inf])
	Rename wv_GainArea, $("GainArea_"+GraphName[4,Inf])
//	Display/N=$(GraphName+"_gradient") wv_gradient vs wv_mu as (GraphName+"_gradient")
//	Display/N=$(GraphName+"_GainPeak") wv_GainPeak vs wv_mu as (GraphName+"_GainPeak")
//	Display/N=$(GraphName+"_GainArea") wv_GainArea vs wv_mu as (GraphName+"_GainArea")
End


####################################################################################################
//////////=====     Other Program [useless thing]     =====\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
####################################################################################################

///////////
//Find mu//
///////////
Function Find_mu()
//define paramesters
	Variable w, N, mu
	Variable Efrom, Eupto, Pfrom, Pupto
	String GraphName, wv_muName
//set parameters
	GraphName = WinName(0,1)
	N = CountWaves(GraphName)
	Prompt Efrom, "Energy [from]"
	Prompt Eupto, "Energy [upto]"
	DoPrompt "Find mu", Efrom	//, Eupto
	if (V_flag==1)
		Print "Cancel"
		return -1
	endif
//make wave
	Make/O/N=(N) wv_mu
	wv_muName = "wv_mu_" + GraphName
	Rename wv_mu, $wv_muName
//main loop
	for (w=0; w<N; w+=1)
		WAVE y = WaveRefIndexed(GraphName,w,1)
		WAVE x = XWaveRefFromTrace(GraphName,NameOfWave(y))
		Pfrom = BinarySearchInterp(x,Efrom)
		Pupto = (x[0]<x[Inf]) ? numpnts(x) : 0
		FindLevel/P/Q/R=[Pfrom,Pupto] y, 0
		mu = x[V_LevelX]
		wv_mu[w] = mu
	endfor
	Edit wv_mu
End


/////////////////////
//Save Window Macro//
/////////////////////
Function SaveWindowMacro(WindowName)
	String WindowName              // "" for top graph or table 
	if (strlen(WindowName) == 0)
		WindowName = WinName(0, 3) // Name of top graph or table
	endif
	String cmd
	sprintf cmd, "DoWindow %s", windowName
	Print cmd
	Execute/P cmd
End


///////////////////////////////////
//Print Window Name and Wave Name//
///////////////////////////////////
Function Print_WinWaveName(WindowName)
	String WindowName
	Variable i,j
	i = CountWaves(WindowName)
	j = 0
	printf "WindowName : %s  ( the number of wave in the window : %g )\r", WindowName, i 
	do
		printf "  No.%02d : %s\r", j, WaveName(WindowName,j,1)
		j += 1
	while (j<i)
End


///////////////////
//Print Wave Name//
///////////////////
Function Print_WaveName()
	String WindowName = WinName(0,1)
	String Xname, Yname
	Variable i, j
	i = CountWaves(WindowName)
	for (j=0;j<i;j+=1)
		Xname = WaveName(WindowName,j,2)
		Yname = WaveName(WindowName,j,1)
		Print Xname
		Print Yname
	endfor
End


/////////////////////
//Extract Wave Pnts//
/////////////////////
//srcWaveのstartPntからendPntまでのデータのWaveを作る
Function ExtractWavePnts(srcWaveName,destWaveName,startPnt,endPnt)
	String srcWaveName, destWaveName
	Variable startPnt,endPnt
	Variable i, N
	WAVE srcWave = $srcWaveName
	N = endPnt - startPnt + 1
	Make/O/D/N=(N) destWave
	for (i=0; i<N; i+=1)
		destWave[i] = srcWave[startPnt+i]
	endfor
	Rename destWave, $destWaveName
End

///////////////////////
//AlGaAs Value Getter//
///////////////////////
Function AlGaAsValueGetter()
	Variable x, E, T, Eg, n
	Prompt x, "Al ratio"
	Prompt E, "photon energy (eV)"
	Prompt T, "temperature (K)"
	DoPrompt "AlGaAs Value Getter", x, E, T
	Eg = AlGaAsBandGap(x,T)
	n  = AlGaAsRefractiveIndex(x,E)
	printf "Al:%g%s, E=%g(eV), T=%g(K)\r", x*100, "(%)", E, T
	printf "Eg=%g(eV), n=%g\r", Eg, n
End

/////////////////////////////////////
//return AlGaAs BandGap Energy [eV]//
/////////////////////////////////////
Function AlGaAsBandGap(x,T)
	Variable x	//Al rario
	variable T	//temperature (K)
	Variable Eg	//Band Gap
	if    (x<=0.45)
		Eg = 1.519 + 1.247*x - 5.405*10^(-4)*T^2/(T+204)
	elseif(x> 0.45)
		Eg = 1.519 + 1.247*x - 5.405*10^(-4)*T^2/(T+204) + 1.147*(x-0.45)
	endif
	return Eg
End

//////////////////////////////////
//return AlGaAs Refractive Index//
//////////////////////////////////
Function AlGaAsRefractiveIndex(x,E)
	Variable x	//Al ratio
	Variable E	//photon energy (eV)
	Variable n	//refractive index
	n = 3.3 + 0.09*x - (0.08+0.7*x)*E + (0.19+0.16*x)*E^2 + 0.00023/((E-(1.42+1.25*x))^2+0.003)
	return n
End

/////////////////////////////
//return Physical Constants//
/////////////////////////////
Function PhysicalConstants(ConstName)
	String   ConstName
	Variable Value
	if    (stringmatch(ConstName,"k_B"))		//Boltzmann constant [eV/K]
		Value = 8.61734e-5
	elseif(stringmatch(ConstName,"h_bar"))		//Dirac constant [eV*s]
		Value = 6.58212e-16
	elseif(stringmatch(ConstName,"c*h_bar"))	//c*h_bar [eV*nm]
		Value = 1.97327e2
	elseif(stringmatch(ConstName,"E_mass"))		//electron rest mass energy [eV]
		Value = 5.10999e5
	elseif(stringmatch(ConstName,"c"))			//speed of light [m/s]
		Value = 2.99792e8
	elseif(stringmatch(ConstName,"e"))			//elementary electric charge [C]
		Value = 1.60218e-19
	else
		Value = NaN
	endif
	return Value
End


####################################################################################################
####################################################################################################
