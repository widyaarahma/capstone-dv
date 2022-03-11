ui <- dashboardPage(skin = "red",
                    dashboardHeader(title = "Forbes Top Company",
                                    tags$li(a(href = 'https://www.linkedin.com/in/widyarahma/',
                                              icon("linkedin"),
                                              title = "About the Author"),
                                            class = "dropdown"),
                                    tags$li(a(href = 'https://algorit.ma',
                                              icon("link"),
                                              title = "Project"),
                                                  
                                                  
                                            class = "dropdown"),
                    dropdownMenu(type="message",
                                 messageItem(
                                   from="System", 
                                   message="Welcome in Dashboard",
                                   icon=icon("life-ring"),
                                   time=substr(Sys.time(),1,10)
                                  )
                                 )
                    ),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Overview", tabName = "overview", icon = icon("certificate")),
      menuItem(text = "Insight", tabName = "insight", icon = icon("briefcase")),
      menuItem(text = "Data", tabName = "data", icon = icon("database")),
      menuItem(text = "About", tabName = "about", icon = icon("bullseye"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "overview",
              fluidPage(
                h2(tags$b("The Forbes Global")),
                br(),
                div(style = "text-align:justify",
                    p("The Forbes Global 2000 is an annual ranking of the top 2,000 public companies in the world by Forbes magazine. 
                      The ranking is based on a mix of four metrics: sales, profit, assets and market value. The list has been published since 2003.
                      Here some my analysis and data visualization about forbes top company in the world, the data was downloaded from Forbes List"),
                    br()
                )
              ),
              fluidRow(
                valueBox(width = 4,
                         value = n_distinct(forbes_trend$Rank),
                         subtitle = "Forbes Top Rank",
                         color = "maroon",
                         icon = icon("briefcase")),
                
                valueBox(width = 4,
                         value = n_distinct(forbes$Company),
                         subtitle = "Total Company",
                         color = "maroon",
                         icon = icon("building")),
                
                valueBox(width = 4,
                         value = n_distinct(forbes$Country),
                         subtitle = "Country",
                         color = "maroon",
                         icon = icon("globe-asia"))
              ),
              
              box(
                width = 12,
                selectInput(inputId = "Country",
                            label = "Select Country",  
                            choices = unique(forbes$Country),
                            selected = "Germany"
                )),
              fluidRow(
                box(title = "Total Market Value",
                    width = 12,
                    height = 600,
                    plotlyOutput(outputId = "plot_8"))
                )
                ),
      tabItem(
        tabName = "insight",
                fluidRow(
                  box( title = "Total Company per Country",
                    width = 11,
                    height = 500,
                    plotlyOutput(outputId = "plot_2")
                    )
                    ),
                fluidRow(
                  box(width = 12,
                      title = "Forbes 2021 Global 500 Companies Statistics",
                      DT::dataTableOutput(outputId = "table"))
                )
                ),
      
      tabItem(
        tabName = "data",
        fluidPage(
          br(),
          h2("Data"),
          div(style = "text-align:justify", 
              p("This visualization was made to analyze a bit more about the top country from company origin,
                the firs step is to filter all the data, which we want to analyze. In this part i have used the filter where
                sales is bigger than the market value, after that we can plot the graph, then the final result is shown below
                "),
              
              
              
              br()
              )
              ),
           fluidRow(box(
             width=12,
             height = 500,
             plotlyOutput(outputId = "plot_4")) 
          )
          ),
        
    
      
      tabItem(tabName = "about",
              
              fluidPage(
                h2(tags$b("About Me")),
                br(),
                div(style = "text-align:justify", 
                    h1("Forbes Company Visualization"),
                    h5("By ", a("Widya Rahma", href = "https://linkedin.com/in/widyarahma")),
                    h2("Dataset"),
                    p("This visualization was made using Top Forbes dataset which
                        published on ", (href = "https://www.forbes.com/lists/global2000/")),
                    h2("Library"),
                    p("Several R library that used to create this visualization are:"),
                    p("-  Tidyverse"),
                    p("-  Lubridate"),
                    p("-  Scales"),
                    p("-  Shiny"),
                    p("-  Shinydashboard"),
                
                    br()
                )
                ),
              fluidPage(
                width = 4,
                actionButton(inputId = "Kountry",
                            label = "Download Data Set",
                            onclick ="location.href='https://www.kaggle.com/kdsharmaai/forbes-2021-global-500-companies-statistics';"
                        
                            ))
               
              
              
      )  
    )   
  )
)