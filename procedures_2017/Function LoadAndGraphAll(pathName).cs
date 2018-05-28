Function LoadAndGraphAll(pathName)
String pathName // Name of symbolic path or "" to get dialog
   String fileName
String graphName
Variable index=0
if (strlen(pathName)==0) 
NewPath/O temporaryPath 
if (V_flag != 0)
       return -1
   endif
   pathName = "temporaryPath"
endif
Variable result
// If no path specified, create one // This will put up a dialog
// User cancelled
do
// Loop through each file in folder 
fileName = IndexedFile($pathName, index, ".txt") 
if (strlen(fileName) == 0) // No more files?
   break                         // Break out of loop
endif
result = LoadAndGraph(fileName, pathName)
if (result == 0) // Did LoadAndGraph succeed?
                                 // Print the graph.
   graphName = WinName(0, 1)     // Get the name of the top graph
String cmd
sprintf cmd, "PrintGraphs %s", graphName Execute cmd // Explained below.
   DoWindow/K $graphName
   KillWaves/A/Z
endif
// Kill the graph
// Kill all unused waves
// Kill temp path if it exists
   index += 1
while (1)
if (Exists("temporaryPath"))
   KillPath temporaryPath
endif
   return 0            // Signifies success.
End

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
   s2 = StringFromList(2, S_waveNames)
Wave w0 = $s0 // Create wave references. 
Wave w1 = $s1
Wave w2 = $s2
   // Set waves' X scaling, X units and data units
   SetScale/P x, 0, 1, "s", w0, w1, w2
   SetScale d 0, 0, "V", w0, w1, w2
Display w0, w1, w2 // Create a new graph
// Annotate graph
Textbox/N=TBFileName/A=LT "Waves loaded from " + S_fileName
return 0 // Signifies success. 
End
