#' Plots the distribution of the specified motifs.
#'
#' A function that takes a dataframe containing labeled STR loci and measure
#' variables, a list of motifs and plots out a distribution graph of motif
#' size with either count or density on the y axis.
#'
#' @param df The dataframe created using labelSTR.R containing labeled STR loci
#'   and measurement variables.
#' @param motifsList A list of motifs to graph out.
#' @param count If TRUE uses count for y axis Else uses density for y axis.
#'
#' @return Plots out a density or count distribution graph of the specified
#'   motifs.
#'
#' @examples
#' # Plot out the distribution size of motifs "AGG", "AC"
#' plotMotifsDistribution(df, c("AGG", "AC"))
#'
#' @references
#' R Core Team (2020). R: A language and environment for statistical
#' computing. R Foundation for Statistical Computing, Vienna,
#' Austria. URL https://www.R-project.org/.
#'
#' H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag
#' New York, 2016.
#'
#'@export
#'@import ggplot2
#'
plotMotifsDistribution <- function(df, motifsList, count=TRUE) {
  if(typeof(motifsList) != "character") {
    stop("motif must be a character containing DNA bases: A, T, G, C")
  }
  if(!is.data.frame(df)) {
    stop("df must be a data frame")
  }

  # Build filter condition
  condition <- FALSE
  for(motif in motifsList) {
    condition <- condition | df$motif==motif
  }

  # Apply filter condition
  filteredDF <- df[condition,]

  if(count) {
    # Show count on the Y-axis
    ggplot(filteredDF, aes(x=size, fill=motif)) +
      geom_histogram(aes(x=size), alpha=.75, bins=15) +
      geom_vline(data=filteredDF, aes(xintercept=size.mean, color=motif),
                 linetype="dashed", size=1) +
      ggtitle("Motif Count Distribution Graph")
  } else {
    # Show density on the Y-axis
    ggplot(filteredDF, aes(x=size, color=motif)) +
      geom_density() +
      geom_vline(data=filteredDF, aes(xintercept=size.mean, color=motif),
                 linetype="dashed", size=1) +
      ggtitle("Motif Density Distribution Graph")
  }
}

#' Plots the top N most common motifs from the dataframe.
#'
#' A function that takes a dataframe containing labeled STR loci and measure
#' variables, a number N and plots out the top N most common motifs and
#' the proportion of variable vs non variable STR loci.
#'
#' @param df The dataframe created using labelSTR.R containing labeled STR loci
#'   and measurement variables.
#' @param num Specifies top how many motifs to graph.
#' @param stacked If TRUE uses stacked bar plot Else uses a dodge bar plot.
#'
#' @return Plots out a bar plot showing the top N most common motifs and
#' the proportion of variable vs non variable STR loci.
#'
#' @examples
#' # Plot out the top 5 most common motifs
#' plotTopNCommonMotifs(df, 5)
#'
#' @references
#' R Core Team (2020). R: A language and environment for statistical
#' computing. R Foundation for Statistical Computing, Vienna,
#' Austria. URL https://www.R-project.org/.
#'
#' H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag
#' New York, 2016.
#'
#'@export
#'@import ggplot2
#'
plotTopNCommonMotifs <- function(df, num, stacked=FALSE) {
  num <- as.integer(num)
  if(num < 1) {
    stop("num parameter must be greater than 0")
  }
  if(!is.integer(num)) {
    stop("type of num must be integer")
  }
  if(!is.data.frame(df)) {
    stop("df must be a data frame")
  }
  topNMotifs <- tail(names(sort(table(df$motif))), num)

  # Build filter condition
  condition <- FALSE
  for(motif in topNMotifs) {
    condition <- condition | df$motif==motif
  }

  # Apply filters
  filteredDF <- DF[condition,]

  title <- paste("Variable vs Stable STRs of Top", toString(num),
                  "Common Motifs", sep=" ")
  if(stacked) {
    # Show stacked bar graph
    ggplot(filteredDF, aes(x=motif, fill=factor(variable))) +
      geom_bar(position="stack") +
      labs(title=title,
           x = "Count", y = "Motifs", fill="Variable\n")
  } else {
    # Show dodged bar graph
    ggplot(filteredDF, aes(motif, fill=factor(variable))) +
      geom_bar(position = "dodge") +
      labs(title=title,
           x = "Count", y = "Motifs", fill="Variable\n")
  }
}

#' Plots the top N most variable motifs from the dataframe.
#'
#' A function that takes a dataframe containing labeled STR loci and measure
#' variables, a number N and plots out the top N most variable motifs
#'
#' @param df The dataframe created using labelSTR.R containing labeled STR loci
#'   and measurement variables.
#' @param num Specifies top how many variable motifs to graph.
#'
#' @return Plots out a bar plot showing the top N most variable motifs.
#'
#' @examples
#' # Plot out the top 5 most variable motifs
#' plotTopNMostVariableMotifs(df, 5)
#'
#' @references
#' R Core Team (2020). R: A language and environment for statistical
#' computing. R Foundation for Statistical Computing, Vienna,
#' Austria. URL https://www.R-project.org/.
#'
#' H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag
#' New York, 2016.
#'
#'@export
#'@import ggplot2
#'
plotTopNMostVariableMotifs <- function(df, num) {
  num <- as.integer(num)
  if(num < 1) {
    stop("num parameter must be greater than 0")
  }
  if(!is.integer(num)) {
    stop("type of num must be integer")
  }
  if(!is.data.frame(df)) {
    stop("df must be a data frame")
  }

  topNMostVariableMotifs <-
    head(unique(df$motif[order(df$variable.percent, decreasing=TRUE)]), num)

  # Build filter condition
  condition <- FALSE
  for(motif in topNMostVariableMotifs) {
    condition <- condition | df$motif==motif
  }

  # Apply filters
  filteredDF <- df[condition,]

  title <- paste("Top", toString(num),
                 "Most Variable Motifs", sep=" ")

  ggplot(filteredDF, aes(x=motif, fill=motif)) +
    geom_bar()  +
    labs(title=title,
         x = "motifs", y = "count")
}

#' Plots the top N least variable or stable motifs from the dataframe.
#'
#' A function that takes a dataframe containing labeled STR loci and measure
#' variables, a number N and plots out the top N least variable or stable motifs
#'
#' @param df The dataframe created using labelSTR.R contaning labeled STR loci
#'   and measurement variables.
#' @param num Specifies top how many least variable motifs to graph.
#'
#' @return Plots out a bar plot showing the top N least variable motifs.
#'
#' @examples
#' # Plot out the top 5 least variable motifs
#' plotTopNMostVariableMotifs(df, 5)
#'
#' @references
#' R Core Team (2020). R: A language and environment for statistical
#' computing. R Foundation for Statistical Computing, Vienna,
#' Austria. URL https://www.R-project.org/.
#'
#' H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag
#' New York, 2016.
#'
#'@export
#'@import ggplot2
#'
plotTopNLeastVariableMotifs <- function(df, num) {
  num <- as.integer(num)
  if(num < 1) {
    stop("num parameter must be greater than 0")
  }
  if(!is.integer(num)) {
    stop("type of num must be integer")
  }
  if(!is.data.frame(df)) {
    stop("df must be a data frame")
  }

  topNMostVariableMotifs <-
    tail(unique(df$motif[order(df$variable.percent, decreasing=FALSE)]), num)

  # Build filter condition
  condition <- FALSE
  for(motif in topNMostVariableMotifs) {
    condition <- condition | df$motif==motif
  }

  # Apply filters
  filteredDF <- df[condition,]

  title <- paste("Top", toString(num),
                 "Least Variable Motifs", sep=" ")

  ggplot(filteredDF, aes(x=motif, fill=motif)) +
    geom_bar()  +
    labs(title=title,
         x = "motifs", y = "count")
}
