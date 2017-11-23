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
  DELIMITERS = [" thousand", " million", " billion", " trillion", " quadrillion", " quintillion", " sextillion"]
  TWO_DIGITS_NUMERALS = { 11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen", 19 => "nineteen"}

  def to_english
    numerals = get_my_numerals
    numerals.reverse.join(" and ")
  end

  private
  #Creator method
  def get_my_numerals
    [].tap do |array|
      get_numbers_collection.each_with_index do |number, index|
        next if its_zero_but_has_other_digits(number, index: index)
        clean_number = transform_number_into_numeral(number)
        array << "#{clean_number}#{number_delimiter_for(index)}"
      end
      was_a_negative_number?(array)
    end
  end

  #========================= Begin: High level Flow methods =====================================================

  def transform_number_into_numeral(number)
    paths = {
      1 => lambda { get_one_digit_numeral(number) },
      2 => lambda { get_two_digits_numeral(number) },
      3 => lambda { get_three_digits_numeral(number) }
    }
    paths[number.length].call
  end

  def get_one_digit_numeral(number)
    NUMERALS[number.to_i][:singular]
  end

  def get_two_digits_numeral(number, prefix: nil)
    parsed_number = verify_special_cases(number)
    return number_with_separator(parsed_number, prefix: prefix, separator: " and ") if prefix
    parsed_number
  end

  def get_three_digits_numeral(number)
    prefix = prefix_for_three_digits_number(number[0].to_i)
    remaining_number = number[1..2]
    prefixed_three_digit_number(prefix: prefix, remaining_number: remaining_number)
  end

  #========================= End: High level Flow methods =====================================================

  #========================= Begin: Low level Flow methods ====================================================

  def verify_special_cases(number)
    plural_number = TWO_DIGITS_NUMERALS[number.to_i]
    return plural_number if plural_number
    define_two_digit_number(number)
  end

  def define_two_digit_number(number)
    _root = NUMERALS[number[0].to_i][:root]
    return _root if is_it_zero?(number[1])
    parse_two_digits_with_root(number, root: _root)
  end

  def prefixed_three_digit_number(prefix: _prefix, remaining_number: _remaining_number)
    return prefix if is_it_zero?(remaining_number)
    get_two_digits_numeral(remaining_number, prefix: prefix)
  end

  #========================= End: Low level Flow methods =====================================================

  #========================= Begin: Utility methods ==========================================================

  def prefix_for_three_digits_number(number_for_prefix)
    "#{NUMERALS[number_for_prefix][:singular]} hundred" unless is_it_zero?(number_for_prefix)
  end

  def number_with_separator(number, prefix: _prefix, separator: _separator)
    "#{prefix}#{separator}#{number}"
  end

  def parse_two_digits_with_root(number, root: _root)
    specific_tens_number = get_one_digit_numeral(number[1])
    return number_with_separator(specific_tens_number, prefix: root, separator: "-") if root
    specific_tens_number
  end

  def number_delimiter_for(delimiter_level)
    #This it's because the hundre delimiter it's already added at the three digits parsed flow
    if !is_it_zero?(delimiter_level)
      DELIMITERS[delimiter_level - 1]
    end
  end

  def was_a_negative_number?(array)
    #Replace 'not' for '!' because higher precedence
    if !is_it_zero?(self) && self.to_s.include?("-")
      last_position = array[-1]
      array[-1] = "negative #{last_position}"
    end
  end

  def is_it_zero?(number)
    number.to_i.zero?
  end

  def its_zero_but_has_other_digits(number, index:)
    is_it_zero?(number) && get_numbers_collection.count > 1
  end

  def get_numbers_collection
    self.to_s.reverse.each_char.each_slice(3).map {|sliced_chars| sliced_chars.reverse.join }
  end

  #========================= End: Utility methods ==========================================================
end

class Integer
  include Arabic2English
end

input_1 = ARGV[0].to_i
puts input_1.to_english
