
#### Vector ####

# Setting up a simple example dataset
text_df <- data.frame(doc=c(1, 2, 3),
                              text=c("Welcome to the annual meeting",
                                     "In this session we are covering text mining",
                                     "By the end you'll be familiar with the basics of the tidytext package")
                              )
text_df

# Our text is a vector
text_df$text


#### Corpus ####

# We can convert our text vector to a corpus using functions from the tm package
text_corpus <- VCorpus(VectorSource(text_df$text))
text_corpus
text_corpus[[1]] # View first document
text_corpus[[1]]$meta # View metadata for first document
text_corpus[[1]]$content # View content for first document

# An example corpus of Reuters news articles from the tm package
data(acq)
acq
acq[[1]]$meta
acq[[1]]$content

# We can apply functions to documents within a corpus to clean up the text for analysis:
acq_lower <- tm_map(acq, content_transformer(tolower))
# Compare first document before and after
acq[[1]]$content
acq_lower[[1]]$content


#### DTM ####

# Convert our corpus into a DTM
text_dtm <- DocumentTermMatrix(text_corpus)
inspect(text_dtm)


#### Tidy ####

# Convert our dataframe into a tidy data frame
?unnest_tokens
text_tidy <- text_df %>%
  unnest_tokens(word, text)
text_tidy


#### Converting between formats ####

# Above we showed vector->corpus, corpus->DTM, vector->tidy

# To convert from corpus -> vector/dataframe we can use the tidy function
text_corpus_df <- text_corpus %>%
  tidy()
text_corpus_df
# Since we now have metadata that we don't need for now, we can remove. Also, convert to dataframe instead of tibble
text_corpus_df <- text_corpus_df %>%
  select(id, text) %>%
  as.data.frame
text_corpus_df
# We can now convert this to tidytext (so for corpus -> tidy, we do corpus -> df -> tidy)
text_corpus_tidy <- text_corpus_df %>%
  unnest_tokens(word, text)
text_corpus_tidy

# To convert from tidy->DTM, we need to first summarize the tidytext data
text_summarized <- text_tidy %>%
  count(doc, word, sort = TRUE)
text_summarized
text_tidy_dtm <- text_summarized %>%
  cast_dtm(document=doc, term=word, value=n)
inspect(text_tidy_dtm)

# To convert from DTM->tidy, we can again use the tidy function
text_dtm_tidy <- tidy(text_dtm)
text_dtm_tidy




