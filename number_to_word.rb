class NumberToWord

	def convert_to_words phone
		phone = phone.to_s
		#return if number is not valid
		if phone.nil? || !(phone !~ /\D/) || phone.size < 9 || phone.include?("1") || phone.include?('0')
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
		mapping_dictionary = {}
		file_path = "dictionary.txt"
		#fetch all values from dictionary and store into mapping_dictionary
		File.foreach( file_path ) do |word|
			mapping_dictionary[word.length] = [] unless mapping_dictionary.has_key?(word.length)
			mapping_dictionary[word.length] << word.chop.to_s.downcase
		end

		keys = phone.chars.collect{|char|mapping_letters[char]}
    total_digits = keys.length - 1
    results = {}
    for i in (2..total_digits)
      first_array = keys[0..i]
      next if first_array.length < 3
      second_array = keys[i + 1..total_digits]
      next if second_array.length < 3
      first_combination = first_array.shift.product(*first_array).map(&:join) # Get product of arrays
      next if first_combination.nil?
      second_combination = second_array.shift.product(*second_array).map(&:join)
      next if second_combination.nil?
      # Get matched words from file
      results[i] = [(first_combination & mapping_dictionary[i+2]), (second_combination & mapping_dictionary[total_digits - i +1])]
    end

    final_words = []
    final_result = []
    results.each do |key, combi|
      next if combi.first.nil? || combi.last.nil?
      combi.first.product(combi.last).map{|w| final_words << w}
      final_result << combi.first.product(combi.last).map(&:join)
    end
    # Map all char for final result
    final_words << (keys.shift.product(*keys).map(&:join) & mapping_dictionary[11]).join(", ")
    final_result << (keys.shift.product(*keys).map(&:join) & mapping_dictionary[11]).map(&:join)
    if final_words.size <= 0
    	puts "no result Found"
    else
    	puts final_words
    	puts '-=-=-=-=-'
    	puts final_result
    end

	end
end
puts "Enter 10 digit numbers"
phone = gets()
NumberToWord.new().convert_to_words(phone.chop)
