#include "Vector3D.h"
#pragma once
class Pared
{
public:
	Pared(void);
	~Pared(void);
	/*unsigned char rojo;
	unsigned char verde;
	unsigned char azul;*/
	Vector3D limite1;
	Vector3D limite2;
	Vector3D limite3;
	Vector3D limite4;

	Vector3D esquina1;
	Vector3D esquina2;
	Vector3D esquina3;
	Vector3D esquina4;

	void Dibuja();
	void SetColor(unsigned char r,unsigned char v, unsigned char a);
private:
	unsigned char rojo;
	unsigned char verde;
	unsigned char azul;
};




///////////////////////////////////////////////////////////////
/*PARA PROBAR CON ESQUINAS
	Vector3D esquina1;
	Vector3D esquina2;
	Vector3D esquina3;
	Vector3D esquina4;
	*/