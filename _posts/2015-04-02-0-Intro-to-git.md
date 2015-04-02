---
layout: lab
title: Introduction to git
hidden: true    <!-- To prevent post from being displayed as regular blog post -->
---

## Git: reproducibility and collaboration

This document will introduce you to __Git__, a version control system that is a great aid in writing software, maintaining documentation, and maintaining reproducibility.

What does Git do?  Git keeps track of changes that you (and your collaborators) make in your documents.  By maintaining a record of all the changes that have been made you can restore your project to an earlier state if needed (i.e. if you screw up).  Git also allows you to maintain different versions (known as branches in Git) simultaneously, an incredibly useful feature.  For example you can maintain a "master" branch that works correctly.  You try out changes in a "develop" branch without breaking the working "master" version.  Once you know that your changes in "develop" are functioning as intended you can merge them into the "master".

For an overiew of how Git can be used in the biological sciences, please read this excellent [article by Ram](http://www.scfbm.org/content/8/1/7)

## A few key concepts

A project that is tracked by Git is called a __repository__ (repo for short).

To start a new repository you use the `git init` command.

To add files for git to track you use `git add`.

When you have made some changes to your project and you want to __commit__ those changes to the repository you use `git commit`.

If you are collaborating with others, or just want to share your project, you will want to set up a __remote repository__.  One common (and free!) hosting site is [GitHub](https://github.com/).  When you want to add your changes to the remote repository you __push__ to the repository using 'git push'.  When you want to download changes that others have made then you want to __pull__ changes using `git pull`.

## Learn about git using an online tutorial

Now lets see some of this in action.

To learn how to create and interact with a repository, please do [this tutorial](https://try.github.io/levels/1/challenges/1)

Keep track of what each command that you learn does by making notes for yourself in a markdown document (perhaps gitNotes.md)

## Now lets try it in real life.

First get a [GitHub](https://github.com/) account

### Make a repository and collaborate

Work with a partner

Designate one of you to create a new repository.  This is Partner 1.

* Partner 1: 
	* Add a file to the repository with a bit of text (what your plans are for the weekend?).  
	* Commit your change
	* Push the repository to git hub
	* Go to the github website for this repository.
	* Add  Partner2 as a collaborator.

* Partner 2:
	* Clone the repository to your computer
	* Add your information (what your plans are for the weekend?)
	* Commit your change
	* Push the changes to the repsitory
	* Run git log and save the output to a file.

* Partner 1:
	* Pull the changes back to your computer
	* Run git log and save the output to a file.

* Want a graphical view of what is going on?
	* type `gitk` at the command line when you are in the directory of a git repository.

### Fork a project

The above exercise illustrate one way to collaborate: each collaborator is added as a contributor to the repository.  A second (and perhaps more common) method is to __fork__ a repository.  When you fork a repository your are creating your own copy of the repository.  You then make changes to your fork.  If you think the original creator might want to incorporate your changes than you can create a __pull request__ to request that they pull your changes back into their repository.  This is safer for the original creator because it is easier for them to choose to include your changes if they don't like them.

Let try it.  I need to collect everyones GitHub usernames.  I have created a repository https://github.com/jnmaloof/gh-usernames for this purpose.

* Go the home page for that respository in your web browser. 
* Fork it using the button on the upper right hand side.
* Clone it to your computer
* Create a develop branch to work on
* Add your name, email, and user name to the 'usernames.md' document
* Confirm that the file looks OK (view it in remarkable)
* Merge your change on to the master branch
	* hint: checkout the master branch, then user 'merge develop'
* Push your change back up to you repository
* Use the website to send a pull request 
