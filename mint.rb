###
# to run use:
#     ruby ./mint.rb


require 'mooncats'

meta = Mooncats::Metadata.new( '0x00000800fa' )

pp meta.genesis?

pp meta.design.to_i
pp meta.design.pose
pp meta.design.facing
pp meta.design.face
pp meta.design.fur
pp meta.invert?

pp meta.rgb


meta = Mooncats::Metadata.new( '0x0077c8278d' )

pp meta.genesis?

pp meta.design.to_i
pp meta.design.pose
pp meta.design.facing
pp meta.design.face
pp meta.design.fur
pp meta.invert?

pp meta.rgb


Mooncats::Image.mint( '0x00000800fa' ).save( 'i/mooncat-00000800fa.png' )
Mooncats::Image.mint( '0x0077c8278d' ).save( 'i/mooncat-0077c8278d.png' )
Mooncats::Image.mint( '0xff5f000ca7' ).save( 'i/mooncat-ff5f000ca7.png' )


# use x2:

Mooncats::Image.mint( '0x00000800fa', zoom: 2 ).save( 'i/mooncat-00000800fa_x2.png' )
Mooncats::Image.mint( '0x0077c8278d', zoom: 2 ).save( 'i/mooncat-0077c8278d_x2.png' )
Mooncats::Image.mint( '0xff5f000ca7', zoom: 2 ).save( 'i/mooncat-ff5f000ca7_x2.png' )

# And x4:

Mooncats::Image.mint( '0x00000800fa', zoom: 4 ).save( 'i/mooncat-00000800fa_x4.png' )
Mooncats::Image.mint( '0x0077c8278d', zoom: 4 ).save( 'i/mooncat-0077c8278d_x4.png' )
Mooncats::Image.mint( '0xff5f000ca7', zoom: 4 ).save( 'i/mooncat-ff5f000ca7_x4.png' )

# And x8:

Mooncats::Image.mint( '0x00000800fa', zoom: 8 ).save( 'i/mooncat-00000800fa_x8.png' )
Mooncats::Image.mint( '0x0077c8278d', zoom: 8 ).save( 'i/mooncat-0077c8278d_x8.png' )
Mooncats::Image.mint( '0xff5f000ca7', zoom: 8 ).save( 'i/mooncat-ff5f000ca7_x8.png' )
