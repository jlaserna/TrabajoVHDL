//
//  BloqueAlternativo.h
//  Juego
//
//  Created by Javier Laserna Moratalla on 23/05/2019.
//  Copyright © 2019 Javier Laserna Moratalla. All rights reserved.
//

#ifndef BloqueAlternativo_h
#define BloqueAlternativo_h

#include <stdio.h>
#include "Vector3D.h"
#include "Obstaculo.h"

#define ancho 20

class BloqueAlternativo {
    Vector3D posicion;
    Vector3D velocidad;
    Vector3D aceleracion;
    Obstaculo *celdas[3];
    
public:
    BloqueAlternativo(float x, float y, float z) : posicion(Vector3D(x,y,z)) {};
    void init(int izq, int med, int der);
    void Dibuja();
    void Mueve(float t);
    void SetVel(float vx, float vy, float vz) {this->velocidad = Vector3D(vx,vy,vz);};
    void SetAcel(float ax, float ay, float az) {this->aceleracion = Vector3D(ax,ay,az);};
    //virtual ~BloqueAlternativo();
};

#endif /* BloqueAlternativo_h */
