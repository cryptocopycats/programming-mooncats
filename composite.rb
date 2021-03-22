$LOAD_PATH.unshift( '../mooncats/lib' )

require 'mooncats'



data = Mooncats::Dataset.read( '../mooncatrescue/*.csv' )

puts "  #{data.size} mooncat(s)"
#=> 25440 mooncat(s)

composite = Mooncats::Image::Composite.new


data.each_with_index do |cat_meta,i|
  cat_id = cat_meta['id']

  puts "  adding [#{i}] - #{cat_id}..."

  composite << Mooncats::Image.generate( cat_id )
end


composite.save( './tmp/mooncatrescue.png', :best_compression )

puts "bye"
