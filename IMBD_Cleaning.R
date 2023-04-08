# LOAD ALL THE NECESSARY LIBRARY
library(tidyverse)
library(readr)
library(visdat)
library(scales)
library(readxl)
library(lubridate)

# IMPORT DATA
Imbd_messy_data <- read_excel("~/Imbd_messy_data.xlsx")
View(Imbd_messy_data)

#LET'S TAKE A LOOK AT OUR DATA STRUCTURE
glimpse(Imbd_messy_data)

# UNITE ALL COLUMNS
Imbd_messy_data <- Imbd_messy_data %>% unite("united", `IMBD title ID;Original titlÊ;Release year;Genrë¨;Duration;Country;Content Rating;Director;;Income; Votes ;Score`, `...2`, `...3`, `...4`, `...5`)

# LET'S MAKE THE SEMICOLON CONSISTENT BY REPLACING DOUBLE SEMICOLON TO SINGLE SEMICOLON
Imbd_messy_data <- Imbd_messy_data %>%
mutate(united = str_replace_all(united, ";;", ";"))

# LET'S SEPERATE THEM BY THEIR COMMON DELIMITERS(;) AND ASSIGN TO THEM THEIR PROPER COLUMN NAMES
Imbd_messy_data <- Imbd_messy_data %>%
separate(united, into = c("IMBD_titleID", "Original_title", "Release_year", "Genre", "Duration", "Country", "Content_rating", "Director", "Income", "Votes", "Score"), sep = ";")

LET'S TAKE A GENERAL VIEW OF OUR DATASET
vis_dat(Imbd_messy_data)

LET'S SEE WHAT R SUGGEST OUR DATA CLASS SHOULD BE
vis_guess(Imbd_messy_data)

LET'S SEE WHAT COLUMS HAS MISSING VALUES
vis_miss(Imbd_messy_data)

# DROPPING EMPTY ROW
Imbd_messy_data <- Imbd_messy_data[-14,]

# I WOULD BE CLEANING THE COLUMNS ONE AFTER THE OTHER

1
# IMBD_TITLEID COLUMN
# CHECKING FOR THE NUMBER OF STRING
str_length(Imbd_messy_data)str_length(Imbd_messy_data$IMBD_titleID)

# SINCE OUR DATASET IS NOT MUCH WE CAN SEE THERE ARE NO STRINGS MORE THAN 9
# MAKING SURE THERE ARE NO DUPLICATES
sum(duplicated(Imbd_messy_data$IMBD_titleID))
# IMBD_TITLEID COLUMN IS IN IT'S CORRECT CLASS (CHARACTER)

2
# ORIGINAL_TITLE
# VIEW THE COLUMN
Imbd_messy_data$Original_title

# REPLACE TITLE NAME WITH A CORRECT ONE
# I KNEW THIS BECAUSE I WENT TO IMBD WEBSITE TO GO CONFIRM THE TITLE SINCE IT THEY HAVE ACCENTED LETTERS AND NOTICED TEHY WERE CORRECT AND JUST A LITTLE MISTAKE

Imbd_messy_data$Original_title <- ifelse(Imbd_messy_data$Original_title == "Per qualche dollaro in piÃ", "Per qualche dollaro in più",
ifelse(Imbd_messy_data$Original_title == "Le fabuleux destin d'AmÃ©lie Poulain", "Le fabuleux destin d'Amélie Poulain",
ifelse(Imbd_messy_data$Original_title == "WALLÂ·E", " WALL·E",
ifelse(Imbd_messy_data$Original_title == "LÃ©on", "Léon", Imbd_messy_data$Original_title))))

# REPLACING UNDERSCORE WITH COMMA
Imbd_messy_data$Original_title = str_replace_all(Imbd_messy_data$Original_title '_', ', ')
# ORIGINAL_TITLE IS IN ITS CORRECT CLASS (CHARACTER)

3
# RELEASE_YEAR
# VIEW THE COLUMN
Imbd_messy_data$Release_year

# CALL THE VARIOUS KINDS OF DATE FORMAT IT HAS IN ORDER TO BE ABLE TO SYNC THEM INTO A CONSISTENT FORMAT OF YYYY-MM-DD
parse_date_time(Imbd_messy_data$Release_year, c('Ymd', 'dmY', 'dby', 'dmy', 'mdy'))
Imbd_messy_data$Release_year = parse_date_time(Imbd_messy_data$Release_year, c('Ymd', 'dmY', 'dby', 'dmy', 'mdy'))
class(Imbd_messy_data$Release_year)

# FIXING THE MISSING DATA MANUALLY AFTER CHECKING IMBD SITE FOR THE IT
is.na(Imbd_messy_data$Release_year)
Imbd_messy_data$Release_year[70] <- ymd("1950-09-10")
Imbd_messy_data$Release_year[83] <- ymd("1983-12-09")
Imbd_messy_data$Release_year[84]<- ymd("1976-02-08")

# VIEWING THE CHANGES MADE
Imbd_messy_data$Release_year

# EXTRACTING YEAR
Imbd_messy_data$Release_year <- year(Imbd_messy_data$Release_year)

# CONFIRMING RELEASE_YEAR COLUMN IS ALREADY IN IT'S RIGHT CLASS (NUMERIC)
class(Imbd_messy_data$Release_year)

4
# GENRE
# CHANGING ALL underscore to comma
Imbd_messy_data$Genre = str_replace_all(Imbd_messy_data$Genre, "_", ", ")
# GENRE IS IN ITS RIGHT CLASS (CHARACTER)

5
# DURATION
# VIEWING THE COLUMN

# CONVERTING TO CLASS NUMERIC
Imbd_messy_data$Duration = as.numeric(Imbd_messy_data$Duration)

# CHECKING FOR THE NUMBERS OF MISSING VALUES
sum(is.na(Imbd_messy_data$Duration))
sum(is.infinite(Imbd_messy_data$Duration))

# FIXING THE MISSING OBSERVATIONS FROM THE IMBD WEBSITE
Imbd_messy_data$Duration [5] <- 154
Imbd_messy_data$Duration [7] <- 195
Imbd_messy_data$Duration [10] <- 139
Imbd_messy_data$Duration [12] <- 178
Imbd_messy_data$Duration [14] <- 136
Imbd_messy_data$Duration [16] <- 124
Imbd_messy_data$Duration [18] <- 133

6
# COUNTRY
# VIEWING THE COLUMN
Imbd_messy_data$Country

# CORRECTING THE COUNTRY NAMES
Imbd_messy_data$Country <- case_when(
grepl("US.|US", Imbd_messy_data$Country) ~ "USA",
grepl("West Germany", Imbd_messy_data$Country) ~ "Germany",
grepl("New Zeland|New Zesland", Imbd_messy_data$Country) ~ "New Zealand",
grepl("Italy1", Imbd_messy_data$Country) ~ "Italy", TRUE ~ Imbd_messy_data$Country)

# MAKING SURE IT HAS BEEN CORRECTED
Imbd_messy_data$Country
# COUNTRY COLUMN IS IN ITS RIGHT CLASS(CHARACTER)

7
# CONTENT_RATING
# VIEWING THE DATA
Imbd_messy_data$Content_rating

# CHANGING IT FROM ITS ABBREVIATED FORM TO ITS FULL FORM FOR THOSE WHO WOULD NOT KNOW THE MEANING
Imbd_messy_data$Content_rating <- ifelse(Imbd_messy_data$Content_rating == "G", "General Audience",
ifelse(Imbd_messy_data$Content_rating == "PG", "Parental Guidance Suggested",
ifelse(Imbd_messy_data$Content_rating == "PG-13", "Parents Strongly Cautioned",
ifelse(Imbd_messy_data$Content_rating == "R", "Restricted",
ifelse(Imbd_messy_data$Content_rating == "#N/A", "Others",
ifelse(Imbd_messy_data$Content_rating == "Unrated", "Not Rated",
ifelse(Imbd_messy_data$Content_rating == "Approved", "Others", Imbd_messy_data$Content_rating)))))))

# CONVERTING IT TO A FACTOR SINCE IT IS A CATEGORICAL DATA
Imbd_messy_data$Content_rating = as.factor(Imbd_messy_data$Content_rating)

# CHECKING FOR THE NUMBER OF LEVELS AND CHECKING THE LEVELS
nlevels(Imbd_messy_data$Content_rating)
levels(Imbd_messy_data$Content_rating)

# 8
# DIRECTOR
# VIEWING THE DATA
Imbd_messy_data$Director

# REPLACING 'Ã‰ric TO Eric AND REPLACING ALL UNDERSCORES TO COMMA FOR PLACES WHERE MORE THAT A DIRECTOR IS INVOLVED
Imbd_messy_data$Director = str_replace(Imbd_messy_data$Director, 'Ã‰ric Toledano', 'Eric Toledano')
Imbd_messy_data$Director = str_replace(Imbd_messy_data$Director, ' _', ', ')
# DIRECTOR COLUMN IS IN ITS RIGHT CLASS (CHARACTER)

# 9
# INCOME
# VIEWING THE DATA
Imbd_messy_data$Income

#REMOVE DOLLAR SIGN TO BE ABLE TO CONVERT TO NUMERIC
Imbd_messy_data$Income = parse_number(Imbd_messy_data$Income)

# ADDING FOR ROW 4 BECAUSE THE CONVERSION COMPROMISED ITS VALUE
Imbd_messy_data$Income_Usd [4] <-40835783

# RENAME TO income_usd TO INDICATE IT IS IN A DOLLAR CURRENCY
Imbd_messy_data <- Imbd_messy_data %>%
rename(Income_Usd = Income)

# 10
# VOTES
# VIEWING THE COLUMNS
Imbd_messy_data $Votes

# REMOVING THE DECIMAL POINT FROM THE VOTE COLUMN TO BE ABLE TO CONVERT TO A NUMERIC CLASS 
Imbd_messy_data $Votes <- gsub("\\.", "", Imbd_messy_data $Votes)
Imbd_messy_data $Votes = as.numeric(Imbd_messy_data $Votes)

# 11
# SCORE
# SEPERATING THEM TO BE ABLE TO EXTRACT ITS REAL VALUE
Imbd_messy_data <- Imbd_messy_data %>%
separate(Score, into = c('Score', 'Score1', 'Score2', 'Score3', 'Score4', 'Score5'), sep = '_NA')

# DELETING THE COLUMNS WITH THE NAs
Imbd_messy_data <- Imbd_messy_data[-c(12:16)]

# VIEWING THE SCORE COLUMN
Imbd_messy_data$Score

# REMOVING NON NUMERIC CHARACTER
Imbd_messy_data$Score <- gsub("[^0-9.]", "", Imbd_messy_data$Score)

# REMOVING DOUBLE DEIMAL POINTS
Imbd_messy_data$Score <- gsub("\\.\\.", ".", Imbd_messy_data$Score)

# REMOVING LEADING ZERO
Imbd_messy_data$Score <- sub("^0", "", Imbd_messy_data$Score)

# ADDING DECIMAL POINT TO THOSE WITHOUT DECIMAL POINT
Imbd_messy_data$Score <- ifelse(grepl("\\.", Imbd_messy_data$Score), Imbd_messy_data$Score, sub("(\\d)(\\d{1})", "\\1.\\2", Imbd_messy_data$Score))

REPLACING THE ROW WITH AN EXTRA DECIMAL POINT
Imbd_messy_data$Score <- str_replace(Imbd_messy_data$Score, '8.7.', '8.7')

# CONVERTING TO A NUMERIC DATA
Imbd_messy_data$Score <- as.numeric(Imbd_messy_data$Score)

# CHECKING TO SEE ALL CHANGES MADE
Imbd_messy_data$Score

# CHECKING TO CONFIRM IF OUR DATA DOES NOT CONTAIN ANY NULL VALUES
vis_miss(Imbd_messy_data)

# CHECKING TO CONFIRM IF OUR DATASET IS CLOSE TO WHAT R GUESSES IT TO BE
vis_guess(Imbd_messy_data)

# CHECKING OUR DATA STRUCTURE AND ITS SUMMARY
str(Imbd_messy_data)
summary(Imbd_messy_data)











