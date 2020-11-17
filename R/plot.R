#' Plots the distribution of a list of motifs.
#'
#' A function that takes a dataframe containing
#'
plotMotifsDistribution <- function(df, motifsList, count=TRUE) {
  if(typeof(motif) != "character") {
    stop("motif must be a character containing DNA bases: A, T, G, C")
  }
  if(!is.data.frame(df)) {
    stop("df must be a data frame")
  }

  # Build filter condition
  condition <- FALSE
  for(motif in motifsList) {
    condition <- condition | DF$motif==motif
  }

  # Apply filter condition
  filteredDF <- DF[condition,]

  if(count) {
    # Show count on the Y-axis
    ggplot(filteredDF, aes(x=size, fill=motif), alpha=.75, bins=15) +
      geom_vline(data=filteredDF, aes(xintercept=size.mean, colour=motif),
                 linetype="dashed", size=1) +
      ggtitle("Motif Count Distribution Graph")
  } else {
    # Show density on the Y-axis
    ggplot(filteredDF, aes(x=size, color=motif)) +
      geom_density() +
      geom_vline(data=filteredDF, aes(xintercept=size.mean, colour=motif),
                 linetype="dashed", size=1) +
      ggtitle("Motif Density Distribution Graph")
  }
}

#
plotTopNCommonMotifs <- function(df, num, stacked=FALSE) {
  if(num < 1) {
    stop("num parameter must be greater than 0")
  }
  if(!is.integer(num)) {
    stop("type of num must be integer")
  }
  if(!is.data.frame(df)) {
    stop("df must be a data frame")
  }
  topNMotifs <- tail(names(sort(table(DF$motif))), num)

  # Build filter condition
  condition <- FALSE
  for(motif in topNMotifs) {
    condition <- condition | DF$motif==motif
  }

  # Apply filters
  filteredDF <- DF[condition,]

  if(stacked) {
    # Show stacked bar graph
    ggplot(filteredDF, aes(x=motif, fill=factor(variable))) +
      geom_bar(position="stack") +
      labs(title="Variable vs Stable STRs of Top " + toString(num) +
             " Common Motifs",
           x = "Count", y = "Motifs", fill="Variable\n")
  } else {
    # Show dodged bar graph
    ggplot(filteredDF, aes(motif, fill=factor(variable))) +
      geom_bar(position = "dodge") +
      labs(title="Variable vs Stable STRs of Top " + toString(num) +
             " Common Motifs",
           x = "Count", y = "Motifs", fill="Variable\n")
  }
}

plotTopNMostVariableMotifs <- function(df, num) {
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
    condition <- condition | DF$motif==motif
  }

  # Apply filters
  filteredDF <- DF[condition,]

  ggplot(filteredDF, aes(x=motif, fill=motif)) +
    geom_bar()  +
    labs(title="Top " + toString(num) +
           " Most Variable Motifs",
         x = "Count", y = "Motifs")
}

plotTopNLeastVariableMotifs <- function(df, num) {
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
    condition <- condition | DF$motif==motif
  }

  # Apply filters
  filteredDF <- DF[condition,]

  ggplot(filteredDF, aes(x=motif, fill=motif)) +
    geom_bar()  +
    labs(title="Top " + toString(num) +
           " Least Variable Motifs",
         x = "Count", y = "Motifs")
}
