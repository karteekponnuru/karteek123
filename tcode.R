needs(RCurl)
needs(stringr)
needs(ggplot2)
needs(treemap)
needs(ggthemes)
needs(ggmap)
needs(plotly)
needs(qdapDictionaries)
needs(tm)
needs(wordcloud)
needs(RColorBrewer)
needs(leaflet)
needs(dplyr)
needs(lexicon)
needs(plyr)

set.seed(512)

testtt <- input[[1]][[1]]

Basic_Twitter_Metrics <- as.data.frame(matrix(0, nrow(testtt), ncol=6))
for(i in 1:nrow(Basic_Twitter_Metrics)){
    Basic_Twitter_Metrics[i,1] <- testtt$created_at[i]#input[[1]][[1]][i,1]
    Basic_Twitter_Metrics[i,2] <- testtt$text[i]#input[[1]][[1]][i,4]
    Basic_Twitter_Metrics[i,3] <- testtt$retweet_count[i]#input[[1]][[1]][[14]][i,5] # We need to check why user: is coming as empty object in free API
    Basic_Twitter_Metrics[i,4] <- testtt$retweet_count[i]##input[[1]][[1]][i,21]
    Basic_Twitter_Metrics[i,5] <- testtt$favorite_count[i]#input[[1]][[1]][i,22]
    Basic_Twitter_Metrics[i,6] <- testtt$lang[i]#input[[1]][[1]][i,25]
}

names(Basic_Twitter_Metrics)[1:6] <- c("date", "text", "location", "retweet-count", "favorited-count", "lang")

Test <- as.data.frame(matrix(0, nrow(testtt), ncol=1))
for(i in 1:nrow(Basic_Twitter_Metrics)){
    Test[i,1] <- testtt$created_at[i]#input[[1]][[1]][i,1]
}
names(Test)[1] <- "Score"


#....... Loading lexicon of positive and negative words (from Neal Caren) .......
lexicon = read.csv( 'C:\\Users\\vidyush.bakshi\\Desktop\\node-karteek\\lexicon.csv' , stringsAsFactors = F )

#...... Function to check if there are any invalid multibyte string in a character vector ......
has.invalid.multibyte.string  <- function(x,return.elements=F){
  
  # determine if "invalid multibyte string" error will be triggered
  # if return.elements=T, then output is logical along x, otherwise single logical
  if (is.null(x))
    return(F)
  if (return.elements)
  {
    n <- length(x)
    out <- rep(F,n)
    for (i in 1:n)
      out[i] <- is.error(try(toupper(x[i]),silent = T))
  }
  else
    out <- is.error(try(toupper(x),silent = T))
  return(out)
}


is.error <- function(x){
  
  # test output of try()
  return(class(x)[1]=="try-error")
}

tweets_df = Basic_Twitter_Metrics


#....... Row indexes which has invalid multibyte stings .......
invalid_row_indexes = which( has.invalid.multibyte.string( tweets_df[,2], return.elements = T ) )

if( length( invalid_row_indexes ) > 0 ){
  final_tweets_df = tweets_df[ -invalid_row_indexes, ]
} else{ final_tweets_df = tweets_df }

positive_words = lexicon$word[ lexicon$polarity == 'positive' ]
negative_words = lexicon$word[ lexicon$polarity == 'negative' ]
negation_words = NULL


for(i in 1:nrow(tweets_df)){
# split into words. str_split is in the stringr package
   word.list = str_split(tweets_df$text[i], '\\s+')    
 
# sometimes a list() is one level of hierarchy too much
   words = unlist(word.list)
  
# compare our words to the dictionaries of positive & negative terms
   pos.matches = match(words, positive_words)
   neg.matches = match(words, negative_words)
 
# compare our words with list of negation words
  negation=match(words,negation.words) 
     
  # match() returns the position of the matched term or NA
  pos.matches = !is.na(pos.matches)
  neg.matches = !is.na(neg.matches)
  negation=!is.na(negation)

     
  # calculation of score
  score= sum(pos.matches)-sum(neg.matches)    

  # calculation for negation handling
  score1=score
  if(score<0){
    nscore=score1+sum(negation)
  }else{ 
    nscore=score1-sum(negation)
  }

    Test$Score[i] <- nscore
}

Test1 <- cbind(Test, Basic_Twitter_Metrics)

Twitter_Score_df <- Test1[ !duplicated( Test1$text ), ]
total_rows = nrow( Twitter_Score_df )


positive_score_percent = round( 100*length( which( Twitter_Score_df$Score > 0 ) )/total_rows, 2 )
neutral_score_percent = round( 100*length( which( Twitter_Score_df$Score == 0 ) )/total_rows, 2 )
negative_score_percent = round( 100*length( which( Twitter_Score_df$Score < 0 ) )/total_rows, 2 )



total_tweets <- nrow(Basic_Twitter_Metrics)
total_retweets <- sum(as.numeric(as.character(Basic_Twitter_Metrics$'retweet-count')))
engagement_level <- total_retweets / total_tweets
total_favourites <- sum(as.numeric(as.character(Basic_Twitter_Metrics$'favorited-count')))
fav_percentage <- (total_favourites / total_tweets ) * 100


#wordlcloud and cleaning

cc <-function(txt){
  clean_tweet = gsub("&amp", "", txt)
  clean_tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", clean_tweet)
  clean_tweet = gsub("@\\w+", "", clean_tweet)
  clean_tweet = gsub("[[:punct:]]", "", clean_tweet)
  clean_tweet = gsub("[[:digit:]]", "", clean_tweet)
  clean_tweet = gsub("http\\w+", "", clean_tweet)
  clean_tweet = gsub("[ \t]{2,}", "", clean_tweet)
  clean_tweet = gsub("^\\s+|\\s+$", "", clean_tweet) 
  #clean_tweet = gsub("")
  
  #get rid of unnecessary spaces
  clean_tweet <- str_replace_all(clean_tweet," "," ")
  #clean_tweet <- str_replace_all(clean_tweet, "[^[:alnum:]]", " ")
  # Get rid of URLs
  clean_tweet = gsub("https://w+", "", clean_tweet)  
  # remove links http
  #clean_tweet4 <- str_replace_all(clean_tweet3, "https://t.co/[a-z,A-Z,0-9]*","")
  #clean_tweet5 <- str_replace_all(clean_tweet4, "http://t.co/[a-z,A-Z,0-9]*","")
  # Take out retweet header, there is only one
  clean_tweet <- str_replace(clean_tweet,"RT @[a-z,A-Z]*: ","")
  # Get rid of hashtags
  clean_tweet <- str_replace_all(clean_tweet,"#[a-z,A-Z]*","")
  # Get rid of references to other screennames
  clean_tweet <- str_replace_all(clean_tweet,"@[a-z,A-Z]*","")  
  
  return(clean_tweet)
  
}

png("views/assets/images/wordclouds/wordcloud.png", width=1280,height=600)
a <- paste(Basic_Twitter_Metrics$text, collapse=" ")
b<-cc(a)
wordcloud(b , colors=brewer.pal(8, "Dark2"))
dev.off()

png("views/assets/images/wordclouds/Positive.png", width=1280,height=600)
a <- paste(Twitter_Score_df$text[(Twitter_Score_df$Score > 0)], collapse=" ")
b<-cc(a)
wordcloud(b , colors=brewer.pal(9,"BuGn"))
dev.off()

png("views/assets/images/wordclouds/Negative.png", width=1280,height=600)
a <- paste(Twitter_Score_df$text[(Twitter_Score_df$Score < 0)], collapse=" ")
b<-cc(a)
wordcloud(b , colors=brewer.pal(9,"OrRd"))
dev.off()

png("views/assets/images/wordclouds/Neutral.png", width=1280,height=600)
a <- paste(Twitter_Score_df$text[(Twitter_Score_df$Score == 0)], collapse=" ")
b<-cc(a)
wordcloud(b , colors=brewer.pal(9,"BuPu"))
dev.off()


abc <- c( total_tweets, total_retweets, engagement_level, total_favourites, fav_percentage, positive_score_percent, neutral_score_percent, negative_score_percent)

return(abc)