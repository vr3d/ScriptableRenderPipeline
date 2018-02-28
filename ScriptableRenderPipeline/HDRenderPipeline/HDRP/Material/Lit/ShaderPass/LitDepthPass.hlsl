#ifndef SHADERPASS
#error Undefine_SHADERPASS
#endif

// Attributes
#define REQUIRE_TANGENT_TO_WORLD defined(_PIXEL_DISPLACEMENT)
#define REQUIRE_NORMAL defined(TESSELLATION_ON) || REQUIRE_TANGENT_TO_WORLD || defined(_VERTEX_WIND) || defined(_VERTEX_DISPLACEMENT)
#define REQUIRE_VERTEX_COLOR ((defined(_VERTEX_DISPLACEMENT) || defined(_TESSELLATION_DISPLACEMENT)) && defined(LAYERED_LIT_SHADER) && (defined(_LAYER_MASK_VERTEX_COLOR_MUL) || defined(_LAYER_MASK_VERTEX_COLOR_ADD))) || defined(_VERTEX_WIND)

// This first set of define allow to say which attributes will be use by the mesh in the vertex and domain shader (for tesselation)

// Tesselation require normal
#if REQUIRE_NORMAL
#define ATTRIBUTES_NEED_NORMAL
#endif
#if REQUIRE_TANGENT_TO_WORLD
#define ATTRIBUTES_NEED_TANGENT
#endif
#if REQUIRE_VERTEX_COLOR
#define ATTRIBUTES_NEED_COLOR
#endif

// About UV
// When UVX is present, we assume that UVX - 1 ... UV0 is present

#if defined(_VERTEX_DISPLACEMENT) || REQUIRE_TANGENT_TO_WORLD || defined(_ALPHATEST_ON) || defined(_TESSELLATION_DISPLACEMENT)
    #define ATTRIBUTES_NEED_TEXCOORD0
    #define ATTRIBUTES_NEED_TEXCOORD1
    #if defined(_REQUIRE_UV2) || defined(_REQUIRE_UV3)
        #define ATTRIBUTES_NEED_TEXCOORD2
    #endif
    #if defined(_REQUIRE_UV3)
        #define ATTRIBUTES_NEED_TEXCOORD3
    #endif
#endif

// Varying - Use for pixel shader
// This second set of define allow to say which varyings will be output in the vertex (no more tesselation)
#if REQUIRE_TANGENT_TO_WORLD
#define VARYINGS_NEED_POSITION_WS // Required to get view vector
#define VARYINGS_NEED_TANGENT_TO_WORLD
#endif

#if REQUIRE_TANGENT_TO_WORLD || defined(_ALPHATEST_ON)
#define VARYINGS_NEED_TEXCOORD0
    #ifdef LAYERED_LIT_SHADER
    #define VARYINGS_NEED_TEXCOORD1
        #if defined(_REQUIRE_UV2) || defined(_REQUIRE_UV3)
        #define VARYINGS_NEED_TEXCOORD2
        #endif
        #if defined(_REQUIRE_UV3)
        #define VARYINGS_NEED_TEXCOORD3
        #endif
    #endif
#endif

// This include will define the various Attributes/Varyings structure
#include "../../ShaderPass/VaryingMesh.hlsl"
