/* License CC BY-NC-SA 4.0 Deed */
/* https://creativecommons.org/licenses/by-nc-sa/4.0/ */
/* Fork of Ryk's VCR distortion shader */
/* https://www.shadertoy.com/view/ldjGzV */

shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap, repeat_disable;

group_uniforms Image;
uniform float curvature: hint_range(0., 10., .01) = 2.;
uniform float chromatic_aberration = 0.01;
uniform float fade = 1.;

vec2 screenDistort(vec2 uv)
{
	uv -= vec2(.5,.5);
	uv = uv*1.2*(1./1.2+curvature*uv.x*uv.x*uv.y*uv.y);
	uv += vec2(.5,.5);
	return uv;
}

void fragment()
{
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	float vignette =smoothstep(.0,0.6, 1. - length(uv - 0.5));
	uv = screenDistort(uv);

	float ca = chromatic_aberration * (1. - vignette);
	float r = texture(screen_texture, uv + vec2(0.2,0.3)*ca).r;
	float g = texture(screen_texture, uv + vec2(-0.2,-0.3)*ca).g;
	float b = texture(screen_texture, uv + vec2(0.4,0.1)*ca).b;

	vec3 color = vec3(r,g,b);
	COLOR = vec4(color * vignette * fade,1.);
}