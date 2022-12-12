# Wave Function Collapse for Minetest

**This mod is _highly_ experimental. Things will break.**

Thanks to [this video][that first video] for introducing me to this
algorithim, and for making a simple explanation of it.

If a change to the library improoves speed at the nessisary cost of
compatibility - the change will be made.

To ensure maximum speed, this libarary plans on making full use of new features
in Minetest as they come out.

## Unit tests

Most Minetest mods don't use unit testing, but the logic for most mods is simple enough they don't really need tests. WFC is _just_ complicated enough that I feel like it's needed.

## References

[that first video]: https://www.youtube.com/watch?v=2SuvO4Gi7uY
[mxgmn]: https://github.com/mxgmn/WaveFunctionCollapse
[demo1]: https://oskarstalberg.com/game/wave/wave.html

First of all, I made sure that there is _zero_ code contamination. I haven't seen anyone else's  WFC algorithim written as code, though these all explain it to some degree.

- Again, [that first video] that let me know about this algorithim in the first place.
- [This repo.][mxgmn] Everyone else seems to site it too. Seems to be where it all started. Also a great direct reference.
- [This demo, as it helped me reason about ways that WFC can be slow.][demo1] A great demo. I really enjoy it, honestly. The slow mode made me wonder ways to change the algorithim to have less steps (ie be faster) and develop theories.
- The Minetest community for providing API resources. Unsure of why they think WFC inside MT will be a bad idea, but glad they helped I guess.
- On that note, rubenwardy is _so_ awesome he gets three bullet points.
- His book was a great "readers digest" for the official lua api. Great place to go to if you want to know what category of functions you need to do something.
