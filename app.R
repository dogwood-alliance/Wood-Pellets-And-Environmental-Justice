#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#load libraries
library(shiny)
library(leaflet)
library(dplyr)
library(leaflet.extras)


library(rgdal)

# From https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html
ejmap <- readOGR("shp/EJ_Counties.shp", layer = "EJ_Counties")
millpoints <- readOGR("shp/Pellet_Mill_Locations.shp", layer = "Pellet_Mill_Locations")

# Define UI for application that draws a histogram
ui <- fluidPage(
    mainPanel( 
        #this will create a space for us to display our map
        leafletOutput(outputId = "mymap") 
        )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$mymap <- renderLeaflet({
        leaflet(ejmap) %>% 
            setView(lng = -87, lat = 32, zoom = 4.5)  %>% #setting the view over ~ center of North America
            addTiles() %>%
            addPolygons(color = "red", weight = 1, smoothFactor = 0.5,
                        opacity =0.5, fillOpacity = 0.3,
                        #fillColor = ~colorQuantile("YlOrRd", ALAND)(ALAND),
                        ) %>%
            addMarkers(data = millpoints, icon=makeIcon(iconUrl="factory.png", iconWidth=40, iconHeight=40))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
