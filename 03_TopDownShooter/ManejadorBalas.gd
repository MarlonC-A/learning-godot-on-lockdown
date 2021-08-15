extends Node2D


func manejarBala(bala, posicion, direccion):
	add_child(bala);
	bala.global_position = posicion;
	bala.darDireccion(direccion);
