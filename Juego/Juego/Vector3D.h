#pragma once
class Vector3D
{
public: //atributos
	float x;
	float y;
	float z;
public: //metodos
	Vector3D(float xv=0.0f,float yv=0.0f, float zv=0.0f);
	~Vector3D(void);
	
	float modulo();      // (2) modulo del vector
	float argumento();     // (3) argumento del vector
	Vector3D Unitario();     // (4) devuelve un vector unitario
	Vector3D operator - (Vector3D &); // (5) resta de vectores
	Vector3D operator + (Vector3D &); // (6) suma de vectores
	float operator *(Vector3D &);   // (7) producto escalar
	Vector3D operator *(float);  // (8) producto por un escalar 
	bool operator == (Vector3D);
};
