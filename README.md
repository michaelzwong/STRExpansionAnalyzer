# STRExpansionAnalyzer

## Background Information
Short tandem repeats (STRs) are tracts of repetitive DNA. Typically, they are
short sequences of 2-6 nucleotides repeated adjacently two or more times in a head
to tail manner<sup>3</sup>. STR loci are prone to mutations and high rates of polymorphism<sup>1</sup>. Expansions
of STR loci can be pathogenic and have been attributed to more than 40 Mendelian diseases<sup>2,4</sup>.
As well, they have been strongly linked to more complex disorders like autism spectrum syndrome<sup>3</sup>.

## Description
This package helps label short tandem repeat (STR) loci as "variable" or not (stable) for machine learning and statistical analysis.
The function *readIntoDF* takes in a text file of identified STR loci locations from any species' genome and creates a dataframe.
The function *createVariables* calculates additional measure variables using STR motifs and locations, cleans the dataset and labels each STR loci as either "variable" or not depending a user defined z-score.
The rest of the functions help graph the distribution of STR motifs, the most common/least common motifs and most variable/least variable motifs.


## Installation
To install:
```
require("devtools")
install_github("michaelzwong/STRExpansionAnalyzer", build_vignettes = TRUE)
library("STRExpansionAnalyzer")
```

## Overview
`STRExpansionAnalyzer` contains 6 functions.

To load text file containing STR loci positions of any species' genome 
into a dataframe, use: *readIntoDF*.

To label loci as variable and add measure variable columns like motif mean and
sd, use: *createVariables*.

To graph distribution, see common/least common motifs, or to see variable or 
least variable motifs, use the graphing functions: *plotMotifsDistribution*, *plotTopNCommonMotifs*, *plotTopNLeastVariableMotifs*, *plotTopNMostVariableMotifs*.

## Tutorials
```
browseVignettes("STRExpansionAnalyzer")
```
## Citation for Package
```
citation("STRExpansionAnalyzer")
```

## References
[1]: Gemayel, R., Vinces MD., Legendre, M., Verstrepen, K.J.. Variable tandem repeats accelerate evolution of coding and regulatory sequences. Annu Rev Genet 44, 445–77 (2010).

[2]:López Castel, A., Cleary, J. D. & Pearson, C. E. Repeat instability as the basis for human diseases and as a potential target for therapy. Nat. Rev. Mol. Cell Biol. 11, 165–170 (2010).

[3]: Trost, B., Engchuan, W., Nguyen, C.M. et al. Genome-wide detection of tandem DNA repeats that are expanded in autism. Nature 586, 80–86 (2020). https://doi.org/10.1038/s41586-020-2579-z

[4]: Hao F., Chu J. A Brief Review of Short Tandem Repeat Mutation. Genomics, Proteomics & Bioinformatics. 5, 7-14 (2007). https://doi.org/10.1016/S1672-0229(07)60009-6.

## Maintainer
* Michael Wong (michaelz.wong@mail.utoronto.ca)

## Acknowledgements

This package was developed as part of an assessment for 2020 BCB410H: Applied Bioinformatics, University of Toronto, Toronto, CANADA

## Contributions
* This package welcomes issues, improvement requests, and contributions. Please use [Issues](https://github.com/michaelzwong/STRExpansionAnalyzer/issues) section
