class Rotor
  Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!?;:-.,'\" 1234567890"
    def initialize(rotor_string)
        @rotor_array = rotor_string.split("").dup  #Calling dup so the original rotor remains unrotated
        #Creating another to aid the reset, no reason found to make it clone rather than dup though.
        @reset_rotor = @rotor_array.dup
        @rotor_hash = Hash.new
        @position = 0
    end
    
    #Places the current state of the rotor into a hash corresponding to it's plaintext.
    def hashit
      n = 0
      Chars.split("").each do |x|
       @rotor_hash[x] = @rotor_array[n]
       n += 1
      end  
      @rotor_hash
    end 
    
    #Rotates the wheel. Shifts the last letter to the beginning of the array.
    #Includes optional argument to rotate array (n) number of times.
    def rotate(n=1)
      n.times {@rotor_array << @rotor_array.shift}
    end          
        
    #Resets the rotor wheel to it's orginal positon.
    def reset
        @rotor_array = @reset_rotor.dup
    end    

    #Returns the current rotor state.
    def rotor_array
        @rotor_array
    end

    def set(x)
    self.reset
    self.rotate(x)
    self.hashit
    end  
end 