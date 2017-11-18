module Arabic2English

  NUMERALS = {
    0 => {singular: "zero"},
    1 => {singular: "one", plural: "eleven", root: "ten"},
    2 => {singular: "two", plural: "twelve", root: "twenty"},
    3 => {singular: "three",plural: "thirteen",  root: "thirty"},
    4 => {singular: "four", plural: "fourteen", root: "forty"},
    5 => {singular: "five", plural: "fifteen", root: "fifty"},
    6 => {singular: "six", plural: "sixteen", root: "sixty"},
    7 => {singular: "seven", plural: "seventeen", root: "seventy"},
    8 => {singular: "eight", plural: "eighteen", root: "eighty"},
    9 => {singular: "nine", plural: "nineteen", root: "ninety"}
  }

  def to_english
    numerals = get_my_numerals([])
    numerals.reverse.join(", ")
  end

  private
  def get_my_numerals(array)
    array.tap do
      get_numbers_collection.each_with_index do |number, index|
        array << define_path_for(number)
      end
    end
  end

  def get_numbers_collection
    self.to_s.reverse.each_char.each_slice(3).map {|x| x.reverse.join }
  end
  
  def define_path_for(number)
    case number.length
    when 1
      get_one_digit_number(number)
    when 2
      get_two_digit_number(number)
    when 3
      get_three_digit_number(number)
    end
  end

  def get_one_digit_number(number)
    NUMERALS[number.to_i][:singular]
  end

  def get_two_digit_number(number)
    base = NUMERALS[number[0].to_i]
    return base[:root] if number[1].to_i.zero?
    "#{base[:root]}-#{get_one_digit_number(number[0])}"
  end

  def get_three_digit_number(number)
    base = "#{get_one_digit_number(number[0])} hundred"
    remaining_number = number[1..2]
    return "#{base}" if remaining_number.to_i.zero?
    "#{base} and #{get_two_digit_number(remaining_number)}"
  end
end

class Integer
  include Arabic2English
end

input_1 = ARGV[0].to_i
puts input_1.to_english
