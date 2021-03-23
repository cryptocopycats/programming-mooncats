require 'pp'

id  = '0x00571281e7'
pp snd = id[4,2]    # take 2 chars (starting at position 4)

pp bits = '%08b' % snd.hex


pp invert = bits[0,1]  # take 1 char (starting at position 0)
pp facing = bits[1,1]  # take 1 char (starting at position 1)
pp face   = bits[2,2]  # take 2 chars (starting at position 2)
pp fur    = bits[4,2]  # take 2 chars (starting at position 4)
pp pose   = bits[6,2]  # take 2 chars (starting at position 6)


pp snd.hex % 128



require 'mooncats'

pp meta = Mooncats::Metadata.new( '0x00571281e7' )
pp meta.invert? #=> false
pp meta.facing    #=> "Right"
pp meta.face      #=> "Frown (Look Down)"
pp meta.fur       #=> "Striped"
pp meta.pose      #=> "Stalking"

pp meta.design.to_i


pp design = Mooncats::Metadata::Design.new( 87 )
pp design.facing   #=> "Right"
pp design.face     #=> "Frown (Look Down)"
pp design.fur      #=> "Striped"
pp design.pose     #=> "Stalking"


