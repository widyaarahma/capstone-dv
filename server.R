server <- function(input, output) {
  
  output$plot_8 <- renderPlotly({
    forbes_america <- forbes %>% 
      filter(Country==input$Country) %>% 
      group_by(Company) %>% 
      summarise(Total_Market_Value = mean(Market_Value)) %>% 
      ungroup() %>% 
      mutate(label =glue("Company: {Company}
                    Market Value : {Total_Market_Value} "))
    plot2 <- ggplot(forbes_america, aes(y = Total_Market_Value,
                                      x =  Company, text = label)) +
      geom_bar(stat="identity", fill="Orange1", alpha=.6, width=.4)+
      theme_light()+
      theme(axis.text.x=element_text(angle = 45, vjust = 0.5))+
      labs(x = NULL,
           y = NULL,
           title = input$Country) 
    ggplotly(plot2, tooltip="text")

  })
  output$plot_2 <- renderPlotly({
    forbes_count <- head(forbes_clean,15) %>% 
      group_by(Country) %>% 
      summarise(Total_Company=n()) %>% 
      arrange(desc(Total_Company)) %>% 
      ungroup()
    
    forbes_count2 <- forbes_count %>% 
      mutate(label = glue("Country : {Country}
                      Total Company: {Total_Company}"))
    
    # prepare data
    # plot
    plot_forbes <- ggplot(forbes_count2, aes(x=Country, y= Total_Company, text= label)) +
      geom_segment( aes(x= reorder(Country, Total_Company), xend=reorder(Country, Total_Company), y=0, yend=Total_Company), color = "black", lwd = 1.7) +
      geom_point( size=5, color="red", fill=alpha("red", 0.9), alpha=0.9, shape=20, stroke=1) +
      labs(title = "Top 5 Company by Country",
           x = NULL,
           y = "Total Company")+
      coord_flip()+
      theme_light()
    ggplotly(plot_forbes,tooltip = "text")
    
  })
    
  output$table <- DT::renderDataTable(forbes_clean,
                                        options = list(scrollX= T,
                                                       scrollY = T) )
  
    
  
  
  output$plot_3 <- renderPlotly({
    plot_forbest2 <- ggplot(forbes_trend, aes(x = Rank, y = avg_Sales)) +
      # group = 1 -> hanya akan buat 1 garis 
      geom_line(group = 2, # text tidak bisa dimasukan ke ggplot/geom kl geom_line
                col = "seagreen") + 
      geom_point( aes(text = label), col = "Red") + 
      labs(title = NULL,
           x = "Rank",
           y = "Average Profit") +
      
      theme_light()
    ggplotly (plot_forbest2, tooltip = "text")
    
    
    
  })
  
  output$plot_4 <- renderPlotly({
    forbes4 <- forbes_clean %>% 
      filter(Sales > Assets) %>%
      group_by(Country) %>% 
      summarise(Total_Profit = sum(Profit)) %>% 
      ungroup() %>% 
      arrange(desc(Total_Profit)) %>% 
      mutate(label = glue ("Country: {Country}
                       Total Profit: {Total_Profit}"))
    
    
    
    forbes_glue4 <- forbes4 %>% 
      mutate(label = glue ("Country: {Country}
                       Total Profit: {Total_Profit}"))
    
    plotf4 <- ggplot(forbes_glue4, aes(y = Total_Profit,
                                     x =  reorder(Country, Total_Profit),text =label)) +
    geom_bar(stat="identity", fill="blue", alpha=1, width=.4)+
    coord_flip()+
    theme_minimal()+
    labs(x = NULL,
         y = "Total Profit",
         title = "Forbes Total Company Profit by Country") 
  
  ggplotly(plotf4, tooltip = "text")
  
  
  
  })
  
  
}

