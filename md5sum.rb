require 'crypto'      ## or use require 'crypto-lite'

# Compute a message digest in hex(adecimal)

text = File.read( 'mooncatparser.js')
p md5( text )
#=> "dbad5c08ec98bec48490e3c196eec683"


