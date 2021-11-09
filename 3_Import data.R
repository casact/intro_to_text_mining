
# Reading in Jane Austen books from janeaustenr package

austen_books()
tidy_books <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         # Divide into chapters by searching for instances of 'Chapter X'
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, text)
tidy_books





