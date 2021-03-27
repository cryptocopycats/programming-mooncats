###
# to run use:
#     ruby ./colors.rb

require 'mooncats'



id  = '0x00571281e7'
pp r = id[6,2]    # take 2 chars (starting at position 6 - that is, byte 3)
pp g = id[8,2]    # take 2 chars (starting at position 8 - that is, byte 4)
pp b = id[10,2]   # take 2 chars (starting at position 10 - that is, byte 5)

pp r.hex
pp g.hex
pp b.hex


pp hsl = Mooncats::Color.rgb_to_hsl( r.hex, g.hex, b.hex )

pp h = hsl[0]
pp s = hsl[1]
pp l = hsl[2]

pp hx = h % 360
pp hy = (h + 320) % 360



c1 = Mooncats::Color.from_hsl( hx, 1, 0.1 )
c2 = Mooncats::Color.from_hsl( hx, 1, 0.2 )
c3 = Mooncats::Color.from_hsl( hx, 1, 0.45 )
c4 = Mooncats::Color.from_hsl( hx, 1, 0.7 )
c5 = Mooncats::Color.from_hsl( hy, 1, 0.8 )


c1 = Mooncats::Color.from_hsl( hx, 1, 0.1 )
c4 = Mooncats::Color.from_hsl( hx, 1, 0.2 )
c5 = Mooncats::Color.from_hsl( hx, 1, 0.45 )
c2 = Mooncats::Color.from_hsl( hx, 1, 0.7 )
c3 = Mooncats::Color.from_hsl( hy, 1, 0.8 )



normal   = Mooncats::Image.derive_palette( r: r.hex,
                                           g: g.hex,
                                           b: b.hex )
inverted = Mooncats::Image.derive_palette( r: r.hex,
                                           g: g.hex,
                                           b: b.hex,
                                           invert: true )

cat = Mooncats::Image.new( design: 87, colors: normal )
cat.save( "i/colors-209_087.png")

cat = Mooncats::Image.new( design: 87, colors: inverted )
cat.save( "i/colors-209i_087.png")






def hue_to_color( hue )
  case hue
  when   0..29  then 'Red'
  when  30..59  then 'Orange'
  when  60..89  then 'Yellow'
  when  90..119 then 'Chartreuse'
  when 120..149 then 'Green'
  when 150..179 then 'Lime Green'
  when 180..209 then 'Cyan'
  when 210..239 then 'Sky Blue'
  when 240..269 then 'Blue'
  when 270..299 then 'Purple'
  when 300..329 then 'Magenta'
  when 330..359 then 'Fuscia'
  end
end

pp hue_to_color( 209 )



metadata = Mooncats::Metadata.new( '0x00571281e7' )
pp metadata.hue
pp metadata.color




