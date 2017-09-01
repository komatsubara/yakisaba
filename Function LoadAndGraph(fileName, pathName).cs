Function LoadAndGraph(fileName, pathName)
String fileName // Name of file to load or "" to get dialog 
String pathName // Name of path or "" to get dialog

// Load the waves and set the local variables. 
LoadWave/J/D/O/P=$pathName fileName
if (V_flag==0) // No waves loaded. Perhaps user cancelled.
       return -1
endif
   // Put the names of the three waves into string variables
   String s0, s1, s2
   s0 = StringFromList(0, S_waveNames)
   s1 = StringFromList(1, S_waveNames)
   
Wave w0 = $s0 // Create wave references. 
Wave w1 = $s1
   // Set waves' X scaling, X units and data units
   SetScale/P x, 0, 1, "s", w0, w1, w2
   SetScale d 0, 0, "V", w0, w1, w2
Display w0, w1 // Create a new graph
// Annotate graph
Textbox/N=TBFileName/A=LT "Waves loaded from " + S_fileName
return 0 // Signifies success. 
End