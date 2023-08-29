library(tidyverse)
library(EDAWR)

# Tibbles ----------------------------------------------------------------------

# Note the difference between the two 
iris  # data.frame
tbl_iris <- as_tibble(iris)  # tibble
View(tbl_iris)

# Subsetting data frame
iris[1, ]  # first row
iris[, 1]  # first column
iris[[1]]  # first column

# Subsetting tibbles
tbl_iris[1, ]  # same as data frames
tbl_iris[, 1]  # there is a difference
tbl_iris[, 1, drop = TRUE]
tbl_iris[[1]]  # same as data frames

# Partial matching
iris$Sp
tbl_iris$Sp

# stringsAsFactors = FALSE
d <- data.frame(
  x = 1:3,
  y = c("A", "B", "C"),
  z = factor(c("X", "Y", "Z")),
  stringsAsFactors = TRUE  # previously default to TRUE prior to R < 4.0
)

# Length coercion
data.frame(x = 1:4, y = 1)
data.frame(x = 1:4, y = 1:2)

tibble(x = 1:4, y = 1)  # only allowed if length 1
tibble(x = 1:4, y = 1:2)
tibble(x = 1:4, y = rep(1:2, 2))


# Tidy data --------------------------------------------------------------------
library(EDAWR)
storms
as_tibble(storms)

cases  # wide format
pivot_longer(cases, c("2011", "2012", "2013"),
             names_to = "year",
             values_to = "count")

pollution  # long format
pivot_wider(data = pollution,
            id_cols = "city",
            names_from = "size",
            values_from = "amount")

# Using separate() and unite()
storms
storms2 <- 
  separate(storms, date, sep = "-", 
           into = c("year", "month", "day"),)

unite(storms2, col = "date", "year", "month", "day", sep = "-")

# Using arrange()
# For sorting the rows in order
arrange(storms, wind)
arrange(storms, storm)
arrange(storms, desc(pressure))
arrange(storms, -pressure)  # i don't usually do this

# Using rename()
storms
storms <- rename(storms, WIND = wind)


# Data wrangling ---------------------------------------------------------------
# 1. Extract columns via select()
# 2. Extract rows via filter() or slice()
# 3. Derive new variables/columns via mutate()
# 4. Change the unit of analysis via summarise()

# Select only a couple of variables/columns from dataset
storms
select(storms, storm, wind)
select(storms, date)
select(storms, 3)

# Select and optionally rename
select(storms, name = storm, everything())  # like renaming column


# Negative select
select(storms, -date)


# Useful select functions
select(storms, wind:date)
select(storms, contains("orm"))
select(storms, starts_with("s"))
select(storms, ends_with("e"))
# etc.

# Filter based on logical tests
filter(storms, wind < 50)
filter(storms, storm %in% c("Alberto", "Alex", "Allison"))
storms$wind[2] <- 45
filter(storms, !is.na(wind))  # also look at drop_na()

# Slice takes a subset of the data frame based on integer locations
slice(storms, 1:3)
slice(storms, rep(1, 3))
slice_min(storms, wind)
slice_max(storms, date)

# take a look as well at slice_min, slice_max, slice_head, slice_tail,
# slice_sample

# Creating new columns via mutate
# e.g. ratio = pressure / wind
storms$ratio <- storms$pressure / storms$wind
mutate(storms, 
       ratio = pressure / wind,
       inverse = 1 / ratio,
       test = "a")

# Useful mutate functions
mutate(storms, pmax = pmax(wind, 50))
mutate(storms, good_wind = between(wind, 0, 50))
mutate(storms, rn = row_number())
# etc.

# Summarising e.g. min, max, mean, median, 
pollution

summarise(storms, mean = mean(wind))  # average wind speed
summarise(storms, 
          sd = sd(wind),
          sum = sum(pressure),
          n = n())  # average wind speed

# Pipelines --------------------------------------------------------------------

summarise(storms, mean = mean(wind))  # nested function

storms %>%
  summarise(mean = mean(wind))

# What about other arguments?
dat <- tibble(x = rnorm(100), y = rnorm(100))
dat %>% 
  plot()
dat %>%
  lm(y ~ x)  # equivalent to lm(dat, y ~ x)
dat %>%
  lm(formula = y ~ x, data = .)

dat %>%
  .$x
dat$x

# The dot is a placeholder!

# nycflights
library(nycflights13)
flights

# How many flights to LAX did each of the legacy carriers (AA, UA, DL or US)
# have in May from JFK, and what was their average duration?
flights %>%
  filter(dest == "LAX") %>%
  # filter(origin == "JFK") %>%
  filter(carrier %in% c("AA", "UA", "DL", "US")) %>%
  filter(month == 5) %>%
  select(carrier, month, origin, dest, air_time) %>%
  group_by(origin) %>%
  summarise(
    count = n(),
    avg_dur = mean(air_time, na.rm = TRUE)
  )

# Analyze all flights time gain (arr_delay - dep_delay) and summarise the
# minimum, maximum and mean gain.
flights %>%
  # Select all variables containing "delay" in their name
  select(contains("delay")) %>%
  # Create a new gain variable
  mutate(gain = arr_delay - dep_delay) %>%
  # Drop all rows with NA in them
  # filter(!is.na(gain)) %>%
  drop_na() %>%
  # Summarise
  summarise(min = min(gain),
            max = max(gain),
            mean = mean(gain))

# Group wrangling --------------------------------------------------------------
# We can discover hidden information lying within groups

# Obtain sum, count, and mean of pollution for each city
pollution %>%
  group_by(city) %>%
  summarise(sum = sum(amount),
            count = n(),
            mean = mean(amount))

# ungroup()


# Multiple groups: Find the top 3 routes with the smallest departure delay in
# the `flights` dataset.
flights %>%
  group_by(origin, dest) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  arrange(dep_delay) %>%
  print(n = 3)
  select(origin, dest, dep_delay)

  flights %>%
    group_by(origin, dest) %>%
    summarise(min_delay = min(dep_delay)) %>%
    arrange(min_delay) %>%
    print(n = 3)  
  
# Joining data sets ------------------------------------------------------------

# Binding columns
x <- select(storms, 1:3)  # First 3 columns of storms
y <- select(storms, date)  # The last column of storms
y[] <- rnorm(6)
names(y) <- "random"
bind_cols(storms, y)

# Binding rows
x <- storms[1:3, ]  # First 3 rows of storms
y <- storms[4:6, ]  # Last 3 rows of storms
bind_rows(x, y)
y <-
  y %>%
  rename(DATE = date)


# left_join
band_members
band_instruments

left_join(band_members, band_instruments,
          by = "name")







