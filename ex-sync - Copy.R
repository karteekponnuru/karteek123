needs(RCurl)
needs(stringr)
needs(ggplot2)
needs(treemap)
needs(ggthemes)
needs(ggmap)
needs(plotly)
needs(qdapDictionaries)
needs(tm)
#needs(twordcloudm)
needs(leaflet)
needs(dplyr)
needs(lexicon)
#needs(rjson)
needs(plyr)
needs(jsonlite)
set.seed(512)

Basic_Twitter_Metrics <- input[[1]]

names(Basic_Twitter_Metrics)[1:6] <- c("date", "text", "location", "retweet-count", "favorited-count", "lang")
Test <- input[[1]]
names(Test)[1:6] <- c("date", "text", "location", "retweet-count", "favorited-count", "lang")
Test <- Test$location
names(Test) <- "Score"

#....... Loading lexicon of positive and negative words (from Neal Caren) .......
lexicon = read.csv( 'C:\\Users\\vidyush.bakshi\\Desktop\\Sentiment_Analysis\\lexicon.csv' , stringsAsFactors = F )

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
invalid_row_indexes = which( has.invalid.multibyte.string( tweets_df$text, return.elements = T ) )

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



abc <- c(nrow(Basic_Twitter_Metrics),positive_score_percent, neutral_score_percent, negative_score_percent)
return(abc)