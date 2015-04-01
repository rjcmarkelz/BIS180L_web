---
layout: lab
title: Instructions on installing and using the BIS180L virtual linux machine
hidden: true    <!-- To prevent post from being displayed as regular blog post -->
tags:
- Linux
---

## About
Most bioinformatics software runs on linux or unix (including Mac) computers.  For this class we will work in a linux environment.  Since the computer labs have Windows machines we will run linux in a virtual environment.

Specifically we will run a program called [VirtualBox](https://www.virtualbox.org/) on the Windows machine ([more info](http://en.wikipedia.org/wiki/VirtualBox)).  Virtualbox creates a virtual machine, hosted on the Windows PC, which will run linux.  The virtual linux machine has a virtual disk which will live on your flash drive.  This way files that you save can be used from class to class.  In addition you can install virtualbox on your personal computer, insert the flashdrive, and use the same virtual linux machine that you are using here.

If you are curious about what version of linux we are using, and what programs I installed, please see the document "Creating the machine image" on the course website.


## Get the BIS180L image

The instructor or TA will give you a USB flash drive with the linux image

## Unpack and start the virtual machine.

Look inside the BIS180L2015 folder on your flash drive.  There will be several files.

* "BIS180L2015.vdi"--this is the virtual disk drive
* "BIS180L2015.vbox"--this contains information about the virtual machine.

Double click the "BIS180L2015.vbox" file.  This should start the virtual machine.  You may need to press "start" in the virtualbox window.  It will take a about 1 minute to boot.  When the boot is complete you should see a window that looks like this:

![BIS180L linux desktop]({{ site.baseurl }}/images/BIS180L_screenshot.png)


## Username and Password

The username and password are:

username: `bis180lstudent`

password: `bioinformatics`

## Using the machine.

You can resize the "screen" by dragging from the lower-right corner.

You should be able to cut and paste between your host machine and the virtual machine.  Mac users note that inside the virtual machine you will need to use ctrl-C, not CMD-c, etc.  Also the cut and paste commands for the terminal are shift-ctrl-C and shift-ctrl-V.

The icons at the bottom left give you access to various programs.  

From left to right:

* Start menu.  This gives you access to system preferences and a variety of programs.
* File manager.  Equivalent to the Mac "Finder" or Windows "Explorer"
* LXTerminal.  Provides access to the Linux command line
* Chromium Web Browser
* Firefox Web Browser
* [Gedit](https://wiki.gnome.org/Apps/Gedit).  A text editor with good features for programming.
* [Rstudio](http://www.rstudio.com).  An IDE (Integrated Development Environment) for [R](http://www.r-project.org)
* [Gnumeric](http://www.gnumeric.org).  A spreadsheet application
* [Remarkable.](http://remarkableapp.net)  A text editor for working in [Markdown](http://en.wikipedia.org/wiki/Markdown)
* This button will collapse windows
* This button allows you to switch desktops

## Create a MEGA account

It is critical that you **keep a backup of your files** (both for this class and always).  For this class we will accompish this by syncing with the cloud storage provider [MEGA](https://mega.co.nz)

* Click on  `Start > Internet > MEGAsync`
* Register for a new account or logon to your existing accound (if you have one)
* Check your email and click on the link to complete registration
* Choose `Selective Sync`
	![SelectiveSync]({{ site.baseurl }}/images/SelectiveSync.png)
* Click on the buttons and change folders to be synced to: 
	* Local Folder: `/home/bis180lstudent`
	* MEGA Folder: `/BIS180L` (you will have to create a new folder)
	![MEGAfolders]({{ site.baseurl }}/images/MEGAfolders.png)
* If successful you should get a message indicating that MEGAsync is now running.	





# Extras not needed for lab


## Extra: Install VirtualBox at home

If you want to do this at home you need to install VirtualBox.  It is free.

Download and install [VirtualBox](https://www.virtualbox.org/)

Direct link to [download page.](https://www.virtualbox.org/wiki/Downloads)  The extension pack is optional.

The virtual machine is formatted to use 3 cores and 3GB of memory.  You may need to change this depending on the specifications of your (real) computer.  See "Settings" in virtual box.

## Extra: Format a flash drive

If you want to put the in virtual machine image on a new flash drive you will probably need to reformat it first.  Your flash drive is probably formatted in "Fat32" format.  This file format has a limitation of 4GB for maximum file size.  The file containing the linux virtual drive is ~ 8GB so you need to change the format of the flash drive.  *This only needs to be done once*

** Warning this will erase all files on your flash drive **

### Windows
* Insert your flash drive into a USB port
* Click on the "Start" menu, lower left, and then click on computer.
* Right click on the flash drive (probably labelled "E:..." or  "F:...")
* Choose "Format"
* Choose "ExFat"
* Click "Start" and then "OK"

### Mac
* Insert your flash drive into a USB port
* Start the Disk Utility application 
* Click on the USB drive in the lefthand pane
* Choose "Erase"
* Under Format choose "ExFat"
* Click the "Erase" button


