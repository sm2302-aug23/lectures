library(tidyverse)
theme_set(theme_bw())
library(palmerpenguins)

# A basic ggplot ---------------------------------------------------------------
penguins
plot(bill_length_mm ~ bill_depth_mm, penguins,
     main = "Bill depth and length",
     sub = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
     xlab = "Bill depth (mm)",
     ylab = "Bill length (mm)")


# Aesthetics -------------------------------------------------------------------
# 1. shape
# 2. colour
# 3. size
# 4. alpha


# Also note the difference between mapping and setting


# Faceting ---------------------------------------------------------------------
p <-
  ggplot(penguins, aes(bill_depth_mm, bill_length_mm)) + 
  geom_point(aes(col = species, shape = island), size = 3)

# facet_grid() -- A matrix of panels. Use when you have one or two discrete
# variables.

# facet_wrap() -- Instead of a matrix, wrap a sequence of panels into 2d.

# free scales





