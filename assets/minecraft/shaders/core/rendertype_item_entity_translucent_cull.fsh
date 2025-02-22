#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 normal;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * ColorModulator;
    float shadingInfluence = 1.0;
    if (color.a < 0.1) {
        discard;
    }
    if (color.a == 209.0/255.0) { 
        shadingInfluence = 0.0;
        // Used by:
        //  Magnesis magnet
    }
    if (color.a == 130.0/255.0) {
        shadingInfluence = 0.0;
        // Used by:
        //  Magnesis select orb (outer layer)
    }
    if (color.a == 252.0/255.0) {
        shadingInfluence = 0.0;
        color.a = 1.0;
        // Used by:
        //  Everything that should be fully
        //  emissive and fully opaque
    }
    if (color.a == 251.0/255.0) { // Semi-emissive
        shadingInfluence = 0.75;
        color.a = 1.0;
    }
    if (color.a == 250.0/255.0) { // Semi-emissive
        shadingInfluence = 0.50;
        color.a = 1.0;
    }
    if (color.a == 249.0/255.0) { // Semi-emissive
        shadingInfluence = 0.25;
        color.a = 1.0;
    }
    if (color.a == 199.0/255.0) { // Semi-emissive (78% in photoshop)
        shadingInfluence = 0.0;
    }
    color = mix(color, color * vertexColor, shadingInfluence);
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
