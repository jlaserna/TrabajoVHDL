//
//  Obstaculo.hpp
//  Juego
//
//  Created by Javier Laserna Moratalla on 23/05/2019.
//  Copyright © 2019 Javier Laserna Moratalla. All rights reserved.
//

#ifndef Obstaculo_h
#define Obstaculo_h

#include <stdio.h>
#include "Vector3D.h"


class Obstaculo {
    Vector3D posicion;
    int tipo;      //Crear objeto colorRGB para manejar esto como objeto
    
public:
    Obstaculo(float x, float y, float z, int tipo) : posicion(Vector3D(x, y, z)), tipo(tipo) {};
    void Dibuja();
    void Mueve(float t);
    ~Obstaculo();
};

#endif /* Celda_hpp */
