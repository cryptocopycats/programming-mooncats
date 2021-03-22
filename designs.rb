###
# to run use:
#     ruby ./designs.rb


require 'mooncats'


pp DESIGNS.size



cat = Mooncats::Image.new( design: DESIGNS[0] )
# or
cat = Mooncats::Image.new( design: 0 )   ## convenience shortcut
cat.save( 'i/design-000.png' )

cat = Mooncats::Image.new( design: DESIGNS[1] )
# or
cat = Mooncats::Image.new( design: 1 )   ## convenience shortcut
cat.save( 'i/design-001.png' )



## x3

cat = Mooncats::Image.new( design: 0, zoom: 3 )
cat.save( 'i/design-000x3.png' )

cat = Mooncats::Image.new( design: 1, zoom: 3 )
cat.save( 'i/design-001x3.png' )




pp Mooncats::POSES    #=> ["Standing", "Sleeping", "Pouncing", "Stalking"]
pp Mooncats::FACES    #=> ["Smile", "Frown (Look Down)", "Frown (Look Up)", "Flat Whiskers"]
pp Mooncats::FURS     #=> ["Solid", "Striped", "Eyepatch", "Half/Half"]
pp Mooncats::FACINGS  #=> ["Left", "Right"]



pp design = Mooncats::Metadata::Design.new( 0 )
pp design.pose     #=> "Standing"
pp design.face     #=> "Smile"
pp design.fur      #=> "Solid"
pp design.facing   #=> "Left"

pp design = Mooncats::Metadata::Design.new( 1 )
pp design.pose     #=> "Sleeping"
pp design.face     #=> "Smile"
pp design.fur      #=> "Solid"
pp design.facing   #=> "Left"


