require File.join(File.dirname(__FILE__), 'gilded_rose')
describe GildedRose do
  
  describe "#update_quality" do

    let(:gilded_rose) { GildedRose.new(items) }

    context "with a single" do
      let(:initial_sell_in) { 5 }
      let(:initial_quality) { 10 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }
      let(:items) { [item] }

      before { gilded_rose.update_quality }

      context "normal item" do
        let(:name) { "NORMAL ITEM" }

        it { expect(item.sell_in).to eql initial_sell_in-1 }

        context "before sell date" do
          it { expect(item.quality).to eql initial_quality-1 }
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it { expect(item.quality).to eql initial_quality-2 }
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it { expect(item.quality).to eql initial_quality-2 }
        end

        context "of zero quality" do
          let(:initial_quality) { 0 }
          it { expect(item.quality).to eql 0 }
        end
      end

      context "Aged Brie" do
        let(:name) { "Aged Brie" }

        it { expect(item.sell_in).to eql initial_sell_in-1 }

        context "before sell date" do
          it { expect(item.quality).to eql initial_quality+1 }

          context "with max quality" do
            let(:initial_quality) { 50 }
            it { expect(item.quality).to eql initial_quality }
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it { expect(item.quality).to eql initial_quality+2 }

          context "near max quality" do
            let(:initial_quality) { 49 }
            it { expect(item.quality).to eql 50 }
          end

          context "with max quality" do
            let(:initial_quality) { 50 }
            it { expect(item.quality).to eql initial_quality }
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it { expect(item.quality).to eql initial_quality+2 }

          context "with max quality" do
            let(:initial_quality) { 50 }
            it { expect(item.quality).to eql initial_quality }
          end
        end
      end

      context "Sulfuras" do
        let(:initial_quality) { 80 }
        let(:name) { "Sulfuras, Hand of Ragnaros" }

        it { expect(item.sell_in).to eql initial_sell_in }

        context "before sell date" do
          it { expect(item.quality).to eql initial_quality }
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it { expect(item.quality).to eql initial_quality }
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it { expect(item.quality).to eql initial_quality }
        end
      end

      context "Backstage pass" do
        let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

        it { expect(item.sell_in).to eql initial_sell_in-1 }

        context "long before sell date" do
          let(:initial_sell_in) { 11 }
          it { expect(item.quality).to eql initial_quality+1 }

          context "at max quality" do
            let(:initial_quality) { 50 }
          end
        end

        context "medium close to sell date (upper bound)" do
          let(:initial_sell_in) { 10 }
          it { expect(item.quality).to eql initial_quality+2 }

          context "at max quality" do
            let(:initial_quality) { 50 }
            it { expect(item.quality).to eql initial_quality }
          end
        end

        context "medium close to sell date (lower bound)" do
          let(:initial_sell_in) { 6 }
          it { expect(item.quality).to eql initial_quality+2 }

          context "at max quality" do
            let(:initial_quality) { 50 }
            it { expect(item.quality).to eql initial_quality }
          end
        end

        context "very close to sell date (upper bound)" do
          let(:initial_sell_in) { 5 }
          it { expect(item.quality).to eql initial_quality+3 }

          context "at max quality" do
            let(:initial_quality) { 50 }
            it { expect(item.quality).to eql initial_quality }
          end
        end

        context "very close to sell date (lower bound)" do
          let(:initial_sell_in) { 1 }
          it { expect(item.quality).to eql initial_quality+3 }

          context "at max quality" do
            let(:initial_quality) { 50 }
            it { expect(item.quality).to eql initial_quality }
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it { expect(item.quality).to eql 0 }
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it { expect(item.quality).to eql 0 }
        end
      end

      context "conjured item" do
        let(:name) { "Conjured Mana Cake" }

        it { expect(item.sell_in).to eql initial_sell_in-1 }

        context "before the sell date" do
          let(:initial_sell_in) { 5 }
          it { expect(item.quality).to eql initial_quality-2 }

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it { expect(item.quality).to eql initial_quality }
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it { expect(item.quality).to eql initial_quality-4 }

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it { expect(item.quality).to eql initial_quality }
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it { expect(item.quality).to eql initial_quality-4 }

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it { expect(item.quality).to eql initial_quality }
          end
        end
      end
    end

    context "with several objects" do
      let(:items) {
        [
         Item.new("NORMAL ITEM", 5, 10),
         Item.new("Aged Brie", 3, 10),
        ]
      }

      before { gilded_rose.update_quality }

      it { expect(items[0].quality).to eql 9 }
      it { expect(items[0].sell_in).to eql 4 }

      it { expect(items[1].quality).to eql 11 }
      it { expect(items[1].sell_in).to eql 2 }
    end
  end
end
