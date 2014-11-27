require "base62/version"

module Base62
	KEYS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	BASE = KEYS.length

	# Encodes base10 (decimal) number to base62 string.
	def self.encode(num)
		return "0" if num == 0
		return nil if num < 0

		str = ""
		while num > 0
			str = str + KEYS[num % BASE]
			num = num / (BASE)
		end
		return str.reverse
	end

	# Eecodes base62 string to a base10 (decimal) number.
	def self.decode(str)
		num = 0
		i = 0
		# while loop is faster than each_char or other 'idiomatic' way
		while i < str.length
			pow = BASE ** (str.length - i -1)
			num += KEYS.index(str[i]) * pow
			i += 1
		end
		return num
	end
end