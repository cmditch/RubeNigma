class Rotor
    def initialize(rotor_array)
		#calling dup so the original rotor remains unrotated
        @rotor_array = rotor_array.dup 
		#Creating another to aid the reset, no reason found to make it clone rather than dup though.
        {@reset_rotor = @rotor_array}.freeze
		@position = 1
    end
    
	#Resets the wheel to it's orginal positon.
    def reset
        @rotor_array = @reset_rotor.dup
    end
    
	#Rotates the wheel. Moves the last letter to the beginning of the array.
    def rotate
        @rotor_array.unshift(@rotor_array.pop)
        print @rotor_array
		@position += 1
    end
	
	#Places the current state of the rotor into a hash corresponding to it's plaintext equivalent.
	def hashit
      n = 0
      rotor_hash = Hash.new
	  
      ("A".."Z").each do |x|
       rotor_hash[x] = @rotor_array[n]
       n += 1
       end
  
      return rotor_hash
    end
	
	def position?
		prints "The wheel has rotated #{@position / 26} times and is at position #{@position % 26}"
end

$i_1930 = ["E","K","M","F","L","G","D","Q","V","Z","N","T","O","W","Y","H","X","U","S","P","A","I","B","R","C","J"]
rotor1 = Rotor.new($i_1930)


#not done yet
