class Solitaire
  def self.encrypt(plaintext, keystream)
    ciphertext = []

    converted_plaintext = convert_plaintext(plaintext)
    converted_plaintext.length.times do |i|
      ciphertext[i] = keystream[i%keystream.length] + converted_plaintext[i] % 26
    end

    return ciphertext.join(' ')
  end

  def self.decrypt(ciphertext, keystream)
    plaintext = []

    ciphertext.length.times do |i|
      plaintext[i] = keystream[i%keystream.length] + ciphertext[i] % 26
    end

    return plaintext.join(' ')
  end

  def self.convert_plaintext(plaintext)
    numerals = []

    # Downcase and cleanup the plaintext
    converted_plaintext = plaintext.downcase.gsub('[^A-Za-z0-9]', '')

    # Add X's to the message to make sure the plaintext is divisible by 5
    if converted_plaintext.length % 5 != 0
      (5 - (converted_plaintext.length % 5)).times do
        converted_plaintext << 'x'
      end
    end

    # Change characters into integers
    converted_plaintext.each_char do |c|
      numerals << c.ord - 96
    end

    return numerals
  end

  def self.unconvert_plaintext(ciphertext)

  end
end