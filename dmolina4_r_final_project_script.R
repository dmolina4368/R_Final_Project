library(sf)
library(tmap)
library(spData)
library(terra)

cbwpre <- read_csv("~/dmolina4_r_final_project/Change_in_Total_Annual_Precipitation_1901-2021.csv")
glimpse(cbwpre)

cbwtemp <- read_csv("~/dmolina4_r_final_project/Change_in_High_Temperature_Extremes_1948-2017.csv")
glimpse(cbwtemp

counties <- sf::read_sf("~/dmolina4_r_final_project/data/CBW/County_Boundaries.shp")
temperature <- sf::read_sf("~/dmolina4_r_final_project/Change_in_High_Temperature_Extremes_1948-2017/Change_in_High_Temperature_Extremes_1948-2017.shp")
precipitation <- sf::read_sf("~/dmolina4_r_final_project/Change_in_Total_Annual_Precipitation_1901-2021/Change_in_Total_Annual_Precipitation_1901-2021.shp")

sf::sf_use_s2(FALSE)

st_crs(temperature)
st_crs(counties)
st_crs(precipitation)

counties <- st_transform(counties, crs = st_crs(temperature))
chesapeaketempchange <- st_intersection(temperature, counties)

counties <- st_transform(counties, crs = st_crs(precipitation))
chesapeakeprecipchange <- st_intersection(precipitation, counties)

cbwtempchangemap <- tm_shape(counties) +tm_borders(col = "gray50", lwd = 1) + 
  tm_shape(chesapeaketempchange) +tm_dots(col = "Chge95Pday", size = 2, palette = "Reds", border.col = "black",             
  border.lwd = 0.2, alpha = 0.8) +
  tm_layout(title = "CBW Temperature Changes from 1948 to 2017", title.size = 1.5, title.position = c("center", "top"))
cbwtempchangemap

cbwprecipchangemap <- tm_shape(counties) +tm_borders(col = "gray50", lwd = 1) + 
  tm_shape(chesapeakeprecipchange) +tm_dots(col = "PercentChg", size = 1, palette = "Blues", border.col = "black",             
  border.lwd = 0.2, alpha = 0.8) +
  tm_layout(title = "CBW Precipitation Changes from 1901 to 2021", title.size = 1.5, title.position = c("center", "top"))
cbwprecipchangemap

