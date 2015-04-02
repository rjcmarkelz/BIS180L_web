# Template for Sequence Alignment Assignment (Week 1, 20 pts possible)

__Full Name:__

__Student ID:__

*_Please answer the following questions which are each worth 1 point unless otherwise indicated. Be clear and concise with any written answers. Graphs should be properly constructed (axis labels, units, titles, etc.)_*

__1.__ Fill in the following table.

|     Characteristic  |   A. thaliana    |   C. elegans   |   D. melanogaster
|:--------------------|:-----------------|:---------------|:-------------------
| File size           |                  |                |                    
| Chromosomes (#)     |                  |                |                    
| Genome size (bp)    |                  |                |                    
| Genome size (bp)    |                  |                |                    
| Chromosomes (#)     |                  |                |                    
| Protein-coding genes|                  |                |                    ￼
| Average protein (aa)|                  |                |                    ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼

__2.__ How do you know that when you use `shuffleseq` the sequences have the same exact composition?

__3.__ Create a histogram and indicate the file name below that shows the distribution of scores when aligning 1000 shuffled C. elegans sequence "ce1" against the A. thaliana sequence "at1". The X-axis should be score. Indicate with an arrow the score of the original, unshuffled alignment. Why is the shape of the curve not quite normal?

__4.__ Perform the experiment 3 more times with a different 1000 shuffled sequences. Create a table using markdown with the mean, mode and median for each run (include your first run for a total of 4 runs).

__5.__ What would be the effect of doing more than 1000 shuffled sequences?

__6.__ Create a plot that shows average alignment score as a function of sequence length and this same information on a log2 scale. Indicate the file name below.

__7.__ Briefly discuss the relationship of sequence length and score. (*2pts*)

__8.__ Search the ce1 sequence against a shuffled version of the same sequence and report the average score.

__9.__ Create a fake protein sequence containing 50% Q but the rest of the letters are typical of real proteins (add a bunch of Qs to the end of a real sequence). Now make a shuffled version of this to distribute the Qs around. Search this against the ce1 and at1 sequences and report the alignment score.

__10.__ Create 1000 shuffles of the Q-enriched sequence above and report the average score.

__11.__ Briefly discuss parts 9-11 with respect to how sequence composition affects score. (*2pts*)

__12.__ Perform random alignments (as in question 3 above) with the following different alignment scoring schemes:

|     Matrix    |   Gap Open    | Gap Extend |   Mean  | Mode    | Median
|:--------------|:--------------|:-----------|:--------|:--------|:--------
| EBLOSUM80     |       9       |     3      |         |         |              
| EBLOSUM40     |       9       |     9      |         |         |              
| EBLOSUM40     |       9       |     3      |         |         |              
| EBLOSUM62     |       9       |     9      |         |         |              
| EBLOSUM62     |       9       |     3      |         |         |              
| EBLOSUM80     |       9       |     9      |         |         |              


__13.__ Inspect the scoring matrices in `/usr/share/EMBOSS/data`. Briefly discuss the table above with
respect to the scoring parameters.

__14.__ Starting with the C. elegans B0213.10 protein, find the best match in the A. thaliana and D.
melanogaster proteomes with `water`. Record their alignment scores and protein names here.

__15.__ What is the expected score of each protein at random? (Perform some shuffled alignments
to get an idea of what the random expectation is).

__16.__ Using E-value to determine the best match, find a worm gene with a single fly ortholog and record their names.

__17.__ Discuss what makes orthology and paralogy difficult to determine. Is alignment score sufficient for determining orthology or paralogy? What other sources of information might be useful? (*2pts*)
