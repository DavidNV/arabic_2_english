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
      context "the input its negative" do
        it "should english numeral with a 'negative' prefix" do
          expect(-330.to_english).to eq("negative three hundred and thirty")
          expect(-12.to_english).to eq("negative twelve")
          expect(-511.to_english).to eq("negative five hundred and eleven")
        end
      end
    end
    context "it's not an special case like eleven" do
      it "should return the english numeral" do
        expect(441.to_english).to eq("four hundred and forty-one")
        expect(-537.to_english).to eq("negative five hundred and thirty-seven")
        expect(99.to_english).to eq("ninety-nine")
      end
    end
  end
  context "The number has more than three digits" do
    context "it's an special case" do
      context "the special case contains eleven or twelve" do
        it "should return the special numeral" do
          expect(763411.to_english).to eq("seven hundred and sixty-three thousand and four hundred and eleven")
          expect(1063412.to_english).to eq("one million and sixty-three thousand and four hundred and twelve")
          #Here the eleven and twelve are at the beginning
          expect(111411.to_english).to eq("one hundred and eleven thousand and four hundred and eleven")
          expect(12063412.to_english).to eq("twelve million and sixty-three thousand and four hundred and twelve")
        end
      end
      context "the input its negative" do
        it "should english numeral with a 'negative' prefix" do
          expect(-763411.to_english).to eq("negative seven hundred and sixty-three thousand and four hundred and eleven")
          expect(-1063412.to_english).to eq("negative one million and sixty-three thousand and four hundred and twelve")
          #Same here
          expect(-111411.to_english).to eq("negative one hundred and eleven thousand and four hundred and eleven")
          expect(-12063412.to_english).to eq("negative twelve million and sixty-three thousand and four hundred and twelve")
        end
      end
    end
    context "it's not an special case like eleven" do
      it "should return english numeral" do
        expect(258411.to_english).to eq("two hundred and fifty-eight thousand and four hundred and eleven")
        expect(990063412.to_english).to eq("nine hundred and ninety million and sixty-three thousand and four hundred and twelve")
        expect(21411.to_english).to eq("twenty-one thousand and four hundred and eleven")
        expect(97642.to_english).to eq("ninety-seven thousand and six hundred and forty-two")
      end
    end
  end
end
