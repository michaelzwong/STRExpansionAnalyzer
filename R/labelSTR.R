#' Load the text data with short tandem repeat (STR) loci into a dataframe.
#'
#' A function that loads the text file with STR loci into a data frame. Each STR
#' locus has the following format:
#' `chr<1-23/X/Y>:<START_POSITION>-<ENDPOSITION>:<REPEAT_UNIT/MOTIF>`.
#' For example, chr16:10000-11000:AT or chrX:900000-900100:TCTC.
#' These loci are separated by a tab space or new line.
#'
#' @param filepath The string filepath containing the text file.
#' @return Returns a dataframe with columns `chr`, `start`, `end` and `motif`
#'
#' @examples
#' # Load STR loci data from str_data.txt located in the inst/extdata folder
#' fpath <- system.file("extdata", "str_data.txt", package="STRExpansionAnalyzer")
#' mydf <- readIntoDF(filepath)
#'
#' @references
#' R Core Team (2020). R: A language and environment for statistical
#' computing. R Foundation for Statistical Computing, Vienna,
#' Austria. URL https://www.R-project.org/.
#'
#' Hadley Wickham and Jim Hester (2020). readr: Read Rectangular Text Data.
#' R package version 1.4.0.
#' https://CRAN.R-project.org/package=readr
#'
#'@export
#'@import readr
#'
readIntoDF <- function(filepath) {
  mystring <- read_file(filepath)

  # Split loci by whitespace
  str_loci <- unlist(strsplit(mystring, "\t"))

  # Split loci up by chromosome, start, end and motif
  df <- data.frame(do.call(rbind, strsplit(str_loci, "[:-]")))

  # Give the columns names
  names(df) <- c("chr", "start", "end", "motif")

  # Set start and end columns as numeric type
  df$start <- as.numeric(as.character(df$start))
  df$end <- as.numeric(as.character(df$end))
  return(df)
}

#' Create additional measurements to add to the loaded data frame.
#'
#' A function that takes in a dataframe and zscore specified by the user and
#' adds additional measurements (`size`, `size.mean`, `size.sd`, `size.zscore`,
#' `motif.totalcount`, `variable`, `variable.total`, `variable.percent`) to the
#' dataframe. The purpose of this function is to label a STR locus as either
#' variable or not using a user defined zscore input parameter. For example,
#' if a user enters a zscore of 0.2, then a STR locus with size greater than 0.2
#' standard deviations of the mean motif size, will be lablled variable.
#'
#' @param df The dataframe loaded from a text file.
#' @param zscore The zscore used to determine whether a STR locus is variable or
#'   not.
#'
#' @return Returns a dataframe with added columns `size`, `size.mean`, `size.sd`
#' , `size.zscore`, `motif.totalcount`, `variable`, `variable.total`,
#' `variable.percent`
#'
#' @examples
#' # Update dataframe with additional columns and labeled loci
#' data("ShortTandemRepeatsLoci")
#' mydf <- createVariables(ShortTandemRepeatsLoci, 0.1)
#'
#'
#' @references
#' R Core Team (2020). R: A language and environment for statistical
#' computing. R Foundation for Statistical Computing, Vienna,
#' Austria. URL https://www.R-project.org/.
#'
#' @export
#'
createVariables <- function(df, zscore) {
  # Calculate the size of a STR using start and end position
  df$size <- with(df, end-start)

  # Calculate mean size of each type of motif
  df$size.mean <- with(df, ave(size, motif, FUN=mean))

  # Calculate standard deviation of the size of each type of motif
  df$size.sd <- with(df, ave(size, motif, FUN=sd))

  # Calculate z-score (# of sd away from mean) of each individual motif
  df$size.zscore <- with(df, ave(size, motif, FUN=function(x) {
    return ((x - mean(x)) / sd(x))
  }))

  # Calculate the total count for each type of motif
  df$motif.totalcount <- as.numeric(with(df, ave(motif, motif, FUN=length)))

  # Calculate if a STR is "variable" or not based on z-score provided by user
  df$variable <- with(df, ave(size.zscore, FUN=function(x) {
    return(ifelse(abs(x) <= zscore, FALSE, TRUE))
  }))

  # Calculate the total number of "variable" STR loci for each type of motif
  df$variable.total <- with(df, ave(variable, motif, FUN=sum))

  # Calculate the percentage as a decimal of the "variable" STR loci
  df$variable.percent <- as.numeric(df$variable.total/df$motif.totalcount)

  # Disregard rows with incomplete data
  df <- df[complete.cases(df),]

  return(df)
}
