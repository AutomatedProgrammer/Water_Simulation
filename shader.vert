#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec2 TexCoords;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform float time;

void main()
{
	vec3 Pos;
	Pos = aPos;
	float amplitude = 0.005f;
	vec2 direction = vec2(0.5f, 1.0f);
	float frequency = 50.0f;
	float speed = 1.0f;
	Pos.z += amplitude * sin(dot(direction, vec2(Pos.x,Pos.y))*frequency + time*speed); 
	
	 
	TexCoords = aTexCoords;
	gl_Position = projection * view * model * vec4(Pos, 1.0);
}

