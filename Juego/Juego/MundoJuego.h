#include "Bloque.h"
#include "Personaje.h"
//#include "Esfera.h"
//#include "Bonus.h"
//#include "Disparo.h"

class Mundo
{
public: 
	/*Disparo disparo;
	Esfera esfera;
	Caja caja;
	Bonus bonus;*/
	//Pared plataforma;
	Bloque bloque;
	Personaje personaje;


	void Tecla(bool keystates[]);
	void tecla(unsigned char key);
	void Inicializa();
	void RotarOjo();
	void Mueve();
	void Dibuja();
	void teclaEspecial(unsigned char key);
	void MovPers();

	float x_ojo;
	float y_ojo;
	float z_ojo;
};