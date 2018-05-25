//TrgWin contents: slPLE, erPLE, PL1, PL2...
#pragma rtGlobals=1		// Use modern global access method.
Menu "KSpanel"
	"KSwin", KSwin_101220()
End


Static StrConstant wn = "KSwin"	//graph name
Static StrConstant fadd = "root:KSwin"	//folder address

Static Constant e0 = 1.60217653e-19		//electron charge magnitude
Static Constant kB = 1.3806505e-23		//Boltzmann constant


Function KSwin_101220()

	if(-1 != FindListItem("KSwin", WinList("KSwin", ";","WIN:1")))	// If window already exists
		DoWindow/F KSwin
		return 0
	endif
	
	NewDataFolder/O $fadd
	String/G	 $fadd + ":TrgWin"	 = ""
	Variable/G $fadd + ":N_PL_waves"= 0
	Variable/G $fadd + ":PLdataNum"= 0
	Variable/G $fadd + ":fpeak1"	= 2
	Variable/G $fadd + ":fpeak2"	= 0.5
	Variable/G $fadd + ":laserw"	= 6
	Variable/G $fadd + ":clw"		= 2
	Variable/G $fadd + ":tl"		= 2
	Variable/G $fadd + ":clh"		= 0.5
	Variable/G $fadd + ":smth"		= 1
	Variable/G $fadd + ":PLoffset"	= 0
	Variable/G $fadd + ":PLEoffset"	= 0
	Variable/G $fadd + ":VerPL"	= 1.2
	Variable/G $fadd + ":VerPLE"	= 400
	Variable/G $fadd + ":CCDg"	= 1/3.65		//CCD gain value (cnts/e-)
	Variable/G $fadd + ":lim_num"	= 1
	Variable/G $fadd + ":VerKSlim"	= 0
	Variable/G $fadd +":fit_pfrom1" 	= 50
	Variable/G $fadd +":fit_pto1"	= 75
	Variable/G $fadd +":fit_pfrom2" 	= 75
	Variable/G $fadd +":fit_pto2"	= 100
	Variable/G $fadd +":fit_pfrom3" 	= 100
	Variable/G $fadd +":fit_pto3"	= 125
	Variable/G $fadd +":fit_pfrom4" 	= 125
	Variable/G $fadd +":fit_pto4"	= 150
	
	SVAR TrgWin			= $fadd + ":TrgWin"
	NVAR N_PL_waves 	= $fadd + ":N_PL_waves"
	NVAR PLdataNum 		= $fadd + ":PLdataNum"
	NVAR fpeak1			= $fadd + ":fpeak1"
	NVAR fpeak2			= $fadd + ":fpeak2"
	NVAR laserw 			= $fadd + ":laserw"
	NVAR clw 			= $fadd + ":clw"
	NVAR tl 				= $fadd + ":tl"
	NVAR clh 			= $fadd + ":clh"
	NVAR smth 			= $fadd + ":smth"
	NVAR PLoffset		= $fadd + ":PLoffset"
	NVAR PLEoffset		= $fadd + ":PLEoffset"
	NVAR VerPL			= $fadd + ":VerPL"	
	NVAR VerPLE		= $fadd + ":VerPLE"
	NVAR CCDg			= $fadd + ":CCDg"
	NVAR lim_num		= $fadd + ":lim_num"
	NVAR VerKSlim		= $fadd + ":VerKSlim"
	NVAR fit_pfrom1 		= $fadd + ":fit_pfrom1"
	NVAR fit_pto1 		= $fadd + ":fit_pto1"
	NVAR fit_pfrom2 		= $fadd + ":fit_pfrom2"
	NVAR fit_pto2 		= $fadd + ":fit_pto2"
	NVAR fit_pfrom3 		= $fadd + ":fit_pfrom3"
	NVAR fit_pto3			= $fadd + ":fit_pto3"
	NVAR fit_pfrom4 		= $fadd + ":fit_pfrom4"
	NVAR fit_pto4 		= $fadd + ":fit_pto4"
	SetDataFolder root:
	
	//Window
	Display/N=KSwin /W=(400, 50,950,650) /K=1
	ShowInfo
	ModifyGraph margin(left)=57,margin(bottom)=34,margin(top)=28,margin(right)=57
	ControlBar 240
	SetWindow KSwin, hook(housekeepinghook) = KSwin_HKhook	// HouseKeeping hook

	
	//Buttons
	Button button0, pos={125,95}, size={70,55}, font="Arial", proc=KSwin_ExcEng_button, title="Exc.Eng"
	Button button1, pos={470,180}, size={100,50}, font="Arial", proc=KS_SaveFitData_button, title="Save to KS_DF"

	//PopupMenu
	PopupMenu popup0,pos={16,15},size={170,25}, font="Arial", mode=1, proc=KSwin_Pop, title = "TrgWin" ,popvalue="none", value= "none;" +  WinList("*", ";", "WIN:1")

	//CheckBox
	//CheckBox check0,pos={60,80},size={40,15}, mode=1, proc=PLEwin_CheckBoxproc,title = "PLE mode", value= 1
//	CheckBox check3,pos={200,15},size={10,15}, mode=0, proc=csr_CheckBoxproc,title = "A", value= 1
//	CheckBox check4,pos={200,45},size={10,15}, mode=0, proc=csr_CheckBoxproc,title = "B", value= 1
	
	//SetValues
	SetVariable setvar0, pos={220,20},	size={128,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= PLdataNum
	SetVariable setvar1, pos={15,100},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fpeak1
	SetVariable setvar2, pos={15,130},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fpeak2
	SetVariable setvar3, pos={230,65},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= laserw
	SetVariable setvar4, pos={230,90},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= clw
	SetVariable setvar5, pos={230,115},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= tl
	SetVariable setvar6, pos={230,140},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,0.2}, value= clh
	SetVariable setvar7, pos={230,165},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= smth
	SetVariable setvar8, pos={350,65},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={-10,inf,1}, value= PLoffset
	SetVariable setvar9, pos={350,90},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= PLEoffset
	SetVariable setvar10, pos={350,115},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= VerPL
	SetVariable setvar11, pos={350,140},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= VerPLE
	SetVariable setvar12, pos={350,165},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= CCDg
	SetVariable setvar13, pos={350,190},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= lim_num		
	SetVariable setvar14, pos={330,215},	size={120,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,0.001}, value= VerKSlim
	SetVariable setvar15, pos={470,65},	size={115,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fit_pfrom1
	SetVariable setvar16, pos={590,65},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fit_pto1
	SetVariable setvar17, pos={470,90},	size={115,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fit_pfrom2
	SetVariable setvar18, pos={590,90},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fit_pto2
	SetVariable setvar19, pos={470,115},	size={115,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fit_pfrom3
	SetVariable setvar20, pos={590,115},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fit_pto3
	SetVariable setvar21, pos={470,140},	size={115,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fit_pfrom4
	SetVariable setvar22, pos={590,140},	size={100,20}, proc=KSwin_ChngVal, font="Arial", fSize=12, limits={0,inf,1}, value= fit_pto4
End



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Function KSwin_Pop(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	SVAR TrgWin			= $fadd + ":TrgWin"
	NVAR N_PL_waves 	= $fadd + ":N_PL_waves"
	NVAR PLdataNum 		= $fadd + ":PLdataNum"
	
	RemoveFromGraph/W=$TrgWin/Z laser_max
	
	Variable N_all_waves
	
	if(stringmatch(ctrlName, "popup0"))
		TrgWin = popStr
		N_all_waves = CountWaves(TrgWin)
		
		SetDataFolder root:KSwin
		KillWaves/A/Z 
		

		if(-1 == FindListItem("laser_max", WaveList("laser_max", ";","WIN:" + TrgWin)))	// If the wave "laser_max" does not exist
			N_PL_waves = N_all_waves - 2
		else
			N_PL_waves = N_all_waves - 3
		endif
		
		if(N_PL_waves >= 1)
			SetVariable setvar0,	limits={0,N_PL_waves-1,1}
		endif
		
		Variable i=0
		Wave x = XWaveRefFromTrace(TrgWin, NameOfWave(WaveRefIndexed(TrgWin,i,1)))
		
		SetVariable setvar15,	limits={0,numpnts(x)-1, 1}
		SetVariable setvar16,	limits={0,numpnts(x)-1, 1}
		SetVariable setvar17,	limits={0,numpnts(x)-1, 1}
		SetVariable setvar18,	limits={0,numpnts(x)-1, 1}
		SetVariable setvar19,	limits={0,numpnts(x)-1, 1}
		SetVariable setvar20,	limits={0,numpnts(x)-1, 1}
		SetVariable setvar21,	limits={0,numpnts(x)-1, 1}
		SetVariable setvar22,	limits={0,numpnts(x)-1, 1}	
		
		SetDataFolder root:
		
		PLdataNum =0
		
		Make_Tw(N_PL_waves)
		
		KilldataFolder/Z root:KS_DF
		NewDataFolder/O root:KS_DF
		DoWindow/F $TrgWin
			
	endif
End


Function KSwin_HKhook(s)
	STRUCT WMWinHookStruct &s
	SVAR TrgWin = $fadd + ":TrgWin"
	Variable rval = 0

	switch(s.eventCode)
		case 2:	// kill
			
			RemoveFromGraph/W=$TrgWin/Z laser_max
			KillWaves/Z $fadd + ":laser_max"
			SetDataFolder root:KSwin:
			KillWaves/A/Z; KillVariables/A/Z; KillStrings/A/Z
			KillDataFolder/Z root:KSwin
			KillDataFolder/Z root:KS_DF
			SetDataFolder root:
			rval = 1
			break
	endswitch
	return rval
End



Function KSwin_ExcEng_button(ctrlName) : ButtonControl		//KS_graph_plot
	String ctrlName
	
	Make_ExcEng_Wave()
	
End


Function KSwin_ChngVal(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	SVAR TrgWin = $fadd + ":TrgWin"
	
	if(strlen(TrgWin)==0)
		DoAlert 0,"No window."
		return -1
	endif

	if( stringmatch( ctrlName, "setvar*") )
		KS_PLEdisplay()
		KS_PLdisplay()
		KS_intp_display()
		KS_display()
		KSfit_display()
		ModifyGraph/W=KSwin log(left)=1, axThick=0.5,standoff=0
		SetDataFolder root:
	endif
End
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Function KS_SaveFitData_button(ctrlName) : ButtonControl		//KS_graph_plot
	String ctrlName

	SVAR TrgWin 			= $fadd + ":TrgWin"
	NVAR PLdataNum 			= $fadd + ":PLdataNum"
	NVAR PLoffset			= $fadd + ":PLoffset"
	NVAR PLEoffset			= $fadd + ":PLEoffset"
	NVAR VerPL				= $fadd + ":VerPL"	
	NVAR VerPLE			= $fadd + ":VerPLE"
	NVAR CCDg				= $fadd + ":CCDg"	
	NVAR laserw				= $fadd + ":laserw"	
	NVAR lim_num			= $fadd + ":lim_num"

	String new_wn
	
	SetDataFolder root:KSwin

	//copy PLE to Folder
	new_wn = "root:KS_DF:" + "PLE_x"
	Duplicate/O PLE_x, $new_wn
	new_wn = "root:KS_DF:" + "PLE_y"
	Duplicate/O PLE_y, $new_wn
	new_wn = "root:KS_DF:" + "PLE_y_n"
	Duplicate/O PLE_y_n, $new_wn

	//copy PL to Folder
	new_wn = "root:KS_DF:" + "PLy_" + num2str(PLdataNum)
	Duplicate/O PLy, $new_wn
	new_wn = "root:KS_DF:" + "PLy_n_" + num2str(PLdataNum)
	Duplicate/O PLy_n, $new_wn
	new_wn = "root:KS_DF:" + "PLx_" + num2str(PLdataNum)
	Duplicate/O PLx, $new_wn

	//copy KSln_y to Folder
	new_wn = "root:KS_DF:" + "KSln_y_" + num2str(PLdataNum)
	Duplicate/O KSln_y, $new_wn
	new_wn = "root:KS_DF:" + "sgmKS_" + num2str(PLdataNum)
	Duplicate/O sgmKS, $new_wn
	
	//copy fit to Folder	
	new_wn = "root:KS_DF:" + "fit1_" + num2str(PLdataNum)
	Duplicate/O fit1, $new_wn
	new_wn = "root:KS_DF:" + "fit2_" + num2str(PLdataNum)
	Duplicate/O fit2, $new_wn
	new_wn = "root:KS_DF:" + "fit3_" + num2str(PLdataNum)
	Duplicate/O fit3, $new_wn
	new_wn = "root:KS_DF:" + "fit4_" + num2str(PLdataNum)
	Duplicate/O fit4, $new_wn

	//copy Tw to Folder	
	new_wn = "root:KS_DF:" + "Tw1"
	Duplicate/O Tw1, $new_wn
	new_wn = "root:KS_DF:" + "dTw1"
	Duplicate/O dTw1, $new_wn
	new_wn = "root:KS_DF:" + "Tw2"
	Duplicate/O Tw2, $new_wn
	new_wn = "root:KS_DF:" + "dTw2"
	Duplicate/O dTw2, $new_wn
	new_wn = "root:KS_DF:" + "Tw3"
	Duplicate/O Tw3, $new_wn
	new_wn = "root:KS_DF:" + "dTw3"
	Duplicate/O dTw3, $new_wn
	new_wn = "root:KS_DF:" + "Tw4"
	Duplicate/O Tw4, $new_wn
	new_wn = "root:KS_DF:" + "dTw4"
	Duplicate/O dTw4, $new_wn
	new_wn = "root:KS_DF:" + "laser_maxloc_x"
	Duplicate/O laser_maxloc_x, $new_wn


	SetDataFolder root:
End




///
Function Make_Tw(num)
	Variable num
	
	SetDataFolder root:KSwin:
	Make/O/N=(num) Tw1, dTw1, Tw2, dTw2, Tw3, dTw3, Tw4, dTw4
	Tw1=NaN; dTw1=NaN
	Tw2=NaN; dTw2=NaN
	Tw3=NaN; dTw3=NaN
	Tw4=NaN; dTw4=NaN	
	SetDataFolder root:
End

	
Function KSfit_display()

	NVAR PLdataNum 		= $fadd + ":PLdataNum"
	NVAR fit_pfrom1 		= $fadd + ":fit_pfrom1"
	NVAR fit_pto1 		= $fadd + ":fit_pto1"
	NVAR fit_pfrom2 		= $fadd + ":fit_pfrom2"
	NVAR fit_pto2 		= $fadd + ":fit_pto2"
	NVAR fit_pfrom3 		= $fadd + ":fit_pfrom3"
	NVAR fit_pto3			= $fadd + ":fit_pto3"
	NVAR fit_pfrom4 		= $fadd + ":fit_pfrom4"
	NVAR fit_pto4 		= $fadd + ":fit_pto4"
	
	
	Variable i = PLdataNum
	
	//fit1//	
	KSfit(fit_pfrom1, fit_pto1)
	SetDataFolder root:KSwin:
	Wave fitdest, tmpT
	Wave Tw1, dTw1

	Tw1[i]=tmpT[0]
	dTw1[i]=tmpT[1]
	
	Duplicate/O fitdest, fit1
	if(-1 == FindListItem("fit1", WaveList("fit1", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin/R $fadd + ":fit1" vs $fadd + ":PLE_x"
		ModifyGraph/W=KSwin rgb(fit1)=(32768,54528,65280)
	endif
	TextBox/W=KSwin/C/N=fitting_All/A=MC "\\F'Arial'\\Z10\s(fit1)T*(1)= " + num2str(Tw1[i]) + " ± " + num2str(dTw1[i]) + " K"
	
	//fit2//	
	KSfit(fit_pfrom2, fit_pto2)
	SetDataFolder root:KSwin:
	Wave fitdest, tmpT
	Wave Tw2, dTw2

	Tw2[i]=tmpT[0]
	dTw2[i]=tmpT[1]
	
	Duplicate/O fitdest, fit2
	if(-1 == FindListItem("fit2", WaveList("fit2", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin/R $fadd + ":fit2" vs $fadd + ":PLE_x"
		ModifyGraph/W=KSwin rgb(fit2)=(0,39168,0)
	endif
	AppendText/W=KSwin/N=fitting_All "\\F'Arial'\\Z10\s(fit2)T*(2)= " + num2str(Tw2[i]) + " ± " + num2str(dTw2[i]) + " K"
	
	//fit3//	
	KSfit(fit_pfrom3, fit_pto3)
	SetDataFolder root:KSwin:
	Wave fitdest, tmpT
	Wave Tw3, dTw3

	Tw3[i]=tmpT[0]
	dTw3[i]=tmpT[1]
	
	Duplicate/O fitdest, fit3
	if(-1 == FindListItem("fit3", WaveList("fit3", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin/R $fadd + ":fit3" vs $fadd + ":PLE_x"
		ModifyGraph/W=KSwin rgb(fit3)=(24576,24576,65280)
	endif
	AppendText/W=KSwin/N=fitting_All "\\F'Arial'\\Z10\s(fit3)T*(3)= " + num2str(Tw3[i]) + " ± " + num2str(dTw3[i]) + " K"
	
	//fit4//	
	KSfit(fit_pfrom4, fit_pto4)
	SetDataFolder root:KSwin:
	Wave fitdest, tmpT
	Wave Tw4, dTw4

	Tw4[i]=tmpT[0]
	dTw4[i]=tmpT[1]
	
	Duplicate/O fitdest, fit4
	if(-1 == FindListItem("fit4", WaveList("fit4", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin/R $fadd + ":fit4" vs $fadd + ":PLE_x"
		ModifyGraph/W=KSwin rgb(fit4)=(52224,34816,0)
	endif
	AppendText/W=KSwin/N=fitting_All "\\F'Arial'\\Z10\s(fit4)T*(4)= " + num2str(Tw4[i]) + " ± " + num2str(dTw4[i]) + " K"
	
	KillWaves/Z fitdest, tmpT
End



Static Function KSfit(fit_pfrom, fit_pto)
	Variable fit_pfrom, fit_pto
	
	Variable fitmode=4
	Variable conf_level =0.95
	
	SetDataFolder root:KSwin:
	Wave KSln_y
	Wave PLE_x
	Wave sgmKS
	
	
	Variable tf=0
	Variable j
	for(j=min(fit_pfrom, fit_pto); j<=max(fit_pfrom, fit_pto); j+=1)	//counting data points for fit.
		if(numtype(KSln_y[j])==0)
			tf+=1
		endif
	endfor
	Print "fitpnts=" + num2str(tf)
	
	Make/N=2/O tmpT
	Duplicate/O PLE_x, fitdest
	fitdest=NaN
	
	if(tf<=2)
		
		tmpT[0] = NaN
		tmpT[1] = NaN
			
	elseif(numtype(fit_pfrom)==0 && numtype(fit_pto)==0 && tf>2)
	
	
		CurveFit/Q line  KSln_y [min(fit_pfrom, fit_pto), max(fit_pfrom, fit_pto)] /X=PLE_x /W=sgmKS /I=1 /D=fitdest /F={conf_level, fitmode}
		Wave W_coef, W_sigma , W_ParamConfidenceInterval


		tmpT[0] = - e0 / (kB * W_coef[1])
		tmpT[1] =  e0 / kB * W_ParamConfidenceInterval[1] / (W_coef[1])^2

		KillWaves W_coef, W_sigma, W_ParamConfidenceInterval

	endif
	SetDataFolder root:
End	
	

Function culc_KSplot()

	SVAR TrgWin 			= $fadd + ":TrgWin"
	NVAR PLdataNum 			= $fadd + ":PLdataNum"
	NVAR PLoffset			= $fadd + ":PLoffset"
	NVAR PLEoffset			= $fadd + ":PLEoffset"
	NVAR VerPL				= $fadd + ":VerPL"	
	NVAR VerPLE			= $fadd + ":VerPLE"
	NVAR CCDg				= $fadd + ":CCDg"	
	NVAR laserw				= $fadd + ":laserw"	
	NVAR lim_num			= $fadd + ":lim_num"	
	NVAR VerKSlim			= $fadd + ":VerKSlim"
			
	SetDataFolder root:KSwin:
	Wave PLE_x
	Wave PLE_y
	Wave PLEer_y
	Wave PLx
	Wave PLy
	Wave tmp_y
	Wave laser_maxloc
	

	Variable i = 2 + PLdataNum	
	//KScalcuration
	Variable npntsPLE = numpnts(PLE_x)
	Make/N=(npntsPLE)/O KSln_y
	KSln_y = ln((tmp_y + PLoffset) / (PLE_y + PLEoffset) /(PLE_x)^2)


	//error estimation
	Make/N=(npntsPLE)/O sgmPL, sgmPLE, sgmKS
	sgmPL 	= sqrt( CCDg*abs((tmp_y + PLoffset)) + 2*(VerPL)^2)
	sgmPLE 	= sqrt( CCDg*abs(PLE_y+PLEoffset) + (VerPLE)^2 + (PLEer_y)^2)
	sgmKS	= sqrt((sgmPL/(tmp_y + PLoffset))^2 + (sgmPLE/(PLE_y+PLEoffset))^2 + (VerKSlim)^2)



	//exclude invalid KSdata points
	Variable j
	for(j=0; j < npntsPLE ; j+=1)
		if(tmp_y[j]<=2*sgmPL[j])
			KSln_y[j]=NaN
			sgmKS[j]=NaN
		endif
		if(PLE_y[j]<=2*sgmPLE[j])
			KSln_y[j]=NaN
			sgmKS[j]=NaN
		endif
	endfor


	//	exclude invalid KS data points
	//lim_num---limitation number to cut off the data

//	WaveStats/Q/Z PLE_y
//	Variable PLmaxlocintp = V_maxloc
	WaveStats/Q/Z tmp_y
	Variable PLmaxlocintp = V_maxloc

	Variable temp_n=0
//	Variable fit_pfrom=NaN; Variable fit_pto=NaN
	for(j=PLmaxlocintp ; j < npntsPLE ; j+=1)
		if(min(PLx[laser_maxloc[i] - laserw] , PLx[ laser_maxloc[i] + laserw]) <= PLE_x[j] && PLE_x[j] <= max(PLx[ laser_maxloc[i] - laserw] , PLx[ laser_maxloc[i] + laserw]))
		elseif(numtype(KSln_y[j])==2 && numtype(tmp_y[j])==2 )
		elseif(numtype(KSln_y[j])==2 && numtype(PLE_y[j])==2 )
		elseif(numtype(KSln_y[j])==2)	//if KSln_y[j]==NaN
			temp_n +=1
		endif
		if(temp_n>=lim_num)
			KSln_y[j]=NaN
			sgmKS[j]=NaN
		endif
	endfor

	temp_n=0
	for(j=PLmaxlocintp ; j >= 0 ; j-=1)
//		Print num2str(j)+"/PLE_x/"+num2str(PLE_x[j])+"/KSln/"+num2str(KSln_y[j]) + "/tmp_y/" +num2str(tmp_y[j])+"/PLE_y/"+num2str(PLE_y[j])
		if(min(PLx[ laser_maxloc[i] - laserw] , PLx[ laser_maxloc[i] + laserw]) <= PLE_x[j] && PLE_x[j] <= max(PLx[ laser_maxloc[i] - laserw] , PLx[ laser_maxloc[i] + laserw]))
		elseif(numtype(KSln_y[j])==2 && numtype(tmp_y[j])==2 )
		elseif(numtype(KSln_y[j])==2 && numtype(PLE_y[j])==2 )
		elseif(numtype(KSln_y[j])==2)	//if KSln_y[j]==NaN
			temp_n +=1
		endif
		Print num2str(temp_n)
		if(temp_n>=lim_num)
			KSln_y[j]=NaN
			sgmKS[j]=NaN
		endif
	endfor

	SetDataFolder root:
End



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




Static Function KS_display()

	SVAR TrgWin 		= $fadd + ":TrgWin"
	NVAR PLdataNum 		= $fadd + ":PLdataNum"
	NVAR N_PL_waves 	= $fadd + ":N_PL_waves"
	
	culc_KSplot()
	
	SetDataFolder $fadd
	if(-1 == FindListItem("KSln_y", WaveList("KSln_y", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin/R $fadd + ":KSln_y" vs $fadd + ":PLE_x"
		ModifyGraph mode(KSln_y)=2,lsize(KSln_y)=0.5,rgb(KSln_y)=(0,0,0)
	endif
	if(-1 == FindListItem("sgmKS", WaveList("sgmKS", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin/L=er_axis $fadd + ":sgmKS" vs $fadd + ":PLE_x"
		ModifyGraph/W=KSwin rgb(PLy)=(65280,48896,62208)
		ErrorBars/T=0 KSln_y Y,wave=(sgmKS, sgmKS)
	endif

	SetDataFolder root:
End



Static Function KS_PLdisplay()

	SVAR TrgWin 		= $fadd + ":TrgWin"
	NVAR PLdataNum 		= $fadd + ":PLdataNum"
	NVAR N_PL_waves 	= $fadd + ":N_PL_waves"
	
	Variable i = 2 + PLdataNum
	Wave x = XWaveRefFromTrace(TrgWin, NameOfWave(WaveRefIndexed(TrgWin,i,1)))
	Wave y = WaveRefIndexed(TrgWin,i,1)
	String wnx = GetWavesDataFolder(x, 2)
	String wny = GetWavesDataFolder(y, 2)
	Duplicate/O x, $fadd + ":PLx"
	Duplicate/O y, $fadd + ":PLy"
	
	SetDataFolder $fadd
	if(-1 == FindListItem("PLy", WaveList("PLy", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin $fadd + ":PLy" vs $fadd + ":PLx"
		ModifyGraph/W=KSwin rgb(PLy)=(65280,48896,62208)
	endif

//	SetDrawLayer/W=KSwin/K UserFront
	SetDrawEnv/W=KSwin fsize=08
	DrawText/W=KSwin 0.02, 0.02, "PLy: " + wny + "//PLx: " + wnx

	SetDataFolder root:
End



Static Function KS_PLEdisplay()

	SVAR TrgWin = $fadd + ":TrgWin"

	Variable i=0
	Wave x0 = XWaveRefFromTrace(TrgWin, NameOfWave(WaveRefIndexed(TrgWin,i,1)))
	Wave y0 = WaveRefIndexed(TrgWin,i,1)
 	Duplicate/O x0, $fadd + ":PLE_x"
	Duplicate/O y0, $fadd + ":PLE_y"
	String wnx = GetWavesDataFolder(x0, 2)
	String wny = GetWavesDataFolder(y0, 2)

	i=1
	Wave y1 = WaveRefIndexed(TrgWin,i,1)
	Duplicate/O y1, $fadd + ":PLEer_y"
	
	SetDataFolder $fadd
	if(-1 == FindListItem("PLE_y", WaveList("PLE_y", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin $fadd + ":PLE_y" vs $fadd + ":PLE_x"
		ModifyGraph/W=KSwin rgb(PLE_y)=(0,0,62208)
	endif
	if(-1 == FindListItem("PLEer_y", WaveList("PLEer_y", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin/L=er_axis $fadd + ":PLEer_y" vs $fadd + ":PLE_x"
		ModifyGraph/W=KSwin rgb(PLEer_y)=(34816,34816,34816)
		ModifyGraph/W=KSwin freePos(er_axis)=0, axisEnab(left)={0.25,1}, axisEnab(er_axis)={0,0.2}, log(er_axis)=1
		ModifyGraph axThick=0.5,standoff=0
	endif
	
	SetDrawLayer/W=KSwin/K UserFront
	SetDrawEnv/W=KSwin fsize=08
	DrawText/W=KSwin 0.02, 0.04, "PLEy: " + wny +  "//PLEx: " + wnx

	SetDataFolder root:
End



Static Function KS_intp_display()

	SVAR TrgWin 		= $fadd + ":TrgWin"
	NVAR PLdataNum 		= $fadd + ":PLdataNum"
	NVAR N_PL_waves 	= $fadd + ":N_PL_waves"
	
	//load PLE waves
//	Wave PLEx 	= WaveRefIndexed(TrgWin, 0, 2)	// PLE X Wave
//	Wave PLEy 	= WaveRefIndexed(TrgWin, 0, 1)	// PLE Y Wave
	
	Variable PLmaxlocxintp = PLinterp()
		
	SetDataFolder $fadd
	Wave PLE_x, PLE_y
	if(-1 == FindListItem("tmp_y", WaveList("tmp_y", ";","WIN:KSwin")))	// If wave not exist
		AppendToGraph/W=KSwin $fadd + ":tmp_y" vs PLE_x
		ModifyGraph/W=KSwin mode(tmp_y)=3,marker(tmp_y)=7,msize(tmp_y)=1.5, rgb(tmp_y)=(65280,0,0)
	endif
	
	SetDataFolder root:
End
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Function PLinterp()
	
	//WindowData
	SVAR TrgWin			= $fadd + ":TrgWin"
	NVAR laserw 			= $fadd + ":laserw"
	NVAR PLdataNum 		= $fadd + ":PLdataNum"
	NVAR N_PL_waves 	= $fadd + ":N_PL_waves"
	NVAR clw 			= $fadd + ":clw"
	NVAR tl 				= $fadd + ":tl"
	NVAR clh 			= $fadd + ":clh"
	NVAR smth 			= $fadd + ":smth"
	
	
	//load PLE waves
//	Wave PLEx 	= WaveRefIndexed(TrgWin, 0, 2)	// PLE X Wave
//	Wave PLEy 	= WaveRefIndexed(TrgWin, 0, 1)	// PLE Y Wave
//	Wave erPLEx 	= WaveRefIndexed(TrgWin, 1, 2)	// erPLE X Wave
//	Wave erPLEy 	= WaveRefIndexed(TrgWin, 1, 1)	// erPLE Y Wave

	SetDataFolder root:KSwin:
	Wave PLE_x, PLE_y, PLEer_y
	
	//PLE wave information
	WaveStats/Q PLE_x
	Variable npntsPLE = numpnts(PLE_x)
	print "PLE data points: " + num2str(npntsPLE)
	
	//PLE normalize
	SetDataFolder root:KSwin:
	WaveStats/Q PLE_y
	Variable maxPLEy = V_max
	Duplicate/O PLE_y, PLE_y_n
	PLE_y_n = PLE_y_n / maxPLEy * 5
	SetDataFolder root:	
	
	//load PL waves
	Variable i=PLdataNum
	Wave PLx = XWaveRefFromTrace(TrgWin, NameOfWave(WaveRefIndexed(TrgWin, i+2 , 1)))	// PL X wave
	Wave PLy = WaveRefIndexed(TrgWin, i+2 , 1)	// PL Y Wave
	SetDataFolder root:KSwin:
	Wave laser_maxloc
	
	//PL wave information
	WaveStats/Q PLx
	Variable npntsPL = V_npnts
	Variable minPLx = V_min
	Variable maxPLx = V_max
	
	//Delete invalid PL data(cosmic lays)
	Duplicate/O PLy, PLy_n, tPLy, tdPLy, cl
	cl=NaN

	Variable j, k

	for(j=0 ; j<1340; j+=1)	//Differenciating PLy wave
		if(j==0)
			tdPLy[j]=NaN
		else
			tdPLy[j]=-(tPLy[j]-tPLy[j-1])
		endif
	endfor
	
	j=0
	do
		WaveStats/Q/R=(j,j+clw) tdPLy
		if( laser_maxloc[i]-laserw <= j && j <= laser_maxloc[i] + laserw )
			tPLy[j]=NaN
		elseif(numtype(tPLy[j]) == 2)
		elseif(V_max * V_min < -clh*10^(6) && V_maxloc >= V_minloc)	//Deleting Points
			for(k =V_minloc-tl ; k<=V_maxloc+tl; k+=1 )
				tPLy[k] = NaN
				cl[k] = PLy[k]
			endfor
			j=V_maxloc
		endif
	j+=1
	while(j<1340-clw)
	
	//PL normalization
	WaveStats/Q tPLy
	Variable maxPLy = V_max
	Variable maxlocPLy=V_maxloc
	PLy_n = PLy / maxPLy * 5
//	cl = cl / maxPLy * 5
	
	//interpolation
	Variable intp_from, intp_to, tp, PLmaxlocxintp
	if(smth>0)
		Smooth smth, tPLy
	endif
	tp=0
	Make/N=(npntsPLE)/O tmp_y
	for(j=0;j<npntsPLE;j+=1)
		if(PLE_x[j] < minPLx || maxPLx < PLE_x[j])
			tmp_y[j] = NaN
		elseif(min(PLx[ laser_maxloc[i] - laserw] , PLx[  laser_maxloc[i] + laserw]) <= PLE_x[j] && PLE_x[j] <= max(PLx[  laser_maxloc[i] - laserw] , PLx[  laser_maxloc[i] + laserw]))
			tmp_y[j] = NaN
		else
			tmp_y[j] = interp(PLE_x[j], PLx, tPLy)
		endif
	endfor
	KillWaves/Z tPLy, tdPLy, cl
End
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Function Make_ExcEng_Wave()

	SVAR TrgWin 	= $fadd + ":TrgWin"
	NVAR N_PL_waves = $fadd + ":N_PL_waves"
	NVAR fpeak1		= $fadd + ":fpeak1"
	NVAR fpeak2		= $fadd + ":fpeak2"

	if(strlen(CsrInfo(A,  TrgWin)) == 0 || strlen(CsrInfo(B,  TrgWin)) == 0)
		DoAlert 0,"Cursor A or B is absent."
		return -1
	endif
	
	//select range
	Variable from, to, dffrnc
	from	= min(pcsr(A,  TrgWin), pcsr(B,  TrgWin))
	to 		= max(pcsr(A,  TrgWin), pcsr(B,  TrgWin))
	dffrnc = to-from

	//search laser_maxloc
	SetDataFolder root:KSwin:
	Make/N=(N_PL_waves)/O laser_maxloc, laser_max, laser_maxloc_x

	SetDataFolder root:
	Variable i
	Variable R1, R2
	Variable tt
	for(i=0; i<N_PL_waves ;i+=1)
	
		Wave PLy = WaveRefIndexed(TrgWin, 2+i , 1)	// PL Y Wave
		Wave PLx = XWaveRefFromTrace(TrgWin, NameOfWave(WaveRefIndexed(TrgWin, 2+i , 1)))	// PL X wave

		if(i==0)
			tt=0
			WaveStats/Q/R=[to-5, to+5] PLy
			laser_maxloc[i]=V_maxloc
			laser_max[i]=V_max
				
		elseif(i>0)
			tt=1
			R1 = min(laser_maxloc[i-1] + dffrnc * (-1) * fpeak1, laser_maxloc[i-1] + dffrnc * (-1) * fpeak2)
			R2 = max(laser_maxloc[i-1] + dffrnc * (-1) * fpeak1, laser_maxloc[i-1] + dffrnc * (-1) * fpeak2)
			WaveStats/Q/R=(R1,R2) PLy	//search V_max and V_maxloc in the selected range(1)
			laser_maxloc[i]=V_maxloc
			laser_max[i]=V_max
			
			if(laser_maxloc[i] < R1+1 || R2-1 < laser_maxloc[i] || laser_max[i]<200)
				tt=2
				FindPeak/B=7.5/Q/R=(R1, R2) PLy	//search V_max and V_maxloc in the selected range(2)
				laser_maxloc[i]=V_peakloc
				laser_max[i]=V_peakval
				if(V_flag!=0  || laser_max[i]<200)
					tt=3
					WaveStats/Q/R=(R1 + dffrnc *(-5) * fpeak1, R2 * (-1) * fpeak2) PLy		//search V_max and V_maxloc in the selected range(3)
					laser_maxloc[i]=V_maxloc
					laser_max[i]=V_max
				endif
			endif
		
			if(laser_maxloc[i-1] < laser_maxloc[i] || 0.01*(laser_max[i-1]) > laser_max[i])
				tt=4
				WaveStats/Q/R=[to+(-i-1)*50*dffrnc, to+(-i+1)*dffrnc] PLy	//search V_max and V_maxloc in the selected range(4)
				laser_maxloc[i]=V_maxloc
				laser_max[i]=V_max
			endif
		endif
		
		laser_maxloc_x[i]=PLx[laser_maxloc[i]]
		
//		Print num2str(i) + "//"+ num2str(tt)
	endfor
	
	SetDataFolder root:KSwin:
	if(-1 == FindListItem("laser_max", WaveList("laser_max", ";","WIN:" + TrgWin)))	// If the wave "laser_max" does not exist
		AppendToGraph/W=$TrgWin $fadd + ":laser_max" vs $fadd + ":laser_maxloc_x"	//excitation Energy
		ModifyGraph/W=$TrgWin mode(laser_max)=4,rgb(laser_max)=(0,0,0)
	endif
	SetDataFolder root:	

End
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////