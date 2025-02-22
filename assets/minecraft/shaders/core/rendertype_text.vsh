#version 150

#moj_import <minecraft:fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {  


    vec2 offset = vec2(0,0);

    // Move each champion icon to its spot on the screen
    if (Color.rga == vec3(33.0/255.0,52.0/255.0,1.0)) {
        offset = vec2(13, -69 + 23*(Color.b*255 - 128));
    }

    if (Color.rga == vec3(33.0/255.0,51.0/255.0,1.0)) {
        offset = vec2(14,0);
    }
    vec3 pos = vec3(Position.x + offset.x, Position.y + offset.y, Position.z);
    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);


    vertexDistance = fog_distance(Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);

    // Move the anchor point of the champion icons 
    // to the top left of the screen
    if (Color.rga == vec3(33.0/255.0,52.0/255.0,1.0)) {
        gl_Position.x -= 1;
        gl_Position.y += 1;
        vertexColor = texelFetch(Sampler2, UV2 / 16, 0);
    }

    if (Color.rga == vec3(33.0/255.0,51.0/255.0,1.0)) {
        vertexColor = texelFetch(Sampler2, UV2 / 16, 0);

    }

    
    texCoord0 = UV0;
}
