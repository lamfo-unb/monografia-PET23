library(tidyverse)
library(ggplot2)

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
  drop_na() %>%
  mutate_at(vars(-Date), as.numeric)
colnames(ts) <- c("Date", "DX", "USD_EUR", "USD_RUB", "USD_UAH", "USD_BYN")

plot_series <- function(data, curr) {
  ggplot(data = data, aes_string(x = "Date", y = curr)) +
    geom_line(color = "blue") +
    labs(title = paste0("Time Series of ", curr, " Exchange Rate"), x = "Date", y = paste0(curr, " Rate")) +
    scale_x_date(date_breaks = "2 years", date_labels = "%Y") +
    theme_minimal()
}

plot_series(ts, "USD_UAH")


