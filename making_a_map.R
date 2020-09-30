
# load libraries ----------------------------------------------------------

require(leaflet)
require(rgdal)
library(tidyverse)
library(here)

# get the data ------------------------------------------------------------

shape <- readOGR(dsn = paste0(here(),"/Spatial_data"), layer = "gadm36_NOR_1")

# check the names of each region ------------------------------------------

shape@data$NAME_1


# map each region to a management region ----------------------------------

shape@data$MAN_REGION<-c("R4", "R4", "R2","R2", "R8", "R5", "R1", 
                         "R6", "R6", "R7", "R3", "R4", "R1", "R1",
                         "R6", "R2", "R8", "R1", "R2")

# plotting a leaflet map --------------------------------------------------

# get the colour pallette -------------------------------------------------
n = length(unique(shape@data$MAN_REGION))
factorPal <- colorFactor(viridis::inferno(n), shape@data$MAN_REGION)


# plot leaflet map --------------------------------------------------------

leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=shape, weight = 2, color = "black",  
              fillColor = ~factorPal(shape@data$MAN_REGION),
              fillOpacity = 1,
              label = shape@data$MAN_REGION)
