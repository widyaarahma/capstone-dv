library(dplyr)
library(ggplot2)
library(plotly)
library(lubridate)
library(glue)
library(tidyverse)
library(stringr)
library(flexdashboard)
library(shiny)
library(shinydashboard)

forbes <- read.csv("Forbes-2021-Global-500-Companies-Statistics.csv")

colnames(forbes) = c("Rank","Company", "Country","Sales","Profit","Assets","Market_Value")


forbes <- forbes %>% 
  mutate(Country = as.factor(Country))

forbes_america <- forbes %>% 
  filter(Country=="United States") %>% 
  group_by(Company) %>% 
  summarise(Total_Market_Value = mean(Market_Value)) %>% 
  ungroup() %>% 
  mutate(label =glue("Company: {Company}
                    Market Value : {Total_Market_Value} "))

forbes_count <- head(forbes_clean,20 ) %>% 
  group_by(Country) %>% 
  summarise(Total_Company=n()) %>% 
  arrange(desc(Total_Company)) %>% 
  ungroup()

forbes_count2 <- forbes_count %>% 
  mutate(label = glue("Country : {Country}
                      Total Company: {Total_Company}"))

forbes_trend <- head(forbes_clean, 10)%>% 
  group_by(Rank) %>% 
  summarise(avg_Sales = round(mean(Sales))) %>% 
  ungroup() %>% 
  mutate(label = glue("Rank: {Rank}
                      Sales: {avg_Sales}"))


average_profit <- head(forbes_clean, 10) %>% 
  group_by(Company, Country) %>% 
  summarise(Max_Sales = max(Sales)) %>% 
  ungroup() %>% 
  arrange(desc(Max_Sales))

forbes_trend <- head(forbes_clean, 10)%>% 
  group_by(Rank) %>% 
  summarise(avg_Sales = round(mean(Sales))) %>% 
  ungroup() %>% 
  mutate(label = glue("Rank: {Rank}
                      Sales: {avg_Sales}"))
forbes4 <- forbes_clean %>% 
  filter(Sales > Assets) %>%
  group_by(Country) %>% 
  summarise(Total_Profit = sum(Profit)) %>% 
  ungroup() %>% 
  arrange(desc(Total_Profit))


forbes_glue4 <- forbes4 %>% 
  mutate(label = glue ("Country: {Country}
                       Total Profit: {Total_Profit}"))