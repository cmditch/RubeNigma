#
#
#                     Virtual Enigma Machine v0.2
#                          By Coury Ditch
#
#  Unlike actual Enimga, this includes Upper and Lowercase letters, 
#             some punctuation - !?.,':;- - and spaces. 
#
#

class Rotor
Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!?;:-.,'\" 1234567890"

    def initialize(rotor_string)
        @rotor_array = rotor_string.split("").dup  #Calling dup so the original rotor remains unrotated
        #Creating another to aid the reset, no reason found to make it clone rather than dup though.
        @reset_rotor = @rotor_array.dup
        @rotor_hash = Hash.new
        @current_letter = "A"
        @position = 0
    end
    
    
    #Places the current state of the rotor into a hash corresponding to it's plaintext equivalent.
    def hashit
      n = 0
      Chars.split("").each do |x|
       @rotor_hash[x] = @rotor_array[n]
       n += 1
       end  
       @rotor_hash
    end 
    
    #Rotates the wheel. Moves the last letter to the beginning of the array.
    #Includes option argument to rotate array (n) number of times.
    def rotate(n=1)
      if n == 1
        @rotor_array << @rotor_array.shift
      else
        n.times do
          @rotor_array << @rotor_array.shift
        end
      end
      @rotor_array
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
# End of Rotor class.

def main
  $rotor_i = Rotor.new(  "EKMFLGtowyh.xbrcjD!QV'ZNT,OW YH1X2?3U4S5u6s7p8a9;i0\"P:-AIBRCJekmflgdqvzn")
  $rotor_ii = Rotor.new( "AJDKSIR1t2,3m4c5q6g7z8n9p0':yfvoeU.XBLHWTsir!uxbM;-CQG?Z\"NPY FVOEajdklhw")
  $rotor_iii = Rotor.new("BD FHJLCPRTXyeiwg1a2k3m4'5u6s7q8o9V0Z:N?YEIWjlcp-rt;GAKMU.\"SQOb!dfhx,vzn")
  $reflector = Rotor.new(Rotor::Chars.reverse)

  $nonce_i = 0
  $nonce_ii = 0

  def run_again?
      print "\n\nRun the 'Virtual Enigma' again?\n\n(1) Yes\n(2) No\n"
      repeat = gets.chomp.to_i
    #Requests to run-again? or exit, and clears screen each time (adds 60 lines).
    case repeat
      when 1
        60.times do print "\n" end
        main
      when 2
        60.times do print "\n" end
        exit
      else 
        print "Please enter (1) to run again, (2) to exit. Thanks expert typer."
        run_again?
    end
  end

  def cipherize(msg_array)
    msg_array.each do |into_rotor_i|
      into_rotor_ii = $rotor_i.hashit.values_at(into_rotor_i).join
      into_rotor_iii = $rotor_ii.hashit.values_at(into_rotor_ii).join
      into_reflector = $rotor_iii.hashit.values_at(into_rotor_iii).join
      back_through_rotor_iii = $reflector.hashit.values_at(into_reflector).join
      back_through_rotor_ii = $rotor_iii.hashit.invert.values_at(back_through_rotor_iii).join
      back_through_rotor_i = $rotor_ii.hashit.invert.values_at(back_through_rotor_ii).join
      $cipher_letters << $rotor_i.hashit.invert.values_at(back_through_rotor_i).join
      $rotor_iii.rotate 
      $nonce_i += 1
      $nonce_ii += 1

      if $nonce_ii / 13 == 1
        $rotor_ii.rotate
        $nonce_ii = 0
      end
        
      if $nonce_i / 26 == 1
        $rotor_i.rotate
        $nonce_i = 0
      end
    end
    $cipher_letters.join
  end

  $cipher_letters = []
  
  60.times do print "\n" end
  puts "\n\n\n            Virtual Enimga\n"
  puts "          Created by C.Ditch"
  puts "\n\n Set each rotors starting letter. Example 'tyx' : "
  rotors_placement = gets.chomp.upcase.split("")

  $rotor_i.set($rotor_i.rotor_array.index(rotors_placement[0]))
  $rotor_ii.set($rotor_ii.rotor_array.index(rotors_placement[1]))
  $rotor_iii.set($rotor_iii.rotor_array.index(rotors_placement[2]))
  $reflector.set(1)

  print "\n\nEnter your message:\n"
  user_input = gets.chomp.split("")

  print "\nOutput:\n"
  print cipherize(user_input)
  
  run_again?

end
main