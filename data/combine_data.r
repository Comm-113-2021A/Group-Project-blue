
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

janssen_second_dose <- janssen_second_dose %>%
  mutate(vaccine = "janssen")

pfizer <- pfizer %>%
  mutate(vaccine = "pfizer")

moderna <- moderna %>%
  mutate(vaccine = "moderna")

vaccines <- rbind(janssen_second_dose, moderna, pfizer)

vaccines <- vaccines %>%
  mutate(week = as.Date(week, "%m/%d/%y"))

write_csv(vaccines, "data/vaccines.csv")



# ----------- demographic -------------------------

demographic <- read_csv("data/demographic.csv")


#-------------join df --------------
library(janitor)
demographic <- demographic %>%
  select(Location, White, Black, Asian, Hispanic) %>%
  janitor::clean_names()

vaccines <- vaccines %>%
  rename(location = "jurisdiction")
vaccine_demographic <- left_join(vaccines, demographic, by = "location") %>%
  na.omit()

vaccine_demographic$asian <- lapply(vaccine_demographic$asian, function(x) as.numeric(as.character(x)))

vaccine_demographic <- vaccine_demographic %>%
  mutate(asian = as.numeric(asian))


