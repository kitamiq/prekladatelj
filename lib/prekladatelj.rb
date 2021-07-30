require_relative "prekladatelj/version.rb"

class String

  def to_latin(*args)
    Prekladatelj::Cyrillic::to_latin self, *args
  end

  def to_cyrillic(*args)
    Prekladatelj::Latin::to_cyrillic self, *args
  end
end

module Prekladatelj
  class Error < StandardError; end

  # TODO user's transliteration preferences support
=begin
  class Preferences
    @preferences = {}

    # @param [Hash] prefs
    def self.define(prefs)
      @preferences = prefs if prefs.kind_of? Hash
    end

    def self.preferences=(prefs)
      define prefs
    end

    def self.preferences
      @preferences
    end

  end
=end
  class Helper
    def self.smart_split(string)
      a = []
      last = ''
      (0..string.length-1).each do |l|
        if string[l]==' '
          a.append last unless last.empty?
          a.append string[l]
          last = ''
        else
          last = last + string[l]
        end
        a.append last if l==string.length-1
      end
      a
    end
  end

  class Cyrillic
    UPPER  = %w[А Б Ц Ч Д Е Є Ф Г Х И Ј К Л Љ М Н Њ О П Р С Ш Т У В Ы З Ж]
    DOWN   = %w[а б ц ч д е є ф г х и ј к л љ м н њ о п р с ш т у в ы з ж]

    # @param [String] line
    def self.to_latin(line, *args)
      str = String line[0..-1]

      UPPER.each { |x| str.gsub! x, Latin::UPPER[UPPER.index(x)] if UPPER.any? x}
      DOWN.each { |x| str.gsub! x, Latin::DOWN[DOWN.index(x)] if DOWN.any? x}

      str
    end

  end

  class Latin
    UPPER = %w[A B C Č D E Ě F G H I J K L LJ M N NJ O P R S Š T U V Y Z Ž]
    DOWN = %w[a b c č d e ě f g h i j k l lj m n nj o p r s š t u v y z ž]

    EASTERN = {
        "ju" => "ю",
        "ja" => "я",
        "ě" => "є",
        "je" => "е",
        "lj" => "ль",
        "nj" => "нь",
        "j" => "й",
        "šč" => "щ"
    }

    # @param [String] line
    def self.to_cyrillic(line, *args)
      str = String line[0..-1]

      if args.any? :eastern
        line = Helper::smart_split str
        line.each do |word|
          while word =~ /[eě](je)/
            word["eje"] = "ее" if word.include? 'eje'
            word["ěje"] = "єе" if word.include? 'ěje'
          end
          while word =~ /[^aiueoyj](je)/
            word["je"] = "ье"
          end
          while word =~ /(ji)/
            word["ji"] = "и"
          end
          word["je"] = "е" if word.start_with? "je"
          word["se"] = "ся" if word.gsub(/\W+/, '') == "se"
          while word =~ /[^aiueoyj](je)/
            word["je"] = "ье"
          end
        end
        str = line.join ""

        EASTERN.each_pair do |k, v|
          str.gsub! k, v
          str.gsub! k.capitalize, v.capitalize
          str.gsub! k.upcase, v.upcase
        end
      end

      UPPER.each { |x| str.gsub! x, Cyrillic::UPPER[UPPER.index(x)] if UPPER.any? x}
      DOWN.each { |x| str.gsub! x, Cyrillic::DOWN[DOWN.index(x)] if DOWN.any? x}

      str
    end

  end


end