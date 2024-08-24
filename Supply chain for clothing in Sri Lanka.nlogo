globals [colombo_inventory kandy_inventory jaffna_inventory galle_inventory anuradhapura_inventory seller_inventory seller_request seller_production colombo_sell jaffna_sell galle_sell anuradhapura_sell kandy_sell colombo_request galle_request anuradhapura_request kandy_request jaffna_request] ;The variables wich we want output

to setup
  clear-all ;Clear the screen

  ;;;;Create the seller
  create-turtles 1[
   setxy random-xcor random-ycor ;select a random location for the seller
   set shape "factory"           ;shape of seller
   set color red                 ;color of seller
   set label "Seller"           ;set name
   set seller_inventory Initial_Seller_Inventory ;set inventory initial value
  ]

  ;;;;Create anuradhapura distributor
  create-turtles 1[
   setxy random-xcor random-ycor ;select random places for the distributors
   set shape "house"             ;shape of distributors
   set color white               ;color of distributors
   set label "Anuradhapura"     ;set name
   set anuradhapura_inventory Initial_Anuradhapura_Inventory ;set inventory initial value
  ]

  ;;;;Create colombo distributor
  create-turtles 1[
   setxy random-xcor random-ycor ;select random places for the distributors
   set shape "house"             ;shape of distributors
   set color yellow              ;color of distributors
   set label "Colombo"          ;set name
   set colombo_inventory Initial_Colombo_Inventory ;set inventory initial value
  ]

  ;;;;Create kandy distributor
  create-turtles 1[
   setxy random-xcor random-ycor ;select random places for the distributors
   set shape "house"             ;shape of distributors
   set color pink                ;color of distributors
   set label "Kandy"            ;set name
   set kandy_inventory Initial_Kandy_Inventory ;set inventory initial value
  ]

  ;;;;Create jaffna distributor
  create-turtles 1[
   setxy random-xcor random-ycor ;select random places for the distributors
   set shape "house"             ;shape of distributors
   set color green               ;color of distributors
   set label "Jaffna"           ;set name
   set jaffna_inventory Initial_Jaffna_Inventory ;set inventory initial value
  ]

  ;;;;Create galle distributor
  create-turtles 1[
   setxy random-xcor random-ycor ;select random places for the distributors
   set shape "house"             ;shape of distributors
   set color blue                ;color of distributors
   set label "Galle"            ;set name
   set galle_inventory Initial_Galle_Inventory ;set inventory initial value
  ]

  reset-ticks ;Reset time(Days)

end

to go

  if ticks >= Time-period[stop] ;stop when days = Time-period

  ;;;;Give instructions for colombo distributor to do something
  ask turtles with[color = yellow][

    let colombo_random_sell random-poisson Colombo_Selling_Rate  ;generate random sell from poisson distribution
    set colombo_sell colombo_random_sell                         ;set colombo daily sell

    if colombo_random_sell > colombo_inventory[  ;if genareted random sell > inventory then request pass to seller
         set colombo_request colombo_random_sell
    ]
    if colombo_inventory >= colombo_random_sell[
         set colombo_inventory colombo_inventory - colombo_random_sell  ;else sell the product from colombo inventory
         set colombo_request random-poisson Colombo_Selling_Rate        ;randomly selected value from poisson distribution to fill the inventory
         set colombo_inventory colombo_inventory + colombo_request
    ]

  ]

  ;;;;Give instructions for anuradhapura distributor to do something
  ask turtles with[color = white][

    let anuradhapura_random_sell random-poisson Anuradhapura_Selling_Rate  ;generate random sell from poisson distribution
    set anuradhapura_sell anuradhapura_random_sell                         ;set anuradhapura daily sell

    if anuradhapura_random_sell > anuradhapura_inventory[  ;if genareted random sell > inventory then request pass to seller
         set anuradhapura_request anuradhapura_random_sell
    ]
    if anuradhapura_inventory >= anuradhapura_random_sell[
         set anuradhapura_inventory anuradhapura_inventory - anuradhapura_random_sell  ;else sell the product from anuradhapura inventory
         set anuradhapura_request random-poisson Anuradhapura_Selling_Rate        ;randomly selected value from poisson distribution to fill the inventory
         set anuradhapura_inventory anuradhapura_inventory + anuradhapura_request
    ]

  ]

  ;;;;Give instructions for galle distributor to do something
  ask turtles with[color = blue][

    let galle_random_sell random-poisson Galle_Selling_Rate  ;generate random sell from poisson distribution
    set galle_sell galle_random_sell                         ;set galle daily sell

    if galle_random_sell > galle_inventory[  ;if genareted random sell > inventory then request pass to seller
         set galle_request galle_random_sell
    ]
    if galle_inventory >= galle_random_sell[
         set galle_inventory galle_inventory - galle_random_sell  ;else sell the product from galle inventory
         set galle_request random-poisson Galle_Selling_Rate        ;randomly selected value from poisson distribution to fill the inventory
         set galle_inventory galle_inventory + galle_request
    ]

  ]
  ;;;;Give instructions for kandy distributor to do something
  ask turtles with[color = pink][

    let kandy_random_sell random-poisson Kandy_Selling_Rate  ;generate random sell from poisson distribution
    set kandy_sell kandy_random_sell                         ;set kandy daily sell

    if kandy_random_sell > kandy_inventory[  ;if genareted random sell > inventory then request pass to seller
         set kandy_request kandy_random_sell
    ]
    if kandy_inventory >= kandy_random_sell[
         set kandy_inventory kandy_inventory - kandy_random_sell  ;else sell the product from kandy inventory
         set kandy_request random-poisson Kandy_Selling_Rate        ;randomly selected value from poisson distribution to fill the inventory
         set kandy_inventory kandy_inventory + kandy_request
    ]

  ]

  ;;;;Give instructions for jaffna distributor to do something
  ask turtles with[color = green][

    let jaffna_random_sell random-poisson Jaffna_Selling_Rate  ;generate random sell from poisson distribution
    set jaffna_sell jaffna_random_sell                         ;set jaffna daily sell

    if jaffna_random_sell > jaffna_inventory[  ;if genareted random sell > inventory then request pass to seller
         set jaffna_request jaffna_random_sell
    ]
    if jaffna_inventory >= jaffna_random_sell[
         set jaffna_inventory jaffna_inventory - jaffna_random_sell  ;else sell the product from jaffna inventory
         set jaffna_request random-poisson Jaffna_Selling_Rate        ;randomly selected value from poisson distribution to fill the inventory
         set jaffna_inventory jaffna_inventory + jaffna_request
    ]

  ]

  ;;;;Give instructions for seller to do something
  set seller_request colombo_request + jaffna_request + anuradhapura_request + galle_request + kandy_request  ;set total request for seller from distributors
  let seller_random_production random-poisson Seller_Production_Rate  ;select random production value from poisson distribution wich mean is seller request
  set seller_production seller_random_production                      ;set daily production

  if seller_inventory + seller_random_production >= seller_request[
      set seller_inventory seller_random_production + seller_inventory - seller_request ;update seller inventory
  ]
  if seller_inventory + seller_random_production < seller_request[       ;when the seller request higher than seller inventory,production will be seller equest + random production
      set seller_inventory seller_random_production + seller_inventory + seller_request - seller_request
  ]

  tick ;time system(days)

end
@#$#@#$#@
GRAPHICS-WINDOW
4
10
446
453
-1
-1
13.152
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

PLOT
918
12
1118
162
Colombo Inventory
Days
Inventory
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -6995700 true "" "plot colombo_inventory"

PLOT
920
489
1120
639
Kandy Inventory
Days
Inventory
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -13403783 true "" "plot kandy_inventory"

PLOT
918
171
1118
321
Jaffna Inventory
Days
Inventory
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -7171555 true "" "plot jaffna_inventory"

PLOT
920
647
1120
797
Galle Inventory
Days
Inventory
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -10022847 true "" "plot galle_inventory"

PLOT
919
330
1119
480
Anuradhapura Inventory
Days
Inventory
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -15040220 true "" "plot anuradhapura_inventory"

PLOT
11
463
211
613
Seller Inventory
Days
Inventory
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot seller_inventory"

PLOT
217
464
417
614
Seller Request
Days
Request
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot seller_request"

BUTTON
473
156
682
189
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
686
156
894
189
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
473
200
681
233
Initial_Seller_Inventory
Initial_Seller_Inventory
1
5000
1000.0
1
1
NIL
HORIZONTAL

SLIDER
473
236
681
269
Initial_Colombo_Inventory
Initial_Colombo_Inventory
1
1000
500.0
1
1
NIL
HORIZONTAL

SLIDER
472
272
681
305
Initial_Kandy_Inventory
Initial_Kandy_Inventory
1
1000
500.0
1
1
NIL
HORIZONTAL

SLIDER
472
308
681
341
Initial_Jaffna_Inventory
Initial_Jaffna_Inventory
1
1000
500.0
1
1
NIL
HORIZONTAL

SLIDER
472
344
681
377
Initial_Galle_Inventory
Initial_Galle_Inventory
1
1000
500.0
1
1
NIL
HORIZONTAL

SLIDER
472
380
681
413
Initial_Anuradhapura_Inventory
Initial_Anuradhapura_Inventory
1
1000
500.0
1
1
NIL
HORIZONTAL

TEXTBOX
472
12
646
144
Seller - red\nKandy - pink\nAnuradhapura - white\nGalle - blue\nJaffna - green\nColombo - yellow 
18
34.0
1

SLIDER
687
200
895
233
Seller_Production_Rate
Seller_Production_Rate
0
1000
200.0
1
1
NIL
HORIZONTAL

SLIDER
687
236
895
269
Colombo_Selling_Rate
Colombo_Selling_Rate
0
500
40.0
1
1
NIL
HORIZONTAL

SLIDER
687
272
896
305
Kandy_Selling_Rate
Kandy_Selling_Rate
0
500
40.0
1
1
NIL
HORIZONTAL

SLIDER
687
308
896
341
Jaffna_Selling_Rate
Jaffna_Selling_Rate
0
500
40.0
1
1
NIL
HORIZONTAL

SLIDER
687
344
896
377
Galle_Selling_Rate
Galle_Selling_Rate
0
500
40.0
1
1
NIL
HORIZONTAL

SLIDER
687
380
896
413
Anuradhapura_Selling_Rate
Anuradhapura_Selling_Rate
0
500
40.0
1
1
NIL
HORIZONTAL

PLOT
423
464
623
614
Seller Production
Days
Production
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot seller_production"

PLOT
1126
12
1326
162
Colombo Sells
Days
Sell
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -6995700 true "" "plot colombo_sell"

PLOT
1127
171
1327
321
Jaffna Sells
Days
Sell
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -7171555 true "" "plot jaffna_sell"

PLOT
1128
331
1328
481
Anuradhapura Sells
Days
Sell
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -15040220 true "" "plot anuradhapura_sell"

PLOT
1127
488
1327
638
Kandy Sells
Days
Sell
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -13403783 true "" "plot kandy_sell"

PLOT
1127
647
1327
797
Galle Sells
Days
Sell
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -10022847 true "" "plot galle_sell"

PLOT
1334
12
1534
162
Seller Request from Colombo
Days
Request
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -6995700 true "" "plot colombo_request"

PLOT
1334
170
1534
320
Seller Request from Jaffna
Days
Request
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -7171555 true "" "plot jaffna_request"

PLOT
1335
331
1535
481
Seller Request from Anuradhapura
Days
Request
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -15040220 true "" "plot anuradhapura_request"

PLOT
1336
488
1536
638
Seller Request from Kandy
Days
Request
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -13403783 true "" "plot kandy_request"

PLOT
1337
647
1537
797
Seller Request from Galle
Days
Request
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -10022847 true "" "plot galle_request"

SLIDER
582
417
791
450
Time-period
Time-period
1
365
100.0
1
1
NIL
HORIZONTAL

PLOT
10
626
449
856
Seller and distributors Inventory
Days
Inventory
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Seller" 1.0 0 -2674135 true "" "plot seller_inventory"
"Colombo" 1.0 0 -3844592 true "" "plot colombo_inventory"
"Galle" 1.0 0 -7858858 true "" "plot galle_inventory"
"Kandy" 1.0 0 -12345184 true "" "plot kandy_inventory"
"Anuradhapura" 1.0 0 -14439633 true "" "plot anuradhapura_inventory"
"Jaffna" 1.0 0 -4079321 true "" "plot jaffna_inventory"

PLOT
457
628
893
857
Seller Request and Distributors sells
Days
Sells
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Seller" 1.0 0 -2674135 true "" "plot colombo_request + kandy_request + anuradhapura_request + galle_request + jaffna_request"
"Colombo" 1.0 0 -3844592 true "" "plot colombo_sell"
"Galle" 1.0 0 -7858858 true "" "plot galle_sell"
"kandy" 1.0 0 -12345184 true "" "plot kandy_sell"
"Anuradhapura" 1.0 0 -14439633 true "" "plot anuradhapura_sell"
"Jaffna" 1.0 0 -4079321 true "" "plot jaffna_sell"

@#$#@#$#@
## WHAT IS IT?

This model simulates a supply chain system involving a single seller and multiple distributors located in different regions (Colombo, Kandy, Jaffna, Galle, and Anuradhapura). The model demonstrates the dynamics of inventory management, demand fulfillment, and production in a simplified supply chain network.

## HOW IT WORKS

Initially, initially created the seller agent with shape “factory”, colour “red”, and set initial seller’s inventory. Moreover, placed location in randomly. Similarly defined for distributors with shape “house”, different colours such white for Anuradhapura, yellow for Colombo, pink for Kandy, green for Jaffna, blue for Galle and set their initial inventory. Moreover, their locations select in randomly. The seller is tasked with the production of goods and full files the distributors’ request, whereas the distributors are responsible for selling these goods to satisfy local demand within their respective sells.

As the simulation process, each distributor calculates its daily sales using a Poisson distribution, which introduces variability and randomness into the sales process. If a distributor's sales surpass its available inventory, then the distributor sends the request to the seller for full fill the sell. Else the sells full fill from the distributor’s inventory and distributor send a random request witch has passion distribution with parameter selling rate of the same distributor for seller to update the distributor’s inventory.

Seller take total request coming from distributors and if seller’s inventory is sufficient to full fill order, then request full fill the current inventory of seller. Else seller is produced new produced to full fill the request.

This iterative process is executed daily throughout the simulation, thereby enabling the model to analyse the dynamics of sells, requests and inventory fluctuations within the supply chain over time.


## HOW TO USE IT

1. Set the initial inventory values for the seller and distributors, and define the selling and production rates.

2. Click on "Setup" to initialize the model.

3. Click on "Go" to run the simulation. The model will continue until the set time period (in ticks) is reached or until manually stopped.



## THINGS TO NOTICE

How inventory levels fluctuate based on demand and supply.

The relationship between the seller's production rate and the distributors' request rates.

Situations where the seller cannot meet the requests due to insufficient inventory.

The impact of the randomness introduced by the Poisson distribution on the system's behavior.

## THINGS TO TRY

Adjust the initial inventory levels and see how it affects the system's stability.

Experiment with different selling and production rates to understand their impact on the overall supply chain dynamics.

Increase or decrease the randomness by altering the parameters of the Poisson distribution and observe the changes in behavior.

## EXTENDING THE MODEL

Availabel to extending the model such as distributors or regions to the model,introduce different types of products with varying demand patterns,implement a more sophisticated production system for the seller that considers factors like lead time or capacity constraints and include transportation delays between the seller and distributors

## SENSITIVITY ANALYSIS

'BehaviourSpace':This function can be used for sensitivity analysis.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

factory
false
0
Rectangle -7500403 true true 76 194 285 270
Rectangle -7500403 true true 36 95 59 231
Rectangle -16777216 true false 90 210 270 240
Line -7500403 true 90 195 90 255
Line -7500403 true 120 195 120 255
Line -7500403 true 150 195 150 240
Line -7500403 true 180 195 180 255
Line -7500403 true 210 210 210 240
Line -7500403 true 240 210 240 240
Line -7500403 true 90 225 270 225
Circle -1 true false 37 73 32
Circle -1 true false 55 38 54
Circle -1 true false 96 21 42
Circle -1 true false 105 40 32
Circle -1 true false 129 19 42
Rectangle -7500403 true true 14 228 78 270

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="Colombo inventory with different colombo selling rates" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="150"/>
    <metric>colombo_inventory</metric>
    <enumeratedValueSet variable="Colombo_Selling_Rate">
      <value value="25"/>
      <value value="50"/>
      <value value="75"/>
      <value value="100"/>
      <value value="125"/>
      <value value="150"/>
      <value value="175"/>
      <value value="200"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Seller request with different colombo selling rates" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="150"/>
    <metric>seller_request</metric>
    <enumeratedValueSet variable="Colombo_Selling_Rate">
      <value value="25"/>
      <value value="50"/>
      <value value="75"/>
      <value value="100"/>
      <value value="125"/>
      <value value="150"/>
      <value value="175"/>
      <value value="200"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
