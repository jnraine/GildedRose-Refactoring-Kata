class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each(&:update_quality)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  class AgedBrie < Item
    def update_quality
      self.quality += 1
      self.quality += 1 if sell_in < 1
      self.quality = [quality, 50].min
      self.sell_in -= 1
    end
  end

  class Backstage < Item
    def update_quality
      if sell_in <= 0
        self.quality = 0
      elsif sell_in <= 5
        self.quality += 3
      elsif sell_in <= 10
        self.quality += 2
      else
        self.quality += 1
      end

      self.quality = [quality, 50].min
      self.sell_in -= 1
    end
  end

  class Sulfuras < Item
    def update_quality
      # noop
    end
  end

  class Conjured < Item
    def update_quality
      self.quality -= 2
      self.quality -= 2 if sell_in < 1
      self.quality = [quality, 0].max
      self.sell_in -= 1
    end
  end

  ITEM_CLASSES = {
    "NORMAL ITEM" => Item,
    "Aged Brie" => AgedBrie,
    "Backstage passes to a TAFKAL80ETC concert" => Backstage,
    "Sulfuras, Hand of Ragnaros" => Sulfuras,
    "Conjured Mana Cake" => Conjured
  }

  def self.new(name, sell_in, quality)
    item_class =  ITEM_CLASSES.fetch(name) { ArgumentError.new("Unknown item: #{name}") }

    if self != item_class
      item_class.new(name, sell_in, quality)
    else
      super
    end
  end

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update_quality
    self.quality -= 1
    self.quality -= 1 if sell_in < 1
    self.quality = [quality, 0].max
    self.sell_in -= 1
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
