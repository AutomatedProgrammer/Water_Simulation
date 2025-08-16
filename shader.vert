#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec2 TexCoords;
out vec3 Normal;
out vec3 Position;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform float time;

void main()
{
	const int NUM_WAVES = 8;
	vec2 directions[NUM_WAVES] = vec2[](
        vec2(1.0, 0.0),
        vec2(0.0, 1.0),
        vec2(0.75, -0.75),
        vec2(-0.75, 0.75),
        vec2(0.6, 0.7),
        vec2(-0.8, 0.4),
        vec2(0.4, -1.0),
        vec2(-0.5, -0.6)
    );

    float amplitudes[NUM_WAVES] = float[NUM_WAVES](
		0.002, 
		0.0012, 
		0.001, 
		0.0016, 
		0.002, 
		0.0012, 
		0.0015, 
		0.002);
    float frequencies[NUM_WAVES] = float[NUM_WAVES](
		70.0, 
		100.0, 
		65.0, 
		120.0, 
		110.0, 
		80.0, 
		120.0, 
		90.0);
    float speeds[NUM_WAVES] = float[NUM_WAVES](
		1.0, 
		1.1, 
		0.9, 
		1.1, 
		1.15, 
		0.7, 
		1.1, 
		1.0);
	vec3 Pos;
	Pos = aPos;

    float waveSum = 0.0;
    float dzdx = 0.0;
    float dzdy = 0.0;

    for (int i = 0; i < NUM_WAVES; i++) {
        float wave = dot(directions[i], vec2(Pos.x, Pos.y)) * frequencies[i] + time * speeds[i];

        waveSum += amplitudes[i] * sin(wave);
    
        dzdx += amplitudes[i] * frequencies[i] * directions[i].x * cos(wave);
        dzdy += amplitudes[i] * frequencies[i] * directions[i].y * cos(wave);
    }

    Pos.z += waveSum;
    vec3 normal = normalize(vec3(-dzdx, -dzdy, 1.0));
	
	Normal = normal;
    Position = vec3(model * vec4(aPos, 1.0));
	TexCoords = aTexCoords;
	gl_Position = projection * view * model * vec4(Pos, 1.0);
}
