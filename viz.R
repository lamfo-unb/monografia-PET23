library(tidyverse)
library(ggplot2)

# WRITING FUNCTIONS

plot_series <- function(data, curr) {
  ggplot(data = data, aes_string(x = "time", y = curr)) +
    geom_line(color = "blue") +
    labs(title = paste0("Time Series of ", curr, " Exchange Rate"), x = "Date", y = paste0(curr, " Rate")) +
    scale_x_date(date_breaks = "2 years", date_labels = "%Y") +
    theme_minimal()
}

############################################################################################################

# READING THE DATA

# Load Data
belarus <- read_csv("data/FX_IDC_USDBYN, 1D.csv") %>% select(time, close)
ukraine <- read_csv("data/FX_IDC_USDUAH, 1D.csv") %>% select(time, close)
russia  <- read_csv("data/FX_IDC_USDRUB, 1D.csv") %>% select(time, close)
euro <- read_csv("data/FX_IDC_USDEUR, 1D.csv") %>% select(time, close)
china <- read_csv("data/FX_IDC_USDCNY, 1D.csv") %>% select(time, close)
poland <- read_csv("data/FX_IDC_USDPLN, 1D.csv") %>% select(time, close)
turkey <- read_csv("data/FX_IDC_USDTRY, 1D.csv") %>% select(time, close)
pound <- read_csv("data/FX_IDC_USDGBP, 1D.csv") %>% select(time, close)


# Read Dates
pound$time <- as.Date(pound$time, format = "%Y-%m-%d")
euro$time <- as.Date(euro$time, format = "%Y-%m-%d")
russia$time <- as.Date(russia$time, format = "%Y-%m-%d")
ukraine$time <- as.Date(ukraine$time, format = "%Y-%m-%d")
belarus$time <- as.Date(belarus$time, format = "%Y-%m-%d")
china$time <- as.Date(china$time, format = "%Y-%m-%d")
poland$time <- as.Date(poland$time, format = "%Y-%m-%d")
turkey$time <- as.Date(turkey$time, format = "%Y-%m-%d")

# Full dataframe
ts <- euro %>%
  left_join(pound, by='time', suffix=c(".EUR", ".GBP")) %>%
  left_join(russia, by='time') %>% 
  left_join(ukraine, by='time', suffix=c(".RUB", ".UAH")) %>% 
  left_join(belarus, by='time') %>%
  left_join(china, by='time', suffix=c(".BYR", ".CNY")) %>%
  left_join(poland, by='time') %>%
  left_join(turkey, by='time', suffix=c(".PLN", ".TRY"))

############################################################################################################

# BUILDING TIME SERIES

# Close Prices
close_prices <- ts %>%
  select(-time) %>%
  mutate_all(.funs = as.numeric)

# Close Prices Returns
close_prices_returns <- close_prices %>%
  mutate_all(.funs = function(x) (x/lag(x) - 1)*100)
close_prices_returns$time <- ts$time

# Rolling Standard Deviations
rolling_std <- close_prices %>%
  lapply(function(x) rollapply(x, width = 140, FUN = sd, by = 1, align = "right", fill = NA)) %>%
  as_tibble()
rolling_std$time <- ts$time

plot_series(rolling_std%>%drop_na(), "close.BYR")

