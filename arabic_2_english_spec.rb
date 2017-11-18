require_relative 'arabic_2_english'

describe Arabic2English do
  context "The number has three or less digits" do
    context "the number contains eleven or twelve" do
      it "should return the numeral with it's delimiter" do
        expect(5.to_english).to eq("five")
        expect(11.to_english).to eq("eleven")
        expect(12.to_english).to eq("twelve")
        expect(13.to_english).to eq("thirteen")
        expect(311.to_english).to eq("three hundred and eleven")
      end
    end
    context "the number it's a regular base root" do
      it "should return the numeral with hundreds delimiter" do
        expect(100.to_english).to eq("one hundred")
        expect(522.to_english).to eq("five hundred and twenty-two")
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
