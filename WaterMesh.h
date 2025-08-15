#include "Mesh.h"
#pragma once

class WaterMesh : public Mesh
{
    public:
    using Mesh::Mesh;
    void Draw(Shader& shader, unsigned int cubemapTexture);
};

void WaterMesh::Draw(Shader& shader, unsigned int cubemapTexture)
{
    shader.setInt("skybox", 0);
    glBindVertexArray(VAO);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_CUBE_MAP, cubemapTexture);
    glDrawElements(GL_TRIANGLES, indices.size(), GL_UNSIGNED_INT, 0);
    glBindVertexArray(0);
    glActiveTexture(GL_TEXTURE0);
}