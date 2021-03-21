# Build Your Own All-In-One Page Cheat Sheet with All 128 MoonCat Designs (0-127) In Original Pixel Size And 3X; Tagged With Pose (4), Face (4), Fur (4), Facing (2) Attributes


Let's build an all-in-one page cheat sheet
that lists all 128 MoonCat designs (0 to 127) in original pixel size
approaching 24×24¹ and 3x zoom;
tagged with pose (4), face (4), fur (4), facing (2) attributes.

¹: Standing (21×17), sleeping (20×14), pouncing (17×22), stalking (20×21)



## Step 1:  Generate design images using original size and 3x

Let's loop from 0 to 127 and generate the two image series in a single run. Naming the original series images `design-000.png`,
`design-001.png`, `design-002.png` and so on
and the 3x series `design-000x3.png`,
`design-001x3.png`, `design-002x3.png`, and so on:


``` ruby
require 'mooncats'

(0..127).each do |design|
  name = 'design-%03d' % design

  cat = Mooncats::Image.new( design: design )
  cat.save( "i/#{name}.png" )

  cat = Mooncats::Image.new( design: design, zoom: 3 )
  cat.save( "i/#{name}x3.png" )
end
```

Resulting in two 128 image series.
Original size:

![](i/design-000.png)
![](i/design-001.png)
![](i/design-002.png)
![](i/design-003.png)
![](i/design-004.png)
![](i/design-005.png)
![](i/design-006.png)
![](i/design-007.png)
...

And with 3x zoom factor:

![](i/design-000x3.png)
![](i/design-001x3.png)
![](i/design-002x3.png)
![](i/design-003x3.png)
![](i/design-004x3.png)
![](i/design-005x3.png)
![](i/design-006x3.png)
![](i/design-007x3.png)
...