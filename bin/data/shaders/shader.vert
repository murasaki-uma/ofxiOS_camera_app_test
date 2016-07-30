
// these are for the programmable pipeline system
uniform mat4 modelViewProjectionMatrix;
attribute vec4 position;
attribute vec2 texcoord;

uniform float mouseRange;
uniform vec2 mousePos;

varying vec2 texCoordVarying;

// PLEASE NOTE.
// texture2D() is not supported in vertex ES2 shaders.
// so unfortunately on ES2, we can not sample the texture,
// and displace the mesh.
// Please see GL2 and GL3 examples for displacement mapping.

void main()
{
    vec4 pos = position;
    float mouseRange = 0.3;
    texCoordVarying = texcoord;
   
    vec2 dir = pos.xy - mousePos;
    
    // distance between the mouse position and vertex position.
    float dist =  sqrt(dir.x * dir.x + dir.y * dir.y);
    
    // check vertex is within mouse range.
    if(dist > 0.0 && dist < mouseRange) {
        
        // normalise distance between 0 and 1.
        float distNorm = dist / mouseRange;
        
        // flip it so the closer we are the greater the repulsion.
        distNorm = 1.0 - distNorm;
        
        // make the direction vector magnitude fade out the further it gets from mouse position.
        dir *= distNorm;
        
        // add the direction vector to the vertex position.
        pos.x += dir.x;
        pos.y += dir.y;
    }
	gl_Position = modelViewProjectionMatrix * pos;
}