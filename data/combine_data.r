
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
  janitor::clean_names() %>%
  rename(
    white_prop = white,
    black_prop = black,
    asian_prop = asian,
    hispanic_prop = hispanic
  )

vaccines <- vaccines %>%
  rename(location = "jurisdiction")
vaccine_demographic <- left_join(vaccines, demographic, by = "location") %>%
  na.omit()

vaccine_demographic$asian_prop <- lapply(vaccine_demographic$asian_prop, function(x) as.numeric(as.character(x)))

vaccine_demographic <- vaccine_demographic %>%
  mutate(asian_prop = if_else(is.na(asian_prop), 0, as.numeric(asian_prop)))




write_csv(vaccine_demographic, "data/vaccine_demographic.csv")


# ------------------------- POPULATION -----------------------------

pop <- read_csv("data/population.csv")
pop <- pop %>%
  mutate(population = as.numeric(population))

vaccine_pop <- left_join(vaccine_demographic, pop, by = "location") %>%
  na.omit()

vaccine_pop <- vaccine_pop %>%
  mutate(
    white = log(population*white_prop),
    black = log(population*black_prop),
    asian = log(population*asian_prop),
    hispanic = log(population*hispanic_prop)
  )

vaccine_pop <- vaccine_pop %>%
  filter(first_dose != 0) %>%
  mutate(first_dose = log(first_dose))


write_csv(vaccine_pop, "data/vaccine_pop.csv")