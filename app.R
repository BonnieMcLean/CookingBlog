library(shiny)
library(emojifont)
library(emo)
library(stringr)
library(shinyjs)
library(shinyMobile)

image_address <- "https://www.honestcookingblog.com/recipes/images/"
recipe_address <- "https://www.honestcookingblog.com/recipes/"

recipes <- list(c("Dal Makhani","dalmakhani.jpg","DalMakhani.html","e1 r3 main indian instantpot vege curry"),
  c("Lorighittas with chicken","lorighittas.jpg","lorighittas.html","e4 r4 italian main pasta chicken summer"),
  c("Rhubarb & Elderflower cake","rhubarb-elderflower-cake.jpg","elderflowerrhubarb.html","e2 r3 tea cake summer"),
                c("Elderflower cordial","elderflowercordial.jpg","elderflowercordial.html","e1 r4 drink summer"),
  c("Ciambella","ciambella.jpg","ricottacake.html","e1 r3 cake tea italian"),
  c("Chicken & Wild Garlic Pie","wildgarlicpie.jpg","wildgarlicpie.html","e4 r4 british spring chicken main"),
                c("Rough Puff Pastry","roughpuff.jpg","roughpuff.html","e2 r4 staple"),
  c("Swedish Strawberry Cake","swedishstrawberry.jpg","swedishstrawberry.html","e1 r4 swedish tea cake summer"),
  c("Cornflake crusted chicken","cornflakechicken.jpg","chickencornflake.html","e1 r3 chicken main summer"),
  c("Rhubarb Panna Cotta","rhubarbpannacotta.jpg","rhubarbpannacotta.html","e1 r3 dessert pudding spring summer italian swedish"),
  c("Toasted marshmallow & rhubarb cake","rhubarbmarshmallow.jpg","rhubarbmarshmallow.html","e3 r4 tea cake summer spring"),
  c("Japchae","japchae.jpg","japchae.html","e3 r4 noodles main party healthy korean vege summer mushroom beef"),
                c("Chai creme brulee","cremebrulee.jpg","chaicremebrulee.html","e2 r4 dessert pudding summer instantpot"),
                c("Naan Two Ways","naan.jpg","Naan.html","e1 r3 side bread indian instantpot"),
                c("Beef Stock","beefstock.jpg","beefstock.html","e1 r3 beef instantpot staple"),
                c("Massaman","massaman.jpg","massaman.html","e3 r4 main thai curry beef winter"),
                c("Aloo Mushroom Masala","matarmushroom.jpg","AlooMushroom.html","e2 r3 main indian curry mushroom vege healthy instantpot"),
                c("Italian Beef Rolls","italianbeef.jpg","italianbeef.html","e1 r3 light burger italian instantpot"),
                c("Zuppa Toscana","zuppatoscana.jpg","zuppatoscana.html","e2 r4 main soup winter italian"),
                c("Rice Kheer","kheer.jpg","ricekheer.html","e1 r3 dessert summer instantpot pudding"),
                c("Pumpkin gnocchi","gnocchi.jpg","pumpkingnocchi.html","e2 r3 pasta main light vege autumn italian"),
                c("Pear Pistachio Tart","peartart.jpg","PearPistachioTart.html","e2 r3 cake dessert tea summer winter"),
                c("Dutch Baby","dutchbaby.jpg","dutchbaby.html","e1 r3 breakfast"),
                c("Fish finger sandwich","fishsandwich.jpg","fishfingersandwich.html","e1 r3 light burger fish healthy"),
                c("Vodka Rigatoni","vodkarigatoni.jpg","vodkarigatoni.html","e1 r1 light pasta italian healthy vege"),
                c("Acqua Pazza","italianfish.jpg","italianpoachedfish.html","e2 r3 main fish italian healthy summer"),
                c("Marinara Sauce (IP)","marinara.jpg","marinara.html","e2 r3 main light pasta vege instantpot italian"),
                c("Tuscan Bean Soup","tuscanbeansoup.jpg","tuscanbeansoup.html","e2 r3 main healthy vege soup italian"),
                c("Beetroot curry","beetrootcurry.jpg","beetrootcurry.html","e1 r4 main curry healthy vege"),
                c("Thai Red Curry","thairedcurry.jpg","thairedcurry.html","e1 r2 curry thai summer chicken main healthy"),
                c("Breton Tiramisu","bretontiramisu.jpg","bretontiramisu.html","e3 r4 dessert pudding summer"),
                c("Mushroom and wild rice","mushroomwildrice.jpg","mushroomwildrice.html","e1 r2 mushroom soup healthy vege winter main instantpot"),
                c("Nishime","nishime.jpg","nishime.html","e2 r3 main instantpot japanese stew healthy vege winter bento light"),
                c("Teriyaki chicken","teriyakichicken.jpg","teriyakichicken.html","e1 r2 main light chicken japanese"),
                c("Moroccan carrot and pumpkin soup","moroccansoup.jpg","moroccansoup.html","e2 r2 main soup healthy vege freezable"),
                c("Cornbread","chickenchili.jpg","cornbread.html","e1 r2 side vege"),
                c("Chicken chili","chickenchili.jpg","whitechilichicken.html","e1 r3 main chicken healthy instantpot"),
                c("Pomegranate jewel cake","pomegranatecake.jpg","pomegranatecake.html","e2 r3 cake tea"),
                c("Lemonade (Instant Pot)","lemonade.jpg","lemonade.html","e1 r3 healthy drink citrus instantpot"),
                c("African Peanut Stew","peanutstew.jpg","peanutstew.html","e2 r3 healthy vege main curry instantpot"),
                c("Coriander and lime pesto","corianderpesto.jpg","corianderlimepesto.html","e1 r1 healthy light main vege pasta fish"),
                c("Pea and pesto soup","peapestosoup.jpg","peapestosoup.html","e1 r2 soup healthy light vege winter"),
                c("Christmas Sponge","christmascake.jpg","japanesechristmas.html","e4 r4 cake dessert freezable tea christmas party summer japanese"),
                c("Chicken stock","chickenstock.jpg","chickenstock.html","e1 r3 chicken soup instantpot healthy staple"),
                c("Pickled red cabbage","norwegianpork.jpg","pickledredcabbage.html","e1 r3 side winter vege healthy swedish"),
                c("Instant pot mash","goulash.jpg","instantpotmash.html","e1 r3 side instantpot"),
                c("Jansson's Temptation","norwegianpork.jpg","janssonstemptation.html","e1 r2 side swedish"),
                c("Norwegian Pork Belly","norwegianpork.jpg","norwegianporkbelly.html","e2 r4 pork main christmas swedish winter"),
                c("Goulash","goulash.jpg","goulash.html","e2 r3 pork curry main winter freezable"),
                c("Sticky gingerbread","gingerbread.jpg","gingerbread.html","e1 r2 cake tea dessert christmas winter"),
                c("Lemon elderflower drizzle","lemonelderflower.jpg","lemonelderflower.html","e1 r2 citrus cake pudding tea dessert summer swedish"),
                c("Creme caramel","cremecaramel.jpg","cremecaramel.html","e1 r3 dessert pudding summer"),
                c("Gozleme","gozleme.jpg","gozleme.html","e2 r3 light vege pancake"),
                c("Apple tea cake","appleteacake.jpg","appleteacake.html","e1 r3 cake freezable tea"),
                c("Fried chicken burger","chickenburger.jpg","chickenburger.html","e2 r4 main chicken burger"),
                c("Moose burger","mooseburger.jpg","mooseburger.html","e1 r4 main game burger"),
                c("Moose stew","moosestew.jpg","moosestew.html","e2 r2 main swedish game mushroom autumn curry"),
                c("Pumpkin soup","pumpkinsoup.jpg","pumpkinsoup.html","e1 r1 autumn main light soup healthy"),
                c("Kladdkaka","kladkakka.jpeg","kladdkaka.html","e1 r3 swedish cake tea"),
                c("Gotlandish lamb stew","lambstew.jpg","lambstew.html","e2 r3 swedish lamb main winter curry"),
                c("Wild mushroom barley","mushroombarley.jpg","mushroombarley.html","e1 r2 mushroom swedish main autumn vege healthy"),
                c("Easy yeast bread","yeastbread.jpg","yeastbread.html","e1 r2 bread side staple freezable"),
                c("Chai choc cookies","chaicookie.jpg","chaicookies.html","e1 r1 tea cookie freezable bento"),
                c("Totally choc cookies","choccoookie.jpg","chocolatecookies.html","e1 r4 tea cookie kids freezable bento"),
                c("Cream cheese frosting","creamcheesefrost.jpg","creamcheesefrosting.html","e1 r2 cake staple"),
                c("Fluffy cupcakes","cupcakes.jpg","cupcakes.html","e2 r3 cake tea party kids bento"),
                c("Matsutake gohan","mushroomrice.jpg","shimejigohan.html","e1 r1 japanese vege bento light healthy mushroom"),
                c("Yakitori","yakitori.jpg","yakitori.html","e1 r2 japanese bento chicken party kids light"),
                c("Butter chicken","butterchicken.jpg","butterchicken.html","e2 r4 main chicken curry indian freezable"),
                c("Mongolian lamb","mongolianlamb.jpg","mongolianlamb.html","e1 r4 main lamb australian"),
                c("Crunchy sticky tofu","crunchytofu.jpg","crunchytofu.html","e1 r2 light main vege korean bento"),
                c("Chocolate saucy pudding","chocolatepudding.jpg","chocolatepudding.html","e2 r3 british pudding dessert winter"),
                c("Chocolate cake","chocolatecake.jpg","chocolatecake.html","e2 r3 cake tea"),
                c("Italian meatballs","italianmeatballs.jpg","meatballsitalien.html","e2 r3 italian beef pork freezable main pasta"),
                c("Pizza scrolls","pizzascrolls.jpg","pizzascrolls.html","e1 r1 light freezable bread kids bento"),
                c("Pouring custard","custard.jpg","custard.html","e1 r2 dessert icecream staple"),
                c("Cheesymite scrolls","cheesymite.jpg","vegemitescrolls.html","e1 r1 light freezable bread bento kids australian vege"),
                c("Chicken mushroom pie","chickenpie.jpg","chickenpie.html","e2 r4 chicken pie main british freezable mushroom"),
                c("Fairy cakes","fairycakes.jpg","fairycakes.html","e2 r2 kids tea cake british"),
                c("Pistachio icecream","pistachioice.jpg","pistachioice.html","e1 r3 icecream dessert"),
                c("Black sesame icecream","blacksesame.jpg","blacksesame.html","e1 r3 icecream dessert"),
                c("Chicken nuggets","chickennuggets.jpg","chickennuggets.html","e1 r3 light chicken main kids freezable party"),
                c("Strawberry icecream","strawberryice.jpg","strawberryice.html","e2 r3 icecream freezable dessert"),
                c("Lamingtons","lamingtons.jpg","lamington.html","e3 r3 cake australian tea bento freezable kids party"),
                c("Tonkatsu","tonkatsu.jpg","tonkatsu.html","e2 r4 main pork japanese"),
                c("Lemon fish","whitefish.jpg","lemonfish.html","e1 r3 main citrus fish summer healthy"),
                c("BBQ marinated salmon","grilledsalmon.jpg","bbqsalmon.html","e1 r4 main fish healthy"),
                c("Sticky oyster salmon","glazedsalmon.jpg","glazedsalmon.html","e1 r3 main fish healthy"),
                c("Teriyaki salmon","teriyaki.jpg","teriyakisalmon.html","e1 r3 main fish summer japanese healthy"),
                c("Kimchi pancake","kimchipancake.jpg","kimchipancake.html","e1 r2 light pancake vege korean bento"),
                c("Lime Yoghurt Cake","limecake.jpg","limecake.html","e2 r2 tea citrus cake freezable"),
                c("Pork chop marinade","porkchops.jpg","porkchops.html","e1 r1 main summer pork"),
                c("Pavlova","pavlova.jpg","pavlova.html","e1 r4 cake dessert party australian summer tea christmas"),
                c("Golden Pudding","goldenpudding.jpg","goldenpudding.html","e2 r3 pudding citrus dessert winter british"),
                c("Easy raspberry mousse","raspberrymousse.jpg","raspberrymousse.html","e1 r2 dessert summer party pudding"),
                c("Rice paper rolls","ricerolls.jpg","ricerolls.html","e2 r2 healthy light salad summer bento party fish"),
                c("Eggplant curry","eggplantcurry.jpg","eggplantcurry.html","e3 r4 healthy main indian freezable curry vege summer"),
                c("Mustard pork chops","mustardpork.jpg","mustardporkchops.html","e1 r2 pork main"),
                c("Palak Paneer","palakpaneer.jpg","palakpaneer.html","e2 r4 curry indian main vege freezable instantpot summer"),
                c("Mushroom Pork Chops","mushroompork.jpg","mushroomporkchops.html","e2 r2 main pork mushroom"),
                c("Carrot cake","carrotcake.jpg","carrotcake.html","e3 r4 cake tea freezable"),
                c("Kimchi and tuna stew","kimchistew.jpg","kimchistew.html","e1 r4 soup fish main healthy korean winter"),
                c("Tomato soup","tomatosoup.jpg","tomatosoup.html","e2 r2 main vege freezable soup healthy winter"),
                c("Lemon delicious","lemondelicious-min.jpg","lemondelicious.html","e2 r4 pudding citrus dessert summer australian"),
                c("Thai beef salad","thaisalad-min.jpg","beefsalad.html","e1 r4 main salad light thai party summer beef healthy"),
                c("Borscht","borscht.jpg","borscht.html","e3 r4 main soup vege healthy freezable winter"),
                c("Corn fritters","cornfritters.jpg","cornfritters.html","e3 r3 main party pancake summer light vege"),
                c("Fancy lemon cake","fancylemon.jpg","fancylemon.html","e4 r4 tea citrus cake"),
                c("Golden soup","cauliflowersoup.jpg","cauliflowersoup.html","e2 r3 main freezable healthy soup vege winter"),
                c("Fish pie","fishpie.jpg","fishpie.html","e2 r3 main fish easter healthy british pie"),
                c("Tantanmen","tantanmen.jpg","tantanmen.html","e3 r3 main noodles pork japanese"),
                c("Caramel croissant pudding","caramelpudding.jpg","caramelcroissantpudding.html","e1 r3 dessert winter british pudding"),
                c("Chocolate pear pudding","chocolatepearpudding.jpg","chocolatepearpudding.html","e1 r3 pudding dessert british winter"),
                c("Zoervleesj","zoervleesj.jpg","zoervleesj.html","e3 r4 main christmas freezable winter beef game curry dutch"),
                c("Grilled pork belly","grilledpork.jpg","grilledporkbelly.html","e1 r3 main summer party light pork korean"),
                c("Curry rice","curryrice.jpg","curryrice.html","e2 r3 main beef curry freezable japanese winter"),
                c("Tomato pea curry","tomatocurry.jpg","tomatopeacurry.html","e2 r3 curry main healthy vege"),
                c("Mushroom risotto","mushroomrisotto.jpg","mushroomrisotto.html","e3 r4 pasta main italian winter mushroom"),
                c("Fruit crumbles","cherrycrumble-min.jpg","crumble.html","e2 r3 pudding dessert british summer winter"),
                c("Mango sticky rice","mangosticky.jpg","mangostickrice.html","e2 r4 dessert thai party pudding summer"),
                c("Creamy anchovy pasta","gemelli.jpg","gemelli.html","e2 r3 pasta light italian"),
                c("Crepes","crepe.jpg","crepes.html","e1 r3 breakfast pancake"),
                c("Golden curry","goldencurry.jpg","goldencurry.html","e2 r4 main curry fish summer"),
                c("Sticky toffee pudding","toffeepudding.jpg","stickytoffeepudding.html","e2 r2 dessert pudding british winter"),
                c("Pumpkin prawn curry","pumpkincurry.jpg","pumpkincurry.html","e2 r3 main curry fish healthy autumn"),
                c("Lemon drizzle","lemondrizzle.jpg","lemondrizzle.html","e1 r1 cake citrus summer freezable tea"),
                c("Beef stroganoff", "stroganoff.jpg","stroganoff.html","e2 r3 main beef pasta mushroom freezable"),
                c("Orange Yoghurt Cake","orangecake.jpg","Orange%20Yoghurt%20Bundt.html","e2 r2 cake citrus tea summer"),
                c("Hot Cross Buns","hotcrossbuns.jpg","hotcrossbuns.html","e4 r4 tea easter british bento freezable spring cake bread"),
                c("Sambar","sambar.jpg","sambar.html","e2 r4 main vege curry indian healthy instantpot"),
                c("Chicken noodle soup","chickennoodlesoup.jpg","chickennoodlesoup.html","e3 r3 soup noodle chicken main healthy winter"),
                c("Lavendar cheesecake","lavendarcheesecake.jpg","lavendarcheesecake.html","e2 r3 tea cake italian instantpot freezable"),
                c("Bulgogi","kbbq.jpg","bulgogi.html","e2 r4 main beef party vege summer korean"),
                c("Chinese Pork Belly","porkbellycrispy.jpg","crispyporkbelly.html","e2 r4 main pork party christmas summer winter"),
                c("Rissoles","rissoles.jpg","rissoles.html","e1 r2 main beef healthy australian"),
                c("Tempura","tempura.jpg","tempura.html","e2 r3 main vege party japanese"),
                c("Pumpkin Lasagne","pumpkinlasagne.jpg","pumpkinlasagne.html","e4 r3 main vege autumn"),
                c("Tangy Irish Soda Bread","sodabread.jpg","sodabread.html","e1 r2 bread staple side freezable"),
                c("Granola","granola.jpg","granola.html","e1 r2 breakfast"),
                c("Banana bread","bananabread.jpg","bananabread.html","e1 r1 cake freezable breakfast tea"),
                c("Spring chicken","springchicken.jpg","springchicken.html","e2 r3 main chicken healthy spring"),
                c("Lemon chicken breasts","lemonchicken.jpg","lemonchicken.html","e1 r2 main citrus chicken"),
                c("Chicken shawarma","chickenshawarma.jpg","chickenshawarma.html","e1 r4 chicken main party summer"),
                c("Chicken Adobo","adobo.jpg","adobo.html","e1 r1 chicken party main"),
               # c("Spaghetti Bolognaise","spaghetti.jpg","slowcookspaghetti.html","e2 r4 pasta main freezable beef"),
               c("Egg Noodles","eggnoodles.jpg","eggnoodles.html","e3 r3 pasta staple noodle"),
               c("Lemon tuna pasta","lemonpasta-min.jpg","lemonpasta.html","e1 r1 healthy light fish pasta summer"),
               c("Vanilla icecream","icecream.jpg","icecream-vanilla.html","e1 r2 icecream dessert staple"),
               c("Christine's sick soup","sicksoup.jpg","sicksoup.html","e2 r3 main freezable healthy soup vege winter"),
  c("Chinese chicken & corn soup","chinesechickensoup.jpg","chickencornsoup.html","e1 r1 main light chicken soup healthy")
                )


names(recipes) <- c(1:length(recipes))


values <- c('noodles','pasta','soup','curry','pancake','salad','fish','chicken','pork','beef','lamb','game','mushroom','bread','burger','bento','cake','cookie','pudding','icecream','drink','summer','winter','autumn','spring','christmas','easter','party','kids','citrus')
names(values) <- c(127836,127837,127858,127835,129374,129367,128031,128020,128055,128046,128017,129420,127812,127838,127828,127857,127856,127850,127854,127846,127865,9728,10052,127810,127793,127876,128048,127882,128103,127819)


path <- "C:\\Users\\bonmc643\\CookingBlog\\app.R"


ui <- fluidPage(
useShinyjs(),
        h4(paste("Search for recipes here, there are",as.character(length(recipes)),"recipes available.")),
        fluidRow(
            column(2,class = "col-xs-5",
                   selectInput("meal","Meal:",c("Breakfast","Light Meal","Main","Tea","Dessert","Side","Staple","Drink"),selected = "Main")),
            
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
                      emoji("lemon"),
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
                htmlOutput("r20"),
                htmlOutput("r21"),
                htmlOutput("r22"),
                htmlOutput("r23"),
                htmlOutput("r24"),
                htmlOutput("r25"),
                htmlOutput("r26"),
                htmlOutput("r27"),
                htmlOutput("r28"),
                htmlOutput("r29"),
                htmlOutput("r30"),
                hidden(actionButton("nextbutton","Show more"))
            ))
            
            
        )
)


recipe_spots <- 32

# type # plus # season # occasion # cuisine
filters <- list('main',1:4,1:4,'empty','empty','empty','empty','empty')

# Define server logic required to draw a histogram
server <- function(input, output) {
  
update_display <- function(){
  show_vals <- c()
  n <- 1
  for(recipe in recipes){
    description <- recipe[4]
    effort <- str_split(description," ")[[1]][1]
    effort <- as.numeric(str_remove(effort,"e"))
    reward <- str_split(description," ")[[1]][2]
    reward <- as.numeric(str_remove(reward,"r"))
    
    meal <- filters[[1]]
    effort_range <- filters[[2]]
    reward_range <- filters[[3]]
    
    if(grepl(meal,description)&
       effort %in% effort_range&
       reward %in% reward_range){
       show_vals <- c(show_vals,n)
    }
    n <- n+1
  }
  
  types <- filters[[4]]
  if(types!="empty"){
    # take everything out of show_vals
    temp_storage <- show_vals
    show_vals <- c()
    
    # now only put back in those that match one of the types
    for(recipe in temp_storage){
      description <- recipes[[as.character(recipe)]][4]
      for(filter in types){
        if(grepl(filter,description)){
          show_vals <- c(show_vals,recipe)
      }
    }
  }}
  
  plus <- filters[[5]]
  if(plus!='empty'){
    for(recipe in show_vals){
      description <- recipes[[as.character(recipe)]][4]
      for(filter in plus){
        if(!(grepl(filter,description))){show_vals <- show_vals[which(show_vals!=recipe)]}
      }
    }
  }
  
  season <- filters[[6]]
  if(season!="empty"){
    # take everything out of show_vals
    temp_storage <- show_vals
    show_vals <- c()
    
    # now only put back in those that match one of the types
    for(recipe in temp_storage){
      description <- recipes[[as.character(recipe)]][4]
      for(filter in season){
        if(grepl(filter,description)){
          show_vals <- c(show_vals,recipe)
        }
      }
    }}
  
  occassion <- filters[[7]]
  if(occassion!="empty"){
    # take everything out of show_vals
    temp_storage <- show_vals
    show_vals <- c()
    
    # now only put back in those that match one of the types
    for(recipe in temp_storage){
      description <- recipes[[as.character(recipe)]][4]
      for(filter in occassion){
        if(grepl(filter,description)){
          show_vals <- c(show_vals,recipe)
        }
      }
    }}
  
  cuisine <- filters[[8]]
  if(cuisine!="empty"){
    # take everything out of show_vals
    temp_storage <- show_vals
    show_vals <- c()
    
    # now only put back in those that match one of the types
    for(recipe in temp_storage){
      description <- recipes[[as.character(recipe)]][4]
      for(filter in cuisine){
        if(grepl(filter,description,ignore.case = TRUE)){
          show_vals <- c(show_vals,recipe)
        }
      }
    }}
  
  show_vals<<-show_vals
#   print(show_vals)
  if(length(show_vals)!=0){
    lapply(1:12,function(j){
      outputId <- paste0("r", j)
      recipe_num <- show_vals[j]
      src <- paste(image_address,recipes[[recipe_num]][2],sep = '')
      caption <- recipes[[recipe_num]][1]
      source <- paste(recipe_address,recipes[[recipe_num]][3],sep='')
      output[[outputId]] <- renderText({c('<figure><a href="',source,'" target="_blank"><img src="',src,'" width=150 height=150 style="padding-top: 10px;"></a><figcaption>',caption,'</figcaption></figure>')})
      show(outputId)
      for(j in (length(show_vals)+1):recipe_spots){
        outputId <- paste0("r", j)
        hide(outputId)
      }
      
    })   }else{
      for(j in 1:length(recipes)){outputId <- paste0("r",j)
      hide(outputId)}
    }
  
  if(length(show_vals)>12){show("nextbutton")}else{hide("nextbutton")}
  
  }
    
update_meal <- function(){
  selected_meal <- str_to_lower(input$meal)
  if(selected_meal=='light meal'){selected_meal <- 'light'}
  filters[[1]] <<- selected_meal
  update_display()
}

update_effort <- function(){
  selected_effort <- input$effort
  effort_range <- selected_effort[1]:selected_effort[2]
  filters[[2]]<<-effort_range
  update_display()
}

update_reward <- function(){
  selected_reward <- input$reward
  reward_range <- selected_reward[1]:selected_reward[2]
  filters[[3]]<<-reward_range
  update_display()
}

update_type <- function(){
  more_filters <- c()
  selected_types <- input$type
  for(type in selected_types){
    key <- utf8ToInt(type)
    name <- values[as.character(key)][[1]]
    if(!(name %in% more_filters)){more_filters <- c(more_filters,name)}
  }
  if((is.null(more_filters))){filters[[4]] <<- 'empty'}else{filters[[4]] <<- more_filters}
  update_display()
}

update_plus <- function(){
  more_filters <- input$plus
  if((is.null(more_filters))){filters[[5]] <<- 'empty'}else{filters[[5]] <<- replace(more_filters,more_filters=="instant pot","instantpot")}
  update_display()
}

update_season <- function(){
  selected <- input$season
  more_filters <- c()
  for (selection in selected){
    key <- utf8ToInt(selection)
    name <- values[as.character(key)][[1]]
    if(!(name %in% more_filters)){more_filters <- c(more_filters,name)}
  }
  if((is.null(more_filters))){filters[[6]] <<- 'empty'}else{filters[[6]] <<- more_filters}
  update_display()
}

update_occassion <- function(){
  more_filters <- c()
  selected <- input$occassion
  for (selection in selected){
    key <- utf8ToInt(selection)
    name <- values[as.character(key)][[1]]
    if(!(name %in% more_filters)){more_filters <- c(more_filters,name)}
  }
  if((is.null(more_filters))){filters[[7]] <<- 'empty'}else{filters[[7]] <<- more_filters}
  update_display()
}

update_cuisine <- function(){
  more_filters <- input$cuisine
  if((is.null(more_filters))){filters[[8]] <<- 'empty'}else{filters[[8]] <<- more_filters}
  update_display()
}


showall <- function(){
  lapply(13:length(show_vals),function(j){
    outputId <- paste0("r", j)
    recipe_num <- show_vals[j]
    src <- paste(image_address,recipes[[recipe_num]][2],sep = '')
    caption <- recipes[[recipe_num]][1]
    source <- paste(recipe_address,recipes[[recipe_num]][3],sep='')
    output[[outputId]] <- renderText({c('<figure><a href="',source,'" target="_blank"><img src="',src,'" width=150 height=150 style="padding-top: 10px;"></a><figcaption>',caption,'</figcaption></figure>')})
    show(outputId)
    for(j in (length(show_vals)+1):recipe_spots){
      outputId <- paste0("r", j)
      hide(outputId)
    }
    hide("nextbutton")
  }) 
}

observeEvent(input$meal,update_meal())
observeEvent(input$effort,update_effort())
observeEvent(input$reward,update_reward())
observeEvent(input$type,update_type(),ignoreNULL = FALSE)
observeEvent(input$plus,update_plus(),ignoreNULL = FALSE)
observeEvent(input$season,update_season(),ignoreNULL = FALSE)
observeEvent(input$occassion,update_occassion(),ignoreNULL = FALSE)
observeEvent(input$cuisine,update_cuisine(),ignoreNULL = FALSE)

observeEvent(input$nextbutton,showall())

}
  
# Run the application 
shinyApp(ui = ui, server = server)
