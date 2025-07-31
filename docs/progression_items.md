# Progression Items

Progression Items are the way that the player can send packages without directly clicking on the package.

They will be purchased from the shop, deducting a certain number of packages from the total per purchase.

Eventually, the player will be able to buy upgrades to replace the progression items with better ones.

## Implementation

Progression items are implemented as resources, in the `resources/progression_items` folder.

They all extend the `progression_item.gd` script. They can also have their own script that extends
`progression_item.gd` to override the default behavior for the `get_background_image()` and
`get_cost()` functions (see `pi_carrier_pigeon.gd` for an example).

## Keeping the list

Several systems in the game need this list of progression items to do their work. For example:

- The item display pane on the left
- The `ProgressionItemManager`, which spins up timers for each item and adds to the package count on timeout
- The shop, which will edit the list

Since they all need the same list, it is defined as an @export var to the `main.tscn` scene, and passed into
the subscriber scenes via various `set_items()` helper functions on the subscribers.

TODO: This system may change depending on how complex the store gets. We will need to edit the list on the fly,
and update the timers/cards.

- Potential problem: killing timers for items that are no longer present. May need to keep timer references & clear all
