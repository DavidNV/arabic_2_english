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

  TWO_DIGITS_NUMERALS = {
    11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen", 19 => "nineteen"
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
    verify_special_cases(number)
  end

  def verify_special_cases(number)
    plural_number = TWO_DIGITS_NUMERALS[number.to_i]
    return plural_number if plural_number
    define_two_digit_number(number)
  end

  def define_two_digit_number(number)
    root = NUMERALS[number[0].to_i][:root]
    return root if is_it_zero?(number[1])
    parse_two_digits_with_root(root, number)
  end

  def parse_two_digits_with_root(root, number)
    if root
      "#{root}-#{get_one_digit_number(number[1])}"
    else
      get_one_digit_number(number[1])
    end
  end

  def get_three_digit_number(number)
    base = "#{get_one_digit_number(number[0])} hundred"
    remaining_number = number[1..2]
    return "#{base}" if remaining_number.to_i.zero?
    "#{base} and #{get_two_digit_number(remaining_number)}"
  end

  def is_it_zero?(number)
    number.to_i.zero?
  end
end

class Integer
  include Arabic2English
end

input_1 = ARGV[0].to_i
puts input_1.to_english
