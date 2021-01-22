# Fred Metabolism

 This is my edit of kamelzarandah edit of spaghetti_metabolismo made by Malik. In this edit you will be able to create consumables. Each one can affect player cores, increasing stamina or health and even overpowers (gold cores). You have some items created as an example. This script works with spaghetti_hud, i added it in case you don't have it i also renamed it to make some functions work properly. This is a script for RedM and VORP framework.

 IMPORTANT: USE THE HUD I UPLOADED TO MAKE IT WORK CORRECTLY.
 SUPER IMPORTANT: IF YOU HAVE ANY CONSUMABLE ALREADY REGISTERED YOU WILL HAVE TO DETELE IT SINCE THIS SCRIPT REGISTER THOSE AUTOMATICALLY, THAT MAY CAUSE ISSUES WITH THE SCRIPT.

 **Hope it helps!**

# Content

- Easy way to configure your consumables.
- Weather effect on metabolism depending if it is cold or hot. 
- Multiple core effects and Gold overpowers.
- Example of consumables on the Config file.
- Many configs to play with.

# Event

Use 
```
TriggerEvent("fred:consume", hunger, thirst, metabolism, innercorestamina, innercorestaminagold, outercorestaminagold, innercorehealth, innercorehealthgold, outercorehealthgold)
```
This will work on any other resource, it is useful if you want to make a specific change on any value.

# TODO: 

- [X] Add animation for consuming. 
- [X] Config.lua file for easy configuration.
- [ ] Add Outer Core Health normal effect.
- [ ] Add more animations depending if it is drinking or eating.
- [ ] Metabolism system to get fatter or skinnier.

## CHANGELOG:

```
18/01/21 - Corrected some notification issues and name display not showing up correctly.
         - Removed Outer Core Health comments on config.lua
```

```
22/01/21 - Added event "fred:consume". You can use this in any other script to change the metabolism values. Read the section Event.
```