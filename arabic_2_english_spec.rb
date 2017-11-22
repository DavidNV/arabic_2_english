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
  context "several test cases" do
    it "should return a valid numeral" do
      TEST_CASES.each do |to_be_tested|
        number = to_be_tested.keys.last
        numeral = to_be_tested.values.last
        expect(number.to_english).to eq(numeral)
      end
    end
  end
end

TEST_CASES = [
  {551=>"five hundred and fifty-one"},
  {899=>"eight hundred and ninety-nine"},
  {242=>"two hundred and forty-two"},
  {435=>"four hundred and thirty-five"},
  {481=>"four hundred and eighty-one"},
  {70=>"seventy"},
  {928=>"nine hundred and twenty-eight"},
  {333=>"three hundred and thirty-three"},
  {787=>"seven hundred and eighty-seven"},
  {530=>"five hundred and thirty"},
  {465=>"four hundred and sixty-five"},
  {342=>"three hundred and forty-two"},
  {345=>"three hundred and forty-five"},
  {605=>"six hundred and five"},
  {889=>"eight hundred and eighty-nine"},
  {608=>"six hundred and eight"},
  {995=>"nine hundred and ninety-five"},
  {776=>"seven hundred and seventy-six"},
  {658=>"six hundred and fifty-eight"},
  {11 =>"eleven"},
  {12 =>"twelve"},
  {56=>"fifty-six"},
  {749=>"seven hundred and forty-nine"},
  {128=>"one hundred and twenty-eight"},
  {278=>"two hundred and seventy-eight"},
  {572=>"five hundred and seventy-two"},
  {633=>"six hundred and thirty-three"},
  {415=>"four hundred and fifteen"},
  {512=>"five hundred and twelve"},
  {787=>"seven hundred and eighty-seven"},
  {116=>"one hundred and sixteen"},
  {4860=>"four thousand and eight hundred and sixty"},
  {7584=>"seven thousand and five hundred and eighty-four"},
  {5996=>"five thousand and nine hundred and ninety-six"},
  {6296=>"six thousand and two hundred and ninety-six"},
  {4180=>"four thousand and one hundred and eighty"},
  {8524=>"eight thousand and five hundred and twenty-four"},
  {2827=>"two thousand and eight hundred and twenty-seven"},
  {3288=>"three thousand and two hundred and eighty-eight"},
  {8750=>"eight thousand and seven hundred and fifty"},
  {4931=>"four thousand and nine hundred and thirty-one"},
  {8078=>"eight thousand and seventy-eight"},
  {4999=>"four thousand and nine hundred and ninety-nine"},
  {6444=>"six thousand and four hundred and forty-four"},
  {9499=>"nine thousand and four hundred and ninety-nine"},
  {9997=>"nine thousand and nine hundred and ninety-seven"},
  {4926=>"four thousand and nine hundred and twenty-six"},
  {7757=>"seven thousand and seven hundred and fifty-seven"},
  {5315=>"five thousand and three hundred and fifteen"},
  {2870=>"two thousand and eight hundred and seventy"},
  {4572=>"four thousand and five hundred and seventy-two"},
  {1278=>"one thousand and two hundred and seventy-eight"},
  {7048=>"seven thousand and forty-eight"},
  {5541=>"five thousand and five hundred and forty-one"},
  {6978=>"six thousand and nine hundred and seventy-eight"},
  {5647=>"five thousand and six hundred and forty-seven"},
  {7195=>"seven thousand and one hundred and ninety-five"},
  {5767=>"five thousand and seven hundred and sixty-seven"},
  {6422=>"six thousand and four hundred and twenty-two"},
  {5008=>"five thousand and eight"},
  {6508=>"six thousand and five hundred and eight"},
  {14019=>"fourteen thousand and nineteen"},
  {98235=>"ninety-eight thousand and two hundred and thirty-five"},
  {31065=>"thirty-one thousand and sixty-five"},
  {86122=>"eighty-six thousand and one hundred and twenty-two"},
  {43214=>"forty-three thousand and two hundred and fourteen"},
  {51198=>"fifty-one thousand and one hundred and ninety-eight"},
  {90372=>"ninety thousand and three hundred and seventy-two"},
  {68762=>"sixty-eight thousand and seven hundred and sixty-two"},
  {29742=>"twenty-nine thousand and seven hundred and forty-two"},
  {89288=>"eighty-nine thousand and two hundred and eighty-eight"},
  {27954=>"twenty-seven thousand and nine hundred and fifty-four"},
  {17409=>"seventeen thousand and four hundred and nine"},
  {83887=>"eighty-three thousand and eight hundred and eighty-seven"},
  {17516=>"seventeen thousand and five hundred and sixteen"},
  {86155=>"eighty-six thousand and one hundred and fifty-five"},
  {81564=>"eighty-one thousand and five hundred and sixty-four"},
  {95658=>"ninety-five thousand and six hundred and fifty-eight"},
  {38211=>"thirty-eight thousand and two hundred and eleven"},
  {70335=>"seventy thousand and three hundred and thirty-five"},
  {36791=>"thirty-six thousand and seven hundred and ninety-one"},
  {34509=>"thirty-four thousand and five hundred and nine"},
  {96274=>"ninety-six thousand and two hundred and seventy-four"},
  {10699=>"ten thousand and six hundred and ninety-nine"},
  {28963=>"twenty-eight thousand and nine hundred and sixty-three"},
  {61168=>"sixty-one thousand and one hundred and sixty-eight"},
  {41237=>"forty-one thousand and two hundred and thirty-seven"},
  {52702=>"fifty-two thousand and seven hundred and two"},
  {15096=>"fifteen thousand and ninety-six"},
  {39597=>"thirty-nine thousand and five hundred and ninety-seven"},
  {94274=>"ninety-four thousand and two hundred and seventy-four"},
  {422919=>"four hundred and twenty-two thousand and nine hundred and nineteen"},
  {510768=>"five hundred and ten thousand and seven hundred and sixty-eight"},
  {142284=>"one hundred and forty-two thousand and two hundred and eighty-four"},
  {177702=>"one hundred and seventy-seven thousand and seven hundred and two"},
  {423006=>"four hundred and twenty-three thousand and six"},
  {401639=>"four hundred and one thousand and six hundred and thirty-nine"},
  {371540=>"three hundred and seventy-one thousand and five hundred and forty"},
  {622241=>"six hundred and twenty-two thousand and two hundred and forty-one"},
  {727101=>"seven hundred and twenty-seven thousand and one hundred and one"},
  {739554=>"seven hundred and thirty-nine thousand and five hundred and fifty-four"},
  {876783=>"eight hundred and seventy-six thousand and seven hundred and eighty-three"},
  {607364=>"six hundred and seven thousand and three hundred and sixty-four"},
  {326241=>"three hundred and twenty-six thousand and two hundred and forty-one"},
  {154615=>"one hundred and fifty-four thousand and six hundred and fifteen"},
  {443541=>"four hundred and forty-three thousand and five hundred and forty-one"},
  {735155=>"seven hundred and thirty-five thousand and one hundred and fifty-five"},
  {671738=>"six hundred and seventy-one thousand and seven hundred and thirty-eight"},
  {585387=>"five hundred and eighty-five thousand and three hundred and eighty-seven"},
  {449413=>"four hundred and forty-nine thousand and four hundred and thirteen"},
  {371304=>"three hundred and seventy-one thousand and three hundred and four"},
  {217423=>"two hundred and seventeen thousand and four hundred and twenty-three"},
  {788471=>"seven hundred and eighty-eight thousand and four hundred and seventy-one"},
  {400105=>"four hundred thousand and one hundred and five"},
  {919008=>"nine hundred and nineteen thousand and eight"},
  {848593=>"eight hundred and forty-eight thousand and five hundred and ninety-three"},
  {891859=>"eight hundred and ninety-one thousand and eight hundred and fifty-nine"},
  {251869=>"two hundred and fifty-one thousand and eight hundred and sixty-nine"},
  {452552=>"four hundred and fifty-two thousand and five hundred and fifty-two"},
  {866174=>"eight hundred and sixty-six thousand and one hundred and seventy-four"},
  {568728=>"five hundred and sixty-eight thousand and seven hundred and twenty-eight"},
  {8168405=>"eight million and one hundred and sixty-eight thousand and four hundred and five"},
  {8204962=>"eight million and two hundred and four thousand and nine hundred and sixty-two"},
  {6228659=>"six million and two hundred and twenty-eight thousand and six hundred and fifty-nine"},
  {1171027=>"one million and one hundred and seventy-one thousand and twenty-seven"},
  {2513330=>"two million and five hundred and thirteen thousand and three hundred and thirty"},
  {5853430=>"five million and eight hundred and fifty-three thousand and four hundred and thirty"},
  {1495970=>"one million and four hundred and ninety-five thousand and nine hundred and seventy"},
  {6084339=>"six million and eighty-four thousand and three hundred and thirty-nine"},
  {2682284=>"two million and six hundred and eighty-two thousand and two hundred and eighty-four"},
  {7242160=>"seven million and two hundred and forty-two thousand and one hundred and sixty"},
  {4947733=>"four million and nine hundred and forty-seven thousand and seven hundred and thirty-three"},
  {9068660=>"nine million and sixty-eight thousand and six hundred and sixty"},
  {5901089=>"five million and nine hundred and one thousand and eighty-nine"},
  {5237474=>"five million and two hundred and thirty-seven thousand and four hundred and seventy-four"},
  {7726267=>"seven million and seven hundred and twenty-six thousand and two hundred and sixty-seven"},
  {4472963=>"four million and four hundred and seventy-two thousand and nine hundred and sixty-three"},
  {8115333=>"eight million and one hundred and fifteen thousand and three hundred and thirty-three"},
  {8667841=>"eight million and six hundred and sixty-seven thousand and eight hundred and forty-one"},
  {2858074=>"two million and eight hundred and fifty-eight thousand and seventy-four"},
  {7583865=>"seven million and five hundred and eighty-three thousand and eight hundred and sixty-five"},
  {8836568=>"eight million and eight hundred and thirty-six thousand and five hundred and sixty-eight"},
  {8589614=>"eight million and five hundred and eighty-nine thousand and six hundred and fourteen"},
  {4677928=>"four million and six hundred and seventy-seven thousand and nine hundred and twenty-eight"},
  {8155266=>"eight million and one hundred and fifty-five thousand and two hundred and sixty-six"},
  {3987804=>"three million and nine hundred and eighty-seven thousand and eight hundred and four"},
  {2815618=>"two million and eight hundred and fifteen thousand and six hundred and eighteen"},
  {1084799=>"one million and eighty-four thousand and seven hundred and ninety-nine"},
  {7260406=>"seven million and two hundred and sixty thousand and four hundred and six"},
  {9563055=>"nine million and five hundred and sixty-three thousand and fifty-five"},
  {3476425=>"three million and four hundred and seventy-six thousand and four hundred and twenty-five"},
  {43347555=>"forty-three million and three hundred and forty-seven thousand and five hundred and fifty-five"},
  {18809446=>"eighteen million and eight hundred and nine thousand and four hundred and forty-six"},
  {74966105=>"seventy-four million and nine hundred and sixty-six thousand and one hundred and five"},
  {87894503=>"eighty-seven million and eight hundred and ninety-four thousand and five hundred and three"},
  {50615203=>"fifty million and six hundred and fifteen thousand and two hundred and three"},
  {38775993=>"thirty-eight million and seven hundred and seventy-five thousand and nine hundred and ninety-three"},
  {48313561=>"forty-eight million and three hundred and thirteen thousand and five hundred and sixty-one"},
  {58077392=>"fifty-eight million and seventy-seven thousand and three hundred and ninety-two"},
  {42122401=>"forty-two million and one hundred and twenty-two thousand and four hundred and one"},
  {16009508=>"sixteen million and nine thousand and five hundred and eight"},
  {33381162=>"thirty-three million and three hundred and eighty-one thousand and one hundred and sixty-two"},
  {16719068=>"sixteen million and seven hundred and nineteen thousand and sixty-eight"},
  {81896194=>"eighty-one million and eight hundred and ninety-six thousand and one hundred and ninety-four"},
  {32739287=>"thirty-two million and seven hundred and thirty-nine thousand and two hundred and eighty-seven"},
  {37751044=>"thirty-seven million and seven hundred and fifty-one thousand and forty-four"},
  {28849845=>"twenty-eight million and eight hundred and forty-nine thousand and eight hundred and forty-five"},
  {79724547=>"seventy-nine million and seven hundred and twenty-four thousand and five hundred and forty-seven"},
  {92005952=>"ninety-two million and five thousand and nine hundred and fifty-two"},
  {60442981=>"sixty million and four hundred and forty-two thousand and nine hundred and eighty-one"},
  {37961236=>"thirty-seven million and nine hundred and sixty-one thousand and two hundred and thirty-six"},
  {33901891=>"thirty-three million and nine hundred and one thousand and eight hundred and ninety-one"},
  {49573036=>"forty-nine million and five hundred and seventy-three thousand and thirty-six"},
  {50088922=>"fifty million and eighty-eight thousand and nine hundred and twenty-two"},
  {94577001=>"ninety-four million and five hundred and seventy-seven thousand and one"},
  {75035625=>"seventy-five million and thirty-five thousand and six hundred and twenty-five"},
  {74759109=>"seventy-four million and seven hundred and fifty-nine thousand and one hundred and nine"},
  {87960857=>"eighty-seven million and nine hundred and sixty thousand and eight hundred and fifty-seven"},
  {43419922=>"forty-three million and four hundred and nineteen thousand and nine hundred and twenty-two"},
  {68209792=>"sixty-eight million and two hundred and nine thousand and seven hundred and ninety-two"},
  {44212007=>"forty-four million and two hundred and twelve thousand and seven"}
]
