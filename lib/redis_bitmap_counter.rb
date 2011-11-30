require "redis"
require "bitset"

class RedisBitmapCounter
  class << self
    def redis=(connection)
      @redis = @connection0
    end

    def redis
      @redis ||= Redis.new
    end
  end

  def initialize(name)
    @name = name
  end

  def count(id)
    self.class.redis.setbit(key, id, 1)
  end

  def counted?(id)
    self.class.redis.getbit(key, id) == 1
  end

  def unique
    bitset.cardinality
  end

  def delete
    self.class.redis.del(key)
  end

  def to_s
    bitset.to_s
  end

  private

  def bitset
    string = self.class.redis.get(key).unpack("b*").first
    Bitset.from_s(string)
  end

  def key
    @key ||= "redis-bitmap-counter:#{@name}"
  end
end
