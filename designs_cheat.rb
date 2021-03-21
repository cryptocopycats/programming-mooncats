$LOAD_PATH.unshift( '../mooncats/lib' )

require 'mooncats'



# Step 1:  Generate design images using original size and 3x

(0..127).each do |design|
  name = 'design-%03d' % design

  cat = Mooncats::Image.new( design: design )
  cat.save( "i/#{name}.png" )

  cat = Mooncats::Image.new( design: design, zoom: 3 )
  cat.save( "i/#{name}x3.png" )
end



# Step 2: Generate the all-in-one cheat sheet page

buf =<<TXT
# MoonCat Designs (128)

In original pixel size¹ and 3x zoom;
tagged with pose (4), face (4), fur (4), facing (2) attributes.

¹: Standing (21×17), sleeping (20×14), pouncing (17×22), stalking (20×21)

TXT



buf << "| Standing | Sleeping | Pouncing | Stalking |\n"
buf << "|----------|----------|----------|----------|\n"

(0..127).each_slice(4) do |slice|
   buf << "| "
   slice.each do |design|
      design_meta = Mooncats::Metadata::Design.new( design )

      name = "design-%03d" % design

      buf << " ![](i/#{name}.png)"
      buf << " ![](i/#{name}x3.png)"
      buf << " <br> #{design} "
      buf << "#{design_meta.pose}·"
      buf << "#{design_meta.face}·"
      buf << "#{design_meta.fur}·"
      buf << "#{design_meta.facing} "
      buf << "|"
   end
   buf << "\n"
end

puts buf




File.open( './DESIGNS.md', 'w:utf-8') { |f| f.write( buf ) }
