#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
# Group 2

# Load required libraries
library(shiny)
library(readr)
library(ggplot2)
library(dplyr)

# Assuming 'combine_static_house_info_df4' is your dataset
data <- read_csv("combine_static_house_info_df4.csv")

# Define UI for the Shiny application
ui <- fluidPage(
  titlePanel("Energy Usage"),
  sidebarLayout(
    sidebarPanel(
      selectInput("plot_type", "Choose a Plot:",
                  choices = c("Box Plot - Total Energy Consumption Across Building Climate Zones", 
                              "Bar Chart - mean Energy Consumption by Vintage", 
                              "Bar Chart - mean Energy Consumption by City", 
                              "Bar Chart - mean Energy Consumption by Number of Bedrooms", 
                              "Bar Chart - Total Energy Consumption by Heating Fuel Type", 
                              "Line Plot - Highest Total Energy Consumption Per Day"))
    ),
    mainPanel(
      plotOutput("selected_plot")
    )
  )
)

# Define server logic to generate plots based on user selection
server <- function(input, output) {
  output$selected_plot <- renderPlot({
    if (input$plot_type == "Box Plot - Total Energy Consumption Across Building Climate Zones") {
      # Create a boxplot to visualize the distribution of total energy consumption across building climate zones
      ggplot(data, aes(x = in.building_america_climate_zone, y = day_total_energy)) +
        geom_boxplot(fill = "lightblue", color = "blue", outlier.color = "red", outlier.shape = 1, width = 0.7) +  
        labs(title = "Distribution of Total Energy Consumption Across Building Climate Zones",  
             x = "Building Climate Zone",
             y = "Total Energy Consumption (kWh)") +
        theme_minimal() 
    } else if (input$plot_type == "Bar Chart - mean Energy Consumption by Vintage") {
      # Create a bar plot to visualize the mean energy consumption by vintage
      mean_energy_by_vintage <- data %>%
        group_by(in.vintage) %>%
        summarize(avg_energy = mean(day_total_energy, na.rm = TRUE)) %>%
        arrange(desc(avg_energy)) 
      
      ggplot(mean_energy_by_vintage, aes(x = reorder(in.vintage, avg_energy), y = avg_energy, fill = avg_energy)) +
        geom_col(show.legend = FALSE) +  
        geom_text(aes(label=sprintf("%.2f kWh", avg_energy)), vjust=-0.3, color="white", size=3.5) +  
        scale_fill_gradient(low = "lightblue", high = "blue") +  
        labs(title = "mean Energy Consumption by Vintage",  
             x = "Vintage",
             y = "mean Energy Consumption (kWh)") +
        theme_minimal()
    } else if (input$plot_type == "Bar Chart - mean Energy Consumption by City") {
      mean_energy_by_city <- data %>%
        group_by(in.weather_file_city) %>%
        summarize(avg_energy = mean(day_total_energy, na.rm = TRUE)) %>%
        arrange(desc(avg_energy)) 
      
      ggplot(mean_energy_by_city, aes(x = reorder(in.weather_file_city, -avg_energy), y = avg_energy, fill = avg_energy)) +
        geom_col(show.legend = FALSE) + 
        scale_fill_gradient(low = "pink", high = "red") +
        labs(title = "mean Energy Consumption by City",  
             x = "City",
             y = "mean Energy Consumption (kWh)") +
        theme_minimal() +  
        theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) 
    } else if (input$plot_type == "Bar Chart - mean Energy Consumption by Number of Bedrooms") {
      # Create a bar plot to visualize the mean energy consumption by number of bedrooms
      mean_energy_by_bedrooms <- data %>%
        group_by(in.bedrooms) %>%
        summarize(avg_energy = mean(day_total_energy, na.rm = TRUE)) %>%
        mutate(percentage = avg_energy / sum(avg_energy) * 100) 
      
      ggplot(mean_energy_by_bedrooms, aes(x = factor(in.bedrooms), y = avg_energy, fill = factor(in.bedrooms))) +
        geom_col(show.legend = FALSE) +  
        geom_text(aes(label = paste(sprintf("%.2f%%", percentage), sep="\n")), 
                  position = position_stack(vjust = 1.1), size = 3.5, color = "black") +
        scale_fill_brewer(palette = "Pastel1") +  
        labs(title = "mean Energy Consumption by Number of Bedrooms",  
             x = "Number of Bedrooms",
             y = "mean Energy Consumption (kWh)") +
        theme_minimal() 
    } else if (input$plot_type == "Bar Chart - Total Energy Consumption by Heating Fuel Type") {
      # Create a bar plot to visualize total energy consumption by heating fuel type
      data <- data
      filtered_data <- data[data$in.heating_fuel != "None", ]
      
      ggplot(filtered_data, aes(x = in.heating_fuel, y = day_total_energy, fill = in.heating_fuel)) +
        geom_bar(stat = "identity", position = "dodge") +  
        scale_fill_brewer(palette = "Set3") +  
        labs(title = "Total Energy Consumption by Heating Fuel Type",  
             x = "Heating Fuel Type",
             y = "Total Energy Consumption (kWh)") +
        theme_minimal()  
    } else if (input$plot_type == "Line Plot - Highest Total Energy Consumption Per Day") {
      # Create a line plot to visualize the highest total energy consumption per day
      data$date <- as.Date(data$date)
      max_energy_per_day <- data %>%
        group_by(date) %>%
        summarise(max_energy = max(day_total_energy))
      
      ggplot(max_energy_per_day, aes(x = date, y = max_energy)) +
        geom_line(color = "steelblue", size = 1, alpha = 0.8) +  
        geom_point(color = "darkred", size = 3, shape = 21, fill = "white", alpha = 0.8) +  
        geom_text(aes(label = sprintf("%.2f", max_energy)), vjust = -1, color = "black", size = 3, check_overlap = TRUE) + 
        labs(title = "Highest Total Energy Consumption Per Day",  
             x = "Date",
             y = "Highest Total Energy Consumption (kWh)") +
        theme_minimal() 
    } 
  })
}

# Run the Shiny application
shinyApp(ui = ui, server = server)
