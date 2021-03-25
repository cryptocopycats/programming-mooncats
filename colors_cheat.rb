###
# to run use:
#     ruby ./colors_cheat.rb

$LOAD_PATH.unshift( '../mooncats/lib' )
require 'mooncats'



# Step 1:  Generate a sample image and a color bar

(0..359).each do |hue|
   normal   = Mooncats::Image.derive_palette( hue: hue )
   inverted = Mooncats::Image.derive_palette( hue: hue, invert: true)

   name = 'colors-%03d' % hue

   bar = Mooncats::Image::Bar.new( colors: normal )
   bar.save( "i/#{name}.png")

   bar = Mooncats::Image::Bar.new( colors: inverted )
   bar.save( "i/#{name}i.png")

   cat = Mooncats::Image.new( design: 1, colors: normal )
   cat.save( "i/#{name}_001.png")

   cat = Mooncats::Image.new( design: 1, colors: inverted )
   cat.save( "i/#{name}i_001.png")
end



# Step 2: Generate the all-in-one cheat sheet page

buf =<<TXT
# MoonCat Colors (360)

Note: Every mooncat has 5 colors.
All (remaining) 4 colors are derived from the
primary / first color (specified in degrees from 0 to 359).
If the inverted palette flag is set,
than color 2 becomes color 4,
color 3 becomes color 5, color 4 becomes color 2, and
color 5 becomes color 3.

The formula for deriving the color palette is
(where hue is a number from 0 to 359 -
mapping to degrees on the color wheel):


``` ruby
hx = hue
hy = (hue + 320) % 360

hsl( hx, 1, 0.1 )    # color 1
hsl( hx, 1, 0.2 )    # color 2
hsl( hx, 1, 0.45 )   # color 3
hsl( hx, 1, 0.7 )    # color 4
hsl( hy, 1, 0.8 )    # color 5
```


TXT



buf << "|      | Hue  | Colors | 1 2 3 4 5  | Colors <br> (Inverted) |\n"
buf << "|------|-----:|--------|------------|------------|\n"



(0..359).each do |hue|
   name = 'colors-%03d' % hue

   normal   = Mooncats::Image.derive_palette( hue: hue )

   buf << "| ![](i/#{name}_001.png) "
   buf << "  ![](i/#{name}i_001.png) "
   buf << "| #{hue}° "
   buf << "| ![](i/#{name}.png) "
   buf << "| `#{Mooncats::Color.to_hex(normal[0])}` "
   buf << " `#{Mooncats::Color.to_hex(normal[1])}` "
   buf << " `#{Mooncats::Color.to_hex(normal[2])}` "
   buf << " `#{Mooncats::Color.to_hex(normal[3])}` "
   buf << " `#{Mooncats::Color.to_hex(normal[4])}` "
   buf << "| ![](i/#{name}i.png) "
   buf << "|\n"
end

puts buf


File.open( './COLORS.md', 'w:utf-8') { |f| f.write( buf ) }

