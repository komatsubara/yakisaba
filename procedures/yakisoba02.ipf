#pragma TextEncoding = "UTF-8"

#pragma rtGlobals=3		// Use modern global access method and strict wave access.
//#pragma TextEncoding = "Shift_JIS"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma rtGlobals=3		// Use modern global access method and strict wave access.
//#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.
Menu "&yakisobaaaaaaaa"
"practice" ,practice()
"&IV_analysis/b" ,IVanalysis()
"&IL_analysis/2" ,ILanalysis()
"ILandIVanalysis",ILandIVanalysis()
end
Function practice()
     string name1,name2,name3,name,file1
    variable n1,n2;
    n1=1;n2=3;
    Make/N=10/D/O w1,w2,w3;
    w1=x;w2=w1*w1; w3=1/(w1+1);
    display w2 vs w1
 	name1="w1";name2="w2";name3="w3";
	print name1; 
	//Display $name1;Display $file1;
	//name3=(name1)+(name2);
	//Display $name3;
	//print w3[3]
	do
	 print "macro test",n1;
	 name=num2str(n1);
	 file1="w"+name;
	 print file1;
	 display $file1;
	 n1+=1;
	while(n1<=n2) 
EndMacro

Macro IVanalysis()
variable fldnum
string name0,name1,name2,name3,name4,fldname,title,graphtitle;
//?��?��ƂƂȂ�IV?��f?��[?��^?��̓�?��?��?��?��?��t?��H?��?��?��_?��?��߂�
fldnum=1;
// do
	graphtitle="A"+"0"+num2str(fldnum)+""//--------------------?��O?��?��?��t?��^?��C?��g?��ݒ肵?��悤
	title="A"+""+num2str(fldnum)+"_ALL"//---------------------?��t?��H?��?��?��_?��^?��C?��g?��?��
	
	fldname="root:"+title;
	print fldname;
	SetDataFolder fldname;
	
	Duplicate/O wave0,resist;DelayUpdate;
	Duplicate/O wave0,dif_resist;DelayUpdate;
	name0="wave0";name1="wave1";name2="resist";name3="dif_resist";//w0:I,w1:V?��̃f?��[?��^?��?��?��?��?��Ă�?��?��
	//$name0=$name0*1000;
	$name2=($name1)/($name0)*1000;//wave2(?��?��R)?��?��v?��Z?��?��?��?��
	Differentiate $name1/X=$name0/D=dif_resist;dif_resist=dif_resist*1000;//wave3(?��?��?��?��?��?��R)?��?��v?��Z?��?��?��?��
	Display $name1 vs $name0 as title;AppendToGraph/R $name2 vs $name0;AppendToGraph/R $name3 vs $name0 ;

//?��ȉ�hklklkhlklkgraph?��̍trtr
	ModifyGraph rgb(wave1)=(0,15872,65280);ModifyGraph rgb(resist)=(0,65280,0);
	setAxis left 0,*;setAxis bottom 0,*;setAxis right 0,*
	Label bottom "\\Z16 current(mA)"
	ModifyGraph mirror(bottom)=1,tick(bottom)=2,standoff(bottom)=0,fSize(bottom)=16,minor(bottom)=1;
	ModifyGraph lblPosMode(bottom)=3,lblPos(bottom)=40;
	Label left "\\Z16 Voltage(V)"
	ModifyGraph tick(left)=2,standoff(left)=0,fSize(left)=16,minor(left)=1;
	ModifyGraph lblPosMode(left)=3,lblPos(left)=50
	Label right "\\Z16 Resistance (Ohm)"
	ModifyGraph tick(right)=2,standoff(right)=0,fSize(right)=16,minor(right)=1;
	ModifyGraph lblPosMode(right)=3,lblPos(right)=70
	Legend/C/N=text0/J/A=MC graphtitle+"\r\\s(wave1) sample Voltage (V)\r\\s(resist) Resistance (Ohm)\r\\s(dif_resist) Differential Resistance (Ohm)"
	Legend/C/N=text0/J/X=15.00/Y=-10
	ModifyGraph width={Aspect,1}
	ModifyGraph height=400;
	fldnum+=1;
//while(fldnum<=9)
end


Macro ILanalysis()
variable fldnum,th;
string name0,name1,name2,name3,name4,fldname,title,graphtitle;
//?��?��ƂƂȂ�IL?��f?��[?��^?��̓�?��?��?��?��?��t?��H?��?��?��_?��?��߂�
fldnum=1;
 //do
	graphtitle="3QW"+"00"+num2str(fldnum)+""//--------------------?��O?��?��?��t?��^?��C?��g?��ݒ肵?��悤
	title="k180501_data"+"00"+num2str(fldnum)+""//---------------------?��t?��H?��?��?��_?��^?��C?��g?��?��
 
	fldname="root:"+title;
	print fldname;
	SetDataFolder fldname;
	
	name0="wave77777";name1="wave1";name2="wave1_Smth";name3="wave1_Smth_Dif"name4="wave1_Smth_Dif_Dif";//w1:I,w2:V?��̃f?��[?��^?��?��?��?��?��Ă�?��?��
//?��ȉ�?��?��̓p?��[?��g
	//$name0=$name0*1000;
	Duplicate/O wave1,wave1_Smth;DelayUpdate;smooth 10,wave1_Smth;//IL?��?��10?��?��X?��?��?��[?��W?��?��?��O
 	Duplicate/O wave1_Smth,wave1_smth_Dif;DelayUpdate;Differentiate wave1_Smth/X=wave0/D=wave1_Smth_Dif;//?��X?��?��?��[?��W?��?��?��O?��?��?��?��?��?��̂�?��K?��?��?��?��
	Duplicate/O wave1_Smth_Dif,wave1_Smth_Dif_Dif;DelayUpdate;Differentiate wave1_Smth_Dif/X=wave0/D=wave1_Smth_Dif_Dif;//?��?��K?��?��?��?��
	Display $name1 vs $name0 as title;AppendToGraph $name2 vs $name0;
	AppendToGraph/R $name3 vs $name0;AppendToGraph/R $name4 vs $name0 ;
	
	wavestats wave1_Smth_Dif_Dif;th=V_max;print V_maxloc,V_max;

//?��ȉ�graph?��̍�
	ModifyGraph rgb($name1)=(0,15872,65280);ModifyGraph rgb($name2)=(0,65280,0);
	ModifyGraph rgb($name3)=(0,65280,0);ModifyGraph rgb($name4)=(65280,0,52224);
	setAxis left 0,*;setAxis bottom 0,*;setAxis right 0,*
	Label bottom "\\Z16 Set Voltage(V)"
	ModifyGraph mirror(bottom)=1,tick(bottom)=2,standoff(bottom)=0,fSize(bottom)=16,minor(bottom)=1;
	ModifyGraph lblPosMode(bottom)=3,lblPos(bottom)=40;
	Label left "\\Z16 Power(W)"
	ModifyGraph tick(left)=2,standoff(left)=0,fSize(left)=16,minor(left)=1;
	ModifyGraph lblPosMode(left)=3,lblPos(left)=50
	Label right "\\Z16 Differentiate"
	ModifyGraph tick(right)=2,standoff(right)=0,fSize(right)=16,minor(right)=1;
	ModifyGraph lblPosMode(right)=3,lblPos(right)=70
	Legend/C/N=text0/J/A=MC graphtitle+"\r\\s(wave1) VLdata (W)\r\\s(wave1_Smth) Smooth\r\\s(wave1_Smth_Dif) Smooth_Diff\r\\s(wave1_Smth_Dif_Dif) Smooth_Diff_Diff\rThreshold pt ("+num2str(V_maxloc)+", "+num2str(V_max)+ ")";
	Legend/C/N=text0/J/X=-5.00/Y=10
	ModifyGraph width={Aspect,1}
//	ModifyGraph height=400;
	fldnum+=1;
	
//while(fldnum<=9)
EndMacro

//--------------------------------------------------------
//-----------IL and IV  curve analysis--------------------
//--------------------------------------------------------
Macro ILandIVanalysis()
variable fldnum,analysis_pt,cavity_L;
string title,graphtitle,title00;
silent 1; pauseupdate;

//--------------------------------------------
//------------setting parameter---------------
//--------------------------------------------
fldnum=16;    //-------------------set the first file number   
cavity_L=300;//-------------------set cavity length (um)  
analysis_pt=94;//------------------------------set the data point to use analysis of efficiency and resistance
    
NewDataFolder/O root:analysis;
setDataFolder root:analysis;
make /O/D ridge_number={1,2,3,4,5};make/O/D cavity_length=cavity_L;make/O/D ridge_width={1.5,2.5,1.5,2.5,1.5,2.5},I_th_column ,i_d,resistance_column,dif_resistance_column;  
do  //-------------------do loop of filename
    if (fldnum<=9)
        title00="data00"+num2str(fldnum);
    else if(fldnum>=10)
        title00="data0"+num2str(fldnum);
    endif
//    title00="data002_02"//-------------title of folder in which waves are
    title=title00+"_ALL"
    graphtitle=title00
    //title="data"+"00"+num2str(fldnum)+"_ALL"//---------------------
 	//graphtitle="bar05_"+"00"+num2str(fldnum);//----------------graphtitle
 	IVIL_AnalysisPart(title,graphtitle,fldnum,analysis_pt)
    setDataFolder root:analysis;
    I_th_column[fldnum-1]=wave_return[0];i_d[fldnum-1]=wave_return[1];resistance_column[fldnum-1]=wave_return[2];dif_resistance_column[fldnum-1]=wave_return[3];
//	wave_return=[I_th,efficiency,resistanve_analy,difresistance_analy]
    fldnum += 1
while(fldnum<=15).
	setDataFolder root:analysis;
	edit ridge_number ,cavity_length,ridge_width,I_th_column,i_d,resistance_column,dif_resistance_column;
	display I_th_column vs ridge_width  ;AppendToGraph/R i_d vs ridge_width;
// modify ridge width graph
	ModifyGraph mode=3,marker=19;ModifyGraph rgb(i_d)=(0,0,65280);
	setAxis left 0,*;setAxis bottom 0,3;setAxis right 0,*
	Label bottom "\\Z16 ridge width (um)"
	ModifyGraph mirror(bottom)=1,tick(bottom)=2,standoff(bottom)=0,fSize(bottom)=16,minor(bottom)=1;
	ModifyGraph lblPosMode(bottom)=3,lblPos(bottom)=40;
	Label left "\\Z16 I threshold (mA)"
	ModifyGraph tick(left)=2,standoff(left)=0,fSize(left)=16,minor(left)=1;
	ModifyGraph lblPosMode(left)=3,lblPos(left)=50;
	Label right "\\Z16 efficiency(W/A)"
	ModifyGraph tick(right)=2,standoff(right)=0,fSize(right)=16,minor(right)=1;
	ModifyGraph lblPosMode(right)=3,lblPos(right)=50
	Legend/C/N=text0/J/A=MC graphtitle+"\r\\s(I_th_column) I thresholc\r\\s(i_d) efficiency";
 	Legend/C/N=text0/J/X=0.00/Y=-10;
	//ModifyGraph width={Aspect,1}
	//ModifyGraph height=300;
	ModifyGraph lsize=2
//
EndMacro

function IVIL_AnalysisPart(title,graphtitle,fldnum,analysis_pt)
string title,graphtitle  //-----------------------------first of all , declare argument(hikisuu)
variable fldnum,analysis_pt
variable th,th_pt,I_th,I_analysis,efficiency,length,deletepoint,delete_start,cavity_L,resistance_analy,dif_resistance_analy;
string name0,name1,name2,name3,name4,name5,name6,name7,name8,name_wave0,name_wave1,name_wave2,name_wave3,fldname,VLgraphtitle,IVgraphtitle,IVtitle,VLtitle,abc;
silent 1; pauseupdate;

    fldname="root:"+title;
    print fldname;
    SetDataFolder fldname;
    deletepoint=6;//-----------------for smoothing, we have to delete the last 6 points 
    VLgraphtitle=graphtitle+"_VL";
    IVgraphtitle=graphtitle+"_IV";
    //wave0=wave0*1000;//------------------------------------------
    name_wave0="wave0",name_wave1="wave1",name_wave2="wave2",name_wave3="wave3"
    Duplicate/O $name_wave0,V_set; Duplicate/O $name_wave1,L; Duplicate/O $name_wave2,I_sample;Duplicate/O $name_wave3,V_sample
    length=NumPnts(V_set);//wave
    name0="V_set";name1="L";name2="L_Smth";name3="L_Smth_Dif";name4="L_Smth_Dif_Dif";


	Duplicate/O L,L_Smth;DelayUpdate;smooth 10,L_Smth;
 	Duplicate/O L_Smth,L_smth_Dif;DelayUpdate;Differentiate L_Smth/X=V_set/D=L_Smth_Dif;
	Duplicate/O L_Smth_Dif,L_Smth_Dif_Dif;DelayUpdate;Differentiate L_Smth_Dif/X=V_set/D=L_Smth_Dif_Dif;
	Display $name1 vs $name0 as VLgraphtitle;//AppendToGraph $name2 vs $name0;
	//AppendToGraph/R $name3 vs $name0;AppendToGraph/R $name4 vs $name0 ;
	wavestats L_Smth_Dif_Dif;th=V_max;th_pt=V_maxloc;print V_maxloc,V_max;//------------------
	
	delete_start=length-deletepoint;//----------smth
	duplicate /O/R=(0,delete_start) L_Smth,L_smth_plt;
 	duplicate /O/R=(0,delete_start) L_Smth_Dif,L_smth_Dif_plt;duplicate /O/R=(0,delete_start) L_Smth_Dif_Dif,L_smth_Dif_Dif_plt;
	appendToGraph L_smth_plt vs V_set;appendToGraph/R L_smth_Dif_plt vs V_set;appendToGraph/R L_smth_Dif_Dif_plt vs V_set;
// modify VL graph
	ModifyGraph rgb(L_Smth_plt)=(65280,32768,0);ModifyGraph rgb(L_Smth_Dif_plt)=(65280,46336,27136);//2^16
	ModifyGraph rgb(L_Smth_Dif_Dif_plt)=(65280,47360,29440);
 	setAxis left 0,*;setAxis bottom 0,*;setAxis right 0,*
	Label bottom "\\Z16 Set Voltage(V)"
	ModifyGraph mirror(bottom)=1,tick(bottom)=2,standoff(bottom)=0,fSize(bottom)=16,minor(bottom)=1;
	ModifyGraph lblPosMode(bottom)=3,lblPos(bottom)=40;
	Label left "\\Z16 Power(uW)"
	ModifyGraph tick(left)=2,standoff(left)=0,fSize(left)=16,minor(left)=1;
	ModifyGraph lblPosMode(left)=3,lblPos(left)=50
	Label right "\\Z16 Differentiate"
	ModifyGraph tick(right)=2,standoff(right)=0,fSize(right)=16,minor(right)=1;
	ModifyGraph lblPosMode(right)=3,lblPos(right)=50
	Legend/C/N=text0/J/A=MC VLgraphtitle+"\r\\s(L) V_set-L (uW)\r\\s(L_Smth_plt) Smooth\r\\s(L_Smth_Dif_plt) Smooth_Diff\r\\s(L_Smth_Dif_Dif_plt) Smooth_Diff_Diff\rThreshold pt ("+num2str(V_maxloc)+" pt, "+num2str(V_max)+ ")";
 	Legend/C/N=text0/J/X=-10.00/Y=10;
 	Legend/C/N=text0/J/F=0/B=1
	ModifyGraph width={Aspect,1}
	ModifyGraph height=300;
	ModifyGraph lsize=2;
	ModifyGraph lstyle(L_smth_dif_dif_plt)=2;
	
//
	IVtitle=title+"_IV;"
	Duplicate/O $name_wave0,resistance;DelayUpdate;
	Duplicate/O $name_wave0,dif_resistance;DelayUpdate;
	Duplicate/O I_sample,I_sample_smth;DelayUpdate;smooth 100,I_sample_smth;
	Duplicate/O V_sample,V_sample_smth;DelayUpdate;smooth 100,V_sample_smth;
	differentiate V_sample_smth/X=I_sample_smth/D=dif_smth_resistance;dif_smth_resistance=dif_smth_resistance*1000
	
	name5="I_sample";name6="V_sample";name7="resistance";name8="dif_resistance";//wave2:I
	resistance=V_sample/I_sample*1000;
	Differentiate V_sample/X=I_sample/D=dif_resistance;dif_resistance=dif_resistance*1000;//name8
	DUplicate/O dif_resistance,dif_resistance_smth;DelayUpdate;smooth 10,dif_resistance_smth;
	Display V_sample vs I_sample as IVtitle;AppendToGraph/R resistance vs I_sample;AppendToGraph/R dif_smth_resistance vs I_sample ;

// modify resistance graph
	ModifyGraph rgb(V_sample)=(5000,5000,65000);ModifyGraph rgb(resistance)=(50000*(1-1/2)+5000,50000*(1/2)+5000,65000);ModifyGraph rgb(dif_smth_resistance)=(55000,55000,65000);
 	setAxis left 0,*;setAxis bottom 0,*;setAxis right 0,*
	Label bottom "\\Z16 current(mA)"
	ModifyGraph mirror(bottom)=1,tick(bottom)=2,standoff(bottom)=0,fSize(bottom)=16,minor(bottom)=1;
	ModifyGraph lblPosMode(bottom)=3,lblPos(bottom)=40;
	Label left "\\Z16 Voltage(V)"
	ModifyGraph tick(left)=2,standoff(left)=0,fSize(left)=16,minor(left)=1;
	ModifyGraph lblPosMode(left)=3,lblPos(left)=50
	Label right "\\Z16 Resistance (\\F'Symbol'W)"
	ModifyGraph tick(right)=2,standoff(right)=0,fSize(right)=16,minor(right)=1;
	ModifyGraph lblPosMode(right)=3,lblPos(right)=50
	Legend/C/N=text0/J/A=MC IVgraphtitle+"\r\\s(V_sample) sample Voltage (V)\r\\s(resistance) Resistance Resistance (\F'Symbol'W\F'Arial')\r\\F'MS UI Gothic'\s(dif_smth_resistance) Differential Resistance (\F'Symbol'W\F'Arial')\r\F'Arial'"+num2str(resistance[analysis_pt])+" \F'Symbol'W\F'Arial',"+num2str(dif_smth_resistance[analysis_pt])+" \F'Symbol'W \r\F'Arial' at "+num2str(I_sample[analysis_pt])+" mA, "+num2str(analysis_pt)+"pt";
 	Legend/C/N=text0/J/X=15.00/Y=0;
 	Legend/C/N=text0/J/F=0/B=1
	ModifyGraph width={Aspect,1}
	ModifyGraph height=300;
	ModifyGraph lsize=2
//
    resistance_analy=resistance[analysis_pt];dif_resistance_analy=dif_smth_resistance[analysis_pt];
//
	I_analysis=I_sample[analysis_pt];
	I_th=I_sample[th_pt];
	Duplicate/O $name0,dIdV_set;DelayUpdate;
	Differentiate $name5/X=$name0/D=dIdV_set;//dIdV_set
	Duplicate /O dIdV_set,dIdV_set_smth;smooth 10,dIdV_set_smth;
	efficiency=L_Smth_Dif[analysis_pt]/dIdV_set_smth[analysis_pt];//dPdI=dPdV_set/dIdV_set
 	Display $name1 vs $name5 as title;AppendToGraph/R $name6 vs $name5;
// modify IL,IV curve graph
	ModifyGraph rgb(L)=(65000,0,0);ModifyGraph rgb(V_sample)=(0,0,65000);
 	setAxis left 0,*;setAxis bottom 0,*;setAxis right 0,*
	Label bottom "\\Z16 current(mA)"
	ModifyGraph mirror(bottom)=1,tick(bottom)=2,standoff(bottom)=0,fSize(bottom)=16,minor(bottom)=1;
	ModifyGraph lblPosMode(bottom)=3,lblPos(bottom)=40;
	Label left "\\Z16 Power(uW)"
	ModifyGraph tick(left)=2,standoff(left)=0,fSize(left)=16,minor(left)=1;
	ModifyGraph lblPosMode(left)=3,lblPos(left)=50;
	Label right "\\Z16Voltage (V)"
	ModifyGraph tick(right)=2,standoff(right)=0,fSize(right)=16,minor(right)=1;
	ModifyGraph lblPosMode(right)=3,lblPos(right)=50
	Legend/C/N=text0/J/A=MC graphtitle+"\r\\s(L) I-L\r\\s(V_sample) I-V\rThreshold "+num2str(I_th)+" mA \refficiency "+num2str(efficiency)+" uW/mA\rat "+num2str(I_analysis)+" mA , "+num2str(analysis_pt)+"pt";
 	Legend/C/N=text0/J/X=0.00/Y=-10;
 	Legend/C/N=text0/J/F=0/B=1;
	ModifyGraph width={Aspect,1}
	ModifyGraph height=300;
	ModifyGraph lsize=2

//
    Return_Wave(I_th,efficiency,resistance_analy,dif_resistance_analy)
End

function Return_Wave(I_th,efficiency,resistance_analy,dif_resistance_analy)
variable I_th,efficiency,resistance_analy,dif_resistance_analy

setDataFolder root:analysis;
make/O/N=4/D wave_return;  //wave_return is a wave for returning following number
wave_return[0]=I_th;wave_return[1]=efficiency;wave_return[2]=resistance_analy;wave_return[3]=dif_resistance_analy//wave_return=[I_th,efficiency,resistanve_analy,difresistance_analy]
End
