#version 330 core
layout (location = 0) in vec3 aPos;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform float time;
vec3 Pos;

void main()
{
	Pos = aPos;
	/*
	if (gl_VertexID % 2 == 0)
	{
		//Pos.z = (sin(time*3)*0.05);
		Pos.z = 0.15 * sin((2*(Pos.x+Pos.y) + time*1)); 
	}
	*/
	Pos.z = 0.15 * sin((2*(Pos.x+Pos.y) + time*1)); 
	gl_Position = projection * view * model * vec4(Pos, 1.0);
}

