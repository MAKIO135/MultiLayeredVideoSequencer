uniform sampler2D src_tex_unit0;
uniform vec2 src_tex_offset0;

uniform vec2 posXY;
uniform float Scale;
uniform float Opacity;

void main(void)
{
	vec2 centre = vec2((1.-(1./Scale))/2., (1.-(1./Scale))/2.);
	vec2 tex_coord = gl_TexCoord[0].st/Scale + centre - posXY/Scale;
	vec4 color0 = texture2D(src_tex_unit0, tex_coord);
	float transparency = color0.a * Opacity;

	if(tex_coord[0] <= 0.) gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
	else if(tex_coord[0] >= 1.) gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
	else if(tex_coord[1] <= 0.) gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
	else if(tex_coord[1] >= 1.) gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
	else gl_FragColor = vec4(color0.rgb, transparency);
}