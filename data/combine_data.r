
library(tidyverse)
library(rvest)

janssen <- read_csv("data/janssen.csv") %>%
  rename(
    first_dose = "1st Dose Allocations",
    # second_dose = "2nd Dose Allocations",
    week = "Week of Allocations",
    jurisdiction = "Jurisdiction"
  )
moderna <- read_csv("data/moderna.csv") %>%
  rename(
    first_dose = "1st Dose Allocations",
    second_dose = "2nd Dose Allocations",
    week = "Week of Allocations",
    jurisdiction = "Jurisdiction"
  )
pfizer <- read_csv("data/pfizer.csv") %>%
  rename(
    first_dose = "1st Dose Allocations",
    second_dose = "2nd Dose Allocations",
    week = "Week of Allocations",
    jurisdiction = "Jurisdiction"
  )

janssen_second_dose <- janssen %>%
  mutate(second_dose = 0)

vaccines <- rbind(janssen_second_dose, moderna, pfizer)

vaccines <- vaccines %>%
  mutate(week = as.Date(week, "%m/%d/%y"))

write_csv(vaccines, "data/vaccines.csv")

