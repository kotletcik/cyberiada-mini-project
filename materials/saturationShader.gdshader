shader_type canvas_item;

uniform float saturation;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    vec3 tex_color = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;

    COLOR.rgb = mix(vec3(dot(tex_color.rgb, vec3(0.299, 0.587, 0.114))), tex_color.rgb, saturation);
	COLOR.a = 1.0;
}