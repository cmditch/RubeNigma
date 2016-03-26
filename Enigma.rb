#
#
#                     Virtual Enigma Machine v0.2
#                          By Coury Ditch
#
#  Unlike actual Enimga, this includes Upper and Lowercase letters, 
#             some punctuation - !?.,':;- - and spaces. 
#

class Rotor
Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!?;:-.,'\" 1234567890"

    def initialize(rotor_string)
        @rotor_array = rotor_string.split("").dup  #calling dup so the original rotor remains unrotated
        #Creating another to aid the reset, no reason found to make it clone rather than dup though.
        @reset_rotor = @rotor_array.dup
        @rotor_hash = Hash.new
        @clicks = 0
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
      return @rotor_hash
    end 
    
    #Rotates the wheel. Moves the last letter to the beginning of the array.
    #Includes option argument to rotate array (n) number of times.
    def rotate(n=1)
      if n == 1
        @clicks += 1
        @position += 1
        @rotor_array << @rotor_array.shift
      else
        n.times do
          @clicks += 1
          @position += 1
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
    end     
      
end # End of Rotor class.


def main

  rotor_i = Rotor.new(  "EKMFLGtowyh.xbrcjD!QV'ZNT,OW YH1X2?3U4S5u6s7p8a9;i0\"P:-AIBRCJekmflgdqvzn")
  rotor_ii = Rotor.new( "AJDKSIR1t2,3m4c5q6g7z8n9p0':yfvoeU.XBLHWTsir!uxbM;-CQG?Z\"NPY FVOEajdklhw")
  rotor_iii = Rotor.new("BD FHJLCPRTXyeiwg1a2k3m4'5u6s7q8o9V0Z:N?YEIWjlcp-rt;GAKMU.\"SQOb!dfhx,vzn")
  reflector = Rotor.new(Rotor::Chars.reverse)

  msg = []
  letter = Object.new
  nonce_i = 0
  nonce_ii = 0

  60.times do print "\n" end
  puts "\n\n\n            Virtual Enimga\n"
  puts "          Created by C.Ditch"
  puts "\n\n Set each rotors starting letter. Example 'tyx' : "
  rotors_placement = gets.chomp.upcase.split("")

  rotor_i_setting = rotor_i.rotor_array.index(rotors_placement[0])
  rotor_ii_setting = rotor_ii.rotor_array.index(rotors_placement[1])
  rotor_iii_setting = rotor_iii.rotor_array.index(rotors_placement[2])

  rotor_i.set(rotor_i_setting)
  rotor_ii.set(rotor_ii_setting)
  rotor_iii.set(rotor_iii_setting)

  print "\n\nEnter your message:\n"

  msg1 = gets.chomp.split("")
    msg1.each do |x|    
      rotor_i.hashit.each do |key1, value1|   
        if key1 == x         
          rotor_ii.hashit.each do |key2, value2|
            if key2 == value1            
              rotor_iii.hashit.each do |key3, value3|
                if key3 == value2
                  reflector.hashit.each do |key4, value4|
                    if key4 == value3
                      rotor_iii.hashit.invert.each do |key5, value5|
                        if key5 == value4
                          rotor_ii.hashit.invert.each do |key6, value6|
                            if key6 == value5
                              rotor_i.hashit.invert.each do |key7, value7|
                                if key7 == value6
                                  letter = value7
                                  rotor_iii.rotate 
                                  nonce_i += 1
                                  nonce_ii += 1
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end                                 
              end          
            end
          end
        end
      end 

      if nonce_ii / 13 == 1
        rotor_ii.rotate
        nonce_ii = 0
      end
      
      if nonce_i / 26 == 1
        rotor_i.rotate
        nonce_i = 0
      end
    msg << letter
  end

    puts "\nHere is the Enigma output (press enter):\n" + msg.join
  
  def run_again?
      print "\n\n\n\nCopy your output text and send it to someone!"
      gets
      print "\nRun the 'Virtual Enigma' again?\n\n(1) Yes\n(2) No\n"
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
  gets
  run_again?
end
main