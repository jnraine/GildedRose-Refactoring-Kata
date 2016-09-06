>        All items have a `sell_in` value which denotes the number of days we have to sell the item. 
>        All items have a `quality` value which denotes how valuable the item is
>        At the end of each day our system lowers both values for every item by running the `update_quantity` method on each item. 
> 
>        Once the sell by date has passed, Quality degrades twice as fast
>        The Quality of an item is never negative
>        “Aged Brie” actually increases in Quality the older it gets
>        The Quality of an item is never more than 50
>        “Sulfuras, Hand of Ragnaros”, being a legendary item, never has to be sold or decreases in Quality
>        “Backstage passes to a TAFKAL80ETC concert”, like aged brie, increases in `quality` as it’s `sell_in` value approaches; `quality` increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but `quality` drops to 0 after the concert
> 
>    We have recently signed a supplier of conjured items. This requires an update to our system:
> 
>        “Conjured Mana Cake” items degrade in Quality twice as fast as normal items


Task: Update the system to be able to handle "conjured" items. Failing specs have been added to help describe this behaviour. 

You may assume that the test coverage is 100%. In otherwords, if the tests pass, the code is perfectly functional. 

You may make any changes you'd like to the specs, but keep in mind that you shouldn't reduce coverage. 




