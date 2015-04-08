---
layout: lab
title: Bash for loops
hidden: true    <!-- To prevent post from being displayed as regular blog post -->
tags:
- Linux
- sequence
---

## Background

I have claimed that there are tools at the command line that make automating tasks easier. You are probably wondering when you will get to see that.  Now is the time.

For the sequence alignment task you were asked to run the random alignments against three different scoring matrices and two different gap extend penalties.  This means that you needed to type almost the same command six times.  Tedious, right?  What if there were 100 scoring matricies?  Then it would get super tedious.

What we want is a method to automatically run the command with the variations that we care about.  To do this we want a __for loop__

## For Loops

A __for loop__ is a method of iterating over a series of values and performing an operation on each value.  All programming languages have some version of this, alhough the syntax varies.

First a toy example.  Lets say that we have a list of fruit and we want to convert the fruit names to plurals.

First lets create our items.  (Type these commands yourself to get practice)

    fruits="bannana apple orange grape plum pear durian pineapple"

This creates the variable `fruits`

Remember to refer to a variable after it is defined we place a "$" in front of it

    echo "$fruits"

In unix-bash a for loop has for parts
1. A statement saying what items we want to loop over
2. `do` to note the beginning of the commands that we want to loop through
3. The commands to repeat
4. `done` to indicate the end of the loop

So if we want to loop through each fruit in $fruits and print them one at a time we would write

    for fruit in $fruits 
    do
        echo "$fruit"
    done

For each fruit in $fruits the value is place in a new variable $fruit.  The command `echo $fruit` is run, and then the next fruit is place in $fruit and the `echo` command is repeated.

What if we want to add an "s" to make these fruit plural? 

    for fruit in $fruits 
    do
        echo "${fruit}s"
    done

The curly brackets are used to help bash distinguish between the variable name `fruit` and the text we want to add `s`

__Exercise One__: Write a for loop to plurlalize peach, tomato, potato (remember that these end in "es" when plural)

Confused?  There are a bunch of tutorials online.  I like [this one](http://www.cyberciti.biz/faq/bash-for-loop/) and [this one](http://www.tutorialspoint.com/unix/for-loop.htm)

__Exercise Two__: Write a for loop that runs the `water` command three times, (once per loop) each time using a different scoring matrix.  Be sure that the results from each call to `water` is saved in a different file with the file name indicating the parameters that were used.

## Nested for Loops

In our case, for each type of scoring matrix we want to use two different gap extension penalties.  Can we automate this also?  Yes!  We could just right two for loops, or include two calls to `water` in our single for loop.  But what if we wanted to go through 10 different gap extenstion penalties?  In this case we could use a __nested for loop__

### fruit example

For some reason we want to add the numbers 1 to 10 after each of our fruit names...

    fruits="bannana apple orange grape plum pear durian pineapple"

    for fruit in $fruits 
    do
        for number in 1 2 3 4 5 6 7 8 9 10
        do
            echo "$fruit $number"
        done
    done

For each fruit we now loop through each of the numbers...

__Exercise Three:__ Use a nested for loop to run water for each scoring matrix and gap extension penalties from 3 through 9










