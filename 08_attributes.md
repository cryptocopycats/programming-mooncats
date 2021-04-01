# Statistics, Statistics, Statistics - Calculate Rarity & Popularity By ID, By Pose, Fur, Face, Facing & More - Inside the 25 440 MoonCat Population



Crypto collectibles are all about rarity - the more rare the type or id of a mooncat the more valuable the ~24x24 pixel art in theory.


Let's use the [`mooncatrescue.csv` dataset](https://github.com/cryptocopycats/mooncatrescue)
in comma-separated values (CSV) format
that houses in blocks of a thousand mooncats each
(e.g.
`00.csv`,
`01.csv`,
`02.csv`, and so on)
all the 25 440 mooncats for more insight into the population.


The data records for cats
incl. id, palette, design, pose, facing, face, fur, color, hue, row and mint serial number, rescue block and timestamp,
and more.
Example:


```
row, id,           palette, design, pose, facing, face, fur, color,    ... mint
0,   0x0000020886, Normal, 0, Standing, Left, Smile, Solid, Blue,       ... 2679
1,   0x000002f63e, Normal, 0, Standing, Left, Smile, Solid, Teal,       ... 13869
2,   0x000004683b, Normal, 0, Standing, Left, Smile, Solid, Teal,       ... 24457
3,   0x0000048998, Normal, 0, Standing, Left, Smile, Solid, Cyan,       ... 22386
4,   0x000006ce5d, Normal, 0, Standing, Left, Smile, Solid, Teal,       ... 7933
...
```


Let's read in the dataset:

``` ruby
require 'mooncats'

cats = Mooncats::Dataset.read( './mooncatrescue/*.csv' )

puts "  #{cats.size} mooncat(s)"
```

printing:

```
  25440 mooncat(s)
```


Let the mooncat helper do the heavy lifting :-).
As a bonus all mooncats get wrapped into easy-to-access structs.
Example:

``` ruby
cat  = cats[0]
cat.id            #=> "0000020886"
cat.genesis?      #=> false

cat.design.to_i   #=> 0
cat.design.pose   #=> "Standing"
cat.design.facing #=> "Left"
cat.design.face   #=> "Smile"
cat.design.fur    #=> "Solid"
cat.invert?       #=> false

cat.hue           #=> 237
cat.color         #=> "Blue"

cat.mint          #=> 2679
cat.block         #=> 4244865
cat.timestamp     #=> 2017-09-06T15:03:43+00:00
cat.year          #=> 2017
```


## Popularity & Rarity by IDs


Let's calculate popularity & rarity by ids.
Let's find all James Bond mooncats where the id starts with 007
or with all zeros 000 (x3) or 0000 (x4) or 00000 (x5).


``` ruby
counter = Hash.new(0)      # a hash (table) - let's (auto-)default to 0 for values
cats.each do |cat|
  case cat.id
  when /^007/        then counter[ '007'   ] += 1
  when /^000[^0]/    then counter[ '000'   ] += 1
  when /^0000[^0]/   then counter[ '0000'  ] += 1
  when /^00000[^0]/  then counter[ '00000' ] += 1
  end
end

counter
#=> {"00000"=>10, "0000"=>97, "000"=>1487, "007"=>1648}
```

Resulting in
1 648 MoonCats (6.48%) starting with 0x007
and 1 487 (5.85%) starting with 0x000
and 97 (0.38%) starting with 0x0000
and 10 (0.04%) starting with 0x00000.


What about the rarity percentage?
To calculate use:

``` ruby
def rarity_in_percent( count, total=25440 )
   percent = Float(count*100)/Float( total )  # use floating point numbers
   '%.2f%%' % percent                         # pretty print/format percentage
end

rarity_in_percent( 1648 )  #=> "6.48%"
rarity_in_percent( 1487 )  #=> "5.85%"
rarity_in_percent(   97 )  #=> "0.38%"
rarity_in_percent(   10 )  #=> "0.04%"
```



## Popularity & Rarity by Mint Year (5) - 2017, 2018, 2019, 2020, 2021

Let's calculate popularity & rarity by the year the
mooncat got minted on the blockchain:

``` ruby
counter = Hash.new(0)      # a hash (table) - let's (auto-)default to 0 for values
cats.each do |cat|
  counter[ cat.year ] += 1
end

counter
#=> {2017=>3365, 2021=>19682, 2018=>2319, 2019=>71, 2020=>3}
```

Resulting in five mint series.
Let's sort by year and pretty print the result
and as a bonus let's calculate the percentage (%) in the total population:

``` ruby
counter = counter.sort { |l,r| l[0]<=>r[0] }
#=> [[2017, 3365], [2018, 2319], [2019, 71], [2020, 3], [2021, 19682]]

counter.each do |rec|
  year    = rec[0]
  count   = rec[1]
  percent =  Float(count*100)/Float(cats.size)

  puts '%d | %5d  (%5.2f%%)' % [year, count, percent]
end
```

Resulting in:

```
2017 |  3365  (13.23%)
2018 |  2319  ( 9.12%)
2019 |    71  ( 0.28%)
2020 |     3  ( 0.01%)
2021 | 19682  (77.37%)
```


What about March 12, 2021 - the Mooncat Rescue Day?
What about August 10, 2017 - the Launch Day? or Launch Day+1 or Launch Day+2?



``` ruby
counter = Hash.new(0)      # a hash (table) - let's (auto-)default to 0 for values
cats.each do |cat|
  case cat.timestamp
  when Date.new(2021,3,12)    then  counter[ '2021-03-12' ] += 1
  when Date.new(2017,8,10)    then  counter[ '2017-08-10' ] += 1
  when Date.new(2017,8,10+1)  then  counter[ '2017-08-11' ] += 1
  when Date.new(2017,8,10+2)  then  counter[ '2017-08-12' ] += 1
  end
end

counter
#=> {"2021-03-12" => 19681,
#    "2017-08-10" => 492,
#    "2017-08-11" => 412,
#    "2017-08-12" => 229}
```

Resulting in
19 681 MoonCats (77.36%) rescued on March 12, 2021
and 492 (1.93%) rescued on August 10, 2017
and 412 (1.62%) on T+1, and 229 (0.90%) on T+2.


Trivia:   The Mooncat could get rescued for "free" on March 12, 2021 -
paying only
the transaction gas fee about $25-35 at the time resulting
in a gold rush for miners raking in about $600 000 in a couple of hours.



## Popularity & Rarity by Pose (4), Fur (4), Face(4), Facing (2)

Remember mooncats get generated from
128 patterns from 0 to 127 -
composed of 4 (pose) x 4 (face) x 4 (fur)
x 2 (facing) designs.
Let's calculate popularity & rarity:



``` ruby
counter = {
  facing:    Hash.new(0),
  face:      Hash.new(0),
  fur:       Hash.new(0),
  pose:      Hash.new(0),
  palette:   Hash.new(0),
  color:     Hash.new(0),
  design:    Hash.new(0),
}

cats.each do |cat|
  counter[ :facing ][ cat.facing ] += 1
  counter[ :face ][ cat.face ] += 1
  counter[ :fur ][ cat.fur ] += 1
  counter[ :pose ][ cat.pose ] += 1

  palette = cat.invert? ? 'Inverted' : 'Normal'
  counter[ :palette ][ palette ] += 1

  design = cat.design.to_i
  ## note: special formula for black/white genesis cats
  color = if cat.genesis?
            design % 2 == 0 ? 'Black' : 'White'
          else
            cat.color
          end
  counter[ :color ][ color ] += 1

  counter[ :design ][ design ] += 1
end
```



Resulting in:

``` ruby
{
:facing=>{
  "Left"  => 12825,
  "Right" => 12615},
:face=>{
  "Smile"             => 6313,
  "Frown (Look Down)" => 6212,
  "Frown (Look Up)"   => 6336,
  "Flat Whiskers"     => 6579},
:fur=>{
  "Solid"     => 6511,
  "Striped"   => 6179,
  "Eyepatch"  => 6172,
  "Half/Half" => 6578},
:pose=>{
  "Standing" => 6175,
  "Sleeping" => 6063,
  "Pouncing" => 6711,
  "Stalking" => 6491},
:palette=>{
  "Normal"   => 12972,
  "Inverted" => 12468},
:color=>{
  "Blue"       => 2223,
  "Teal"       => 1934,
  "Cyan"       => 2191,
  "Green"      => 1920,
  "Purple"     => 2179,
  "Sky Blue"   => 2199,
  "Yellow"     => 2137,
  "Chartreuse" => 1903,
  "Orange"     => 2233,
  "Red"        => 2251,
  "Fuchsia"    => 2116,
  "Magenta"    => 2058,
  "Black"      => 48,
  "White"      => 48},
:design=>{
  0=>216, 1=>164,  2=>211, 3=>225,
  4=>186, 5=>186,  6=>216, 7=>199,
  8=>191, 9=>186, 10=>196, 11=>198,
  12=>218, 13=>190, 14=>216, 15=>205,
  16=>187, 17=>213, 18=>211, 19=>204,
  20=>167, 21=>193, 22=>188, 23=>199,
  24=>190, 25=>174, 26=>203, 27=>206,
  28=>204, 29=>172, 30=>194, 31=>194,
  32=>192, 33=>196, 34=>237, 35=>223,
  36=>171, 37=>200, 38=>188, 39=>184,
  40=>187, 41=>197, 42=>210, 43=>193,
  44=>209, 45=>191, 46=>222, 47=>207,
  48=>204, 49=>220, 50=>213, 51=>230,
  52=>212, 53=>196, 54=>225, 55=>208,
  56=>181, 57=>162, 58=>222, 59=>207,
  60=>174, 61=>208, 62=>224, 63=>230,
  64=>206, 65=>183, 66=>185, 67=>203,
  68=>198, 69=>168, 70=>200, 71=>210,
  72=>194, 73=>181, 74=>193, 75=>189,
  76=>203, 77=>189, 78=>208, 79=>200,
  80=>202, 81=>197, 82=>218, 83=>194,
  84=>181, 85=>189, 86=>173, 87=>184,
  88=>179, 89=>187, 90=>207, 91=>177,
  92=>184, 93=>209, 94=>233, 95=>199,
  96=>179, 97=>180, 98=>211, 99=>224,
  100=>187, 101=>216, 102=>181, 103=>186,
  104=>190, 105=>143, 106=>203, 107=>181,
  108=>204, 109=>205, 110=>198, 111=>241,
  112=>193, 113=>174, 114=>215, 115=>201,
  116=>190, 117=>183, 118=>225, 119=>190,
  120=>186, 121=>219, 122=>257, 123=>183,
  124=>210, 125=>192, 126=>228, 127=>217}}
```

Voila! That's it to get your started on calculating rarity & popularity
stats on the 25 440 mooncats population.




Need more rarity ideas?
Find mooncat twins, that is, mooncats with
identicial colors and pose/face/fur/facing.
Or how about doppelganger twins, that is, mooncats with
identicial colors and pose/face/fur BUT one facing left
the other facing right.
Or how about siblings, that is, mooncats
rescued in the same block? How many sisters and brothers is the max?


