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

  DELIMITERS = ["", " thousand", " million", " billion", " trillion", " quadrillion", " quintillion", " sextillion"]

  TWO_DIGITS_NUMERALS = {
    11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen", 19 => "nineteen"
  }


  def to_english
    numerals = get_my_numerals
    numerals.reverse.join(" and ")
  end

  private
  def get_my_numerals
    [].tap do |array|
      get_numbers_collection.each_with_index do |number, index|
        next if its_zero_but_has_other_digits(number, index: index)
        clean_number = define_path_for(number)
        array << "#{clean_number}#{number_delimiter_for(index)}"
      end
    end
  end

  def get_numbers_collection
    self.to_s.reverse.each_char.each_slice(3).map {|x| x.reverse.join }
  end
  
  #TODO rename me this please
  def define_path_for(number)
    paths = {
      1 => lambda { get_one_digit_number(number) },
      2 => lambda { get_two_digit_number(number) },
      3 => lambda { get_three_digit_number(number) }
    }
    paths[number.length].call
  end

  def get_one_digit_number(number)
    NUMERALS[number.to_i][:singular]
  end

  def get_two_digit_number(number, prefix: nil)
    parsed_number = verify_special_cases(number)
    if prefix
      "#{prefix} and #{parsed_number}"
    else
      parsed_number
    end
  end

  def get_three_digit_number(number)
    number_for_prefix = number[0].to_i
    remaining_number = number[1..2]
    prefix = prefix_for_three_digits_number(number_for_prefix)
    prefixed_three_digit_number(prefix, remaining_number)
  end

  def prefix_for_three_digits_number(number_for_prefix)
    "#{NUMERALS[number_for_prefix][:singular]} hundred" unless is_it_zero?(number_for_prefix)
  end

  def prefixed_three_digit_number(prefix, remaining_number)
    return prefix if is_it_zero?(remaining_number)
    get_two_digit_number(remaining_number, prefix: prefix)
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

  def is_it_zero?(number)
    number.to_i.zero?
  end

  def its_zero_but_has_other_digits(number, index:)
    is_it_zero?(number) && get_numbers_collection.count > 1
  end

  def number_delimiter_for(delimiter_level)
    DELIMITERS[delimiter_level]
  end
end

class Integer
  include Arabic2English
end

input_1 = ARGV[0].to_i
puts input_1.to_english
