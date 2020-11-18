#' Short tandem repeats found in GRCh38 Genome Assembly.
#'
#' A dataset of short tandem repeats found in the human reference genome build h38
#' [Reference 1, 2].
#' The list was found using ExpansionHunter [Reference 3, 4] and Tandem Repeats
#' Finder [Reference 5] as part of research done at the SickKids Yuen lab
#' [Reference 6, 7]
#'
#' @source Genome Reference Consortium.
#'
#' @format A data.frame with 29757 rows and 4 variables:
#' \describe{
#'  \item{chr}{The chromosome of where the short tandem repeat is located.}
#'  \item{start}{The start position of the short tandem repeat.}
#'  \item{end}{The end position of the short tandem repeat.}
#'  \item{motif}{The repeat sequence or motif of the short tandem repeat.}
#' }
#'
#' @examples
#' \dontrun{
#' head(ShortTandemRepeatsLoci)
#' }
#'
#' @references
#' 1. Church, D. M., Schneider, V. A., Graves, T., Auger, K., Cunningham, F., Bouk, N., Chen, H. C., Agarwala, R., McLaren, W. M., Ritchie, G. R., Albracht, D., Kremitzki, M., Rock, S., Kotkiewicz, H., Kremitzki, C., Wollam, A., Trani, L., Fulton, L., Fulton, R., Matthews, L., … Hubbard, T. (2011). Modernizing reference genome assemblies. PLoS biology, 9(7), e1001091. https://doi.org/10.1371/journal.pbio.1001091
#' 2. Schneider, V. A., Graves-Lindsay, T., Howe, K., Bouk, N., Chen, H. C., Kitts, P. A., Murphy, T. D., Pruitt, K. D., Thibaud-Nissen, F., Albracht, D., Fulton, R. S., Kremitzki, M., Magrini, V., Markovic, C., McGrath, S., Steinberg, K. M., Auger, K., Chow, W., Collins, J., Harden, G., … Church, D. M. (2017). Evaluation of GRCh38 and de novo haploid genome assemblies demonstrates the enduring quality of the reference assembly. Genome research, 27(5), 849–864. https://doi.org/10.1101/gr.213611.116
#' 3. Dolzhenko, E., van Vugt, J., Shaw, R. J., Bekritsky, M. A., van Blitterswijk, M., Narzisi, G., Ajay, S. S., Rajan, V., Lajoie, B. R., Johnson, N. H., Kingsbury, Z., Humphray, S. J., Schellevis, R. D., Brands, W. J., Baker, M., Rademakers, R., Kooyman, M., Tazelaar, G., van Es, M. A., McLaughlin, R., … Eberle, M. A. (2017). Detection of long repeat expansions from PCR-free whole-genome sequence data. Genome research, 27(11), 1895–1903. https://doi.org/10.1101/gr.225672.117
#' 4. Dolzhenko, E., Deshpande, V., Schlesinger, F., Krusche, P., Petrovski, R., Chen, S., Emig-Agius, D., Gross, A., Narzisi, G., Bowman, B., Scheffler, K., van Vugt, J., French, C., Sanchis-Juan, A., Ibáñez, K., Tucci, A., Lajoie, B. R., Veldink, J. H., Raymond, F. L., Taft, R. J., … Eberle, M. A. (2019). ExpansionHunter: a sequence-graph-based tool to analyze variation in short tandem repeat regions. Bioinformatics (Oxford, England), 35(22), 4754–4756. https://doi.org/10.1093/bioinformatics/btz431
#' 5. Benson G. (1999). Tandem repeats finder: a program to analyze DNA sequences. Nucleic acids research, 27(2), 573–580. https://doi.org/10.1093/nar/27.2.573
#' 6. C Yuen, R., Merico, D., Bookman, M. et al. Whole genome sequencing resource identifies 18 new candidate genes for autism spectrum disorder. Nat Neurosci 20, 602–611 (2017). https://doi.org/10.1038/nn.4524
#' 7. Trost, B., Engchuan, W., Nguyen, C.M. et al. Genome-wide detection of tandem DNA repeats that are expanded in autism. Nature 586, 80–86 (2020). https://doi.org/10.1038/s41586-020-2579-z
"ShortTandemRepeatsLoci"
