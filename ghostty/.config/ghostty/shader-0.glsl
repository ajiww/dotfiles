// This is used by Ghostty to render color animated background.

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    float time = iTime * 0.155;

    // 1. Create the animated background
    float movement = sin(uv.x * 3.0 + time) * cos(uv.y * 2.0 + time * 0.5);
    vec3 deepBlue = vec3(0.01, 0.01, 0.05); // Vector of Red-Green-Blue
    vec3 black = vec3(0.0, 0.0, 0.0);
    vec3 animatedBg = mix(black, deepBlue, smoothstep(-0.5, 0.5, movement));

    // 2. Fetch the terminal content
    vec4 terminal = texture(iChannel0, uv);

    // 3. Logic: If the terminal pixel is "dark", show the shader. We calculate brightness (Luminance)
    float brightness = dot(terminal.rgb, vec3(0.199, 0.187, 0.114)); // Values (0.0 --> darkest, 1.0 --> brightest)

    vec3 finalOutput;
    if (brightness < 0.05) {
        // This is background space -> Show our animation
        finalOutput = animatedBg;
    } else {
        // This is text/cursor -> Show the terminal color
        finalOutput = terminal.rgb;
    }

    float opacity = 0.935;
    fragColor = vec4(finalOutput, opacity);
}
