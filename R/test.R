library(readr)
zscore <- 0.1
typeof(zscore)
mystring <- read_file("asd_data.txt")
str_loci <- unlist(strsplit(mystring, "\t"))
str_loci <- str_loci[-(1:4)]

DF <- data.frame(do.call(rbind, strsplit(str_loci, "[:-]")))
names(DF) <- c("chr", "start", "end", "motif")
DF$start <- as.numeric(as.character(DF$start))
DF$end <- as.numeric(as.character(DF$end))

DF$size <- with(DF, end-start)

DF$size.mean <- with(DF, ave(size, motif, FUN=mean))
DF$size.sd <- with(DF, ave(size, motif, FUN=sd))
DF$size.zscore <- with(DF, ave(size, motif, FUN=getZScore))
DF$motif.totalcount <- as.numeric(ave(motif, motif, FUN=length))
DF$variable <- with(DF, ave(size.zscore, FUN=isVariable))
DF$variable.total <- with(DF, ave(variable, motif, FUN=sum))
DF$variable.percent <- as.numeric(DF$variable.total/DF$motif.totalcount)

head(DF)


# remove incomplete cases
DF <- DF[complete.cases(DF),]
head(DF)

# Graph distribution
distDF <- DF[c("motif", "size.zscore", "size")]
motifsList <- c("GAAG", "AGAG")
typeof(motifsList)

condition <- FALSE
for(motif in motifsList) {
  condition <- condition | DF$motif==motif
}

filteredDF <- DF[condition,]
filteredDf2 <- DF[DF$motif=="AGAG",]

# density
ggplot(filteredDF, aes(x=size, fill=motif)) +
  geom_histogram(aes(x=size), alpha=.75, bins=15) +
  geom_vline(data=filteredDF, aes(xintercept=size.mean,  colour=motif),
             linetype="dashed", size=1)

# distribution
ggplot(filteredDF, aes(x=size, color=motif)) +
  geom_density() +
  geom_vline(data=filteredDF, aes(xintercept=size.mean,  colour=motif),
             linetype="dashed", size=1)


# Get top 5 most variable motifs
table(DF$variable)
topNMotifs <- tail(names(sort(table(DF$motif))), 5)
sum(DF$motif=="GAAG" & DF$variable==FALSE)
print(topNMotifs)

for(motif in topNMotifs) {
  condition <- condition | DF$motif==motif
}

filteredDF <- DF[condition,]

ggplot(filteredDF, aes(x=motif, fill=factor(variable))) +
  geom_bar(position="stack") +
  labs(title = "Temperatures\n", x = "TY [°C]", y = "Txxx", fill = "Legend Title\n")

getZScore <- function(x) {
  return ((x - mean(x)) / sd(x))
}


isVariable <- function(x) {
  return(ifelse(abs(x) <= zscore, FALSE, TRUE))
}

library(ggplot2)

topNMostVariableMotifs <-
  tail(unique(DF$motif[order(DF$variable.percent, decreasing=TRUE)]), 5)

# Build filter condition
condition <- FALSE
for(motif in topNMostVariableMotifs) {
  condition <- condition | DF$motif==motif
}

head(filteredDF)

# Apply filters
filteredDF <- DF[condition,]

ggplot(filteredDF, aes(x=motif, fill=motif, label=variable.percent)) +
  geom_bar()


library(class)
