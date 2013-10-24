### intro ############################
#
#How to install Minion Pro with MacTeX on OS X Snow Leopard. This works if you want to install into yoru personal tex tree. If you wanted to install it system wide you would change the destination of many of the font files to something like /usr/local/texlive/texmf-local/
#
#I found that lcdf-typetools is included with texlive, but it is a critical dependency. If you don't have it install it form elsewhere. (cf /usr/local/texlive/2009/tlpkg/tlpobj/lcdftypetools.tlpobj)
#
###############################

### establish where your personal tex tree is. By default this directory is not created with MacTeX, but this is where it should be (cf http://www.tug.org/mactex/2009/faq/#qm04)
texmf_folder=~/Library/texmf

### establish where your minion pro font files are located (this is set to the minionpro folder in the current directory)
minion_folder=`PWD`/minionpro/

### Establish a working directory (these values can be changed freely)
cd ~
rm -Rf minionprotemp
mkdir minionprotemp
cd minionprotemp
workdir=$PWD

### determine which version of Minion Pro you have and select the appropriate encodings file:
#   The MinionPro distribution is split into several archives. Which of them you need depends on the version of the fonts you have installed. We support three different versions of MinionPro:
#
#   o 001.000: This is the first version which can be found on, e.g., the 'Adobe Type Classics for Learning' CD.
#   o 001.001: This is the version included with, e.g., the 'Adobe Font Folio Opentype Edition' CD.
#   o 002.000: This version is included in recent Acrobat Reader installations and is currently for sale.
#
#   If you have LCDF Typetools installed you can determine the version with  otfinfo command. For example, for version 002.000 you get:
#   
#     $ otfinfo -v MinionPro-Regular.otf
#     Version 2.012;PS 002.000;Core 1.0.38;makeotf.lib1.6.6565
encoding=enc-1.000.zip

###### Install MnSymbol for minion-like symbols

### grab and unzip the mnsymbol archive -L follows redirection, -O downloads the file.
curl -L -O http://mirrors.ctan.org/fonts/mnsymbol.zip
unzip mnsymbol.zip
cd mnsymbol/tex

### make MnSymbol.sty
latex MnSymbol.ins

### establish personal tree folders, and move MnSymbol files there. 
rm -Rf $texmf_folder/tex/latex/MnSymbol/
rm -Rf $texmf_folder/fonts/source/public/MnSymbol/
rm -Rf $texmf_folder/doc/latex/MnSymbol/
rm -Rf $texmf_folder/fonts/map/dvips/MnSymbol
rm -Rf $texmf_folder/fonts/enc/dvips/MnSymbol
rm -Rf $texmf_folder/fonts/type1/public/MnSymbol
rm -Rf $texmf_folder/fonts/tfm/public/MnSymbol


mkdir -p $texmf_folder/tex/latex/MnSymbol/
mkdir -p $texmf_folder/fonts/source/public/MnSymbol/
mkdir -p $texmf_folder/doc/latex/MnSymbol/
cp MnSymbol.sty $texmf_folder/tex/latex/MnSymbol/MnSymbol.sty
cd ..
cp source/* $texmf_folder/fonts/source/public/MnSymbol/
cp MnSymbol.pdf README $texmf_folder/doc/latex/MnSymbol/
mkdir -p $texmf_folder/fonts/map/dvips/MnSymbol
mkdir -p $texmf_folder/fonts/enc/dvips/MnSymbol
mkdir -p $texmf_folder/fonts/type1/public/MnSymbol
mkdir -p $texmf_folder/fonts/tfm/public/MnSymbol
cp enc/MnSymbol.map $texmf_folder/fonts/map/dvips/MnSymbol/
cp enc/*.enc $texmf_folder/fonts/enc/dvips/MnSymbol/
cp pfb/*.pfb $texmf_folder/fonts/type1/public/MnSymbol/
cp tfm/* $texmf_folder/fonts/tfm/public/MnSymbol/

### install map files (from your personal tree, sudo updmap-sys if you are installing this system wide)
updmap --enable MixedMap MnSymbol.map



###### Install MinionPro for Minion Pro support
### go back to the working directory
cd $workdir

### grab and unzip the MinionPro archive
curl -L -O http://mirrors.ctan.org/fonts/minionpro/scripts.zip
rm -Rf minionpro-scripts
mkdir minionpro-scripts
cd minionpro-scripts
unzip ../scripts.zip

### locate your MinionPro files. Change /Library/Fonts/ to the location of your files if they aren't there.
rm -Rf ./otf
mkdir ./otf
find $minion_folder -iname '*minion*pro*otf' -exec cp -v '{}' otf/ ';'
./convert.sh

### make a directory for and copy these converted type files
rm -Rf $texmf_folder/fonts/type1/adobe/MinionPro/
mkdir -p $texmf_folder/fonts/type1/adobe/MinionPro/
cp pfb/*.pfb $texmf_folder/fonts/type1/adobe/MinionPro/

### go back to the working directory
cd $workdir

### grab and unzip the encodings and metrics
rm -Rf $texmf_folder/fonts/enc/dvips/MinionPro
rm -Rf $texmf_folder/fonts/tfm/adobe/MinionPro
rm -Rf $texmf_folder/fonts/vf/adobe/MinionPro
rm -Rf $texmf_folder/doc/latex/MinionPro
rm -Rf $texmf_folder/fonts/map/dvips/MinionPro
rm -Rf $texmf_folder/tex/latex/MinionPro
curl -L -O http://mirrors.ctan.org/fonts/minionpro/$encoding
curl -L -O http://mirrors.ctan.org/fonts/minionpro/metrics-full.zip 
curl -L -O http://mirrors.ctan.org/fonts/minionpro/metrics-base.zip
curl -L -O http://mirrors.ctan.org/fonts/minionpro/metrics-opticals.zip
cd $texmf_folder
unzip $workdir/metrics-base.zip
unzip $workdir/metrics-full.zip
unzip $workdir/metrics-opticals.zip
unzip $workdir/$encoding

### install map files 
updmap --enable MixedMap MinionPro.map

### cleanup tempfiles
cd ~
rm -Rf minionprotemp
