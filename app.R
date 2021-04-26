library(shiny)
library(emojifont)
library(emo)
library(stringr)
library(shinyjs)
library(shinyMobile)

image_address <- "https://www.honestcookingblog.com/recipes/images/"
recipe_address <- "https://www.honestcookingblog.com/recipes/"

recipes <- list(c("Sambar","sambar.jpg","sambar.html","e2 r4 main vege curry indian healthy instantpot"),
                c("Chai creme brulee","cremebrulee.jpg","chaicremebrulee.html","e2 r4 dessert pudding instantpot"),
                c("Naan Two Ways","naan.jpg","naan.html","e1 r3 side bread indian instantpot"),
                c("Beef Stock","beefstock.jpg","beefstock.html","e1 r3 beef instantpot staple"),
                c("Massaman","massaman.jpg","massaman.html","e3 r4 main thai curry beef winter"),
                c("Aloo Mushroom Masala","matarmushroom.jpg","aloomushroom.html","e2 r3 main indian curry vege healthy instantpot"),
                c("Italian Beef Rolls","italianbeef.jpg","italianbeef.html","e1 r3 light burger italian instantpot"),
                c("Zuppa Toscana","zuppatoscana.jpg","zuppatoscana.html","e2 r4 main soup winter italian"),
                c("Rice Kheer","kheer.jpg","ricekheer.html","e1 r3 dessert summer instantpot pudding"),
                c("Pumpkin gnocchi","gnocchi.jpg","pumpkingnocchi.html","e2 r3 pasta main light vege autumn italian"),
                c("Pear Pistachio Tart","peartart.jpg","PearPistachioTart.html","e2 r3 cake dessert tea"),
                c("Dutch Baby","dutchbaby.jpg","dutchbaby.html","e1 r3 breakfast"),
                c("Fish finger sandwich","fishsandwich.jpg","fishfingersandwich.html","e1 r3 light burger fish healthy"),
                c("Lavendar cheesecake","lavendarcheesecake.jpg","lavendarcheesecake.html","e2 r3 tea cake italian instantpot freezable"),
                c("Vodka Rigatoni","vodkarigatoni.jpg","vodkarigatoni.html","e1 r1 light pasta italian healthy vege"),
                c("Italian Poached Fish","italianfish.jpg","italianpoachedfish.html","e2 r2 main fish italian healthy summer"),
                c("Marinara Sauce (IP)","marinara.jpg","marinara.html","e2 r3 main light pasta vege instantpot italian"),
                c("Tuscan Bean Soup","tuscanbeansoup.jpg","tuscanbeansoup.html","e2 r3 main healthy vege soup italian"),
                c("Beetroot curry","beetrootcurry.jpg","beetrootcurry.html","e1 r4 main curry healthy vege")
        
                )


values <- c('noodles','pasta','soup','curry','pancake','salad','fish','chicken','pork','beef','lamb','game','mushroom','bread','burger','bento','cake','cookie','pudding','icecream','drink','summer','winter','autumn','spring','christmas','easter','party','kids')
names(values) <- c(127836,127837,127858,127835,129374,129367,128031,128020,128055,128046,128017,129420,127812,127838,127828,127857,127856,127850,127854,127846,127865,9728,10052,127810,127793,127876,128048,127882,128103)


path <- "C:\\Users\\bonmc643\\CookingBlog\\app.R"
# Define UI for application that draws a histogram
ui <- fluidPage(
useShinyjs(),
    # Application title
        h4("Search for recipes here"),
        fluidRow(
            column(2,class = "col-xs-5",
                   selectInput("meal","Meal:",c("Breakfast","Light Meal","Main","Tea","Dessert","Side","Staple"),selected = "Main")),
            
            column(2,class = "col-xs-3", sliderInput("effort",
                             "Effort:",
                             min = 1,
                             max = 4,
                             pre=emoji('persevere'),value=c(1,4))),
                 column(2,class = "col-xs-3",
                 sliderInput("reward",
                             "Reward:",
                             min = 1,
                             max = 4,
                             pre=emoji('yum'),value=c(1,4)))),
        fluidRow(
            column(1,class = "col-xs-2",
                   checkboxGroupInput("type","Type:",choices=c(
                      emoji("ramen"),
                      emoji("spaghetti"),
                      emoji("stew"),
                      emoji("curry"),
                      emoji("pancakes"),
                      emoji("green_salad"),
                      emoji("fish"),
                      emoji("chicken"),
                      emoji("pig"),
                      emoji("cow"),
                      emoji("sheep"),
                      emoji("deer"),
                      emoji("mushroom"),
                      emoji("bread"),
                      emoji("hamburger"),
                      emoji("bento"),
                      emoji("cake"),
                      emoji("cookie"),
                      emoji("custard"),
                      emoji("icecream"),
                      emoji("tropical_drink")
                   ))
            ),
            column(1,class = "col-xs-3",
                   checkboxGroupInput("plus","Plus:",c("healthy","vege","instant pot")),
                   checkboxGroupInput("season","Season:",c(emoji("sunny"),emoji("fallen_leaf"),emoji("snowflake"),emoji("seedling"))),
                   checkboxGroupInput("occassion","Occassion:",c(emoji("christmas_tree"),emoji("rabbit"),emoji("confetti_ball"),emoji("girl"))),
                   checkboxGroupInput("cuisine","Cuisine:",c("Australian","Swedish","British","Japanese","Korean","Dutch","Italian","Indian","Thai")))
                   
            ,            
            column(10,class = "col-xs-7",flowLayout(
                htmlOutput("r1"),
                htmlOutput("r2"),
                htmlOutput("r3"),
                htmlOutput("r4"),
                htmlOutput("r5"),
                htmlOutput("r6"),
                htmlOutput("r7"),
                htmlOutput("r8"),
                htmlOutput("r9"),
                htmlOutput("r10"),
                htmlOutput("r11"),
                htmlOutput("r12"),
                htmlOutput("r13"),
                htmlOutput("r14"),
                htmlOutput("r15"),
                htmlOutput("r16"),
                htmlOutput("r17"),
                htmlOutput("r18"),
                htmlOutput("r19"),
                htmlOutput("r20")
                
            )),
            
        )
)

recipe_spots <- 20

# Define server logic required to draw a histogram
server <- function(input, output) {

    # first restrict it to the selected meal, effort and reward

    update_display <- function(){
        show_vals <- c()
        hide <- c()
        selected_meal <- str_to_lower(input$meal)
        if(selected_meal=='light meal'){selected_meal <- 'light'}
        selected_effort <- input$effort
        selected_reward <- input$reward
        effort_range <- selected_effort[1]:selected_effort[2]
        reward_range <- selected_reward[1]:selected_reward[2]
        
        
        # first do meal, effort, reward
        for (i in 1:length(recipes)){
            description <- recipes[[i]][4]
            effort <- str_split(description," ")[[1]][1]
            effort <- as.numeric(str_remove(effort,"e"))
            reward <- str_split(description," ")[[1]][2]
            reward <- as.numeric(str_remove(reward,"r"))
            if(grepl(selected_meal,description)&(reward %in% reward_range)&(effort %in% effort_range)){
                if(!(i %in% show_vals)){
                    
                    # check for additional filters
                    if(is.character(input$type)){
                        more_filters <- c()
                        selected_types <- input$type
                        for(type in selected_types){
                            key <- utf8ToInt(type)
                            name <- values[as.character(key)][[1]]
                            if(!(name %in% more_filters)){more_filters <- c(more_filters,name)}
                        }
                        for(filter in more_filters){
                            if((grepl(filter,description))){
                                # show it
                                show_vals <- c(show_vals,i)
                            }else{hide <- c(hide,i)}
                        }
                    }else{show_vals <- c(show_vals,i)}
                    
                    # check for plus filters
                    if(is.character(input$plus)){
                        more_filters <- input$plus
                        for(filter in more_filters){
                            if(!(grepl(str_replace(filter," ",""),description))){
                                # remove it from show
                                show_vals <- show_vals[which(show_vals!=i)]
                                
                                # add it to hide
                                hide <- c(hide,i)
                            } 
                        }
                    }
                    
                    # check for season filters
                    if(is.character(input$season)){
                        more_filters <- c()
                        selected <- input$season
                        for (selection in selected){
                            key <- utf8ToInt(selection)
                            name <- values[as.character(key)][[1]]
                            if(!(name %in% more_filters)){more_filters <- c(more_filters,name)}
                        }
                        
                        for(filter in more_filters){
                            if(!(grepl(str_replace(filter," ",""),description))){
                                # remove it from show
                                show_vals <- show_vals[which(show_vals!=i)]
                                
                                # add it to hide
                                hide <- c(hide,i)
                            } 
                        }
                    }
                    
                    
                    # check for occassion filters
                    if(is.character(input$occassion)){
                        more_filters <- c()
                        selected <- input$occassion
                        for (selection in selected){
                            key <- utf8ToInt(selection)
                            name <- values[as.character(key)][[1]]
                            if(!(name %in% more_filters)){more_filters <- c(more_filters,name)}
                        }
                        print(more_filters)
                        for(filter in more_filters){
                            if(!(grepl(str_replace(filter," ",""),description))){
                                # remove it from show
                                show_vals <- show_vals[which(show_vals!=i)]
                                
                                # add it to hide
                                hide <- c(hide,i)
                            } 
                        }
                    }
                    
                    # check for cuisine filters
                    if(is.character(input$cuisine)){
                        more_filters <- input$cuisine
                        for(filter in more_filters){
                            if(!(grepl(str_to_lower(filter),description))){
                                # remove it from show
                                show_vals <- show_vals[which(show_vals!=i)]
                                
                                # add it to hide
                                hide <- c(hide,i)
                            } 
                        }
                    }
                    
                }
            }
             else{
                 hide <- hide(hide,i)
             }
        }
        
        

        
        
        if(length(show_vals)!=0){
            lapply(1:length(show_vals),function(j){
                outputId <- paste0("r", j)
                recipe_num <- show_vals[j]
                src <- paste(image_address,recipes[[recipe_num]][2],sep = '')
                caption <- recipes[[recipe_num]][1]
                source <- paste(recipe_address,recipes[[recipe_num]][3],sep='')
                output[[outputId]] <- renderText({c('<figure><a href="',source,'"><img src="',src,'" width=150 height=150 style="padding-top: 10px;"></a><figcaption>',caption,'</figcaption></figure>')})
                show(outputId)
                for(j in (length(show_vals)+1):recipe_spots){
                    outputId <- paste0("r", j)
                    hide(outputId)
                }
                
            })   }else{
                for(j in 1:length(recipes)){outputId <- paste0("r",j)
                hide(outputId)}
            } 
    
    }
    observeEvent(input$meal,update_display())
    observeEvent(input$effort,update_display())
    observeEvent(input$reward,update_display())
    observeEvent(input$type,update_display(),ignoreNULL = FALSE)
    observeEvent(input$plus,update_display(),ignoreNULL = FALSE)
    observeEvent(input$season,update_display(),ignoreNULL = FALSE)
    observeEvent(input$occassion,update_display(),ignoreNULL = FALSE)
    observeEvent(input$cuisine,update_display(),ignoreNULL = FALSE)
    
    
}


# Run the application 
shinyApp(ui = ui, server = server)
