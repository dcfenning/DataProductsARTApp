##server.r

##Function to take user input to select column to read, by age and statistic
##if stat user selected was data not requiring calculation then select col by age and statistic
##else if statistic user selected has had calculations on it then select col by age, statistic and the calculation

selected_col <- function(fstats_in,age_in){
  if(fstats_in %in% nocalcstats){
    user_selection <- paste(fstats_in,age_in, sep="")
  }else{
    user_selection <- paste(fstats_in,age_in,"calc", sep="")       
  }
  colnum <- which(names(fdata)==user_selection)
}

shinyServer(
        function(input, output){
                ####Loaded once per user#####

                incols <- reactive({selected_col(input$fstats_in,input$age_in)})       
            
                ##ouputs
                output$fstats_out <- renderText({paste("All data on this page are statistics for: ",names(which(fstats_list == input$fstats_in)))})
                                output$clinic_out <- renderText({paste("The statistic for the clinic, ",input$clinic_in,", is:")})
                output$state_out <- renderText({paste("The average for this statistic for: ",input$state_in," is:")})
                output$cstats_out <- renderText({fdata[which(fdata$PrevClinName1 == input$clinic_in),incols()]})
                
                output$smean_out <- renderText({
                              subset_data <- subset(fdata, fdata$ClinStateCode == input$state_in)
                              mean(subset_data[,incols()])
                             })

                output$allmean_out   <- renderDataTable({ 
                              setNames(aggregate(x=fdata[,incols()], by = list(fdata$ClinStateCode), FUN = mean, na.action = na.omit), c("State_Name","Average for State"))
                   },options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
                output$gplot_out <- renderGvis({
                              aggfdata <- setNames(aggregate(x=fdata[,incols()], by = list(fdata$ClinStateCode), FUN = mean, na.action = na.omit), c("State_Name","Average for State"))
                              G <- gvisGeoChart(aggfdata, locationvar = "State_Name", colorvar = "Average for State", hovervar ="State_Name", 
                                    options=list(region="US", displayMode="regions", resolution="provinces", title="Average per State",titlePosition='out',width=600, height=400))
                              plot(G)
                })
        }
)