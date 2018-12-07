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
needs(jsonlite)


set.seed(512)

testtt <- input[[1]]
testt1 <- input[[2]]
#count_of_tweets_1 <- testt1$count
count_of_tweets_1 <- nrow(testtt)
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

Basic_Twitter_Metrics <- as.data.frame(matrix(0, nrow = count_of_tweets_1, ncol=65))

write.csv(count_of_tweets_1, "C://users//vidyush.bakshi//Desktop//abcabc.csv")

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
                                "favorited", "retweeted", "tweet_language", "Score", "Day", "Month", "Date", "Time", "sec", 
                                "Year", "Date_full")


for(i in 1:nrow(Basic_Twitter_Metrics)){
  abc1 <- strsplit(Basic_Twitter_Metrics$created_at[i], " ")
  Basic_Twitter_Metrics$Day[i] <- abc1[[1]][1]
  Basic_Twitter_Metrics$Month[i] <- abc1[[1]][2]
  Basic_Twitter_Metrics$Date[i] <- abc1[[1]][3]
  Basic_Twitter_Metrics$Time[i] <- abc1[[1]][4]
  Basic_Twitter_Metrics$sec[i] <- abc1[[1]][5]
  Basic_Twitter_Metrics$Year[i] <- abc1[[1]][6]
  Basic_Twitter_Metrics$Date_full[i] <- paste0(Basic_Twitter_Metrics$Date[i],Basic_Twitter_Metrics$Month[i],Basic_Twitter_Metrics$Year[i])
}

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

    Basic_Twitter_Metrics$Score[i] <- nscore
}

#Twitter_Score_df <- Basic_Twitter_Metrics[ !duplicated( Basic_Twitter_Metrics$text ), ]
#total_rows = nrow( Twitter_Score_df )
total_rows = nrow( Basic_Twitter_Metrics )
#Twitter_Score_df_1 = Twitter_Score_df[complete.cases(Twitter_Score_df), ]

#positive_score_percent = round( 100*length( which( Twitter_Score_df$Score > 0 ) )/total_rows, 2 )
#neutral_score_percent = round( 100*length( which( Twitter_Score_df$Score == 0 ) )/total_rows, 2 )
#negative_score_percent = round( 100*length( which( Twitter_Score_df$Score < 0 ) )/total_rows, 2 )
positive_score_percent = round( 100*length( which( Basic_Twitter_Metrics$Score > 0 ) )/total_rows, 2 )
neutral_score_percent = round( 100*length( which( Basic_Twitter_Metrics$Score == 0 ) )/total_rows, 2 )
negative_score_percent = round( 100*length( which( Basic_Twitter_Metrics$Score < 0 ) )/total_rows, 2 )


#total_tweets <- nrow(Twitter_Score_df)
#total_retweets <- sum(as.numeric(as.character(Twitter_Score_df$retweet_count)), na.rm=TRUE)
#engagement_level <- total_retweets / total_tweets
#total_favourites <- sum(as.numeric(as.character(Twitter_Score_df$fav_count)), na.rm=TRUE)
#fav_percentage <- (total_favourites / total_tweets ) * 100
total_tweets <- nrow(Basic_Twitter_Metrics)
total_retweets <- sum(as.numeric(as.character(Basic_Twitter_Metrics$retweet_count)), na.rm=TRUE)
engagement_level <- total_retweets / total_tweets
total_favourites <- sum(as.numeric(as.character(Basic_Twitter_Metrics$fav_count)), na.rm=TRUE)
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

png("views/assets/images/wordclouds/wordcloud.png", width=500,height=500,bg=NA)
a <- paste(Basic_Twitter_Metrics$text, collapse=" ")
b<-cc(a)
wordcloud(b , colors=brewer.pal(8, "Dark2"))
dev.off()

png("views/assets/images/wordclouds/Positive.png", width=500,height=500,bg=NA)
a <- paste(Basic_Twitter_Metrics$text[(Basic_Twitter_Metrics$Score > 0)], collapse=" ")
#a <- paste(Twitter_Score_df$text[(Twitter_Score_df$Score > 0)], collapse=" ")
b<-cc(a)
wordcloud(b , colors=brewer.pal(9,"BuGn"))
dev.off()

png("views/assets/images/wordclouds/Negative.png",width=500,height=500,bg=NA)
a <- paste(Basic_Twitter_Metrics$text[(Basic_Twitter_Metrics$Score < 0)], collapse=" ")
#a <- paste(Twitter_Score_df$text[(Twitter_Score_df$Score < 0)], collapse=" ")
b<-cc(a)
wordcloud(b , colors=brewer.pal(9,"OrRd"))
dev.off()

png("views/assets/images/wordclouds/Neutral.png",width=500,height=500,bg=NA)
a <- paste(Basic_Twitter_Metrics$text[(Basic_Twitter_Metrics$Score == 0)], collapse=" ")
#a <- paste(Twitter_Score_df$text[(Twitter_Score_df$Score == 0)], collapse=" ")
b<-cc(a)
wordcloud(b , colors=brewer.pal(9,"BuPu"))
dev.off()

abc <- c( total_tweets, total_retweets, engagement_level, total_favourites, fav_percentage, positive_score_percent, neutral_score_percent, negative_score_percent)
abc1 <- as.data.frame(matrix(0, nrow = 1, ncol = 8))
abc1[1,1] = total_tweets
abc1[1,2] = total_retweets
abc1[1,3] = engagement_level
abc1[1,4] = total_favourites
abc1[1,5] = fav_percentage
abc1[1,6] = positive_score_percent
abc1[1,7] = neutral_score_percent
abc1[1,8] = negative_score_percent
names(abc1) <- c("total_tweets", "total_retweets", "engagement_level", "total_fav", "fav_per", "pos", "neu", "neg")

#remove all the files in the directory beforehand
file.remove(file.path("C://users//vidyush.bakshi//Desktop//data", list.files("C://users//vidyush.bakshi//Desktop//data"))) 

#Save the overall tweet count in the json file
write_json(abc1, paste0("C://users//vidyush.bakshi//Desktop//data//tweet_count.json"))

#Save overall data with scores
write_json(Basic_Twitter_Metrics, "C://users//vidyush.bakshi//Desktop//data//overall_data.json")

#Finding otu unique dates in the data
unique_dates <- unique(Basic_Twitter_Metrics$Date_full)

#Save up the unique dates in json
write_json(unique_dates, "C://users//vidyush.bakshi//Desktop//data//unique_dates.json")

#Save data for graph with unique dates and the count of tweets as per dates
tweet_count_u <- as.data.frame(matrix(0, nrow = length(unique_dates), ncol = 12));
for(i in 1:length(unique_dates)){
    Basic_Twitter_Metrics_u <- Basic_Twitter_Metrics[(Basic_Twitter_Metrics$Date_full == unique_dates[i]),]

    tweet_count_u[i,1] <- unique_dates[i]
    tweet_count_u[i,2] <- as.numeric(unique(Basic_Twitter_Metrics_u$Year))
    if(unique(Basic_Twitter_Metrics_u$Month)=='Dec'){
      tweet_count_u[i,3] = 12;
    }else { 
      tweet_count_u[i,3] = 11;
    }
    
    tweet_count_u[i,4] <- as.numeric(unique(Basic_Twitter_Metrics_u$Date))
    tweet_count_u[i,5] <- nrow(Basic_Twitter_Metrics_u)
    tweet_count_u[i,6] <- sum(as.numeric(as.character(Basic_Twitter_Metrics_u$retweet_count)), na.rm=TRUE)
    tweet_count_u[i,7] <- total_retweets / total_tweets
    tweet_count_u[i,8] <- sum(as.numeric(as.character(Basic_Twitter_Metrics_u$fav_count)), na.rm=TRUE)
    tweet_count_u[i,9] <- (total_favourites / total_tweets ) * 100

    Basic_Twitter_Metrics_u_pos = Basic_Twitter_Metrics_u[(Basic_Twitter_Metrics_u$Score > 0),]
    Basic_Twitter_Metrics_u_neu = Basic_Twitter_Metrics_u[(Basic_Twitter_Metrics_u$Score == 0),]
    Basic_Twitter_Metrics_u_neg = Basic_Twitter_Metrics_u[(Basic_Twitter_Metrics_u$Score < 0),]
    tweet_count_u[i,10] <- nrow(Basic_Twitter_Metrics_u_pos)
    tweet_count_u[i,11] <- 0
    tweet_count_u[i,12] <- nrow(Basic_Twitter_Metrics_u_neg)
}
write_json(tweet_count_u, paste0("C://users//vidyush.bakshi//Desktop//data//tweet_count_datewise.json"))

#
if(length(unique_dates) == 1){
  write_json(Basic_Twitter_Metrics, paste0("C://users//vidyush.bakshi//Desktop//data//", unique_dates, ".json"))
}else{
  for(i in 1:length(unique_dates)){
    Basic_Twitter_Metrics_1 <- Basic_Twitter_Metrics[(Basic_Twitter_Metrics$Date_full == unique_dates[i]),]
    write_json(Basic_Twitter_Metrics_1, paste0("C://users//vidyush.bakshi//Desktop//data//", unique_dates[i], ".json"))
  }
}

#Save all negative data
Basic_Twitter_Metrics_1 <- Basic_Twitter_Metrics[(Basic_Twitter_Metrics$Score < 0),]
write_json(Basic_Twitter_Metrics_1, "C://users//vidyush.bakshi//Desktop//data//all_neg.json")

unique_dates <- unique(Basic_Twitter_Metrics_1$Date_full)

if(length(unique_dates) == 1){
  write_json(Basic_Twitter_Metrics_1, paste0("C://users//vidyush.bakshi//Desktop//data//", unique_dates, "_neg.json"))
}else{
  for(i in 1:length(unique_dates)){
    Basic_Twitter_Metrics_2 <- Basic_Twitter_Metrics_1[(Basic_Twitter_Metrics_1$Date_full == unique_dates[i]),]
    write_json(Basic_Twitter_Metrics_2, paste0("C://users//vidyush.bakshi//Desktop//data//", unique_dates[i], "_neg.json"))
  }
}


#Save all positive data
Basic_Twitter_Metrics_1 <- Basic_Twitter_Metrics[(Basic_Twitter_Metrics$Score > 0),]
write_json(Basic_Twitter_Metrics_1, "C://users//vidyush.bakshi//Desktop//data//all_pos.json")


unique_dates <- unique(Basic_Twitter_Metrics_1$Date_full)

if(length(unique_dates) == 1){
  write_json(Basic_Twitter_Metrics_1, paste0("C://users//vidyush.bakshi//Desktop//data//", unique_dates, "_pos.json"))
}else{
  for(i in 1:length(unique_dates)){
    Basic_Twitter_Metrics_2 <- Basic_Twitter_Metrics_1[(Basic_Twitter_Metrics_1$Date_full == unique_dates[i]),]
    write_json(Basic_Twitter_Metrics_2, paste0("C://users//vidyush.bakshi//Desktop//data//", unique_dates[i], "_pos.json"))
  }
}

#Save all neutral data
Basic_Twitter_Metrics_1 <- Basic_Twitter_Metrics[(Basic_Twitter_Metrics$Score == 0),]
write_json(Basic_Twitter_Metrics_1, "C://users//vidyush.bakshi//Desktop//data//all_neu.json")


unique_dates <- unique(Basic_Twitter_Metrics_1$Date_full)

if(length(unique_dates) == 1){
  write_json(Basic_Twitter_Metrics_1, paste0("C://users//vidyush.bakshi//Desktop//data//", unique_dates, "_neu.json"))
}else{
  for(i in 1:length(unique_dates)){
    Basic_Twitter_Metrics_2 <- Basic_Twitter_Metrics_1[(Basic_Twitter_Metrics_1$Date_full == unique_dates[i]),]
    write_json(Basic_Twitter_Metrics_2, paste0("C://users//vidyush.bakshi//Desktop//data//", unique_dates[i], "_neu.json"))
  }
}

return(abc)