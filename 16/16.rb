class BITSDecoder
  def initialize(hex_data)
    @data = (hex_data.length / 2).times.map {|i|
      hex_data[(i * 2)..(i * 2 + 1)].to_i(16)
    }
    @bit_position = 0
    @version_sum = 0
  end

  def version_sum
    @version_sum
  end

  def bit_position
    @bit_position
  end

  def get_bits(count)
    datum = 0

    while count > 0 do
      byte = @data[@bit_position / 8]
      bits = 8 - @bit_position % 8

      n = [count, bits].min
      count -= n
      mask = (1 << n) - 1
      datum = (datum << n) | ((byte >> (bits - n)) & mask)
      @bit_position += n
    end

    return datum
  end

  def decode_literal
    value = 0

    while true do
      nibble = get_bits(5)
      value = (value << 4) | (nibble & 0xF)
      break if (nibble & 0x10) == 0
    end

    return value
  end

  def decode_operands
    i = get_bits(1)
    if i == 0 then
      length = get_bits(15)
      end_position = bit_position + length
      operands = []
      while bit_position < end_position do
        operands <<= decode
      end
      operands
    else
      count = get_bits(11)
      count.times.map {decode}
    end
  end

  def decode
    vers = get_bits(3)
    type = get_bits(3)

    @version_sum += vers

    value = nil
    if type == 4 then
      value = decode_literal
    else
      values = decode_operands
      case type
      when 0 # sum
        value = values.sum
      when 1 # product
        value = values.inject(&:*)
      when 2 # minimum
        value = values.min
      when 3 # maximum
        value = values.max
      when 5 # greater than
        value = values.inject(&:>) ? 1 : 0
      when 6 # less than
        value = values.inject(&:<) ? 1 : 0
      when 7 # equal to
        value = values.inject(&:==) ? 1 : 0
      end
    end

    return value
  end
end

reader = BITSDecoder.new($stdin.read)
puts "Result: #{reader.decode}"
puts "Version Sum: #{reader.version_sum}"
