library("data.table")
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("syuzhet")
library("ggplot2")
library("stringr")
library("sjmisc")

# Read the text file from local machine , choose file interactively
text <- readLines("yt_pre_debate_0053sep30_cleaned.txt")
#unused pattern, remove later
#pattern = "ago(.*)REPLY" 
commentlist <- str_split(text, "ago")[[1]]

length(commentlist)
# Load the data as a corpus
TextDoc <- Corpus(VectorSource(text))
#Replacing "/", "@" and "|" with space
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
TextDoc <- tm_map(TextDoc, toSpace, "/")
TextDoc <- tm_map(TextDoc, toSpace, "@")
TextDoc <- tm_map(TextDoc, toSpace, "\\|")
# Convert the text to lower case
TextDoc <- tm_map(TextDoc, content_transformer(tolower))
# Remove numbers
#TextDoc <- tm_map(TextDoc, removeNumbers)
# Remove english common stopwords
TextDoc <- tm_map(TextDoc, removeWords, stopwords("english"))
TextDoc <- tm_map(TextDoc, removeWords, c("repli", "ago", "hour", "minut","reply", "hours", "minutes","like", "’s", "just")) 



# Build a term-document matrix
TextDoc_dtm <- TermDocumentMatrix(TextDoc)
dtm_m <- as.matrix(TextDoc_dtm)
# Sort by descearing value of frequency
dtm_v <- sort(rowSums(dtm_m),decreasing=TRUE)
dtm_d <- data.frame(word = names(dtm_v),freq=dtm_v)
# Display the top 20 most frequent words
head(dtm_d, 20)
barplot(dtm_d[1:5,]$freq, las = 2, names.arg = dtm_d[1:5,]$word,
        col ="pink", main ="Top 5 most frequent words",
        ylab = "Word frequencies")
#generate word cloud
set.seed(1234)
wordcloud(words = dtm_d$word, freq = dtm_d$freq, min.freq = 5,
          max.words=100, random.order=FALSE, rot.per=0.40, 
          colors=brewer.pal(8, "Dark2"))

tr <- 0
bi <- 0
ne <- 0
for (comment in commentlist) {
  if (str_contains(comment, "tru")){
    print("about trump")
    tr <- tr+1
  }
  else if (str_contains(comment, "bid")){
    print("about biden")
    bi <- bi+1
  }
  else{
    print("about neither")
    ne <- ne+1
  }
  
}



d<-get_nrc_sentiment(text)
head (d,20)


#transpose
td<-data.frame(t(d))
#The function rowSums computes column sums across rows for each level of a grouping variable.
td_new <- data.frame(rowSums(td[2:253]))
#Transformation and cleaning
names(td_new)[1] <- "count"
td_new <- cbind("sentiment" = rownames(td_new), td_new)
rownames(td_new) <- NULL
td_new2<-td_new[1:8,]
#Plot One - count of words associated with each sentiment
quickplot(sentiment, data=td_new2, weight=count, geom="bar", fill=sentiment, ylab="count")+ggtitle("Survey sentiments")





# given a string vector and size of ngrams this function returns     word ngrams with corresponding frequencies
createNgram <-function(stringVector, ngramSize){
  
  ngram <- data.table()
  
  ng <- textcnt(stringVector, method = "string", n=ngramSize, tolower = FALSE)
  
  if(ngramSize==1){
    ngram <- data.table(w1 = names(ng), freq = unclass(ng), length=nchar(names(ng)))  
  }
  else {
    ngram <- data.table(w1w2 = names(ng), freq = unclass(ng), length=nchar(names(ng)))
  }
  return(ngram)
}
# Remove your own stop word
# specify your custom stopwords as a character vector
# Remove punctuations
#TextDoc <- tm_map(TextDoc, removePunctuation)
# Eliminate extra white spaces
#TextDoc <- tm_map(TextDoc, stripWhitespace)
# Text stemming - which reduces words to their root form
#TextDoc <- tm_map(TextDoc, stemDocument)
res <- createNgram(text, 3)
