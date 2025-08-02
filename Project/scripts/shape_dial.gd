extends Node2D


func get_sprite(shape) -> Sprite2D:
	match shape:
		Global.Shape.CIRCLE: return $ShapeCircle
		Global.Shape.CONE: return $ShapeCone
		Global.Shape.CROSS: return $ShapeCross
		Global.Shape.DIAMOND: return $ShapeDiamond
		Global.Shape.FUNNEL: return $ShapeFunnel
		Global.Shape.SQUARE: return $ShapeSquare
	return null

# pass the Shape enum
func toggle_shape(shape) -> void:
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
