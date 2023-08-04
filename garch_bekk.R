library(tidyverse)
library(mgarchBEKK)
library(MTS)

belarus <- read_csv("data/BYN=X.csv") %>% select(Date, Close)
ukraine <- read_csv("data/UAH=X.csv") %>% select(Date, Close)
russia  <- read_csv("data/RUB=X.csv") %>% select(Date, Close)
euro <- read_csv("data/EURUSD=X.csv") %>% select(Date, Close)
USD <- read_csv("data/DX-Y.NYB.csv") %>% select(Date, Close)

USD$Date <- as.Date(USD$Date, format = "%Y-%m-%d")
euro$Date <- as.Date(euro$Date, format = "%Y-%m-%d")
russia$Date <- as.Date(russia$Date, format = "%Y-%m-%d")
ukraine$Date <- as.Date(ukraine$Date, format = "%Y-%m-%d")
belarus$Date <- as.Date(belarus$Date, format = "%Y-%m-%d")

ts <- USD %>% left_join(euro, by='Date') %>% left_join(russia, by='Date') %>% left_join(ukraine, by='Date') %>% 
  left_join(belarus, by='Date') %>%
  mutate_if(is.character, ~ ifelse(. == "null", NA, .)) %>%
  drop_na() 
colnames(ts) <- c("Date", "DX", "USD/EUR", "USD/RUB", "USD/UAH", "USD/BYN")

close_prices_returns <- ts %>%
  select(-Date) %>%
  mutate_all(.funs = as.numeric) %>%
  mutate_all(.funs = function(x) (x/lag(x) - 1))


model <- BEKK(close_prices_returns%>%select(`USD/RUB`, `USD/UAH`))
diagnoseBEKK(model)

plot(close_prices_returns$`USD/RUS`)




