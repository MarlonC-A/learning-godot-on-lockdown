extends Node2D


onready var manejadorBalas = $ManejadorBalas;
onready var jugador = $Jugador;


func _ready():
	jugador.connect("balaDisparada", manejadorBalas, "manejarBala");

