extends Node2D

enum Shape
{
	CIRCLE,
	CONE,
	CROSS,
	DIAMOND,
	FUNNEL,
	SQUARE
}

func get_sprite(shape) -> Sprite2D:
	match shape:
		Shape.CIRCLE: return $ShapeCircle
		Shape.CONE: return $ShapeCone
		Shape.CROSS: return $ShapeCross
		Shape.DIAMOND: return $ShapeDiamond
		Shape.FUNNEL: return $ShapeFunnel
		Shape.SQUARE: return $ShapeSquare
	return null

# pass the Shape enum
func toggle(shape) -> void:
	var sprite = get_sprite(shape)
	sprite.visible = !sprite.visible

func get_dial_code() -> String:
	var result = ""
	if $ShapeCircle.visible:
		result += "CI"
	if $ShapeCone.visible:
		result += "CO"
	if $ShapeCross.visible:
		result += "CR"
	if $ShapeDiamond.visible:
		result += "DI"
	if $ShapeFunnel.visible:
		result += "FU"
	if $ShapeSquare.visible:
		result += "SQ"
	return result

func _process(_delta: float) -> void:
	$DebugLabel.text = get_dial_code()
	pass
