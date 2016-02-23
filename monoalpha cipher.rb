
#Most of the Rotor class is unused. Currently this is a mono-alphabetic cipher script.
#Eventually I'll have a fully operational enigma, with multiple rotors rotating as it encrypts.
#A bombe proof (heh!) polyalphabetic cipher with selectable rotors settings and all!
#Enjoy the basic script for now! 
#Click >Run!                                                                          ^^^^^^^^

#By Coury Ditch



class Rotor

    def initialize(rotor_string)
        @rotor_array = rotor_string.split("").dup  #calling dup so the original rotor remains unrotated
        #Creating another to aid the reset, no reason found to make it clone rather than dup though.
        @reset_rotor = @rotor_array.dup
        @rotor_hash = Hash.new
    	@position = 0
    end
    
    #Returns the total amount of notches the rotor has turned, one letter being one notch.
    def total_steps?
        print "At position " + @position.to_s + ", not counting all resets."
        @position
    end        
        
        
	#Resets the rotor wheel to it's orginal positon.
    def reset
        @position = 0
        @rotor_array = @reset_rotor.dup
    end    
    
    
	#Rotates the wheel. Moves the last letter to the beginning of the array.
    #Includes option argument to rotate array (n) number of times.
    def rotate(n=1)
      if n == 1
        @position += 1
        @rotor_array << @rotor_array.shift
      else
        n.times do
          @position += 1
          @rotor_array << @rotor_array.shift
        end
      end
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
	
    
    #Returns a descriptions of the rotors history. How many nothces, and full revolutions.
    def position?
        print "The wheel has "
        
		  if @position / 26 == 0
            print "not yet fully rotated, "
            elsif @position / 26  == 1
            print "rotated once "
            else 
            print "rotated #{@position / 26} times, "
          end
                 
          if @position % 26 == 0
            print "and is at position 1. \n"
            else
		    print "and is at position #{@position % 26}. \n"
          end
	end
    
    
    #Returns the current rotor state.
    def state
        @rotor_array
    end
    
end # End of Rotor class.



# Removes all non-letter characters and whitespace, and converts to an array of capitalized letters.
# I've had to add an 'if' statement because I couldn't get regex to work if the msg was only one word.
def format_encrypt(msg_string) 
     if msg_string.upcase.gsub(/^[^A-Z]$/, "").split("") == nil || ""
     msg_string.upcase.split("")
     else
     msg_string.upcase.gsub!(/^[^A-Z]$/, "").split("")
     end
end


#    This formats the cipher into an array and gets it ready for decryption.
#This is superfluous, as the split method could be added to the message gets.chomp
def format_decrypt(msg_string) 
     msg_string.upcase.split("")
end


#           Below is the meat of the current mono-alphabetic script.   
#               This takes each letter of your formatted message, 
#                 and checks it against the rotor's cipher hash.
#
# Once the corresponding plaintext-ciphertext letter is found in the rotors hash, 
#             it will push the value to the 'encrypted_msg' array.
#
#               Returned is the encrypted message as an array,
#                best converted to string before printing it.
#
def encrypt(msg_array, rotor)
    encrypted_msg = []
    msg_array.each do |x|
      rotor.each do |key, value| 
        if key == x
        encrypted_msg << value
        end
     end
   end
   encrypted_msg
end
#
##^^^ Meat of the program for the time being ^^^


#Here is a record of some actual Enigma rotor wirings, as per wikipedia.
#  http://www.wikiwand.com/en/Enigma_rotor_details#/Rotor_wiring_tables

ic_1924 = Rotor.new("DMTWSILRUYQNKFEJCAZBPGXOHV")
i_1930 = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ")
ii_1930 = Rotor.new("AJDKSIRUXBLHWTMCQGZNPYFVOE")
iii_1930 = Rotor.new("BDFHJLCPRTXVZNYEIWGAKMUSQO")
iv_1938 = Rotor.new("ESOVPZJAYQUIRHXLNFTGKDCMWB")
v_1938 = Rotor.new("VZBRGITYUPSDNHLXAWMJQOFECK")
vi_1939 = Rotor.new("JPGVOUMFYQBENHZRDKASXLICTW")
vii_1939 = Rotor.new("NZJHGRCXMYSWBOUFAIVLPEKQDT")
viii_1939 = Rotor.new("FKQHTLXOCBJSPDZRAMEWNIUYGV")
reflector = Rotor.new("ZYXWVUTSRQPONMLKJIHGFEDCBA").hashit.freeze





#        Below is the script to encrypt/decrypt your own messages.
#
puts " Welcome to the psuedo-Enimga\n    Monoalphabetic v0.1"
puts "  Proper version coming soon! "
print "\nWould you like to encrypt or decrypt?"
program = gets.chomp.downcase

case program
when "encrypt"
    puts "Enter your plaintext (text only plz, no numbers,and more than one word!): "
    og_message = gets.chomp
    og_message = format_encrypt(og_message)
    puts "Here is your encrypted text!\n\n"
    print encrypt(og_message, i_1930.hashit)
  when "decrypt"
  puts "Enter encoded text: "
    ciphertext = gets.chomp
    ciphertext = format_decrypt(ciphertext)
    puts "Here is your decrypted message!\n\n"
    print encrypt(ciphertext, i_1930.hashit.invert).to_s.downcase  
  else
  puts "\nSorry I didn't understand you? \nIt\'s \'encrypt\' or \'decrypt\', run it again foo!"
end

#The End.

