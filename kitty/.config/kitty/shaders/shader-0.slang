// Uniform parameters passed by the terminal renderer
struct Uniforms {
    float2 iResolution;
    float  iTime;
};

ParameterBlock<Uniforms> u;

// Terminal text/content texture (corresponds to iChannel0)
Texture2D    iChannel0;
SamplerState iChannel0Sampler;

[shader("fragment")]
float4 fragmentMain(float4 sv_position : SV_Position) : SV_Target {
    // Convert gl_FragCoord to normalized UV coordinates (0.0 to 1.0)
    float2 uv = sv_position.xy / u.iResolution;
    float time = u.iTime * 0.155;

    // 1. Create the animated background
    float movement = sin(uv.x * 3.0 + time) * cos(uv.y * 2.0 + time * 0.5);
    float3 deepBlue = float3(0.01, 0.01, 0.05);
    float3 black = float3(0.0, 0.0, 0.0);
    
    // GLSL mix() maps to Slang lerp()
    float3 animatedBg = lerp(black, deepBlue, smoothstep(-0.5, 0.5, movement));

    // 2. Sample the terminal content texture
    float4 terminal = iChannel0.Sample(iChannel0Sampler, uv);

    // 3. Logic: If the terminal pixel is dark, show the animated background
    float brightness = dot(terminal.rgb, float3(0.199, 0.187, 0.114));

    float3 finalOutput;
    if (brightness < 0.05) {
        // Background space -> show animation
        finalOutput = animatedBg;
    } else {
        // Text/cursor -> show terminal color
        finalOutput = terminal.rgb;
    }

    float opacity = 0.935;
    return float4(finalOutput, opacity);
}
