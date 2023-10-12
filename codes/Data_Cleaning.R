# Required packages
install.packages(c("dplyr", "tidyr", "readr", "tm", "Matrix"))
library(dplyr)
library(tidyr)
library(readr)
library(tm)
library(Matrix)

# Load the CSV into a data frame
df <- read_csv('/Users/qbs/downloads/games.csv')

# Initial inspection
print(head(df))

# Define clean_price function
clean_price <- function(price) {
  ifelse(is.na(as.numeric(price)), NA, as.numeric(price))
}

df$Price <- sapply(df$Price, clean_price)

# Create price category
df <- df %>%
  mutate(Price_Category = cut(Price, breaks=c(-1, 0, 10, Inf), labels=c('Free', 'Low-cost', 'Expensive')))

# Only quantitative columns
df_quantitative <- df %>%
  select_if(is.numeric)

# Only qualitative columns
df_qualitative <- df %>%
  select_if(is.character)

print(head(df))

# Text vectorization
df <- df %>%
  filter(!is.na(Name))

corpus <- Corpus(VectorSource(df$Name))
dtm <- DocumentTermMatrix(corpus)
df_vectorized <- as.data.frame(as.matrix(dtm))
print(head(df_vectorized))

# Drop non-useable columns
columns_to_drop <- c('Reviews', 'Support url', 'Support email', 'Metacritic score',
                     'Metacritic url', 'User score', 'Score rank', 'Notes', 'Screenshots', 'Movies')
df <- df %>%
  select(-one_of(columns_to_drop))

# Handle missing values
df <- df %>%
  mutate(`About the game` = ifelse(is.na(`About the game`), 'No Description', `About the game`),
         `Supported languages` = ifelse(is.na(`Supported languages`), 'No Supported Languages', `Supported languages`),
         `Full audio languages` = ifelse(is.na(`Full audio languages`), 'No Audio Languages', `Full audio languages`),
         Website = ifelse(is.na(Website), 'No Websites', Website),
         Developers = ifelse(is.na(Developers), 'No Developers', Developers),
         Publishers = ifelse(is.na(Publishers), 'No Publishers', Publishers),
         Categories = ifelse(is.na(Categories), 'No Categories', Categories),
         Genres = ifelse(is.na(Genres), 'No Genres', Genres),
         Tags = ifelse(is.na(Tags), 'No Tags', Tags)) %>%
  drop_na()

print(head(df))