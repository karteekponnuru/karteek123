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

testtt <- input[[1]]
testt1 <- input[[2]]
count_of_tweets_1 <- testt1$count
testtt_user <- testtt$user
testtt_metadata <- testtt$metadata

#TODO
 # 'entities',
 # 'geo',
 # 'coordinates',
 # 'place',
 # 'contributors',
 # 'is_quote_status',
 # 'possibly_sensitive',
 # 'retweeted_status',
 # 'extended_entities',
 # 'quoted_status_id',
 # 'quoted_status_id_str',
 # 'quoted_status'

Basic_Twitter_Metrics <- as.data.frame(matrix(0, nrow = count_of_tweets_1, ncol=57))
for(i in 1:nrow(Basic_Twitter_Metrics)){
    Basic_Twitter_Metrics[i,1] = testtt$created_at[i]
    Basic_Twitter_Metrics[i,2] = testtt$id[i]
    Basic_Twitter_Metrics[i,3] = testtt$id_str[i]
    Basic_Twitter_Metrics[i,4] = testtt$text[i]
    Basic_Twitter_Metrics[i,5] = testtt$truncated[i]
    Basic_Twitter_Metrics[i,6] = testtt$in_reply_to_status_id[i]
    Basic_Twitter_Metrics[i,7] = testtt$in_reply_to_status_id_str[i]
    Basic_Twitter_Metrics[i,8] = testtt$in_reply_to_user_id[i]
    Basic_Twitter_Metrics[i,9] = testtt$in_reply_to_user_id_str[i]
    Basic_Twitter_Metrics[i,10] = testtt$in_reply_to_screen_name[i]
    Basic_Twitter_Metrics[i,11] = testtt$source[i]

    #userdata
    Basic_Twitter_Metrics[i,12] = testtt_user$id[i]
    Basic_Twitter_Metrics[i,13] = testtt_user$id_str[i]
    Basic_Twitter_Metrics[i,14] = testtt_user$name[i]
    Basic_Twitter_Metrics[i,15] = testtt_user$screen_name[i]
    Basic_Twitter_Metrics[i,16] = testtt_user$location[i]
    Basic_Twitter_Metrics[i,17] = testtt_user$description[i]
    Basic_Twitter_Metrics[i,18] = testtt_user$url[i]
    Basic_Twitter_Metrics[i,19] = testtt_user$protected[i]
    Basic_Twitter_Metrics[i,20] = testtt_user$followers_count[i]
    Basic_Twitter_Metrics[i,21] = testtt_user$friends_count[i]
    Basic_Twitter_Metrics[i,22] = testtt_user$listed_count[i]
    Basic_Twitter_Metrics[i,23] = testtt_user$created_at[i]
    Basic_Twitter_Metrics[i,24] = testtt_user$favourites_count[i]
    Basic_Twitter_Metrics[i,25] = testtt_user$geo_enabled[i]
    Basic_Twitter_Metrics[i,26] = testtt_user$verified[i]
    Basic_Twitter_Metrics[i,27] = testtt_user$statuses_count[i]
    Basic_Twitter_Metrics[i,28] = testtt_user$lang[i]
    Basic_Twitter_Metrics[i,29] = testtt_user$contributors_enabled[i]
    Basic_Twitter_Metrics[i,30] = testtt_user$is_translator[i]
    Basic_Twitter_Metrics[i,31] = testtt_user$is_translation_enabled[i]
    Basic_Twitter_Metrics[i,32] = testtt_user$profile_background_color[i]
    Basic_Twitter_Metrics[i,33] = testtt_user$profile_background_image_url[i]
    Basic_Twitter_Metrics[i,34] = testtt_user$profile_background_image_url_https[i]
    Basic_Twitter_Metrics[i,35] = testtt_user$profile_background_tile[i]
    Basic_Twitter_Metrics[i,36] = testtt_user$profile_image_url[i]
    Basic_Twitter_Metrics[i,37] = testtt_user$profile_image_url_https[i]
    Basic_Twitter_Metrics[i,38] = testtt_user$profile_banner_url[i]
    Basic_Twitter_Metrics[i,39] = testtt_user$profile_link_color[i]
    Basic_Twitter_Metrics[i,40] = testtt_user$profile_sidebar_border_color[i]
    Basic_Twitter_Metrics[i,41] = testtt_user$profile_sidebar_fill_color[i]
    Basic_Twitter_Metrics[i,42] = testtt_user$profile_text_color[i]
    Basic_Twitter_Metrics[i,43] = testtt_user$profile_use_background_image[i]
    Basic_Twitter_Metrics[i,44] = testtt_user$has_extended_profile[i]
    Basic_Twitter_Metrics[i,45] = testtt_user$default_profile[i]
    Basic_Twitter_Metrics[i,46] = testtt_user$default_profile_image[i]
    Basic_Twitter_Metrics[i,47] = testtt_user$following[i]
    Basic_Twitter_Metrics[i,48] = testtt_user$follow_request_sent[i]
    Basic_Twitter_Metrics[i,49] = testtt_user$notifications[i]
    Basic_Twitter_Metrics[i,50] = testtt_user$translator_type[i]

    #metadata
    Basic_Twitter_Metrics[i,51] = testtt_metadata$iso_language_code[i]
    Basic_Twitter_Metrics[i,52] = testtt_metadata$result_type[i]

    #counts
    Basic_Twitter_Metrics[i,53] = testtt$retweet_count[i]
    Basic_Twitter_Metrics[i,54] = testtt$favorite_count[i]
    Basic_Twitter_Metrics[i,55] = testtt$favorited[i]
    Basic_Twitter_Metrics[i,56] = testtt$retweeted[i]

    #language
    Basic_Twitter_Metrics[i,57] = testtt$lang[i]
}

names(Basic_Twitter_Metrics) <- c("created_at","id","id_str","text","truncated","in_reply_to_status_id",
                                "in_reply_to_status_id_str","in_reply_to_user_id","in_reply_to_user_id_str",
                                "in_reply_to_screen_name","source", "user_id", "user_id_str", "user_name",
                                "user_screenn_name", "user_location", "user_description", "user_url", "user_protected",
                                "user_followers_count", "user_friends_count", "user_listed_count", "user_created_at",
                                "user_favourites_count", "user_geo_enabled", "user_verified", "user_statuses_count",
                                "user_lang", "user_contributors_enabled", "u_is_translator", "u_is_translation_enabled",
                                "u_profile_background_color","u_profile_background_image_url","u_profile_background_image_url_https",
                                "u_profile_background_tile","u_profile_image_url",
                                "u_profile_image_url_https","u_profile_banner_url","u_profile_link_color","u_profile_sidebar_border_color",
                                "u_profile_sidebar_fill_color","u_profile_text_color","u_profile_use_background_image",
                                "u_has_extended_profile","u_default_profile","u_default_profile_image",
                                "u_following", "u_follow_request_sent", "u_notifications", "u_translator_type",
                                "metadata_iso_language_code", "metadata_result_type", "retweet_count", "fav_count",
                                "favorited", "retweeted", "tweet_language")


Test <- as.data.frame(matrix(0, nrow(testtt), ncol=1))
for(i in 1:nrow(Basic_Twitter_Metrics)){
    Test[i,1] <- testtt$created_at[i]
}
names(Test)[1] <- "Score"

#....... Loading lexicon of positive and negative words (from Neal Caren) .......
lexicon = read.csv( 'C:\\Users\\vidyush.bakshi\\Desktop\\node-karteek_1\\lexicon.csv' , stringsAsFactors = F )

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
Twitter_Score_df_1 = Twitter_Score_df

write.csv(Twitter_Score_df, "C:\\Users\\vidyush.bakshi\\Desktop\\output\\complete_table.csv")
Twitter_Score_df_1 <- Twitter_Score_df[(Twitter_Score_df$Score > 0),c(1,5)]
write.csv(Twitter_Score_df_1, "C:\\Users\\vidyush.bakshi\\Desktop\\output\\positive_table.csv")
Twitter_Score_df_1 <- Twitter_Score_df[(Twitter_Score_df$Score < 0),c(1,5)]
write.csv(Twitter_Score_df_1, "C:\\Users\\vidyush.bakshi\\Desktop\\output\\negative_table.csv")
Twitter_Score_df_1 <- Twitter_Score_df[(Twitter_Score_df$Score == 0),c(1,5)]
write.csv(Twitter_Score_df_1, "C:\\Users\\vidyush.bakshi\\Desktop\\output\\neutral_table.csv")
Twitter_Score_df_1 <- table(Twitter_Score_df$user_location)
write.csv(Twitter_Score_df_1, "C:\\Users\\vidyush.bakshi\\Desktop\\output\\location_table.csv")

positive_score_percent = round( 100*length( which( Twitter_Score_df$Score > 0 ) )/total_rows, 2 )
neutral_score_percent = round( 100*length( which( Twitter_Score_df$Score == 0 ) )/total_rows, 2 )
negative_score_percent = round( 100*length( which( Twitter_Score_df$Score < 0 ) )/total_rows, 2 )



total_tweets <- nrow(Twitter_Score_df)
total_retweets <- sum(as.numeric(as.character(Twitter_Score_df$retweet_count)))
engagement_level <- total_retweets / total_tweets
total_favourites <- sum(as.numeric(as.character(Twitter_Score_df$fav_count)))
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
  #get rid of unnecessary spaces
  clean_tweet <- str_replace_all(clean_tweet," "," ")
  # Get rid of URLs
  clean_tweet = gsub("https://w+", "", clean_tweet)  
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