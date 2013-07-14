#shufString.rb
#by Julian Borrey
# 13/07/2013
#
# Adaptation to sting class to shuffle the string.

class String
   
   def shuf()
      rv = self.split(''); #split the string into individual chars
      rv = rv.shuffle();   #shuffle elements in array
      rv = rv.join();      #join elements to make a single string
      return rv;
   end

end
