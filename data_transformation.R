# install packages
install.packages("dplyr")

# load library
library(dplyr)

# read csv file into Rstudio
imdb <- read.csv("imdb.csv", stringsAsFactors = F)
View(imdb)

#review data structure
glimpse(imdb)

# print head and tail of data
head(imdb, 10)
tail(imdb, 10)

# select columns
select(imdb, MOVIE_NAME, RATING)
select(imdb, 1, 5)

# rename head of columns
select(imdb, movie_name = MOVIE_NAME)

# pipe operator
imdb %>% 
  select(movie_name = MOVIE_NAME, released_year = YEAR) %>%
  head(10)

# filter data
filter(imdb, SCORE >= 9)
imdb %>% filter(SCORE >= 9)
 
names(imdb) <- tolower(names(imdb))

imdb %>% 
  select(movie_name, year, score) %>%
  filter(score == 8.8 | score == 8.3 | year == 2000)

imdb %>% 
  select(movie_name, length, score) %>%
  filter(score %in% c(8.3, 8.8, 9.0))

# filter string columns
imdb %>% 
  select(movie_name, genre, rating) %>%
  filter(grepl("Drama", imdb$genre))

imdb %>% 
  select(movie_name) %>%
  filter(grepl("The", imdb$movie_name))

# create new columns
imdb %>% 
  select(movie_name, score, length) %>%
  mutate(score_group = if_else(score >= 9, "High Rating", "Low Rating"),
         length_group = if_else(length >= 120, "Long Film", "Short Film"))

# replace columns
imdb %>%
  select(movie_name, score) %>%
  mutate(score = score + 0.1) %>%
  head(10)

# arrange data (sort data)
imdb %>%
  arrange(desc(length)) %>% # descending order
  head(10)

# sort multiple columns
imdb %>%
  filter(rating != "") %>%
  arrange(rating, length)

# summarise and group by
imdb %>%
  filter(rating != "") %>%
  group_by(rating) %>%
  summarise(mean_length = mean(length),
            sum_length = sum(length),
            sd_length = sd(length),
            min_length = min(length),
            max_length = max(length),
            n = n())

# joint data

favourite_film <- data.frame(id = c(5, 10, 25, 30, 98))

favourite_film %>%
  inner_join(imdb, by = c("id" = "no"))

# write csv file (export result)
imdb_prep <- imdb %>%
  select(movie_name, released_year = year, rating, length, score) %>%
  filter(rating == "R" & released_year > 2000) 

# export file
write.csv(imdb_prep, "imdb_prep.csv", row.names = F)





