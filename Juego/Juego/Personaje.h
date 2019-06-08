#include "Vector3D.h"

#pragma once
class Personaje
{
	float altura;
	Vector3D posicion;
	Vector3D velocidad;
	Vector3D aceleracion;
public:
	Personaje(void);
	~Personaje(void);
	void Dibuja();
	void Mueve(float t);
	void SetPos(float ix, float iy, float iz);
	Vector3D GetPos();
	void SetVel(float vx, float vy, float vz);


	int saltos();	//compruebo si está en el suelo, en dicho caso me deja saltar, sinó no me permite realizar un soble salto
	int giro();		//con este parametro se obtiene si va hacia la derecha o a la izquierda
	int jump();		//comprobamos si está saltando

	friend class Interaccion;
};