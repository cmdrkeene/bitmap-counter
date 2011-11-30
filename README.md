# Bitmap Counter

An efficient id-based counter. Current implementation uses redis.

# Usage

    require "bitmap/counter"
    counter = Bitmap::Counter.new("name")
    
    counter.add(id = 1)   # a numeric user_id for example
    counter.count         # 2
    counter.includes?(1)  # true
    counter.includes?(2)  # false

## Redis

You can use your own redis connection.

    Bitmap::Counter.redis = your_redis_here
    
## DateCounter

Count ids for a series of dates.

    require "bitmap/date_counter"
    counter = Bitmap::DateCounter.new("name")
    counter.add(1, Date.today)
    counter.add(2, Date.today)
    counter.add(1, Date.today - 1)

You can inspect a specific date:
    
    counter.count(Date.today)     # 2
    counter.count(Date.today - 1) # 1

    counter.includes?(1, Date.today)      # true
    counter.includes?(2, Date.today)      # true
    counter.includes?(1, Date.today - 1)  # true
    counter.includes?(2, Date.today - 1)  # false
    
Or a range of dates:

    counter.count((Date.today - 1)..Date.today) # 2

    counter.includes?(1, (Date.today - 1)..Date.today) # true
    counter.includes?(2, (Date.today - 1)..Date.today) # true
    counter.includes?(3, (Date.today - 1)..Date.today) # false

# Benchmarks

## Memory

Redis doesn't expose easy statistics on memory/disk usage :(

TODO

## Intersections

TODO

## Cardinality

Performance is acceptable, but worse than native redis sets.

Sending the entire bitstring across the wire is not all that efficient.

Some people suggested implementing this a Lua routine inside redis. I suspect
the performance will be better, but is unlikely to beat native sets.

Totally unscientific, but here are my results:

    Bitmap::Counter.unique (10_000_000 ids): 76.39ms
    Redis.scard            (10_000_000 ids): 2.38ms
    
It's not any better for small datasets:

    unique (1000): 0.26ms
    unique (10000): 0.59ms
    unique (100000): 0.94ms
    scard  (1000): 0.19ms
    scard  (10000): 0.23ms
    scard  (100000): 0.26ms
        
# Credits

Inspired by the awesome [post](http://blog.getspool.com/2011/11/29/fast-easy-realtime-metrics-using-redis-bitmaps/) by Chandra Patni.
        
# Ruby Version

This was developed on ruby 1.9.2p180 and not tested on other versions...yet :)

# TODO

* Add different backends (File, Postgres, etc)