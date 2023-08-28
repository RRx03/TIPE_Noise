
#include <metal_stdlib>
using namespace metal;

#define particleNumber 100
#define flowRate 1
#define frameRate (60*flowRate)
#define dt (1.0/frameRate)
#define pixelToMeter 6300



#define twoPI 3.1415*2
#define PI 3.1415

#define randomSeeder 10e4


struct Particle {
    float2 position;
    float2 velocity;
    float2 acc;
    float maxSpeed;
    

};
struct Uniform{
    float brightness;
    short time;
};


float random (float2 vec) {
    return fract(sin(dot(vec,float2(12.9898,78.233)))*43758.5453123);
}

kernel void pixels(texture2d<half, access::read> textureIn [[texture(1)]],
                   texture2d<half, access::write> textureOut [[texture(0)]],
                   constant Uniform &uniform [[buffer(1)]],
                   uint2 id [[thread_position_in_grid]]) {
    
    
    float2 screenSize = float2(textureOut.get_width(), textureOut.get_height());
    float2 normalizedPos = float2(id)/screenSize;
    half3 pixelColor;
    float2 st = float2(10);
    float2 ipos = floor(normalizedPos*st)/st;
    float2 fpos = fract(normalizedPos*st);
    
    
    float grayValue = random(ipos);
    pixelColor = half3(grayValue);
    
    textureOut.write(half4(pixelColor*uniform.brightness, 1), id);

    
    
}


