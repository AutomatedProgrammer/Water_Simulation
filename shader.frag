#version 330 core
out vec4 FragColor;
in vec2 TexCoords;
in vec3 Position;
in vec3 Normal;
uniform vec3 cameraPos;
uniform samplerCube skybox;

void main()
{
    vec3 waterColor = vec3(0.0, 0.4, 0.7);
	float ratio = 1.00 / 1.33;  // refraction index ratio
    vec3 N = normalize(Normal);
    vec3 I = normalize(Position - cameraPos);

    vec3 R_refract = refract(I, N, ratio);

    if (length(R_refract) < 0.001)
    {
        R_refract = reflect(I, N);
    }

    vec3 R_reflect = reflect(I, N);

    float cosTheta = max(dot(-I, N), 0.0);
    float fresnel = pow(1.0 - cosTheta, 5.0);
    fresnel = mix(0.15, 1.0, fresnel); 

    vec3 refractColor = texture(skybox, R_refract).rgb;
    vec3 reflectColor = texture(skybox, R_reflect).rgb;
    reflectColor *= 0.8;

    vec3 finalColor = mix(refractColor, reflectColor, fresnel);
    finalColor = mix(finalColor, waterColor, 0.5);

    FragColor = vec4(finalColor, 1.0);
}