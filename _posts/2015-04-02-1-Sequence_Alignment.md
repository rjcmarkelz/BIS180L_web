---
layout: lab
title: Sequence Alignment
hidden: true    <!-- To prevent post from being displayed as regular blog post -->
tags:
- Linux
- sequence
---
## Background reading
There is good background information on sequence analysis [elsewhere on this site]({{site.baseurl}}/docs/SequenceAnalysisPrimer.pdf)

## Part 1: Getting Organized ##

If you look at the `/data` directory, you will see that there are 3
sub-directories for 3 different genomes. Each of these files was
downloaded directly from its source genome project (TAIR, WormBase,
FlyBase). There are files for proteins and files for genomes (the _A.
thaliana_ files are in separate chromosomes while the worm and fly have
all the sequences in a single file).

Now lets organize the files a little to make our lives easier. Create a
subdirectory in your home directory called `Data`. Create
sub-directories for each species, and alias the sequences into each
directory. Also create sub-directories under `Data` that organize by
sequence type rather than species. In the end, your hierarchical
structure should look like this.

	Data
		Sequences
			Genome
				A.thaliana.fa
				C.elegans.fa
				D.melanogaster.fa
			Proteome
				A.thaliana.fa
				C.elegans.fa
				D.melanogaster.fa
		Species
			A.thaliana
				genome.fa
				protein.fa
			C.elegans
				genome.fa
				protein.fa
			D.melanogaster
				genome.fa
				protein.fa

Note that the files do not have `.gz` extensions because they have been
uncompressed. Furthermore, the A.thaliana chromosomes have all been
merged into a single file. You should not need to duplicate sequences.
That is, `Sequences/Genome/A.thaliana.fa` and
`Species/A.thaliana/genome.fa` should contain the same thing, so no need
to duplicate the data unnecessarily (i.e. make an alias). Lastly, the
file permissions should be "appropriate". When you have completed these
tasks, change directory to your home directory and run the following
command.

	ls -lR Data

This should indicated that there are 6 aliases to 6 files.

## Part 2: Lab Notebook ##

It is now time to start doing some bioinformatics experiments. Create a
new directory to organize your thoughts and files.

	mkdir ~/Lab1
	cd ~/Lab1

Open up another terminal, change to the directory you just created, and
start a log where you can keep notes. This will be your laboratory
notebook for this unit.

	cd ~/Lab1
	nano lab1_notebook.md

Instead of editing in nano, you could also write your lab notebook while
using Markdown preview in the program Remarkable which is already 
installed on your Virtual Machine.

Create a simple table with the following information for each species.

1. Size of the file
2. Number of chromosomes
3. Size of the genome in bp
4. Number of protein-coding genes
5. Average protein length

The size of the file is very easy to determine. You can use `ls` or `wc`
for that. To find the various chromosomes, use `grep`. The size of the
genome will be the number of {ACGT} letters. This is a little
complicated because it's not the size of the file. The files also have
newline characters and FASTA headers. You need to subtract these.
Fortunately, you can do all of this with the Unix skills you already have.

## Part 3: Local Alignment ##

The program we are going to use for alignment is called `water`, which
is named after the **Smith-Waterman** algorithm. This comes from the
**EMBOSS** suite of bioinformatics programs, which is installed on your
system. One of the first things you should do when using a new program
is to skim the documentation. Some bioinformatics programs will have
`man` pages, but not all. `water` doesn't come with a `man` page, but
there is good documentation online at the EMBOSS site. Most
bioinformatics programs will have a **usage statement** that gives you
some help with the program. To display the usage statement, try the
`-h`, `-help`, `--help` options or try using the program without any
arguments. The `water` program responds to the first three, but if you
give it no arguments, it will start prompting you for arguments (which
can be useful or annoying depending on your mindset).

As you gain more experience with bioinformatics tools, you will find a
large variety of command line syntaxes and usage statements. Why?
Because most scientific programmers aren't professional software
developers. They don't always follow the rules and best practices of the
Unix community.

	water -h

There are not many options. We need to provide two sequence files,
penalties for gap opening and extension, and an output file. The scoring
matrix appears to BLOSUM62 by default but others are available (see
`/usr/share/EMBOSS/data` or `/usr/local/share/EMBOSS/data`). Let's try
the interactive mode.

	water

The program now asks for the name of the input sequence file. You can't
tab-complete this. That's enough reason for me to NEVER USE THE
INTERACTIVE MODE, but if you like it, go ahead.

So where are we going to get our sequence files from? Let's grab the
first protein from the A. thaliana, C. elegans, and D. melanogaster
proteomes to begin. You can use `head` with a command line option for
the number of lines and the `>` redirection symbol for this task. Save
these files as `at1.fa`, `ce1.fa`, and `dm1.fa`. You might want to write
a bit in your `lab1_notebook.md` file about how you did this. You can
even paste in parts of your `history`.

Now let's try aligning the various files to each other.

	water at1.fa ce1.fa -gapopen 10 -gapextend 5 -outfile at_ce.water

Read the output of this command with `less`. Note the score, percent
identity, percent similarity, and score. Is a score of 37 good? Hmm,
that's a difficult question. What exactly does "good" mean? Should a
good score mean that two sequences are evolutionarily related? That they
have similar function? As a scientist, one of the first questions you
should ask yourself is how likely that alignment could have occurred at
random.

## Part 4: Random Expectation ##

We can use the EMBOSS `shuffleseq` to create related sequences whose
letters have been mixed up.

	head ce1.fa
	shuffleseq ce1.fa -outseq ce1.shuffle.fa 
	head ce1.shuffle.fa

Notice that the sequences are completely different. Now let's determine
if they actually have the same number of letters. We'll use the
`compseq` program for that.

	compseq ce1.fa -word 1 -outfile ce1.comp
	compseq ce1.shuffle.fa -word 1 -outfile ce1.shuffle.comp
	less ce1.comp
	less ce1.shuffle.comp

The files look pretty similar, but are they **exactly** the same? We can use
the Unix `diff` command for that.

	diff ce1.comp ce1.shuffle.comp

Nothing happened? Actually, that was very important. `diff` reports
which lines are different. If there aren't any, then there's nothing to
report. To verify this, try `diff`-ing the two sequence files. They
should have the same FASTA definition line, but completely different
sequence lines.

	diff ce1.fa ce1.shuffle.fa

Well, that's not quite what happened. Even the FASTA header lines are
slightly different. Apparently `shuffleseq` changes whitespace in the
defline for some reason.

Now let's try aligning the shuffled C. elegans protein against the A.
thaliana protein.

	water at1.fa ce1.shuffle.fa -gapopen 10 -gapextend 5 -outfile 1.water

Examine the file and look at the score. Use the arrow keys or your
`history` to repeat the command you used to create the shuffled
sequence. This will overwrite your last command. Then do the alignment
again and look at the score. Repeat this a few more times. As you can
see, the score changes each time. Do you wonder what the distribution of
scores looks like? Of course you do. So let's do this 1000 times.

Wait! Hands off those arrow keys. The `shuffleseq` program will let us
make multiple copies of the same sequence. That will make our lives much
easier.

	shuffleseq ce1.fa -outseq ce1.shuffle.fa -shuffle 1000
	less ce1.shuffle.fa
	water at1.fa ce1.shuffle.fa -gapopen 10 -gapextend 5 -outfile 1k.water

Now let's collect all the scores and make a histogram. The only part of
each alignment we care about is the score. Fortunately, there's only one
place in each alignment that uses the word 'Score' so we can pull that
out with `grep`.

	grep Score 1k.water

To get just the number, we can treat the other characters as 'fields' in
a pseudo-spreadsheet using the `cut` command with the `-d " "` option to
tell it that our fields split on spaces and the `-f 3` option to tell it
we want the 3rd column. We can pipe the `grep` command line above
directly to the `cut` command without creating any intermediate files.

	grep Score 1k.water | cut -d " " -f 3

Let's `sort` this and look at the maximum and minimum values. The `-n`
option tells `sort` to compare numerically rather than alphabetically.

	grep Score 1k.water | cut -d " " -f 3 | sort -n

Use `head` and `tail` to find the minimum and maximum values. Or you can
use `less` and scroll the the output.

To find the median score, sort the output as above, but pipe it to
`head` to get the 500th and 501st value (with an even number of values, 
you average the two middle values).

	grep Score 1k.water | cut -d " " -f 3 | sort -n | head -501 | tail -2

These two values can be averaged for the median. You can even pipe to it
to `tail` to complete the logical converse.

	grep Score 1k.water | cut -d " " -f 3 | sort -n | tail -501 | head -2

There is an odd Unix command called `uniq` that compares adjacent lines
in a file and reports when they are not the same. Since it is comparing
adjacent lines, we will need to `sort` the scores again. To count when
the lines are not the same, use `uniq` with the `-c` option. We can use 
that to make a histogram.

	grep Score 1k.water | cut -d " " -f 3 | sort -n | uniq -c

Boom! This is the distribution of maximum scoring alignments expected at
random between these two sequences. To compute the average, we can use
`awk` to sum up column 3 of the `1k.water` file and then divide by the
number of records. `awk` is a powerful scripting language that we don't
have time to discuss.

	grep Score 1k.water | awk '{sum+=$3} END {print sum/NR}'

Answer the following questions in your notebook.

1. Is the shape of the curve normal? Do you expect it to be normal?
2. Do you expect all protein comparisons to have the same distribution?
3. How would protein composition and length affect the scores?
4. How would the scoring matrix and gap penalites affect the scores?
5. How might real sequences be different from random?

## Part 5: Alignment Significance ##

OK, the training wheels are off and it's time to do some experiments on
your own. Your goal is to determine the statistical significance of an
alignment. The query sequence is B0213.10, which can be found in the C.
elegans proteome. Search this against all A. thaliana and D.
melanogaster proteins to find its homologs.

Before you begin, it's a good idea to get an idea how long it will take
to do the experiment. Will your experiment take seconds, minutes, hours,
days, or longer? Before attempting to do the whole experiment, it pays
to do a small fraction first. Don't begin until you can answer the
following questions?

* How many amino acids can I align per second?
* How many amino acids do I need to align to do this experiment?
* How long would it take to compare two proteomes?

Write those down in your notebook. Now let's get back to the experiment.
You want to find the A. thaliana and D. melanogaster orthologs of
B0213.10. Set up the experiment any way you like. You need to be able to
answer the following questions. Note that some questions are very
open-ended and may be very difficult to answer. For these, do your best 
and support your answer with scientific reasoning and/or appropriate 
sources.

* What is the best match in each genome?
* What protein is this?
* What are the alignment properties (% identity, etc.)
* What is the expected score of your alignment at random?
* How different is your best score from random?
* How statistically significant is this score?
* How biologically significant is this score?
