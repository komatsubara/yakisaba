#pragma rtGlobals=1		// Use modern global access method.
Menu "PLE"
	"PLEpanel", PLEwin100422()
End

////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////


StrConstant wfadd = "root:PLEwin"	//folder address


Function PLEwin100422()

	if(-1 != FindListItem("PLEwin", WinList("PLEwin", ";","WIN:1")))	// If window already exists
		DoWindow/F PLEwin
		return 0
	endif
	
	NewDataFolder/O $wfadd
	String/G $wfadd + ":TrgWin"	 = ""
	String/G $wfadd + ":setPLEx"	 = ""
	Variable/G $wfadd + ":csrA"	= 1
	Variable/G $wfadd + ":csrB"	= 1
	Variable/G $wfadd + ":Ap"		= 0
	Variable/G $wfadd + ":Bp"		= 1339
	Variable/G $wfadd + ":PLnum" 	= 1
	Variable/G $wfadd + ":pfrom" 	= 0
	Variable/G $wfadd + ":pto" 		= 1339
	Variable/G $wfadd + ":lw" 		= 5
	Variable/G $wfadd + ":frg_in"	= 6
	Variable/G $wfadd + ":frg_out"	= 12
	Variable/G $wfadd + ":t" 		= 2
	Variable/G $wfadd + ":cd_r"		= 0.1
	
	SVAR TrgWin 	= $wfadd + ":TrgWin"
	SVAR setPLEx 	= $wfadd + ":setPLEx"
	NVAR csrA		= $wfadd + ":csrA"
	NVAR csrB		= $wfadd + ":csrB"
	NVAR Ap			= $wfadd + ":Ap"
	NVAR Bp			= $wfadd + ":Bp"
	NVAR PLnum 	= $wfadd + ":PLnum"
	NVAR pfrom 		= $wfadd + ":pfrom"
	NVAR pto 		= $wfadd + ":pto"
	NVAR lw 			= $wfadd + ":lw"
	NVAR frg_in		= $wfadd + ":frg_in"
	NVAR frg_out		= $wfadd + ":frg_out"
	NVAR t 			= $wfadd + ":t"
	NVAR cd_r 		= $wfadd + ":cd_r"
	
	SetDataFolder root:
	
	//Window
	Display/N=PLEwin /W=(490, 50,950,650) /K=1
	ShowInfo
	ModifyGraph margin(left)=57,margin(bottom)=34,margin(top)=14,margin(right)=14
	ControlBar 180
	SetWindow PLEwin, hook(housekeepinghook) = PLEwin_HKhook	// HouseKeeping hook

	
	//Buttons
	Button button2, pos={360,50}, size={200,35}, font="Arial", proc=PLEwin_DP_button, title="Display"
	
	//PopupMenu
	PopupMenu popup0,pos={40,15},size={60,30}, font="Arial", mode=1, proc=PLEwin_Pop, title = "TrgWin" ,popvalue="none", value= "none;" +  WinList("*", ";", "WIN:1")
	PopupMenu popup1,pos={40,130},size={60,30}, font="Arial", mode=1, proc=PLEwin_Pop, title = "setPLEx" ,popvalue="none", value= "none;" +  WaveList("*x*", ";", "") +  WaveList("*eV*", ";", "")

	//CheckBox
	//CheckBox check0,pos={60,80},size={40,15}, mode=1, proc=PLEwin_CheckBoxproc,title = "PLE mode", value= 1
	CheckBox check3,pos={200,15},size={10,15}, mode=0, proc=csr_CheckBoxproc,title = "A", value= 1
	CheckBox check4,pos={200,45},size={10,15}, mode=0, proc=csr_CheckBoxproc,title = "B", value= 1
	
	//SetValues
	SetVariable setvar0, pos={40,50},	size={128,15}, font="Arial", fSize=12, proc= PLEwin_ChngVal, limits={0,inf,1}, value= PLnum 
	SetVariable setvar1, pos={230,15},	size={100,20}, font="Arial", fSize=12, proc= PLEwin_ChngVal, limits={0,inf,1}, value= Ap
	SetVariable setvar2, pos={230,45},	size={100,20}, font="Arial", fSize=12, proc= PLEwin_ChngVal, limits={0,inf,1}, value= Bp
	SetVariable setvar3, pos={205,90},	size={140,20}, font="Arial", fSize=12, proc= PLEwin_ChngVal, limits={0,inf,1}, value= lw
	SetVariable setvar4, pos={205,120},	size={140,20}, font="Arial", fSize=12, proc= PLEwin_ChngVal, limits={0,inf,0.2}, value= t
	SetVariable setvar5, pos={205,150},	size={140,20}, font="Arial", fSize=12, proc= PLEwin_ChngVal, limits={0,inf,1}, value= frg_in
	SetVariable setvar6, pos={365,150},	size={140,20}, font="Arial", fSize=12, proc= PLEwin_ChngVal, limits={0,inf,1}, value= frg_out
	SetVariable setvar7, pos={365,120},	size={140,20}, font="Arial", fSize=12, proc= PLEwin_ChngVal, limits={0,inf,0.1}, value= cd_r
End



Function PLEwin_Pop(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	
	SVAR TrgWin 	= $wfadd + ":TrgWin"
	SVAR setPLEx 	= $wfadd + ":setPLEx"
	NVAR Ap			= $wfadd + ":Ap"
	NVAR Bp			= $wfadd + ":Bp"
	NVAR PLnum 	= $wfadd + ":PLnum"
	
	Variable N_all_waves
	
	if(stringmatch(ctrlName, "popup0"))
		TrgWin = popStr
		N_all_waves = CountWaves(TrgWin)

		//PL data points
		Wave PLx = XWaveRefFromTrace(TrgWin, NameOfWave(WaveRefIndexed(TrgWin, 0, 1)))	// PL X wave
		Variable npntsPL=numpnts(PLx)
			
		if(N_all_waves >= 1)
			//PLnum
			SetVariable setvar0,	limits={0,N_all_waves-1,1}
			//Ap
			SetVariable setvar1,	limits={0,npntsPL-1,1}
			//Bp
			SetVariable setvar2,	limits={0,npntsPL-1,1}
			//lw
			SetVariable setvar3,	limits={0,npntsPL-1,1}
		endif
		
		PLnum =0
		setPLEx = "none"	
		PLdisplay()
		ModifyGraph axThick=0.5, standoff=0,tick=2,mirror=1,minor=1,axisEnab(left)={0.5,1}
		Label left "\\Z14PL Intensity (arb. units)";Label bottom "\\Z14Photon Energy (eV)"
		SetDrawEnv ycoord= left;DrawLine 0,0,1,0
		Cursor/W=PLEwin A, PLy, (npntsPL-1) 	; Ap=(npntsPL-1)
		Cursor/W=PLEwin B, PLy, 0			; Bp=0
		
		String dfname = "root:"+ TrgWin
		KilldataFolder/Z $dfname
		NewDataFolder/O $dfname
	
	elseif(stringmatch(ctrlName, "popup1"))
		setPLEx = popStr
	endif
End



Function csr_CheckBoxproc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked			// 1 if selelcted, 0 if not
	
	NVAR csrA		= $wfadd + ":csrA"
	NVAR csrB		= $wfadd + ":csrB"
	
	strswitch(ctrlName)
		case "check3":
			csrA = checked
		break
		case "check4":
			csrB = checked
		break
		Print "unexpected error"	// seems to be critical
	endswitch
End



Function PLEwin_ChngVal(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	SVAR TrgWin 	= $wfadd + ":TrgWin"
	SVAR setPLEx	= $wfadd + ":setPLEx"
	NVAR csrA		= $wfadd + ":csrA"
	NVAR csrB		= $wfadd + ":csrB"
	NVAR Ap			= $wfadd + ":Ap"
	NVAR Bp			= $wfadd + ":Bp"
	NVAR PLnum 	= $wfadd + ":PLnum"
	NVAR pfrom 		= $wfadd + ":pfrom"
	NVAR pto 		= $wfadd + ":pto"
	NVAR lw 			= $wfadd + ":lw"
	NVAR frg_in		= $wfadd + ":frg_in"
	NVAR frg_out		= $wfadd + ":frg_out"
	NVAR t 			= $wfadd + ":t"
	NVAR cd_r		= $wfadd + ":cd_r"
	
	if(strlen(TrgWin)==0)
		DoAlert 0,"No window."
		return -1
	endif

	if( stringmatch( ctrlName, "setvar0") )
		PLdisplay()
		LFdisplay(PLnum, lw, frg_in, frg_out, cd_r)
	else
		PLEwin_PutCsrs()	
		pfrom = min(Ap, Bp)
		pto = max(Ap, Bp)
		PLEdisplay()
		LFdisplay(PLnum, lw, frg_in, frg_out, cd_r)
	endif

End



Function PLEwin_HKhook(s)
	STRUCT WMWinHookStruct &s
	SVAR TrgWin 	= $wfadd + ":TrgWin"
	NVAR PLnum 	= $wfadd + ":PLnum"
	NVAR pfrom 		= $wfadd + ":pfrom"
	NVAR pto 		= $wfadd + ":pto"
	NVAR Ap			= $wfadd + ":Ap"
	NVAR Bp			= $wfadd + ":Bp"
	NVAR lw 			= $wfadd + ":lw"
	NVAR frg_in		= $wfadd + ":frg_in"
	NVAR frg_out		= $wfadd + ":frg_out"
	NVAR cd_r		= $wfadd + ":cd_r"
	Variable rval = 0
	
//	print s.keycode
	switch(s.eventCode)
		case 2:	// kill
			KillWindow PLEwin
			KillDataFolder/Z root:PLEwin
			rval = 1
			break
			
		case 11:	// keyboard
			if(s.keycode==30)	// up arrow
				PLEwin_SetVal(1)
				PLdisplay()
				LFdisplay(PLnum, lw, frg_in, frg_out, cd_r)
			endif
			if(s.keycode==31)	// down arrow
				PLEwin_SetVal(-1)
				PLdisplay()
				LFdisplay(PLnum, lw, frg_in, frg_out, cd_r)
			endif
			if(s.keycode==28)	// left arrow
				PLEwin_SetCsr(-1)
				pfrom = min(Ap, Bp)
				pto = max(Ap, Bp)
				PLEdisplay()
			endif
			if(s.keycode==29)	// right arrow
				PLEwin_SetCsr(1)			
				pfrom = min(Ap, Bp)
				pto = max(Ap, Bp)
				PLEdisplay()
			endif
			if(s.keycode==44)	// <
				PLEwin_SetCsr(-10)
				pfrom = min(Ap, Bp)
				pto = max(Ap, Bp)
				PLEdisplay()
			endif
			if(s.keycode==46)	// >	
				PLEwin_SetCsr(10)
				pfrom = min(Ap, Bp)
				pto = max(Ap, Bp)
				PLEdisplay()
			endif
			rval = 1
			break
	endswitch
	return rval
End


Static Function PLEwin_PutCsrs()
	
	NVAR csrA		= $wfadd + ":csrA"
	NVAR csrB		= $wfadd + ":csrB"
	NVAR Ap			= $wfadd + ":Ap"
	NVAR Bp			= $wfadd + ":Bp"
		
	Variable cnd = PLEwin_csrstate()
	if(cnd==-1 || csrA==0 || csrB==0)
		DoAlert 0,"Cursor error."
		return -1
	endif

	Cursor/W=PLEwin A, PLy, Ap
	Cursor/W=PLEwin B, PLy, Bp
End



Static Function PLEwin_SetCsr(vr)
	Variable vr
	
	NVAR csrA		= $wfadd + ":csrA"
	NVAR csrB		= $wfadd + ":csrB"
	NVAR Ap			= $wfadd + ":Ap"
	NVAR Bp			= $wfadd + ":Bp"
	NVAR pfrom 		= $wfadd + ":pfrom"
	NVAR pto 		= $wfadd + ":pto"

	Variable cnd = PLEwin_csrstate()
	if(cnd==-1)
		DoAlert 0,"Cursor error."
		return -1
	endif

	String aTName= StringByKey("TNAME",CsrInfo(A,"PLEwin"))
	Variable aIsFree= NumberByKey("ISFREE",CsrInfo(A,"PLEwin"))	
	Variable aPoint= NumberByKey("POINT",CsrInfo(A,"PLEwin"))	

	String bTName= StringByKey("TNAME",CsrInfo(B,"PLEwin"))
	Variable bIsFree= NumberByKey("ISFREE",CsrInfo(B,"PLEwin"))	
	Variable bPoint= NumberByKey("POINT",CsrInfo(B,"PLEwin"))	
	
	if(csrA==1 && aIsFree==0)
		Cursor A, $aTName, (aPoint + vr)
		Ap=NumberByKey("POINT",CsrInfo(A,"PLEwin"))
	endif
	if(csrB==1 && bIsFree==0)
		Cursor B, $bTName, (bPoint + vr)
		Bp=NumberByKey("POINT",CsrInfo(B,"PLEwin"))
	endif	

End


Static Function PLEwin_csrstate()
	
	String aTName= StringByKey("TNAME",CsrInfo(A,"PLEwin"))
	String bTName= StringByKey("TNAME",CsrInfo(B,"PLEwin"))
	
	if(stringmatch(aTName, "PLy") && stringmatch(bTName, "PLy"))
		return 0
	else
		return -1
	endif
End


Static Function PLEwin_SetVal(vec)
	Variable vec
	
	SVAR TrgWin 	= $wfadd + ":TrgWin"
	NVAR PLnum 	= $wfadd + ":PLnum"
	
	Variable N_all_waves = CountWaves(TrgWin)
	
	if(vec > 0)
		if(PLnum + vec < N_all_waves - 1)
			PLnum += vec
		elseif(PLnum + vec >= N_all_waves)
			PLnum = N_all_waves-1
		endif
	elseif(vec < 0)
		if(0 <= PLnum + vec)
			PLnum += vec
		elseif( 0 > PLnum + vec)
			PLnum =0
		endif
	endif
End



Function PLEwin_DP_button(ctrlName) : ButtonControl	
	String ctrlName

	SVAR TrgWin 	= $wfadd + ":TrgWin"
	NVAR csrA		= $wfadd + ":csrA"
	NVAR csrB		= $wfadd + ":csrB"
	NVAR Ap			= $wfadd + ":Ap"
	NVAR Bp			= $wfadd + ":Bp"
	NVAR PLnum 	= $wfadd + ":PLnum"
	NVAR pfrom 		= $wfadd + ":pfrom"
	NVAR pto 		= $wfadd + ":pto"
	NVAR lw 			= $wfadd + ":lw"
	NVAR frg_in		= $wfadd + ":frg_in"
	NVAR frg_out		= $wfadd + ":frg_out"
	NVAR t 			= $wfadd + ":t"
	
	Wave PLEp 		= $wfadd + ":PLE_p"
	Wave PLEx 		= $wfadd + ":PLE_x"
	Wave PLEy 		= $wfadd + ":PLE_y"
	Wave slPLEy 		= $wfadd + ":slPLE_y"
	Wave RRSy 		= $wfadd + ":RRS_y"
	Wave erPLEy 		= $wfadd + ":erPLE_y"
	
	String dfname	= "root:"	+TrgWin
	String wname		= "PLE_"		+TrgWin

	if(-1 != FindListItem(wname, WinList(wname, ";","WIN:1")))
		DoWindow/F/N $wname
	elseif(-1 == FindListItem(wname, WinList(wname, ";","WIN:1")))
		Display/N=$wname as wname
	endif
	
	SetDataFolder $dfname
	String Name_slPLE_y	= "slPLE_y_" 	+ TrgWin
	String Name_RRS_y	= "RRS_y_" 	+ TrgWin
	String Name_erPLE_y	= "erPLE_y_" 	+ TrgWin
	
	Duplicate/O PLEp,	 	$dfname + ":PLE_p_"	+ TrgWin
	Duplicate/O PLEx, 	$dfname + ":PLE_x_"	+ TrgWin
	Duplicate/O PLEy,	 	$dfname + ":PLE_y_"	+ TrgWin
	Duplicate/O slPLEy,	$dfname + ":slPLE_y_"	+ TrgWin
	Duplicate/O RRSy, 	$dfname + ":RRS_y_"	+ TrgWin
	Duplicate/O erPLEy,	$dfname + ":erPLE_y_"	+ TrgWin

	
	if(-1 == FindListItem(Name_slPLE_y, WaveList(Name_slPLE_y, ";","WIN:")))	// If wave not exist
		AppendToGraph/W=$wname 	$dfname + ":slPLE_y_"	+ TrgWin	vs 	$dfname + ":PLE_x_"	+ TrgWin		//PLE
	endif
	if(-1 == FindListItem(Name_RRS_y, WaveList(Name_RRS_y, ";","WIN:")))	// If wave not exist
		AppendToGraph/W=$wname 	$dfname + ":RRS_y_"	+ TrgWin	vs 	$dfname + ":PLE_x_"	+ TrgWin		//RRS		
	endif
	if(-1 == FindListItem(Name_erPLE_y, WaveList(Name_erPLE_y, ";","WIN:")))	// If wave not exist
		AppendToGraph/W=$wname 	$dfname + ":erPLE_y_"	+ TrgWin	vs 	$dfname + ":PLE_x_"	+ TrgWin		//erPLE
	endif

	SetDataFolder root:
	
	ModifyGraph/W=$wname rgb($WaveName(wname,0,1))=(0,0,65280)
	ModifyGraph/W=$wname rgb($WaveName(wname,1,1))=(0,39168,0)
	ModifyGraph/W=$wname rgb($WaveName(wname,2,1))=(30464,30464,30464)
	ModifyGraph/W=$wname tick=2,mirror=1,minor=1, standoff=0, axThick=0.5, margin(left)=43,margin(bottom)=28,margin(top)=14,margin(right)=14
	Label/W=$wname bottom "Photon Energy (eV)"; Label/W=$wname left "PL Intensity (arb. units)"
	ShowInfo
	TextBox/W=$wname/C/N=parameters/A=MC/X=40/Y=25 "\\F'Arial'\\Z07pfrom: " + num2str(pfrom) + "\rpto: " + num2str(pto) + "\rlw: " + num2str(lw) + " / frg_in: " + num2str(frg_in)+ " / frg_out: " + num2str(frg_out)
End


////////////////////////////


Function PLdisplay()

	SVAR TrgWin 	= $wfadd + ":TrgWin"
	NVAR PLnum 	= $wfadd + ":PLnum"
	
	Wave x = XWaveRefFromTrace(TrgWin, NameOfWave(WaveRefIndexed(TrgWin,PLnum,1)))
	Wave y = WaveRefIndexed(TrgWin,PLnum,1)

	Duplicate/O x, $wfadd + ":PLx"
	Duplicate/O y, $wfadd + ":PLy"
	
	SetDataFolder $wfadd
	if(-1 == FindListItem("PLy", WaveList("PLy", ";","WIN:PLEwin")))	// If wave not exist
		AppendToGraph/W=PLEwin $wfadd + ":PLy" vs $wfadd + ":PLx"
	endif
	SetDataFolder root:
	
End



Function PLEdisplay()

	Print "<<<<< PLEdisplay >>>>>>"

	SVAR TrgWin 	= $wfadd + ":TrgWin"
	SVAR setPLEx 	= $wfadd + ":setPLEx"
	NVAR pfrom 		= $wfadd + ":pfrom"
	NVAR pto 		= $wfadd + ":pto"
	NVAR lw 			= $wfadd + ":lw"
	NVAR frg_in		= $wfadd + ":frg_in"
	NVAR frg_out		= $wfadd + ":frg_out"
	NVAR t 			= $wfadd + ":t"
	NVAR cd_r		= $wfadd + ":cd_r"
		
	//plot the PLE graph
	SetDataFolder $wfadd
	Variable i = CountWaves(TrgWin)
	Variable pf=min(pfrom,pto) ; Variable pt=max(pfrom,pto)
	Wave x = XWaveRefFromTrace(TrgWin, NameOfWave(CsrWaveRef(A, TrgWin)))
	Variable PLdatapnts = numpnts(x)
	Variable j
	
	Make/N=(i)/O tempy_minus_laser, laser_error
	
	Print "calclating PLE"
	if(stringmatch(setPLEx, "none"))
		PLEwin_PLEx(TrgWin, t) ; Wave tempx, tempp
	else
		PLEwin_setPLEx(TrgWin, setPLEx) ; Wave tempx, tempp
	endif
	PLEwin_PLEy_sum(TrgWin, pf, pt) ; Wave tempy
	Duplicate/O tempp, $wfadd + ":PLE_p"
	Duplicate/O tempx, $wfadd + ":PLE_x"
	Duplicate/O tempy, $wfadd + ":PLE_y"
	
	Print "calclating RRS"
	String wn=NameOfWave(tempp)
	PLEwin_Laser_sum(TrgWin, wn, 0, (PLdatapnts)-1, lw, frg_in, frg_out, cd_r) ; Wave templaser
	Duplicate/O templaser, $wfadd + ":RRS_y"
	
	
	Print "calclating erPLE"
	PLEwin_Laser_sum(TrgWin, wn, pf, pt, lw, frg_in, frg_out, cd_r) ; Wave templaser, templaser_er
	tempy_minus_laser = tempy - templaser
	Duplicate/O tempy_minus_laser, $wfadd + ":slPLE_y"
	Duplicate/O templaser_er, $wfadd + ":erPLE_y"
	
	KillWaves/Z tempp, tempx, tempy, tempy_minus_laser, templaser, templaser_er
		
	SetDataFolder $wfadd

	if(-1 == FindListItem("slPLE_y", WaveList("slPLE_y", ";","WIN:PLEwin")))	// If wave not exist
		AppendToGraph/W=PLEwin/L=leftPLE $wfadd + ":slPLE_y" vs $wfadd + ":PLE_x"
	endif

	if(-1 == FindListItem("RRS_y", WaveList("RRS_y", ";","WIN:PLEwin")))	// If wave not exist
		AppendToGraph/W=PLEwin/L=leftPLE $wfadd + ":RRS_y" vs $wfadd + ":PLE_x"
	endif

	if(-1 == FindListItem("erPLE_y", WaveList("erPLE_y", ";","WIN:PLEwin")))	// If wave not exist
		AppendToGraph/W=PLEwin/L=leftPLE $wfadd + ":erPLE_y" vs $wfadd + ":PLE_x"
	endif

	SetDataFolder root:
	
	Label leftPLE, "\\F'Arial'PL Intensity (arb.unit)"
	ModifyGraph tick=2,mirror=1,minor=1, standoff=0, freePos(leftPLE)=0
	ModifyGraph axThick=0.5,lblPos(leftPLE)=55,axisEnab(leftPLE)={0,0.45}
	ModifyGraph rgb(slPLE_y)=(0,0,65280),rgb(RRS_y)=(0,39168,0)
	ModifyGraph rgb(erPLE_y)=(30464,30464,30464)
//	TextBox/C/N=text_range/A=MC/X=35 /Y=40 "\\F'Arial'\\Z07Integral Range: \r" + num2str(x[pf]) + "eV -" + num2str(x[pt]) + "eV" + "\r(Point: " + num2str(pf) +"-" + num2str(pt) +")" + "lw: " + num2str(lw)

End



Function PLEwin_PLEx(grfName, t)	//produce a PLE p_wave and x_wave as "tempp" and "tempx"
	String grfName
	Variable t
	
	Variable i = CountWaves(grfName)
	Variable j, d, R1, R2
	Variable cd=0
	Make/N=(i)/O tempx, tempp
	Make/N=(2) ml
	
	//produce waves
	for(j=0 ; j<i ; j+=1)
		Wave x = XWaveRefFromTrace(grfname, NameOfWave(WaveRefIndexed(grfName,j,1)))
		Wave y = WaveRefIndexed(grfName,j,1)

		if(j==0)
			WaveStats/Q y
			ml[j]=V_maxloc

		elseif(j==1)
			WaveStats/Q y
			ml[j]=V_maxloc
			d = t * abs(ml[1] -ml[0])
			if(d<1)
				d = t
			endif
			Print "d = " + num2str(d)

		elseif(j>=2)
			if(cd==0)
				R1 = V_maxloc- d
				R2 = V_maxloc+ d/4			
				WaveStats/Q/R=( R1, R2) y
			
				if(V_maxloc < R1+1 || V_maxloc > R2-1)	//if V_maxloc is near the edge of the interval(R1, R2)
					FindPeak/Q/R=(R1, R2) y
					V_maxloc = V_PeakLoc
					if(V_flag != 0)			
						V_maxloc = tempp[j-1]+(tempp[j-1]-tempp[j-2])
						Print "Info PLEx: peak was not found for PLnum=" + num2str(j) + "/ V_maxloc=" + num2str(V_maxloc)
					endif
				endif
				
				if(V_maxloc<0)
					cd=1
				endif
	
			elseif(cd == 1)
				V_maxloc=0
			endif
		endif				
		tempx[j] = x[V_maxloc]
		tempp[j] = V_maxloc
	endfor
	KillWaves/Z ml
End



Function PLEwin_setPLEx(grfName, setPLEx)	//set PLE x_wave by hand
	String setPLEx, grfName

	//tempx
	String PLEx_name = "root:" + setPLEx
	Duplicate/O $PLEx_name, tempx
	
	//tempp
	Variable j
	Wave x = XWaveRefFromTrace(grfname, NameOfWave(WaveRefIndexed(grfName,0,1)))
	Duplicate/O x, xp
	for(j=0;j<numpnts(x); j+=1)
		xp[j] = j
	endfor
		
	Duplicate/O tempx, test
	for(j=0;j<numpnts(tempx); j+=1)
		test[j] = round(interp(tempx[j], x, xp))
	endfor
		
	Duplicate/O test, tempp
	KillWaves/Z test, xp
End


Function PLEwin_PLEy_sum(grfName,pfrom,pto)	//produce a PLE y_wave as "tempy"
	String grfName
	Variable pfrom,pto
	
	Variable i = CountWaves(grfName)
	Make/N=(i)/O tempy	
	
	//produce a y_wave of PLEplot
	Variable k
	for( k=0 ; k<i ; k+=1)
		Wave y = WaveRefIndexed(grfName,k,1)
		tempy[k] = sum(y,min(pfrom,pto),max(pfrom,pto))
	endfor
End



Function LFdisplay(PLnum, lw, frg_in, frg_out, cd_r)
	Variable PLnum, lw, frg_in, frg_out, cd_r
	
	SVAR TrgWin = $wfadd + ":TrgWin"
	
	SetDataFolder $wfadd
	if(-1 == FindListItem("PLE_p", WaveList("PLE_p", ";","")))
		PLEdisplay()
	endif

	Variable N_all_waves = CountWaves(TrgWin)
	Wave PLE_p = $wfadd + ":PLE_p"
	String y0name = WaveName(TrgWin, N_all_waves-1, 1)
	Variable fc = 	LF(PLE_p[PLnum], lw, frg_in, frg_out, TrgWin, PLnum, y0name, cd_r); Wave tempfy, tempfy_frg
		
	Duplicate/O tempfy, LFy
	Duplicate/O tempfy_frg, LFfrg_y
	
	//plot
	if(-1 == FindListItem("LFy", WaveList("LFy", ";","WIN:PLEwin")))	// If wave not exist
		AppendToGraph/W=PLEwin/L=left $wfadd + ":LFy" vs $wfadd + ":PLx"
		ModifyGraph mode(LFy)=4,marker(LFy)=19,lsize(LFy)=0.5,msize(LFy)=1,rgb(LFy)=(0,0,0)
	endif
	if(-1 == FindListItem("LFfrg_y", WaveList("LFfrg_y", ";","WIN:PLEwin")))	// If wave not exist
		AppendToGraph/W=PLEwin/L=left $wfadd + ":LFfrg_y" vs $wfadd + ":PLx"
		ModifyGraph mode(LFfrg_y)=0,lsize(LFfrg_y)=0.5,rgb(LFfrg_y)=(0,39168,0)
	endif
	SetDataFolder root:
	KillWaves/Z tempfy, tempfy_frg
	
	SetDrawLayer/W=$"PLEwin"/K UserFront
	SetDrawLayer/W=$"PLEwin" UserFront
	if(fc==1)
		SetDrawEnv/W=$"PLEwin" fsize=9
		DrawText 0.1,0.1, "curve fit 1, PLstd"
	elseif(fc==2)
		SetDrawEnv/W=$"PLEwin" fsize=9
		DrawText 0.1,0.1, "curve fit 2, poly"
	endif
End



Function LF(ppt, lw, frg_in, frg_out, grfName, ynum, y0name, cd_r)
	Variable ppt, lw, frg_in, frg_out, ynum, cd_r
	String grfName, y0name
	
	String y0add_name = "root:" + y0name
	Wave y0 = $y0add_name	//standard wave for the shape of PLy
	Wave y = WaveRefIndexed(grfName, ynum, 1)
	Wave x = XWaveRefFromTrace(grfName, NameOfWave(WaveRefIndexed(grfName,ynum,1)))
	
	//SetDataFolder $wfadd
	Duplicate/O y, tfydp1, tfydp2 tempfy_frg	//tfydp1 for resonant range, tfydp2 for offresonant range ,tempfy_frg for fit range
	Make/O/N=(1340) tempfy
	
	Variable f1=min(frg_in, frg_out)
	Variable f2=max(frg_in, frg_out)
	
	Variable k
	for(k=0;k<1340;k+=1)	//removing points not used for curvefit
		if( ppt-f1 < k && k < ppt+f1 )
			tfydp1[k]=NaN
			tfydp2[k]=NaN
			tempfy_frg[k] = NaN
		endif
		if( k < ppt-f2 || ppt+f2 < k )
			tfydp1[k]=NaN
			tfydp2[k]=NaN
			tempfy_frg[k] = NaN
		endif
		if( y0[k] < 5*1.2 )	//if y0 is noisy.
			tfydp1[k]=NaN
		endif
	endfor
	
	Duplicate/O y0, y0smth
	Smooth 3, y0smth
	tfydp1 = tfydp1 / y0smth
	WaveStats/Q tfydp1
	Variable r = V_avg
	
	//producing tempfy
	if(ppt<0.1)	//if laser peak is not in PL spectrum
		for(k=0;k<1340;k+=1)
			if( ppt-lw <= k && k <= ppt+lw )
				tempfy[k]=0
			else
				tempfy[k]=NaN
			endif
		endfor
		return 0

	elseif(r>cd_r)	//condition to choose curve fit method(poly or y0smth)
		for(k=0;k<1340;k+=1)
			if( ppt-lw <= k && k <= ppt+lw )
				tempfy[k]=y0smth[k] * r
			else
				tempfy[k]=NaN
			endif
		endfor
		return 1
		
	else
		CurveFit/Q/N poly 3,  tfydp2 /X=x /D
		Wave W_coef
					
		for(k=0;k<1340;k+=1)
			if( ppt-lw <= k && k <= ppt+lw )
				tempfy[k]=W_coef[0]+W_coef[1]*x[k]+W_coef[2]*x[k]^2
			else
				tempfy[k]=NaN
			endif
		endfor
		return 2
		
	endif

	KillWaves/Z tfydp1, tfydp2, y0smth

End


Function PLEwin_Laser_sum(grfName,pName,pfrom,pto,lw, frg_in, frg_out, cd_r)
	String grfName, pName
	Variable pfrom, pto, lw, frg_in, frg_out, cd_r
	
	//PLErange
	Variable pf = min(pfrom, pto)
	Variable pt = max(pfrom, pto)
	
		
	Variable i = CountWaves(grfName)
	Variable j, k, cf, ct, p1, p2, pminus, pplus

	Wave tempp = $pName
	String y0name = WaveName(grfName, i-1, 1)
	
	if(numpnts(tempp) != i)
		DoAlert 0,"Different wavelengths."
		return -1
	endif
	
	Make/N=(i)/O templaser, templaser_er
	
	//produce a wave of the laser intensity
	if(lw==0)
		templaser=0
		templaser_er=0
	else
		for(j=0; j<i; j+=1)

			Wave y = WaveRefIndexed(grfName,j,1)
			if( pt >= tempp[j]-lw && tempp[j]+lw >= pf )	//if laser (tempp[j]+lw, tempp[j]-lw) is in the range (pt, pf) (note; point axis direction)

				cf = tempp[j] - lw		;ct = tempp[j] + lw	
				p1 = max( pf, cf)		;p2 = min( pt, ct)		//range in which PLEy is modified
				LF(tempp[j], lw, frg_in, frg_out, grfName, j, y0name,cd_r); Wave tempfy
				
				Duplicate/O tempfy, tempfy_temp
				for(k=0;k<1340;k+=1)
					if(numtype(tempfy[k])==2)
						tempfy_temp[k]=y[k]
					endif
				endfor
								
				//laser counts = all counts - estimated PL counts in range [p1, p2]
				templaser[j] = sum( y, p2, p1) - sum(tempfy_temp, p2, p1)

				//laser error estimation
				//lw-1
				cf = tempp[j] - (lw-1)	;ct = tempp[j] + (lw-1)
				p1 = max( pf, cf)		;p2 = min( pt, ct)		
				pminus = sum( y, p2, p1) -sum(tempfy_temp, p1, p2) - templaser[j]
				
				//lw+1
				cf = tempp[j] - (lw+1)	;ct = tempp[j] + (lw+1)
				p1 = max( pf, cf)		;p2 = min( pt, ct)		
				pplus = sum( y, p2, p1) -sum(tempfy_temp, p1, p2) - templaser[j]
				
				if(numtype(pplus) != 0)
					pplus=0
//					Print "pplus=" + num2str(pplus) +"for"+num2str(j)
				endif
				if(numtype(pminus) != 0)
					pminus=0
//					Print "pminus=" + num2str(pminus) +"for"+num2str(j)
				endif
				templaser_er[j] = sqrt(pminus^2 + pplus^2)
			else
			
				templaser[j] = 0
				templaser_er[j] = 0
			
			endif	
		endfor
	endif
End