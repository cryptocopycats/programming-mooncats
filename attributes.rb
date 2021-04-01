require 'mooncats'


cats = Mooncats::Dataset.read( '../mooncatrescue/*.csv' )

puts "  #{cats.size} mooncat(s)"



pp cat  = cats[0]
pp cat.id

pp cat.genesis?      #=> false

pp cat.design.to_i   #=> 0
pp cat.design.pose   #=> "Standing"
pp cat.design.facing #=> "Left"
pp cat.design.face   #=> "Smile"
pp cat.design.fur    #=> "Solid"
pp cat.invert?       #=> false

puts

pp cat.hue
pp cat.color

puts

pp cat.mint
pp cat.block
pp cat.timestamp
pp cat.year



counter = Hash.new(0)      # a hash (table) - let's (auto-)default to 0 for values
cats.each do |cat|
  case cat.id
  when /^007/        then counter[ '007'   ] += 1
  when /^000[^0]/    then counter[ '000'   ] += 1
  when /^0000[^0]/   then counter[ '0000'  ] += 1
  when /^00000[^0]/  then counter[ '00000' ] += 1
  end
end

pp counter
#=> {"00000"=>10, "0000"=>97, "000"=>1487, "007"=>1648}

def rarity_in_percent( count, total=25440 )
  percent = Float(count*100)/Float( total )  # use floating point numbers
  '%.2f%%' % percent                        # pretty print/format percentage
end

pp rarity_in_percent( 1648 )
pp rarity_in_percent( 1487 )
pp rarity_in_percent(   97 )
pp rarity_in_percent(   10 )



counter = Hash.new(0)      # a hash (table) - let's (auto-)default to 0 for values
cats.each do |cat|
  counter[ cat.year ] += 1
end

pp counter

pp counter = counter.sort { |l,r| l[0]<=>r[0] }

counter.each do |rec|
  year    = rec[0]
  count   = rec[1]
  percent =  Float(count*100)/Float(cats.size)

  puts '%d | %5d  (%5.2f%%)' % [year, count, percent]
end



counter = Hash.new(0)      # a hash (table) - let's (auto-)default to 0 for values
cats.each do |cat|
  case cat.timestamp
  when Date.new(2021,3,12)    then  counter[ '2021-03-12' ] += 1
  when Date.new(2017,8,9)     then  counter[ '2017-08-09' ] += 1
  when Date.new(2017,8,10)    then  counter[ '2017-08-10' ] += 1
  when Date.new(2017,8,10+1)  then  counter[ '2017-08-11' ] += 1
  when Date.new(2017,8,10+2)  then  counter[ '2017-08-12' ] += 1
  end
end

pp counter


pp rarity_in_percent( 19681 )
pp rarity_in_percent( 492 )
pp rarity_in_percent( 412 )
pp rarity_in_percent( 229 )




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

pp counter



