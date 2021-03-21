$LOAD_PATH.unshift( '../mooncats/lib' )

require 'mooncats'


(0..127).each do |design|
  name = 'design-%03d' % design

  cat = Mooncats::Image.new( design: design )
  cat.save( "i/#{name}.png" )

  cat = Mooncats::Image.new( design: design, zoom: 3 )
  cat.save( "i/#{name}x3.png" )
end

