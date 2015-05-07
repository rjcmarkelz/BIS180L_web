---
layout: post
title: Creating Virtual Box machine for BIS180L
hidden: true
permalink: Creating_VBox_machine
category: extras
---

Download virtual box from https://www.virtualbox.org/

# linux installation

Start with [lubuntu](http://lubuntu.net/) 14.04.  Download 64 bit disk image.   Insert .iso into virtual CD drive.  Boot virtual machine from CD drive.  Follow standard installation procedures.  Use 30GB dynamic virtual disk.  It is not much slower than a fixed size and makes transfer the image *much* faster.

**username** bis180lstudent

**password** bioinformatics

### lubuntu-specific

Guest additions is a Vbox specific set of tools that helps the virtual machine interface with Vbox better.  

Before installing guest additions on lubuntu must install gcc and make:

    sudo apt-get install gcc make

Installed "guest additions" by choosing to insert the disk from the devices menu, then at the command line changing to that proper directory and executing the install guest and executing `./VBoxLinuxAdditions.run` as root.

Set the machine to use 

* 3000MB of memory
* 4 processors at up to 80%
* 64 MB of video ram

### update installation:

    sudo apt-get update
    sudo apt-get upgrade




# Additional software

## python
python and python3 are installed by default; no changes
make sure that python3 is installed
    
    python3 --version
    
## vim
default ships with vi not vim, but I like vim better

    sudo apt-get install vim
    
Modify/create .vimrc file to set default colors

    cat >> .vimrc
        :color desert

## latex
Needed for knitting .Rmd to PDF

    sudo apt-get install texlive-latex-extra texlive-fonts-recommended

## curl
This is needed for some R package installation

    sudo apt-get install curl libcurl4-openssl-dev

## R
Follow instruction on [CRAN](http://cran.us.r-project.org/)
First add the source URL to the apt sources list

    sudo vi /etc/apt/sources.list

added line:
    	deb http://cran.cnr.Berkeley.edu/bin/linux/ubuntu trusty/
    
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    sudo apt-get update
    sudo apt-get install r-base r-recommended r-base-dev
    
then

	sudo R
	#within R:
	install.packages(c("swirl","ggplot2","genetics","LDheatmap","hwde","GenABEL","seqinr","qtl"))
	
	
bioconductor (while still in R)

	source("http://bioconductor.org/biocLite.R")
	biocLite()
    #biocLite("snpMatrix") #not available
    biocLite("edgeR")

	
## Rstudio
download from [rstudio website](http://www.rstudio.com/ide/download/desktop)

open in Gdebi and install from there

Then start Rstudio.  Click on create new Rmarkdown file.  Click "yes" to install required packages.

## git and git viewers

    sudo apt-get install git

not sure which viewer I will use so install several
    
    sudo apt-get install git-cola git-gui gitg

## libre office

    sudo apt-get install libreoffice-cal libreoffice-writer
    
(note that abiword and gnumeric are also installed)
    
## htop 

    sudo apt-get install htop

## igv

__NO THIS VERSION IS BROKEN__ GET FROM WEBSITE
    sudo apt-get igv
    
## lxmed

This allows editing of the start menu.  See [lxmed webpage](http://lxmed.sourceforge.net/)
for download and installation instructions

For students installing on their own machines this can be skipped.

you may need to do 

    lxpanelctl restart
    
## menus

need to change default terminal to lxterminal

## sequence viewers and aligners

### Jalview
    sudo apt-get install jalview
    

### Others

    sudo apt-get install seaview
    sudo apt-get install clustalw clustalx kalign t-coffee muscle mafft probcons 
   
## short read tools

    sudo apt-get install tophat bwa bowtie2 bowtie2-examples cufflinks samtools bedtools
    
## blast (both versions)

    sudo apt-get install blast2 ncbi-blast+
    
## markdown viewer: remarkable

Download [remarkable](http://remarkableapp.net/download.html) and install with gdebi
    
## MACS2

Not MACS; MACS2!

install [pip](http://www.pip-installer.org/en/latest/installing.html#install-or-upgrade-pip)

    sudo apt-get install python-pip python-numpy python-scipy

Then [MACS2](https://github.com/taoliu/MACS/wiki/Install-macs2)
    
    
    sudo pip install MACS2
    
## Cytoscape

    sudo apt-get install openjdk-7-jdk openjdk-7-source openjdk-7-jre-lib

Version 2.8.2 from [website](www.cytoscape.org)

    sudo ./Cytoscape_2_8_2_unix.sh

Then installed in default location /opt

Note: In 2014 version 3 will not work with the plug-ins that Siobhan needs to use.

I also downloaded 3.2.1 just in case this has changed for 2015

## Mev

Download version 4.9 from [MEV website](http://www.tm4.org/mev.html)

	tar -xvzf MeV_4_8_1_r2727_linux.tar.gz 
	sudo mv MeV_4_8_1 /usr/local/bin
	
Then edit tmev.sh file to hardwire in location and to fix -a error
	
    21c21
    < for jar in /usr/local/bin/MeV_4_8_1/lib/*.jar 
    ---
    > for jar in lib/*.jar 
    36c36
    < CurrDIR=/usr/local/bin/MeV_4_8_1
    ---
    > CurrDIR=`pwd`
    41c41
    < if [  ${CurrDIR}/lib/libjri.so ]
    ---
    > if [ -a ${CurrDIR}/lib/libjri.so ]


Then create shortcut in "education" start menu

## gedit

installing gedit, to use as a programming text editor

    sudo apt-get install gedit gir1.2-gtksource-3.0
   
Add shortcut in start menu, under programming, and also to lower panel

## emboss

    sudo apt-get install emboss
    
installs 6.6.0

## filezilla

installing filezilla so there is a good sftp client

	sudo apt-get filezilla
	
## MEGA

We will use [MEGA](https://mega.co.nz/) for backup of student files.

Download [deb file](https://mega.co.nz/#sync) and install with gdebi

# Data

This is for Ian

Download https://www.dropbox.com/sh/j7o2wfm69t60wug/NdRUMv1rU0 and place them in /data 
Change permission so that the files are owned by root but readable by everyone

# Not installed 2015:

## SAINT

### first install GSL
I am not sure why the apt-get version of this isn't working, but it isn't...

Download http://mirrors.syringanetworks.net/gnu/gsl/gsl-latest.tar.gz

Open terminal

    cd Downloads
    tar -xvzf gsl-latest.tar.gz
    cd gsl-1.16
    ./configure
    make
    sudo make install

Download SAINT_v3.1.0.zip from SourceForge: http://sourceforge.net/projects/saint-apms/files/SAINTexpress_v3.1.0.zip/download

Then in the terminal

	cd Downloads

# benchmarks (not run in 2015)

Mostly in R


Set-up     | start-up time | 1000 x 100,000 matrix create | 1000 x 10,000 matrix write | 1000 x 10,000 matrix read | 100 example(lme) | 100,000 row lme | 1,000,000 row lme
-----------|---------------|------------------------------|----------------------------|-----------------|--------------------------|--------------
Native Mac mini | NA     | 2.2 sec | 16 sec | 18 sec | 18 sec | 3.2 sec | 35 sec 
xubuntu32 flash |        | 7.2     | 33 sec | 8.7 sec | 24 sec | 2.5 sec | 79 sec
xubuntu64 flash | 90 sec | 3.7 sec | 27 sec | 6.2 sec | 19 sec | 2.5 sec | 35 sec
lubuntu32 on HD |        | 7 sec   | 31 sec | 7.2 sec | 23 sec | 3.1 sec | 53 sec |
lubuntu64 on HD |        | 5.3 sec | 29 sec | 8.1 sec | 30 sec | 3.2 sec | 44 sec |
lubuntu64 flash | 45 sec | 5.4 sec | 37 sec | 8.0 sec | 22.3 sec | 3.3 sec | 47 sec  |
lubuntu64 2020PC |        | 6.3 sec | 25 sec | 6.2 sec | 13 sec |  2.3 sec | 32.8 sec |



#### matrix creation

	results <- vector()
	results[1]
	for (i in 1:10) {
	results[i] <- system.time(m <- matrix(1234,ncol=1000,nrow=100000))[3]
	}
	results
	mean(results)
	
#### matrix write

    m <- matrix(1234,ncol=1000,nrow=10000)
	results <- vector()
	for(i in 1:5) {
	results[i] <- system.time(write.csv(m,"~/test.csv"))[3]
	print(i)
	print(results[i])
	}
	mean(results)
	
#### matrix read

	results <- vector()
	for(i in 1:10) {
	print(i)
	results[i] <- system.time(m <- read.csv("~/test.csv"))[3]
	print(results[i])
	}
	mean(results)
	
#### lme	

	library(nlme)
	results <- vector()
	for(j in 1:5) {
		results[j] <- system.time(for(i in 1:100) example(lme))[3]
		}
	mean(results)
	
	results <- vector()
	size <- 100000
	for(i in 1:5) {
		df <- data.frame(group= sample(letters[1:10],size,replace=T),
			response=rnorm(size),
			trt=sample(LETTERS[1:2],size,replace=T))
		results[i] <- system.time(lme1 <- lme(response ~ trt, random=~trt|group,data=df))[3]
	}
	mean(results)
	
	results <- vector()
	size <- 1000000
	for(i in 1:5) {
		df <- data.frame(group= sample(letters[1:10],size,replace=T),
			response=rnorm(size),
			trt=sample(LETTERS[1:2],size,replace=T))
		results[i] <- system.time(lme1 <- lme(response ~ trt, random=~trt|group,data=df))[3]
	}
	mean(results)
	

