require 'mooncats'

design = DESIGNS[0]   ## pick any design 0-127

## step 1: convert single-line string into array of array
design = design.split( '.' )
design = design.map { |row| row.chars }

## step 2: print pixel data / matrix
puts '---'
design.each do |row|
  puts row.join( ' ' )
end
puts '---'
