library(shiny)
library(emojifont)
library(emo)
library(stringr)
library(shinyjs)
library(shinyMobile)

image_address <- "https://www.honestcookingblog.com/recipes/images/"

recipe_address <- "https://www.honestcookingblog.com/recipes/"

recipes <- list(
  c("Easter egg nest cake","eastereggnest.jpg","easyeastercake.html","e1 r3 fika dessert easter chocolate"),
  c("Lamb shoulder","lambshoulder-whole.jpg","lambshoulder.html","e1 r3 main lamb easter spring"),
  c("Burnt butter and blood orange crepes","burntbuttercrepe.jpg","burntbuttercrepes.html","e1 r3 breakfast winter citrus"),
  c("Wild Boar Ragu with Celeriac Pappardelle","wildboarragu.jpg","wildboarragu.html","e4 r4 main pork autumn winter italian"),
  c("Lemon Myrtle Chiffon Cake","lemonchiffon.jpg","lemonchiffon.html","e4 r4 fika cake citrus japanese australian"),
  c("Homestyle Ramen","ramen.jpg","ramen.html","e2 r3 main noodles japanese pork"),
  c("Rhubarbmisu","rhubarbmisu.jpg","rhubarbmisu.html","e4 r4 spring dessert italian"),
  c("Strawberry rhubarb roll cake","rollcake.jpg","rollcake.html","e1 r4 fika spring summer"),
  c("Swedish Strawberry Cake","strawberrycake.jpg","swedishstrawberry.html","e1 r4 swedish fika cake summer"),
  c("Spicy chewy cavatelli","cavatelli.jpg","cavatelli.html","e2 r3 main healthy vege summer light italian"),
  c("Arancini","aranciniballs.jpg","arancini.html","e1 r3 main healthy vege summer light italian"),
  c("Pumpkin, brown butter and sage risotto","pumpkinrisotto.jpg","pumpkinrisotto.html","e2 r3 main healthy italian vege autumn"),
  c("Beetroot and Black Lentils","beetrootlentils.jpg","beetrootlentils.html","e1 r3 main healthy vege summer"),
  c("Cauliflower Tikka Masala","cauliflowertikka.jpg","cauliflowertikka.html","e1 r3 main healthy vege indian curry"),
  c("Creamy eggplant  basil pasta","eggplantpasta.jpg","eggplantpasta.html","e2 r3 main pasta italian healthy"),
  c("Punchy Pasta Sauce","ravioli.jpg","punchypastasauce.html","e2 r4 staple main pasta italian"),
  c("Rhubarb and Custard Pavlova","rhubarbpav.jpeg","rhubarbpavlova.html","e2 r4 dessert spring australian"),
  c("Scottish cheddar and wild garlic scones","wildgarlicscones.jpg","wildgarlicscones.html","e1 r4 fika light side spring british"),
  c("Lime chocolate cake with margarita cream","choclimecake.jpg","choclimecake.html","e2 r4 fika cake chocolate citrus"),
  c("Gooseberry fool","gooseberryfool.jpg","gooseberryfool.html","e1 r2 summer british pudding dessert"),
  c("Lamb Keema Suet Pudding","keemapudding.jpg","keemapie.html","e3 r4 main british indian lamb winter healthy instantpot"),
  c("Poached Gooseberries","poachedgooseberries.jpg","gooseberries.html","e2 r3 staple summer"),
  c("Ham Pea Soup","peasoup.jpg","hampeasoup.html","e1 r3 main dutch pork healthy winter"),
  c("Katsu Curry","katsucurry.jpg","katsucurry.html","e3 r4 main japanese pork healthy winter"),
  c("Black Forest Cake","blackforest.jpg","blackforestcake.html","e2 r4 fika german chocolate cake winter"),
  c("Sticky Date Puddings","stickydatepudding.jpg","stickydatepudding.html","e2 r3 dessert british winter pudding instantpot"),
  c("Braised Reindeer Shanks","reindeershank.jpg","reindeershanks.html","e2 r4 main autumn winter swedish game christmas"),
  c("Rhubarb & Elderflower cake","rhubarbcake1.jpg","elderflowerrhubarb.html","e2 r4 fika cake summer spring"),
  c("Lemon Victoria Sponge","lemonvictoriasponge.jpg","lemonsponge.html","e1 r3 fika cake citrus summer"),
  c("Poached rhubarb (two ways)","poachedrhubarb.jpg","poached_rhubarb.html","e1 r4 staple spring"),
  c("Fruit crumbles","cherrycrumble-min.jpg","crumble.html","e2 r3 pudding dessert british summer winter spring"),
  c("Wild boar chili","wildboarchili.jpg","wildboarchili.html","e2 r4 main pork game healthy autumn winter"),
  c("Swedish apple cake","swedishapple.jpg","swedishapple.html","e2 r3 fika cake apple swedish autumn"),
  c("Fish pie","fishpie.jpg","fishpie.html","e2 r3 main fish easter healthy british pie"),
  c("Raspberry Lemon Cake","raspberrylemon.jpg","raspberrylemoncake.html","e3 r4 fika citrus cake summer"),
  c("Chocolate Guinness Cake","guinesscake.jpg","guinnesscake.html","e1 r4 fika cake party chocolate winter"),
  c("Caramel croissant pudding","caramelpudding.jpg","caramelcroissantpudding.html","e1 r3 dessert winter british pudding"),
  c("Hot Cross Buns","hotcrossbuns.jpg","hotcrossbuns.html","e3 r4 fika easter breakfast british freezable spring cake bread"),
  c("Black sesame icecream","blacksesame.jpg","blacksesameice.html","e1 r3 icecream dessert"),
  c("Tonkatsu","tonkatsu.jpg","tonkatsu.html","e2 r4 main pork japanese"),
  c("Peanut Stew","peanutstew.jpg","peanutstew.html","e2 r3 healthy vege main curry instantpot"),
  c("Chocolate and beetroot cake","chocbeetrootcake.jpg","chocbeetrootcake.html","e2 r3 fika cake swedish summer chocolate"),
  c("Borscht","borscht.jpg","borscht.html","e3 r4 main soup vege healthy freezable winter"),
  c("Kimchi Pork Ribs","kimchiporkribs.jpg","kimchiporkribs.html","e1 r4 main pork healthy korean winter"),
  c("Lemon curd","lemoncurd.jpg","lemoncurd.html","e1 r3 staple citrus instantpot"),
  c("Swedish meatballs","swedishmeatballs.jpg","swedishmeatballs.html","e2 r4 main swedish pork beef"),
  c("Renskav","renskav.jpg","renskav.html","e1 r4 main swedish game mushroom autumn winter"),
  c("Chocolate cake","chocolatecake.jpg","chocolatecake.html","e2 r3 cake chocolate fika easter"),
  c("Golden Pudding","goldenpudding.jpg","goldenpudding.html","e2 r4 pudding citrus dessert instantpot winter british"),
  c("Creme brulee, three ways","cremebrulee.jpg","chaicremebrulee.html","e2 r4 dessert pudding summer instantpot"),
  c("Chicken with wild mushrooms","mushroomchicken.jpg","mushroomchicken.html","e1 r4 main chicken mushroom healthy autumn"),
  c("Chocolate steamed pudding","fancychocolatepud.jpg","sfikamedpuddingchocolate.html","e2 r4 christmas party pudding chocolate dessert easter kids winter"),
  c("Instant pot lattes","tumericlatte.jpg","latte.html","e1 r2 drink indian instantpot"),
  c("Lamb shank noodles in aromatic broth","lambnoodles.jpg","lambnoodles.html","e1 r3 main noodles healthy winter lamb"),
  c("Kapusniak","kapusniak.jpg","kapusniak.html","e1 r3 main soup winter vege healthy pork"),
  c("Gozleme","gozleme.jpg","gozleme.html","e1 r3 light vege pancake"),
  c("Pear Pistachio Tart","peartart.jpg","PearPistachioTart.html","e3 r3 cake dessert fika summer winter"),
  c("Chestnut tagliatelle with basil pesto","pesto.jpg","chestnutpesto.html","e3 r4 main light italian pasta healthy vege"),
  c("Saffron wreath","saffronwreath.jpg","saffronwreath.html","e2 r2 christmas fika"),
  c("Glögg","glogg.jpg","glogg.html","e1 r2 drink christmas"),
  c("Norwegian Pork Belly","norwegianpork.jpg","norwegianporkbelly.html","e2 r4 pork main christmas swedish winter"),
  c("Christmas Kladdkaka","christmaskladdkaka.jpg","christmaskladdkaka.html","e2 r4 christmas chocolate cake fika dessert winter swedish"),
  c("Wild Mushroom Pizza","mushroompizza.jpg","mushroompizza.html","e2 r4 autumn main mushroom vege swedish"),
  c("Rhubarb Panna Cotta","rhubarbpannacotta.jpg","rhubarbpannacotta.html","e1 r3 dessert pudding spring summer italian swedish"),
  c("Zuppa Toscana","zuppatoscana.jpg","zuppatoscana.html","e2 r3 main soup winter italian"),
  c("Gingerbread swirl bundt","gingerbreadbundt.jpg","gingerbreadbundt.html","e1 r3 fika christmas cake winter"),
  c("Gotlandish lamb stew","lambstew.jpg","lambstew.html","e2 r3 swedish lamb main winter curry"),
  c("Gooseberry vlaam","gooseberryvlaam.jpg","gooseberryvlaam.html","e3 r4 fika cake dutch"),
  c("Rice Pudding","ricepudding.jpg","ricepudding.html","e1 r2 dessert winter pudding"),
  c("Lavender cheesecake","lavendarcheesecake.jpg","lavendarcheesecake.html","e2 r3 fika cake italian summer instantpot freezable"),
  c("Chicken Pho","pho.jpg","pho.html","e2 r4 main noodles instantpot chicken"),
  c("Fresh Marinara Sauce (IP)","marinara.jpg","marinara.html","e2 r3 main light pasta vege instantpot italian"),
  c("Chinese noodle soup","chinesenoodles.jpg","chinesenoodle.html","e1 r3 main noodles chicken"),
  c("Dal Makhani","dalmakhani.jpg","DalMakhani.html","e1 r3 main indian instantpot vege curry"),
  c("Lorighittas with chicken","lorighittas.jpg","lorighittas.html","e4 r4 italian main pasta chicken summer"),
  c("Elderflower cordial","elderflowercordial.jpg","elderflowercordial.html","e1 r4 drink summer swedish"),
  c("Ciambella","ciambella.jpg","ricottacake.html","e1 r3 cake fika italian"),
  c("Chicken & Wild Garlic Pie","wildgarlicpie.jpg","wildgarlicpie.html","e4 r4 british spring chicken main"),
  c("Rough Puff Pastry","roughpuff.jpg","roughpuff.html","e2 r4 staple"),
  c("Cornflake crusted chicken","cornflakechicken.jpg","chickencornflake.html","e1 r3 chicken main summer"),
  c("Toasted marshmallow & rhubarb cake","rhubarbmarshmallow.jpg","rhubarbmarshmallow.html","e3 r4 fika cake summer spring"),
  c("Japchae","japchae.jpg","japchae.html","e3 r4 noodles main party healthy korean vege summer mushroom beef"),
  c("Jansson's Temptation","norwegianpork.jpg","janssonstemptation.html","e1 r2 side swedish"),
  c("Naan Two Ways","naan.jpg","Naan.html","e1 r3 side bread indian instantpot"),
  c("Beef Stock","beefstock.jpg","beefstock.html","e1 r3 beef instantpot staple"),
  c("Massaman","massaman.jpg","massaman.html","e3 r4 main thai curry beef winter"),
  c("Aloo Mushroom Masala","matarmushroom.jpg","AlooMushroom.html","e2 r3 main indian curry mushroom vege healthy instantpot"),
  c("Italian Beef Rolls","italianbeef.jpg","italianbeef.html","e1 r3 light burger italian instantpot"),
  c("Rice Kheer","kheer.jpg","ricekheer.html","e1 r3 dessert summer instantpot pudding"),
  c("Pumpkin gnocchi","gnocchi.jpg","pumpkingnocchi.html","e2 r3 pasta main light vege autumn italian"),
  c("Dutch Baby","dutchbaby.jpg","dutchbaby.html","e1 r3 breakfast"),
  c("Fish finger sandwich","fishsandwich.jpg","fishfingersandwich.html","e1 r3 light burger fish healthy"),
  c("Vodka Rigatoni","vodkarigatoni.jpg","vodkarigatoni.html","e1 r1 light pasta italian healthy vege"),
  c("Acqua Pazza","italianfish.jpg","italianpoachedfish.html","e2 r3 main fish italian healthy summer"),
  c("Tuscan Bean Soup","tuscanbeansoup.jpg","tuscanbeansoup.html","e2 r3 main healthy vege soup italian"),
  c("Beetroot curry","beetrootcurry.jpg","beetrootcurry.html","e1 r4 main curry healthy vege indian"),
  c("Thai Red Curry","thairedcurry.jpg","thairedcurry.html","e1 r2 curry thai summer chicken main healthy"),
  c("Breton Tiramisu","bretontiramisu.jpg","bretontiramisu.html","e3 r4 dessert pudding summer"),
  c("Mushroom and wild rice","mushroomwildrice.jpg","mushroomwildrice.html","e1 r2 mushroom soup healthy vege winter main instantpot"),
  c("Nishime","nishime.jpg","nishime.html","e2 r3 main instantpot japanese stew healthy vege winter bento light"),
  c("Teriyaki chicken","teriyakichicken.jpg","teriyakichicken.html","e1 r2 main light chicken japanese"),
  c("Moroccan carrot and pumpkin soup","moroccansoup.jpg","moroccansoup.html","e2 r2 main soup healthy vege autumn freezable"),
  c("Cornbread","chickenchili.jpg","cornbread.html","e1 r2 side vege"),
  c("Chicken chili","chickenchili.jpg","whitechilichicken.html","e1 r3 main chicken healthy instantpot"),
  c("Pomegranate jewel cake","pomegranatecake.jpg","pomegranatecake.html","e2 r3 cake fika"),
  c("Lemonade (Instant Pot)","lemonade.jpg","lemonade.html","e1 r3 healthy drink citrus instantpot"),
  c("Coriander and lime pesto","corianderpesto.jpg","corianderlimepesto.html","e1 r1 healthy light main vege pasta fish"),
  c("Pea and pesto soup","peapestosoup.jpg","peapestosoup.html","e1 r2 soup healthy light vege winter"),
  c("Christmas Sponge","christmascake.jpg","japanesechristmas.html","e4 r4 cake dessert freezable fika christmas party summer japanese"),
  c("Chicken stock","chickenstock.jpg","chickenstock.html","e1 r3 chicken soup instantpot healthy staple"),
  c("Pickled red cabbage","norwegianpork.jpg","pickledredcabbage.html","e1 r3 side winter vege healthy swedish"),
  c("Instant pot mash","goulash.jpg","instantpotmash.html","e1 r3 side instantpot"),
  c("Goulash","goulash.jpg","goulash.html","e2 r3 pork curry main winter freezable"),
  c("Sticky gingerbread","gingerbread.jpg","gingerbread.html","e1 r2 cake fika dessert christmas winter"),
  c("Lemon elderflower drizzle","lemonelderflower.jpg","lemonelderflower.html","e1 r2 citrus cake pudding fika dessert summer swedish"),
  c("Creme caramel","cremecaramel.jpg","cremecaramel.html","e1 r3 dessert pudding summer"),
  c("Apple tea cake","appleteacake.jpg","appleteacake.html","e1 r3 cake freezable fika autumn apple"),
  c("Fried chicken burger","chickenburger.jpg","chickenburger.html","e2 r4 main chicken burger"),
  c("Moose burger","mooseburger.jpg","mooseburgers.html","e1 r4 main game burger"),
  c("Moose stew","moosestew.jpg","moosestew.html","e2 r2 main swedish game mushroom autumn curry christmas"),
  c("Pumpkin soup","pumpkinsoup.jpg","pumpkinsoup.html","e1 r1 autumn main light soup healthy"),
  c("Kladdkaka","kladdkaka.jpg","kladdkaka.html","e1 r3 swedish cake chocolate fika"),
  c("Wild mushroom barley","mushroombarley.jpg","mushroombarley.html","e1 r2 mushroom swedish main autumn vege healthy"),
  c("Easy yeast bread","yeastbread.jpg","yeastbread.html","e1 r2 bread side staple freezable"),
  c("Chai choc cookies","chaicookie.jpg","chaicookies.html","e1 r1 fika cookie freezable bento"),
  c("Totally choc cookies","choccoookie.jpg","chocolatecookies.html","e1 r4 fika cookie kids chocolate freezable bento"),
  c("Cream cheese frosting","creamcheesefrost.jpg","creamcheesefrosting.html","e1 r2 cake staple"),
  c("Fluffy cupcakes","cupcakes.jpg","cupcakes.html","e2 r3 cake fika party kids bento"),
  c("Matsutake gohan","mushroomrice.jpg","shimejigohan.html","e1 r1 japanese vege bento light healthy mushroom"),
  c("Yakitori","yakitori.jpg","yakitori.html","e1 r2 japanese bento chicken party kids light"),
  c("Butter chicken","butterchicken.jpg","butterchicken.html","e2 r4 main chicken curry indian freezable"),
  c("Mongolian lamb","mongolianlamb.jpg","mongolianlamb.html","e1 r4 main lamb australian"),
  c("Crunchy sticky tofu","crunchytofu.jpg","crunchytofu.html","e1 r2 light main vege korean bento"),
  c("Chocolate saucy pudding","chocolatepudding.jpg","chocolatepudding.html","e2 r3 british pudding chocolate dessert winter"),
  c("Italian meatballs","italianmeatballs.jpg","meatballsitalien.html","e2 r3 italian beef pork freezable main pasta"),
  c("Pizza scrolls","pizzascrolls.jpg","pizzascrolls.html","e1 r1 light freezable bread kids bento"),
  c("Custard","custard.jpg","custard.html","e1 r2 dessert icecream staple"),
  c("Cheesymite scrolls","cheesymite.jpg","vegemitescrolls.html","e1 r1 light freezable bread bento kids australian vege"),
  c("Chicken mushroom pie","chickenpie.jpg","chickenpie.html","e2 r4 chicken pie main british freezable mushroom"),
  c("Fairy cakes","fairycakes.jpg","fairycakes.html","e2 r2 kids fika cake british"),
  c("Pistachio icecream","pistachioice.jpg","pistachioice.html","e1 r3 icecream dessert"),
  c("Chicken nuggets","chickennuggets.jpg","chickennuggets.html","e1 r3 light chicken main kids freezable party"),
  c("Strawberry icecream","strawberryice.jpg","strawberryice.html","e2 r3 icecream freezable dessert"),
  c("Lamingtons","lamingtons.jpg","lamingtons.html","e3 r3 cake australian fika bento freezable kids party"),
  c("Lemon fish","whitefish.jpg","lemonfish.html","e1 r3 main citrus fish summer healthy"),
  c("BBQ marinated salmon","grilledsalmon.jpg","bbqsalmon.html","e1 r4 main fish healthy"),
  c("Sticky oyster salmon","glazedsalmon.jpg","glazedsalmon.html","e1 r3 main fish healthy"),
  c("Teriyaki salmon","teriyaki.jpg","teriyakisalmon.html","e1 r3 main fish summer japanese healthy"),
  c("Kimchi pancake","kimchipancake.jpg","kimchipancake.html","e1 r2 light pancake vege korean bento"),
  c("Lime Yoghurt Cake","limecake.jpg","limecake.html","e2 r2 fika citrus cake freezable"),
  c("Pork chop marinade","porkchops.jpg","porkchops.html","e1 r1 main summer pork"),
  c("Pavlova","christmaspavlova.jpg","pavlova.html","e1 r4 cake dessert party australian summer fika christmas"),
  c("Easy raspberry mousse","raspberrymousse.jpg","raspberrymousse.html","e1 r2 dessert summer party pudding"),
  c("Rice paper rolls","ricerolls.jpg","ricerolls.html","e2 r2 healthy light salad summer bento party fish"),
  c("Eggplant curry","eggplantcurry.jpg","eggplantcurry.html","e3 r4 healthy main indian freezable curry vege summer"),
  c("Mustard pork chops","mustardpork.jpg","mustardporkchops.html","e1 r2 pork main"),
  c("Palak Paneer","palakpaneer.jpg","palakpaneer.html","e2 r4 curry indian main vege freezable instantpot summer healthy"),
  c("Mushroom Pork Chops","mushroompork.jpg","mushroomporkchops.html","e2 r2 main pork mushroom"),
  c("Carrot cake","carrotcake.jpg","carrotcake.html","e3 r4 cake fika freezable"),
  c("Kimchi and tuna stew","kimchistew.jpg","kimchistew.html","e1 r4 soup fish main healthy korean winter"),
  c("Tomato soup","tomatosoup.jpg","tomatosoup.html","e2 r2 main vege freezable soup healthy winter"),
  c("Lemon delicious","lemondelicious-min.jpg","lemondelicious.html","e2 r4 pudding citrus dessert summer australian"),
  c("Thai beef salad","thaisalad-min.jpg","beefsalad.html","e1 r4 main salad light thai party summer beef healthy"),
  c("Corn fritters","cornfritters.jpg","cornfritters.html","e3 r3 main party pancake summer light vege"),
  c("Fancy lemon cake","fancylemon.jpg","fancylemon.html","e4 r4 fika citrus cake"),
  c("Golden soup","cauliflowersoup.jpg","cauliflowersoup.html","e2 r3 main freezable healthy soup vege winter"),
  c("Tantanmen","tantanmen.jpg","tantanmen.html","e3 r3 main noodles pork japanese"),
  c("Chocolate pear pudding","chocolatepearpudding.jpg","chocolatepearpudding.html","e1 r3 pudding dessert chocolate british winter"),
  c("Zoervleesj","zoervleesj.jpg","zoervleesj.html","e3 r4 main christmas freezable winter beef game curry dutch"),
  c("Grilled pork belly","grilledpork.jpg","grilledporkbelly.html","e1 r3 main summer party light pork korean"),
  c("Curry rice","curryrice.jpg","curryrice.html","e2 r3 main beef curry freezable japanese winter"),
  c("Tomato pea curry","tomatocurry.jpg","tomatopeacurry.html","e2 r3 curry main healthy vege"),
  c("Mushroom risotto","mushroomrisotto.jpg","mushroomrisotto.html","e3 r4 pasta main italian winter mushroom"),
  c("Mango sticky rice","mangosticky.jpg","mangostickyrice.html","e2 r4 dessert thai party pudding summer"),
  c("Creamy anchovy pasta","gemelli.jpg","gemelli.html","e2 r3 pasta light italian"),
  c("Crepes","crepe.jpg","crepes.html","e1 r3 breakfast pancake"),
  c("Golden curry","goldencurry.jpg","goldencurry.html","e2 r4 main curry fish summer"),
  c("Sticky toffee pudding","toffeepudding.jpg","stickytoffeepudding.html","e1 r2 dessert pudding british winter"),
  c("Pumpkin prawn curry","pumpkincurry.jpg","pumpkincurry.html","e2 r3 main curry fish healthy autumn"),
  c("Lemon drizzle","lemondrizzle.jpg","lemondrizzle.html","e1 r1 cake citrus summer freezable fika"),
  c("Beef stroganoff", "stroganoff.jpg","stroganoff.html","e2 r3 main beef pasta mushroom freezable"),
 # c("Orange Yoghurt Cake","orangecake.jpg","Orange%20Yoghurt%20Bundt.html","e2 r2 cake citrus fika summer"),
  c("Sambar","sambar.jpg","sambar.html","e2 r4 main vege curry indian healthy instantpot"),
  c("Chicken noodle soup","chickennoodlesoup.jpg","chickennoodlesoup.html","e3 r3 soup noodle chicken main healthy winter"),
  c("Bulgogi","kbbq.jpg","bulgogi.html","e2 r4 main beef party vege summer korean"),
  c("Chinese Pork Belly","porkbellycrispy.jpg","crispyporkbelly.html","e2 r4 main pork party christmas summer winter"),
  c("Rissoles","rissoles.jpg","rissoles.html","e1 r2 main beef healthy australian"),
  c("Tempura","tempura.jpg","tempura.html","e2 r3 main vege party japanese"),
  c("Pumpkin Lasagne","pumpkinlasagne.jpg","pumpkinlasagne.html","e4 r3 main vege autumn"),
  c("Tangy Irish Soda Bread","sodabread.jpg","sodabread.html","e1 r2 bread staple side freezable"),
  c("Granola","granola.jpg","granola.html","e1 r2 breakfast"),
  c("Banana bread","bananabread.jpg","bananabread.html","e1 r1 cake freezable breakfast fika"),
  c("Spring chicken","springchicken.jpg","springchicken.html","e2 r3 main chicken healthy spring"),
  c("Lemon chicken breasts","lemonchicken.jpg","lemonchicken.html","e1 r2 main citrus chicken"),
  c("Chicken shawarma","chickenshawarma.jpg","chickenshawarma.html","e1 r4 chicken main party summer"),
  c("Chicken Adobo","adobo.jpg","adobo.html","e1 r1 chicken party main"),
  # c("Spaghetti Bolognaise","spaghetti.jpg","slowcookspaghetti.html","e2 r4 pasta main freezable beef"),
  c("Egg Noodles","eggnoodles.jpg","eggnoodles.html","e3 r3 pasta staple noodle"),
  c("Lemon tuna pasta","lemonpasta-min.jpg","lemonpasta.html","e1 r1 healthy light fish pasta summer citrus"),
  c("Vanilla icecream","icecream.jpg","icecream-vanilla.html","e1 r2 icecream dessert staple"),
  c("Christine's sick soup","sicksoup.jpg","sicksoup.html","e2 r3 main freezable healthy soup vege winter"),
  c("Chinese chicken & corn soup","chinesechickensoup.jpg","chickencornsoup.html","e1 r1 main light chicken soup healthy")
)


names(recipes) <- c(1:length(recipes))

### utf8ToInt(emoji("apple"))

values <- c('noodles','pasta','soup','curry','pancake','salad','fish','chicken','pork','beef','lamb','game','mushroom','bread','burger','bento','cake','cookie','pudding','icecream','drink','summer','winter','autumn','spring','christmas','easter','party','kids','citrus','apple','chocolate')
names(values) <- c(127836,127837,127858,127835,129374,129367,128031,128020,128055,128046,128017,129420,127812,127838,127828,127857,127856,127850,127854,127846,127865,9728,10052,127810,127793,127876,128048,127882,128103,127819,127822,127851)


path <- "C:\\Users\\bonmc643\\CookingBlog\\app.R"


ui <- fluidPage(
  useShinyjs(),
  h4(paste("Search for recipes here, there are",as.character(length(recipes)),"recipes available.")),
  fluidRow(
    column(2,class = "col-xs-5",
           selectInput("meal","Meal:",c("Breakfast","Light Meal","Main","Fika","Dessert","Side","Staple","Drink","Any"),selected = "Main")),
    
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
             emoji("apple"),
             emoji("chocolate_bar"),
             emoji("cookie"),
             emoji("custard"),
             emoji("icecream")
           ))
    ),
    column(1,class = "col-xs-3",
           checkboxGroupInput("plus","Plus:",c("healthy","vege","instant pot")),
           checkboxGroupInput("season","Season:",c(emoji("sunny"),emoji("fallen_leaf"),emoji("snowflake"),emoji("seedling"))),
           checkboxGroupInput("occassion","Occassion:",c(emoji("christmas_tree"),emoji("rabbit"),emoji("confetti_ball"),emoji("girl"))),
           checkboxGroupInput("cuisine","Cuisine:",c("Australian","Swedish","British","Japanese","Korean","Dutch","German","Italian","Indian","Thai")))
    
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
      hidden(actionButton("nextbutton","Show more")),
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
      htmlOutput("r31"),
      htmlOutput("r32"),
      htmlOutput("r33"),
      htmlOutput("r34"),
      htmlOutput("r35"),
      htmlOutput("r36"),
      htmlOutput("r37"),
      htmlOutput("r38"),
      htmlOutput("r39"),
      hidden(div(id="morerecipesavailable",p("More recipes available: try adding more filters")))
    )))
)


recipe_spots <- 39

# type # plus # season # occasion # cuisine
filters <- list('main',1:4,1:4,'empty','empty','empty','empty','empty')

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  update_display <- function(){
    hide("morerecipesavailable")
    
    for(j in 1:30){outputId <- paste0("r",j)
    hide(outputId)}
    
    
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
      if(meal=="any"&
         effort %in% effort_range&
         reward %in% reward_range){show_vals <- c(show_vals,n)
         
      }
      else if(grepl(meal,description)&
              effort %in% effort_range&
              reward %in% reward_range){
        show_vals <- c(show_vals,n)
      }
      n <- n+1
    }
    
    types <- filters[[4]]
    t <- paste(types,collapse="")
    
    if(t!="empty"){
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
    t <- paste(plus,collapse="")
    if(t!='empty'){
      for(recipe in show_vals){
        description <- recipes[[as.character(recipe)]][4]
        for(filter in plus){
          if(!(grepl(filter,description))){show_vals <- show_vals[which(show_vals!=recipe)]}
        }
      }
    }
    
    season <- filters[[6]]
    testseason <- paste(season,collapse="")
    if(testseason!="empty"){
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
    t <- paste(occassion,collapse="")
    if(t!="empty"){
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
    t <- paste(cuisine,collapse="")
    if(t!="empty"){
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
    #   #print(show_vals)
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
      if(length(show_vals)>recipe_spots){
        show("morerecipesavailable")
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
