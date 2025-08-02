shader_type canvas_item;
uniform sampler2D image : source_color;
uniform sampler2D noiseTex;

float sdRoundedBox( in vec2 p, in vec2 b, in vec4 r )
{
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    vec2 q = abs(p)-b+r.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}

mat2 rotate2d(float angle){
	float cosA = cos(angle);
	float sinA = sin(angle);
    return mat2(vec2(cosA,-sinA),
                vec2(sinA,cosA));
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	mat2 rot = rotate2d(radians(5));
	vec2 uv = UV;
	uv = uv - .5;
	uv.x =  fract(uv.x*4.)-.5;
	float box = step(length(uv),.5);
	box = sdRoundedBox(uv, vec2(.25,.25), vec4(0.1,.1,.1,.1));
	box = step(box,.2) * (1. - uv.y);
	float alpha = smoothstep(0.48,0.52,box);

	//vec2 dir = normalize( vec2(dFdx(UV.x),dFdy(UV.y))/fwidth(UV));
	//COLOR = vec4(dir,0,1);
	COLOR = vec4(box,box,box,alpha);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
