ic_1924 = Rotor.new("DMTWSILRUYQNKFEJCAZBPGXOHV")
i_1930 = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ")
ii_1930 = Rotor.new("AJDKSIRUXBLHWTMCQGZNPYFVOE")
iii_1930 = Rotor.new("BDFHJLCPRTXVZNYEIWGAKMUSQO")
iv_1938 = Rotor.new("ESOVPZJAYQUIRHXLNFTGKDCMWB")
v_1938 = Rotor.new("VZBRGITYUPSDNHLXAWMJQOFECK")
vi_1939 = Rotor.new("JPGVOUMFYQBENHZRDKASXLICTW")
vii_1939 = Rotor.new("NZJHGRCXMYSWBOUFAIVLPEKQDT")
viii_1939 = Rotor.new("FKQHTLXOCBJSPDZRAMEWNIUYGV")

class Rotor
    def initialize(rotor_string)
        @rotor_array = rotor_string.split("")
    	#calling dup so the original rotor remains unrotated
        @rotor_array = rotor_array.dup
		#Creating another to aid the reset, no reason found to make it clone rather than dup though.
        @reset_rotor = @rotor_array.dup
		@rotor_hash = Hash.new
		@position = 1
    end
    
	#Resets the wheel to it's orginal positon.
    def reset
        @position = 0
        @rotor_array = @reset_rotor.dup
    end
    
	#Rotates the wheel. Moves the last letter to the beginning of the array.
    def rotate
        @position += 1
        @rotor_array << @rotor_array.shift
    end
	
	#Places the current state of the rotor into a hash corresponding to it's plaintext equivalent.
	def hashit
      n = 0	  
      ("A".."Z").each do |x|
       @rotor_hash[x] = @rotor_array[n]
       n += 1
       end  
      return @rotor_hash
    end
	
    def position?
        print "The wheel has "
		  if @position / 26 == 0
          print "not rotated at all, "
          elsif @position / 26  <= 1.99
          print "rotated once "
          else 
          print "rotated #{@position / 26} times, "
          end
		print "and is at position #{@position % 26}. \n"
	end
    
    def encrypt
    #array.each_index {|index| puts "#{index}: #{array[index]}" }
    end
end



