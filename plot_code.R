

# load packages

library(tidyverse)
library(readxl)

# load data

data <- read_excel("CFISD_Covid_App/raw_data/CFISD_Return_to_School_Data.xlsx",
                   sheet = "Sheet2")

# Marking Period 1 Plot
plot1 <- data %>%
  rename(Type = type) %>%
  ggplot(aes(x = perc_econ_dis,
             y = mp1_perc_oncampus,
             size = enrollment,
             color = Type)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "grey15", se = FALSE) +
  labs(title = "Wealthier Schools Had More of their Students Opting to Learn In-Person",
       subtitle = "There was a strong negative correlation in Marking Period 1",
       x = "Percentage of Students Who are Economically Disadvantaged",
       y = "Percentage of Students Choosing In-Person School",
       caption = "Source: Cypress-Fairbanks ISD") +
  theme_classic() 

mp1_plot <- plot1 + scale_size(guide = 'none')



# Marking Period 2 Plot
plot2 <- data %>%
  rename(Type = type) %>%
  ggplot(aes(x = perc_econ_dis,
             y = mp2_perc_oncampus,
             size = enrollment,
             color = Type)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "grey15", se = FALSE) +
  labs(title = "Wealthier Schools Had More of their Students Opting to Learn In-Person",
       subtitle = "Correlation is Less Steep than Before, but Still Negative in Marking Period 2",
       x = "Percentage of Students Who are Economically Disadvantaged",
       y = "Percentage of Students Choosing In-Person School",
       caption = "Source: Cypress-Fairbanks ISD") +
  theme(legend.position = "none") +
  theme_classic() 

mp2_plot <- plot2 + scale_size(guide = 'none')


# Marking Period 3 Plot
plot3 <- data %>%
  rename(Type = type) %>%
  ggplot(aes(x = perc_econ_dis,
             y = mp3_perc_oncampus,
             size = enrollment,
             color = Type)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "grey15", se = FALSE) +
  labs(title = "Elementary Schools Now Have Largest Portions of Students In-Person",
       subtitle = "This Trend Applies Across the Range of Economic Opportunity",
       x = "Percentage of Students Who are Economically Disadvantaged",
       y = "Percentage of Students Choosing In-Person School",
       caption = "Source: Cypress-Fairbanks ISD") +
  theme_classic() 

mp3_plot <- plot3 + scale_size(guide = 'none')


# Marking Period 4 Plot
plot4 <- data %>%
  rename(Type = type) %>%
  ggplot(aes(x = perc_econ_dis,
             y = mp4_perc_oncampus,
             size = enrollment,
             color = Type)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "grey15", se = FALSE) +
  labs(title = "More Students Across Grade Levels Opted for In Person School",
       subtitle = "Elementary Schools Continue to See Largest Rates On Campus in Marking Period 4",
       x = "Percentage of Students Who are Economically Disadvantaged",
       y = "Percentage of Students Choosing In-Person School",
       caption = "Source: Cypress-Fairbanks ISD") +
  theme_classic() 

mp4_plot <- plot4 + scale_size(guide = 'none')

