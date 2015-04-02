# Template for Sequence Alignment Assignment

__Name:__

__Student ID:__

## Q1

## Q2

# Unit 1 Worksheet (20 pts possible)
# Name:

1. Fill in the following table.
|     Chacteristic    |   A. thaliana    |   C. elegans   |   D. melanogaster
|:--------------------|:-----------------|:---------------|:-------------------
| File size           |                  |                |                    
| Chromosomes (#)     |                  |                |                    
| Genome size (bp)    |                  |                |                    
| Genome size (bp)    |                  |                |                    
| Chromosomes (#)     |                  |                |                    
| Protein-coding genes|                  |                |                    ￼
| Average protein (aa)|                  |                |                    ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼

2. How do you know that when you use shuffleseq the sequences have the same exact composition?

3. In the area below, draw a histogram showing the distribution of scores when aligning 1000 shuffled C. elegans sequence "ce1" against the A. thaliana sequence "at1". The X-axis should be score. Indicate with an arrow the score of the original, unshuffled alignment.
4. Why is the shape of the curve not quite normal?

5. Perform the experiment 3 more times with a different 1000 shuffled sequences. Create a table using markdown with the￼Mean, Mode and￼Median for each run.

6. What would be the effect of doing more than 1000 shuffled sequences?
7. Use the area below to graph average alignment score as a function of sequence length.
8. Re-draw the graph in log2 scale.
￼￼!9. Discuss the relationship of sequence length and score. 

￼Unit 1 Worksheet Name:
10. Search the ce1 sequence against a shuffled version of the same sequence and report the average score.
!11. Create a fake protein sequence containing 50% Q but the rest of the letters are typical of real proteins (add a bunch of Qs to the end of a real sequence). Now make a shuffled version of this to distribute the Qs around. Search this against the ce1 and at1 sequences and report the alignment score.
!12. Create 1000 shuffles of the Q-enriched sequence above and report the average score. !13. Discuss parts 10-12 with respect to how sequence composition affects score.
!14. Perform random alignments (as in question 3 above) with the following different alignment scoring schemes.
!
! EBLOSUM80
15. Inspect the scoring matrices in /usr/share/EMBOSS/data. Discuss the table above with
￼￼￼￼￼￼￼￼Matrix
EBLOSUM40
EBLOSUM40
EBLOSUM62
EBLOSUM62
EBLOSUM80
Gap Open
9
9
9
9
9
9
Gap Extend
3
9
3
9
3
9
Mean
Mode
Median
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼respect to the scoring parameters.
!

￼Unit 1 Worksheet Name:
16. How many amino acids per second does the water program compare?
!17. How long does it take to search two entire proteomes with water? Show your work.
!18. Starting with the C. elegans B0213.10 protein, find the best match in the A. thaliana and D.
melanogaster proteomes with water. Record their alignment scores here.
!19. What is the expected score of each protein at random? (Perform some shuffled alignments
to get an idea of what the random expectation is).
!20. Using Z-scores, how many standard deviations away from the mean are your alignments in (18) compared to your alignments in (19)?
!21. Is this statistically significant? You may want to correct for multiple statistical tests. !22. Why is the z-score approach flawed?
!23. Graph run-time as a function of word size for blastp in the box at the right.
￼￼!24. How much faster is blastp than water at word size 5?
!25. How long will it take to search two proteomes with word size 5.
!26. Using E-value to determine the best match, find a worm gene with a single fly ortholog and record their names.
!27. Discuss what makes orthology difficult to determine.
!28. Discuss what makes paralogy difficult to determine.
!29. Is alignment score sufficient for determining orthology or paralogy? What other sources of information might be useful?
