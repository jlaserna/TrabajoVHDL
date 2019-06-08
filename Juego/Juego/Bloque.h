#include "Pared.h"   //el include no es necesario que ponga “dominio”
					//porque ya estamos en dicha carpeta.
#pragma once
class Bloque
{
public:
	Bloque(void);
	~Bloque(void);
	Pared suelo;
	Pared techo;
	Pared pared_izq;
	Pared pared_dcha;
	Vector3D aceleracion;
	Vector3D velocidad;
	//void SetColor(unsigned char r,unsigned char v, unsigned char a);
	void Dibuja();
	void Mueve(float t);
	void SetVel(float vx, float vy, float vz);
};