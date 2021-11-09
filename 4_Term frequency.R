
# Calculate the word frequency by novel and sort by most common words
book_words <- tidy_books %>%
  count(book, word, sort = TRUE)
book_words

# We saw common words that aren't very meaningful in analyzing text, like 'the'. We can remove a list of these "stop words"
data(stop_words)
stop_words

tidy_books <- tidy_books %>%
  anti_join(stop_words)

# Try term frequency again
book_words <- tidy_books %>%
  count(book, word, sort = TRUE)
book_words

book_words %>% filter(book == "Mansfield Park")
book_words %>% filter(book == "Emma")

# We can calculate the total number of words in each novel and join
total_words <- book_words %>% 
  group_by(book) %>% 
  summarize(total = sum(n))
book_words <- left_join(book_words, total_words)
book_words

# Now we can calculate the frequency of each word in each novel as a percentage
freq <- book_words %>% 
  group_by(book) %>% 
  mutate(term_frequency = n/total) %>%
  ungroup()
freq

# We can use bind_tf_idf to calculate the tf_idf, which will give a better measure of the importance of each word
book_tf_idf <- book_words %>%
  bind_tf_idf(word, book, n)
book_tf_idf


