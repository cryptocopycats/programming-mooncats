require 'digest'

# Compute a message digest in hex(adecimal)

text = File.read( 'mooncatparser.js')
p Digest::MD5.hexdigest( text )
#=> "dbad5c08ec98bec48490e3c196eec683"


