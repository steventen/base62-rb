require "base62/version"

module Base62
	KEYS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	KEYS_HASH = KEYS.each_char.with_index.inject({}){ |h,(k,v)| h[k]=v; h }
	BASE = KEYS.length

	# Encodes base10 (decimal) number to base62 string.
	def self.encode(num)
		return "0" if num == 0
		return nil if num < 0

		str = ""
		while num > 0
			# prepend base62 charaters
			str = KEYS[num % BASE] + str
			num /= BASE
		end
		return str
	end

	# Eecodes base62 string to a base10 (decimal) number.
	def self.decode(str)
		num = 0
		i = 0
		# while loop is faster than each_char or other 'idiomatic' way
		while i < str.length
			pow = BASE ** (str.length - i -1)
			num += KEYS_HASH[str[i]] * pow
			i += 1
		end
		return num
	end
end