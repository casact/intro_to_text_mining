
# Tidytext includes multiple sentiment dictionaries. We'll use the AFINN, which scores sentiment on -5 (negative) to +5 (positive)

afinn <- get_sentiments("afinn")


# Now, we will attach sentiments using inner_join (words with no sentiment in the dictionary would be dropped)
jane_austen_sentiment <- tidy_books %>% 
  inner_join(afinn)
jane_austen_sentiment

#Summarize to 80 line chunks
jane_austen_sentiment_summarized <- jane_austen_sentiment %>% 
  group_by(book, index = linenumber %/% 80) %>% 
  summarise(sentiment = sum(value))
jane_austen_sentiment_summarized

# Now we can plot sentiment score chronologically across the novels
ggplot(jane_austen_sentiment_summarized, aes(index, sentiment, fill = book)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~book, ncol = 2, scales = "free_x")

