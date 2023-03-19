# A Database application on _triple threat_

## The data you find here and our data sources
- Provisional COVID-19 Deaths by Sex and Age(NCHS/DVS)
- COVID-19 Vaccination Age and Sex Trends in the United States, National and Jurisdictional(NCIRD)
- Laboratory-Confirmed Influenza Hospitalizations(FluSurv-NET)
- Weekly Rates of Laboratory-Confirmed RSV Hospitalizations(RSV-NET)

## The complete _triple threat_ dataset
The attributes represent all of our main data related to deaths, vaccination and hospitalizations 
as well as other attribute of potential interest.

### unified_view

| Attribute                                  | Description                                                                                                   |
|:------------------------------------------|:--------------------------------------------------------------------------------------------------------------|
| `date`                                    | Date of observation                                                                                           |
| `state`                                   | Geographical location                                                                                         |
| `sex`                                     | Gender of observation                                                                                         |
| `covid19Death`                            | Deaths involving COVID-19                                                                                     |
| `totalDeath`                              | Deaths from all causes of death                                                                               |
| `pneumoniaDeath`                          | Pneumonia Deaths                                                                                              |
| `pneumoniaAndCovid19Death`                | Deaths with Pneumonia and COVID-19                                                                            |
| `influenzaDeaths`                         | Influenza Deaths                                                                                              |
| `tripleThreatTotalDeath`                  | Deaths with Pneumonia, Influenza, or COVID-19                                                                 |
| `censusForVaccination`                    | Census Population                                                                                        |
| `vaccinationStarted`                      | Total count of people with at least one dose                                                                  |
| `vaccinationSeriesDone`                   | Total count of people who completed a primary series                                                          |
| `vaccinationBooster`                      | Total count of people aged 5 years and older who completed a primary series and received a first booster dose |
| `weekly_RSV_hospitalizations_rate`        | Weekly rate of RSV hospitalizations                                                                           |
| `cumulative_RSV_hospitalizations_rate`    | Cumulative rate of RSV hospitalizations                                                                       |
| `weekly_Influenza_hospitalizations_rate`  | Weekly rate of Influenza hospitalizations                                                                     |
| `cumulative_Influenza_rate`               | Cumulative rate of Influenza hospitalizations                                                                 |

## Additional files and information
- [`canned queries`](https://github.com/Drenight/TripleThreatDBApplication/tree/main/canned%20queries):
5 canned SQL query provided by us for user to do the search
- [`sql creator`](https://github.com/Drenight/TripleThreatDBApplication/tree/main/sql%20creator):
A simple python file that helps user to generate specific SQL queries based on date state and sex.