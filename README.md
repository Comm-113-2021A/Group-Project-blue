
Analysis of COVID Vaccine Distribution in the U.S.
================
by Team Blue

## Summary

An Analysis of COVID Vaccine Distribution in the U.S.
Group Blue

An article in KFF discusses the existence of racial disparities in COVID vaccine distribution. To confirm or deny the validity of this statement, Group B posed this research question: Are Vaccines Being Distributed Fairly Within the US? 

The plan consists of first finding and tidying data of the population by race and state, then using linear regression in an attempt to model the number of vaccines each state received based on the racial grouping of the population. Lastly the accuracy of the model will be evaluated. 

Initial vaccination data was collected from the Centers for Disease Control and Prevention (CDC), however, a challenge was quickly faced as there was not one readily available dataframe for all currently distributed in the US. To combat this, research and merging of 3 different datasets on vaccination allocation was done. The three datasets were on the allocation of the three types of vaccines that are largely recommended and authorized in the US: `pfizer`, `moderna`, and `janssen` as of the week of April 5th 2021. The variables as of were location, week of allocation, and number of dosage. Tidying consisted of changing names to match basic syntax, assigning 0 to Janssen’s number of dosage variables where the second dose would be (as Janssen is a singular dose vaccine), and assigning the different types of vaccines to prospective data frames so that they can be differentiated later on. After tidying, the datasets were able to be bound together to create a larger dataframe called “vaccines”. In order to compare vaccination to racial population, a racial demographic dataset was found and merged with the vaccination data set. As many racial groups in the dataset had missing values, only `white`, `black`, `asian`, and `hispanic` were used to join with the vaccines dataframe. An attempt was made to run the model with the proportion of each of the four racial groups in each state but as the model didn’t run well, it was decided to merge another dataset. Thinking that the issue came from the respective sizes of each state, the dataset used contained data on the population by state. The proportions figure was multiplied by the populations to get the number of people of each race by state. However, the residual graph was still skewed. More testing revealed a power model (take natural log of both independent and dependent variables) was appropriate, resulting in a random, uniformly distributed residual plot. 

To create the model the data was first split into training and testing data which created a 25-75 split. Then the model was specified by building the model and recipe. The model was attempting to predict the number of first doses based on the week, vaccine type, and population of race in each state. A workflow was then built from the recipe and model. Next, the model was fit to the training dataset in order to see how well the model works. Once again, the model was on a logarithmic scale as the initial test resulted in a fan-shaped distribution. From building the workflow, a key takeaway was that on average, an increase of 1in ln (white) resulted in a 0.549 increase in ln (vaccines), while an in increase of 1 in ln (black), ln (asian), and ln (hispanic) resulted in around a .1 increase in ln (vaccines). 

The model was then evaluated to determine whether any conclusions can be drawn. To get predicted values, the model was tested on the training dataset and then the testing dataset. The residual graph displayed a random distribution about the x-axis. The resulting RMSE from testing the training dataset was .521 and the resulting RMSE from testing the testing dataset was .505. As the RMSE could go up to 10, these are considered very low. The resulting R^2 from the training dataset was .786 while the resulting R^2 from the testing dataset was .792. Both of these R^2 are considerably high. The conclusion drawn was that the regression model was a good fit for the data based on the residual graph and that the model quite accurately predicts the number of vaccinations based on racial distribution as indicated by the low RMSE and high R^2. 

However, there are limitations to the findings that don’t allow for the conclusion to be made that the distribution of vaccines is racially discriminatory. Firstly, it cannot be said that vaccine distributors were consciously deciding to discriminate against people of color receiving the vaccine. Secondly, the key takeaway from the building of the workflow shows only correlation, but not causation. Also, there could be a third confounding variable such as education level or physical capability to go to a vaccination center that would affect the numbers of people of color that receive the vaccine. In addition, the dataset was grouped by state which could have led to the ove-rgeneralization of the distribution of racial populations receiving the vaccine. Lastly, the data was already biased as vaccines were first given on need-based priority. 

To improve the datasets and in turn, the conclusions, it is recommended that a study is conducted to establish cause. Another recommendation would be to find more focused datasets (perhaps by city) to combat the issue of over-generalization. Re-running the study at a later date when there is more data available would also improve the research as it would provide a more complete picture of the vaccine distribution in the US. 

## Presentation

Our presentation can be found [here](presentation/presentation.html).

## Data 

Centers for Disease Control and Prevention, 2021. COVID-19 Vaccine Distribution Allocations by Jurisdiction - Pfizer. [online] Data.cdc.gov. Available at: <https://data.cdc.gov/Vaccinations/COVID-19-Vaccine-Distribution-Allocations-by-Juris/saz5-9hgg/data> [Accessed 5 April 2021].

Centers for Disease Control and Prevention, 2021. COVID-19 Vaccine Distribution Allocations by Jurisdiction - Moderna. [online] Data.cdc.gov. Available at: <https://data.cdc.gov/Vaccinations/COVID-19-Vaccine-Distribution-Allocations-by-Juris/b7pe-5nws/data> [Accessed 5 April 2021].
https://www.kff.org/other/state-indicator/distribution-by-raceethnicity/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D

Centers for Disease Control and Prevention, 2021. COVID-19 Vaccine Distribution Allocations by Jurisdiction - Janssen. [online] Data.cdc.gov. Available at: <https://data.cdc.gov/Vaccinations/COVID-19-Vaccine-Distribution-Allocations-by-Juris/w9zu-fywh/data> [Accessed 5 April 2021].

Kaiser Family Foundation, 2021. Population Distribution by Race/Ethnicity. [online] KFF. Available at: <https://www.kff.org/other/state-indicator/distribution-by-raceethnicity/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D> [Accessed 21 April 2021].

United States Census Bureau, 2021. 2019 National and State Population Estimates. [online] The United States Census Bureau. Available at: <https://www.census.gov/newsroom/press-kits/2019/national-state-estimates.html> [Accessed 21 April 2021].


## References

Centers for Disease Control and Prevention, 2021. COVID-19 Vaccine Distribution Allocations by Jurisdiction - Pfizer. [online] Data.cdc.gov. Available at: <https://data.cdc.gov/Vaccinations/COVID-19-Vaccine-Distribution-Allocations-by-Juris/saz5-9hgg/data> [Accessed 5 April 2021].

Centers for Disease Control and Prevention, 2021. COVID-19 Vaccine Distribution Allocations by Jurisdiction - Moderna. [online] Data.cdc.gov. Available at: <https://data.cdc.gov/Vaccinations/COVID-19-Vaccine-Distribution-Allocations-by-Juris/b7pe-5nws/data> [Accessed 5 April 2021].

Centers for Disease Control and Prevention, 2021. COVID-19 Vaccine Distribution Allocations by Jurisdiction - Janssen. [online] Data.cdc.gov. Available at: <https://data.cdc.gov/Vaccinations/COVID-19-Vaccine-Distribution-Allocations-by-Juris/w9zu-fywh/data> [Accessed 5 April 2021].

Kaiser Family Foundation, 2021. Population Distribution by Race/Ethnicity. [online] KFF. Available at: <https://www.kff.org/other/state-indicator/distribution-by-raceethnicity/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D> [Accessed 21 April 2021].

Ndugga, N., Pham, O., Hill, L., Artiga, S., Alam, R. and Parker, N., 2021. Latest Data on COVID-19 Vaccinations Race/Ethnicity. [online] KFF. Available at: <https://www.kff.org/coronavirus-covid-19/issue-brief/latest-data-on-covid-19-vaccinations-race-ethnicity/> [Accessed 22 April 2021].

United States Census Bureau, 2021. 2019 National and State Population Estimates. [online] The United States Census Bureau. Available at: <https://www.census.gov/newsroom/press-kits/2019/national-state-estimates.html> [Accessed 21 April 2021].


