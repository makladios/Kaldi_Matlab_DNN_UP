# Kaldi_Matlab_UD_UP

Permission is granted for anyone to copy, use, or modify these tools for purposes of research or education. 

These tools have been developed using Matlab 2014b and tested using Matlab 2012b and 2014b in conjunction with Kaldi Version 4069. However, The tools are distributed without any warranty.  As the programs were written for research purposes only, they have not been tested to the degree that would be advisable in any important application.  All use of these programs is entirely at the user's own risk.

An example for how to use the tools is given in example.m. 

Before running the example, make sure to extract the archive final.7z and that the path to Kaldis' binaries is in your bash profile. Alternatively, do the following steps:

- Write the path to kaldi trunk in the script path.sh
- Run the script path.sh as follows:
~$. ./path.sh
- Run Matlab in the same session

More details about each tool can be obtained using the help command in Matlab followed by the tool name, e.g., 

> help readkaldiNNet

The example needs an external tool "writekaldifeatures
" that has been downloaded from "http://kaldi-to-matlab.gforge.inria.fr/". 
  