#version 320 es
precision highp float;

// Simple passthrough shader to unblock asset loading; replace with real refraction logic if needed.
layout(location = 0) out vec4 fragColor;

void main() {
  fragColor = vec4(1.0); // white placeholder
}
