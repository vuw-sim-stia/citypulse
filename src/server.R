library(shiny)
library(tm)
library(wordcloud)
library(twitteR)
library(networkD3)

shinyServer(function(input, output, session) {
  consumerKey <- "ftgzDp5zzkWipHWx7xNzwFpfZ"
  consumerSecret <- "hoEvgsaX7UUK5EiBLZiaMs9bIewgweQ4lMRqtOG9HxbgKACLAd"
  accessToken <- "15658907-UEtKKZCbwNloiiIVhjkO9vrD5AsJvWWT3K2SvO9zX"
  accessTokenSecret <- "IrGElw7BHX6ARGnrEAVMLtgaeq2X0iwJVHpgEGjUVotTZ"
  
  setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)
  
  vals <- reactiveValues()
  vals$lastId <- 0
  vals$vector_users <- vector()
  vals$vector_texts <- vector()
  vals$vector_time <- vector()
  vals$vector_id <- vector()
  
  observe({
    invalidateLater(60000,session)
    if(isolate(vals$lastId) > 0) tweets_result = searchTwitter("Wellington", n=20, resultType = "recent", lang='en', sinceID = isolate(vals$lastId))
    else tweets_result = searchTwitter("Wellington", n=20, resultType = "recent", lang='en')
    new <- 0
    for (tweet in tweets_result){
      if(new==0) vals$lastId <- tweet$id;
      vals$vector_users <- c(isolate(vals$vector_users), as.character(tweet$screenName));
      vals$vector_texts <- c(isolate(vals$vector_texts), as.character(tweet$text));
      vals$vector_time <- c(isolate(vals$vector_time), as.POSIXct(tweet$created));
      vals$vector_id <- c(isolate(vals$vector_id), as.character(tweet$id));
      new <- new + 1
    }
    tweets <- data.frame(isolate(vals$vector_users), isolate(vals$vector_time), isolate(vals$vector_id), isolate(vals$vector_texts))
    tweets <- tweets[order(-tweets$isolate.vals.vector_time.),]
    df_output <- tweets[,c(1,4)]
    output$tweets_table = renderDataTable({
      df_output
    })
  })
})