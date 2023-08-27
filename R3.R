library(tidyverse)

# Tibbles ----------------------------------------------------------------------

# Note the difference between the two 
iris  # data.frame
tbl_iris <- as_tibble(iris)  # tibble

# Subsetting tibbles
iris[1, ]
iris[, 1]
iris[[1]]

# Subsetting tibbles
tbl_iris[1, ]
tbl_iris[, 1]
tbl_iris[, 1, drop = TRUE]
tbl_iris[[1]]

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

# Tidy data --------------------------------------------------------------------
library(EDAWR)
storms
as_tibble(storms)

cases  # wide format

pollution  # long format

# Using separate() and unite()
storms

# Using arrange()
storms

# Using rename()
storms

# Data wrangling ---------------------------------------------------------------
# 1. Extract columns via select()
# 2. Extract rows via filter() or slice()
# 3. Derive new variables/columns via mutate()
# 4. Change the unit of analysis via summarise()

# Select only a couple of variables/columns from dataset
storms

# Select and optionally rename

# Negative select

# Useful select functions
select(storms, wind:date)
select(storms, contains("orm"))
select(storms, starts_with("s"))
select(storms, ends_with("e"))
# etc.

# Filter based on logical tests
filter(storms, wind >= 50)
filter(storms, storm %in% c("Alberto", "Alex", "Allison"))
filter(storms, !is.na(wind))  # also look at drop_na()

# Slice takes a subset of the data frame based on integer locations
slice(storms, 1:3)
slice(storms, rep(1, 3))
which.min
which.max
# take a look as well at slice_min, slice_max, slice_head, slice_tail,
# slice_sample

# Creating new columns via mutate
# e.g. ratio = pressure / wind
# storms$ratio <- storms$pressure / storms$wind

# Useful mutate functions
mutate(storms, pmax = pmax(wind, 50))
mutate(storms, good_wind = between(wind, 0, 50))
mutate(storms, rn = row_number())
# etc.

# Summarising e.g. min, max, mean, median, 
pollution

# Pipelines --------------------------------------------------------------------
summarise(storms, mean = mean(wind))

# What about other arguments?
tibble(x = rnorm(100), y = rnorm(100)) %>%
  plot()
?lm
# The dot is a placeholder!

# nycflights
library(nycflights13)
flights

# How many flights to LAX did each of the legacy carriers (AA, UA, DL or US)
# have in May from JFK, and what was their average duration?


# Analyze all flights time gain (arr_delay - dep_delay) and summarise the
# minimum, maximum and mean gain.
flights 
  # Select all variables containing "delay" in their name

  # Create a new gain variable

  # Drop all rows with NA in them

  # Summarise


# Group wrangling --------------------------------------------------------------
# We can discover hidden information lying within groups

# Obtain sum, count, and mean of pollution for each city
pollution 

# ungroup()

# Multiple groups: Find the top 3 routes with the smallest departure delay in
# the `flights` dataset.
flights

# Joining data sets ------------------------------------------------------------

# Binding columns
x <- select(storms, 1:3)  # First 3 columns of storms
y <- select(storms, date)  # The last column of storms


# Binding rows
x <- storms[1:3, ]  # First 3 rows of storms
y <- storms[4:6, ]  # Last 3 rows of storms

# left_join
band_members
band_instruments








