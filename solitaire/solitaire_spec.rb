require 'rspec'
require './solitaire'

describe "Solitaire" do
  let(:keystream) {[1,2,3,4,5]}
  let(:plaintext) {'blah blah blah'}
  let(:ciphertext) {"3 14 4 12 19 3 14 4 12 19 3 14 4 12 29"}

  it "should decrypt its encryption" do
    Solitaire.decrypt(Solitaire.encrypt(plaintext, keystream), keystream).should eq(plaintext)
  end

  it "should encrypt" do
    Solitaire.encrypt(plaintext, keystream).should eq(ciphertext)
  end

  it "should decrypt" do
    Solitaire.decrypt(ciphertext, keystream).should eq(plaintext)
  end

  context 'plaintext conversion' do
    it "should convert plaintext" do
      Solitaire.convert_plaintext('abcde').should eq [1, 2, 3, 4, 5]
    end

    it "should convert plaintext" do
      Solitaire.convert_plaintext('abcdef').should eq [1, 2, 3, 4, 5, 6, 24, 24, 24, 24]
    end
  end
end