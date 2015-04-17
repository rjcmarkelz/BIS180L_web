---
title: "ssh keys for git"
layout: lab
tags: 
- R
- Git
- Linux
hidden: yes
---

Tired of having to enter your password every time you push or pull from git?

Git push and pull not working with RStudio?

__There is a solution__

We will use an [ssh public key](https://help.ubuntu.com/community/SSH/OpenSSH/Keys) to authenticate your identity.

In this method of authentication you generate a public key and a private key.  The private key stays on your computer (in this case your virtual computer) and the public key is given to 3rd parties who will want to verify your identity (in this case GitHub).

When you attempt to login to GitHub a program called [SSH](https://help.ubuntu.com/community/SSH) tests to see if your computer has the matching private key.

## Generate a ssh key pair

From the Linux terminal, change to your home directory and see if you already have a ssh key pair

    cd ~
    ls -al .ssh/*

If you get a directory not found, or don't see either `id_rsa.pub` or `id_dsa.pub` file then it means you need to create one (most likely you will need to create one)

    ssh-keygen -t RSA -C "youremail@ucdavis.edu"
    #creates a new ssh key pair using your email as an identifier

When asked for a file to save the key in, just __press enter__ to save in the default location

Make sure that the files exist

    cd .ssh
    ls

You should see 
* `id_rsa`(this is your private key--don't share)
* `id_rsa.pub` (this is your public key)

## Add your public key to github

First copy your key to your clipboard

    cat id_rsa.pub

copy the key and your email address but no extra lines or spaces to the clipboard (`ctrl-shift-C`)

Go to github.com and login to your account

Click on the "gear" icon near the upper right hand side to bring up your settings.

![]({{site.baseurl}}/images/GitHub_SSH1.png)

Click on "SSH keys" on the left hand side

Paste in your key and press "add key"

### Test the connection

    ssh -T git@github.com

You may get a warning.  Go ahead and type "yes".  You should then get a message that you have successfully authenticated.

![]({{site.baseurl}}/images/GitHub_SSH2.png)

## Update repository settings on your computer

In order to use the public key / private key authentication you must change the URL for your repository so that it uses ssh instead of https.

Go to GitHub for your repository, find the URL for cloning.  Click below it to change the access method to ssh and then copy the URL.

![]({{site.baseurl}}/images/GitHub_SSH3.png)

In the Linux terminal cd to the directory for that repository and update the URL

    cd ~/BIS180L_Assignments_Julin.Maloof/
    git remote set-url origin PASTE_IN_CLIPBOARD_URL_HERE


Now you should be all set!









