#version 330 compatibility

#define MC_BLOCK_LEAVES 42
#define MC_BLOCK_GRASS 43

#define TextureScale 10.0 // [1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0]
#define TextureResolution 16.0 // [1.0 8.0 16.0 32.0 64.0 128.0 256.0 512.0 1024.0 2048.0]

#define SideGrassNoTiling // Let the side of a grass block have both a tiled and non-tiled element
#define TileTransparentBlocks // Should transparent blocks be tiled aswell?
#define TileOnlyTransparentLeaves // Let leaves be the only transparent block to tile

in vec2 texcoord;
in vec2 lmcoord;
in vec4 glcolor;
in vec3 normal;
flat in int block;

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform ivec2 atlasSize; 

/* RENDERTARGETS: 0,1,2 */
layout(location = 0) out vec4 color;

void main() 
{
    bool shouldTile = true;

#ifndef TileTransparentBlocks
    #ifdef TileOnlyTransparentLeaves
        shouldTile = (block == MC_BLOCK_LEAVES);
    #else
        shouldTile = false;
    #endif
#endif

if (block == MC_BLOCK_GRASS)
{
#ifdef SideGrassNoTiling
    shouldTile = (texture(gtexture, texcoord).a < 0.1);
#else
    shouldTile = true;
#endif
}

    if (shouldTile)
    {
        vec2 tileCount = vec2(atlasSize.xy) / vec2(TextureResolution);
	    vec2 newTexcoord = floor(texcoord.xy * tileCount);
	    vec2 repeatingPixels = mod(gl_FragCoord.xy / vec2(TextureScale), vec2(TextureResolution));
        color = texture(gtexture, vec2(repeatingPixels.x, TextureResolution - repeatingPixels.y) / atlasSize + 1.0 / tileCount * newTexcoord);

        // Calculate simple lighting. Thanks to @PepperCode1
        float light = min(normal.x * normal.x * 0.6 + normal.y * normal.y * 0.25 * (3.0 + normal.y) + normal.z * normal.z * 0.8, 1.0);
        color *= vec4(glcolor.rgb * light, glcolor.a);
        color *= texture(lightmap, lmcoord);
    }
    else
    {
        color = texture(gtexture, texcoord); // biome tint
        color *= texture(lightmap, lmcoord) * glcolor;
    }

    if (color.a < 0.1)
        discard;
}


