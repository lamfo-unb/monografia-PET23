library(tidyverse)
library(BEKKs)

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

ts <- euro %>%
  left_join(pound, by='time', suffix=c(".EUR", ".GBP")) %>%
  left_join(russia, by='time') %>% 
  left_join(ukraine, by='time', suffix=c(".RUB", ".UAH")) %>% 
  left_join(belarus, by='time') %>%
  left_join(china, by='time', suffix=c(".BYR", ".CNY")) %>%
  left_join(poland, by='time') %>%
  left_join(turkey, by='time', suffix=c(".PLN", ".TRY"))

close_prices <- ts %>%
  select(-time) %>%
  mutate_all(.funs = as.numeric)

close_prices_returns <- close_prices %>%
  mutate_all(.funs = function(x) (x/lag(x) - 1)*100)

# MODELS
spec <- bekk_spec(list(type = "bekk", asymmetric = TRUE))

# 1 - EURO, RUBLE, HRYVNIA, BELARUSSIAN RUBLE
m1 <- bekk_fit(spec, as.ts(close_prices_returns%>%select(close.EUR, close.RUB, close.UAH, close.BYR)%>%drop_na()))
summary(m1)
saveRDS(m1, "models/EUR_RUB_UAH_BYR.rds")

# 2 - POUND, RUBLE, HRYVNIA, BELARUSSIAN RUBLE
m2 <- bekk_fit(spec, as.ts(close_prices_returns%>%select(close.GBP, close.RUB, close.UAH, close.BYR)%>%drop_na()))
summary(m2)
saveRDS(m2, "models/GBP_RUB_UAH_BYR.rds")

# 3 - ZLOTY, RUBLE, HRYVNIA
m3 <- bekk_fit(spec, as.ts(close_prices_returns%>%select(close.PLN, close.RUB, close.UAH)%>%drop_na()))
summary(m3)
saveRDS(m3, "models/PLN_RUB_UAH.rds")

# 4 - LIRA, RUBLE
m4 <- bekk_fit(spec, as.ts(close_prices_returns%>%select(close.TRY, close.RUB)%>%drop_na()))
summary(m4)
saveRDS(m4, "models/TRY_RUB.rds")

# 5 - YUAN, RUBLE
m5 <- bekk_fit(spec, as.ts(close_prices_returns%>%select(close.CNY, close.RUB)%>%drop_na()))
summary(m5)
saveRDS(m5, "models/CNY_RUB.rds")

