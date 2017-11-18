require_relative 'arabic_2_english'

RSpec.shared_context "includes arabic_2_english" do
  before do
    class Integer
      include Arabic2English
    end
  end
end

#to_english will be the public interface.
describe Arabic2English do
  include_context "includes arabic_2_english"
  context "The number has three or less digits" do
    context "it's an special case" do
      context "the special case it's a two digits number with two digit number's root in it" do
        it "should return the root" do
          #Test the tens roots here
          expect(10.to_english).to eq("ten")
          expect(20.to_english).to eq("twenty")
          expect(30.to_english).to eq("thirty")
          expect(40.to_english).to eq("forty")
          expect(50.to_english).to eq("fifty")
          expect(60.to_english).to eq("sixty")
          expect(70.to_english).to eq("seventy")
          expect(80.to_english).to eq("eighty")
          expect(90.to_english).to eq("ninety")
        end
      end
      context "the special case it's a three digits number with two digit number's root in it" do
        it "should return the root" do
          #Special case root for tens specific values with more digits
          expect(110.to_english).to eq("one hundred and ten")
          expect(220.to_english).to eq("two hundred and twenty")
          expect(330.to_english).to eq("three hundred and thirty")
          expect(440.to_english).to eq("four hundred and forty")
          expect(550.to_english).to eq("five hundred and fifty")
          expect(660.to_english).to eq("six hundred and sixty")
          expect(770.to_english).to eq("seven hundred and seventy")
          expect(880.to_english).to eq("eight hundred and eighty")
          expect(990.to_english).to eq("nine hundred and ninety")
        end
      end
      context "the special case contains eleven or twelve" do
        it "should return the special numeral" do
          expect(11.to_english).to eq("eleven")
          expect(12.to_english).to eq("twelve")
          expect(511.to_english).to eq("five hundred and eleven")
          expect(912.to_english).to eq("nine hundred and twelve")
        end
      end
    end
    context "it's not an special case like eleven" do
      it "should return the english numeral" do
        expect(441.to_english).to eq("four hundred and forty-one")
        expect(537.to_english).to eq("five hundred and thirty-seven")
        expect(99.to_english).to eq("ninety-nine")
      end
    end
  end
  context "The number has more than three digits" do
    context "the number contains eleven or twelve" do
      it "should return the numeral with its respective delimiters and the special case" do
        expect(1111.to_english).to eq("one thousand and one hundred and eleven")
        expect(2212.to_english).to eq("two thousand and two hundred and twelve")
      end
    end
    context "the number it's a regular base root" do
      it "should return the numeral with hundreds delimiter" do
        expect(2222.to_english).to eq("two thousand and two hundred and twenty-two")
        expect(22222.to_english).to eq("twenty-two thousand and two hundred and twenty-two")
      end
    end
  end
end
