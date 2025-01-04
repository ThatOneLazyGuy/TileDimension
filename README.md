# TileDimension

A shaderpack that makes all terrain textures appear as if they are a windows into a tiled verison of that texture!
This shaderpack is based on [XorDevs-Default-Shaderpack](https://github.com/XorDev/XorDevs-Default-Shaderpack).

The shaderpack uses all shaders from XorDev's shaderpack but adds:\
gbuffer_terrain.vsh\
gbuffer_terrain.fsh

Shaderpack settings:
- TextureResolution: the resolution for a block texture in the currently active texturepack (Used to properly render the tiling effect).
- TextureScale: the scale of the tiling effect.
<br>

- TileTransparentBlocks: should the tiling effect also work on transparent/cutout terrain?
- TileOnlyTransparentLeaves: set transparent leaves to use the tiling effect (has no affect if TileTransparentBlocks is on).
- SideGrassNoTiling: adds the small overhang on grass blocks while also tiling the whole texture over the block.
