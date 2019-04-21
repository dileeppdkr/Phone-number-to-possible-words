class NumberToWord

	def convert_to_words phone
		phone = phone.to_s
		#return if number is not valid
		if phone.nil? || !(phone !~ /\D/) || phone.size < 3 || phone.include?("1") || phone.include?('0')
			puts "Provide a valid phone number"
    	return []
    end
    #The phone number mapping to letters is as follows:
    mapping_letters = {
    										"2" => ["a", "b", "c"],
    										"3" => ["d", "e", "f"],
    										"4" => ["g", "h", "i"],
    										"5" => ["j", "k", "l"],
    										"6" => ["m", "n", "o"],
    										"7" => ["p", "q", "r", "s"],
    										"8" => ["t", "u", "v"],
    										"9" => ["w", "x", "y", "z"]
    									}
mapping_dictionary = []
file_path = "dictionary.txt"
#fetch all values from dictionary
File.foreach( file_path ) do |word|
	mapping_dictionary << word.chop.to_s.downcase
end
keys = phone.chars.collect{|char|mapping_letters[char]}
# puts keys
mapping_result = keys.shift.product(*keys).map(&:join)

final_result =  mapping_result & mapping_dictionary
puts final_result
	end
end
NumberToWord.new.convert_to_words 6686787825
