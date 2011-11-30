module Bitmap
  class DateCounter < Bitmap::Counter
    def count(id, date = Date.today)
      self.class.redis.setbit(key(date), id, 1)
    end

    def counted?(id, date = Date.today)
      self.class.redis.getbit(key(date), id) == 1
    end

    def unique(range = [Date.today])
      range = [range] if range.is_a?(Date)
      set = nil
      range.each do |date|
        next unless s = bitset(date)
        set ||= s
        set |= s
      end
      set.cardinality
    end

    def delete
      keys = self.class.redis.keys("#{prefix}*")
      self.class.redis.pipelined do
        keys.each do |k|
          self.class.redis.del(k)
        end
      end
    end

    private

    def bitset(date)
      if string = self.class.redis.get(key(date))
        Bitset.from_s(string.unpack("b*").first)
      end
    end

    def key(date)
      "#{prefix}#{date}"
    end

    def prefix
      "redis-bitmap-counter:#{@name}:"
    end
  end
end
