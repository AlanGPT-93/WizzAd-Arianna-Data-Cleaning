## Data From WizzAd
library(dplyr)
library(purrr)
library(stringr)
library(readxl)
library(writexl)

year <- "2021"
my_data <- read_excel( paste0( "C:/Users/Alan.Garcia/Downloads/WizzAd_competitive_",year,".xlsx"), 
                      sheet = paste0("D- WHOLE CAT 2021 - 2021 D- Tel") ) #"D- WHOLE CAT 2019-2020 - DIMENS" 

colnames(my_data) <- my_data %>% colnames() %>% toupper()

my_data$CATEGORY <- ""
my_data$DUPLICATED <- "NO"

################################### Repeat in another category

#### Mobility
aux <- my_data$BRAND %in% c("AT&T: INTERNET", 'AT&T: BUSINESS', 'CLARO: BUSINESS',
                     'T-MOBILE: BUSINESS')

data_aux <- my_data[aux,]

data_aux$CATEGORY <- "Mobility"
data_aux$DUPLICATED <- "SI"

#### Business
aux_2 <- my_data$BRAND %in% c() # "NEPTUNO: INTERNET",  "WORLDNET: INTERNET",'OPTICO: INTERNET'

data_aux_2 <- my_data[aux_2,]

data_aux_2$CATEGORY <- "Business"
data_aux_2$DUPLICATED <- "SI"

#### Residence

# aux_3 <- my_data$BRAND %in% c('AT&T: FIRSTNET')
# 
# data_aux_3 <- my_data[aux_3,]
# 
# data_aux_3$CATEGORY <- "Residence"
# data_aux_3$DUPLICATED <- "SI"

############################################# PRINCIPAL CATEGORY
### INSTITUTIONAL

institutional <- c("CLARO: INSTITUTIONAL", "LIBERTY: INSTITUTIONAL", # eran residence
                   'T-MOBILE: INSTITUTIONAL',"AT&T: INSTITUTIONAL",'AT&T: CO BRAND')   # eran mobility


institutional_f <- my_data$BRAND %in% institutional

my_data[institutional_f,]$CATEGORY <- "Institutional"

### Residence

residence <- c('AT&T: INTERNET', 'DIRECTV: INSTITUTIONAL', 'DISH: INSTITUTIONAL',
'CLARO: INTERNET', 'CLARO: LIFELINE', 'CLARO: MULTIPROD', 'DIRECTV: CABLE',
'DIRECTV: PROGRAM', 'DISH NETWORK: HOPPER', 'HUGHESNET: INTERNET',
'LIBERTY: CABLE', 'LIBERTY: GO', 'LIBERTY: INTERNET', 'LIBERTY: LIFELINE',
'LIBERTY: MULTIPROD', 'LIBERTY: ON DEMAND', 'LIBERTY: PAY PER VIEW', 'LIBERTY: PROGRAMACION','LIBERTY: HUB TV',
'NEPTUNO: INTERNET', 'AT&T: DTV HBO MAX',
'AT&T: DTV PPV', 'AT&T: DTV PROGRAM', 'AT&T: MULTIPROD', 'AERONET: INTERNET',
'CLARO: CABLE', 'DISH NETWORK: ANYWHERE', 'DISH NETWORK: CABLE', 'DISH NETWORK: MULTIPROD',
'LIBERTY: EVERYWHERE', 'LIBERTY: PREMIUM CHANNELS','OPTICO: INTERNET', 'PRWIRELESS: INTERNET','WORLDNET: INTERNET',
'CLARO: TV','LIBERTY: CABLE TV', 'OPTICO FIBER')

residence_f <- my_data$BRAND %in% residence

my_data[residence_f,]$CATEGORY <- "Residence"

### Mobility ,'AT&T: CO BRAND'
mobility <- c( 'AT&T: FIRSTNET','AT&T: LIFELINE', 
              'AT&T: POST PAID', 'AT&T: PREPAID', 'BOOST: PREPAID',
'CLARO: POST PAID', 'CLARO: PREPAID', 'T-MOBILE: INTERNET',
'T-MOBILE: POST PAID', 'T-MOBILE: PREPAID','LIBERTY: POST PAID',
'LIBERTY: PREPAID','BOOST: INSTITUTIONAL','SPRINT: POST PAID', 'SPRINT: INSTITUTIONAL')

mobility_f <- my_data$BRAND %in% mobility

my_data[mobility_f,]$CATEGORY <- "Mobility"


### Business
# ,"WORLDNET: INTERNET"
business <- c('AT&T: BUSINESS', 'CLARO: BUSINESS', 'LIBERTY: BUSINESS',
              'T-MOBILE: BUSINESS','AERONET: BUSINESS', 'DIRECTV: BUSINESS', 
              'LIBERTY: BUSINESS MULTIPROD','FUSE: INTERNET','FUSE TELECOM',
              'WORLDNET: BUSINESS')

business_f <- my_data$BRAND %in% business

my_data[business_f,]$CATEGORY <- "Business"


## Union

copetitive <- my_data %>% bind_rows(data_aux) %>% bind_rows(data_aux_2) #%>% bind_rows(data_aux_3)
copetitive %>% count(CATEGORY)

a <- copetitive %>% distinct(ADVERTISER, BRAND, CATEGORY, DUPLICATED)

write_xlsx(copetitive,
           paste0("C:/Users/Alan.Garcia/OneDrive - OneWorkplace/Documentos/Trabajos MyOMC/Competitivo/",
                  "Telecom_Competitive_WizzAd_",year,".xlsx") )

## Reading 2020
copetitive_2020 <- read_excel( paste0( "C:/Users/Alan.Garcia/OneDrive - OneWorkplace/Documentos/Trabajos MyOMC/Competitivo/",
                                       "Telecom_Competitive_WizzAd_","2020",".xlsx"), 
                       sheet = paste0("Sheet1") )

## Union 2021
copetitive20_21 <- copetitive_2020 %>% bind_rows(copetitive)

## CHANGING CL NAMES AND COMPETITORS NAME
colnames(copetitive20_21) <- c("ADVERTISER", "Brand", "Date" ,"Media Type", "Spend", "Category","DUPLICATED")


tf <- copetitive20_21$ADVERTISER == "DISH NETWORK"
copetitive20_21$ADVERTISER[tf] <- "DISH"

tf <- copetitive20_21$ADVERTISER == "NEPTUNO NETWORKS"
copetitive20_21$ADVERTISER[tf] <- "NEPTUNO"

tf <- copetitive20_21$ADVERTISER == "BOOST MOBILE"
copetitive20_21$ADVERTISER[tf] <- "BOOST"


write_xlsx(copetitive20_21,
           paste0("C:/Users/Alan.Garcia/OneDrive - OneWorkplace/Documentos/Trabajos MyOMC/Competitivo/",
                  "Telecom_Competitive_WizzAd",".xlsx") )
