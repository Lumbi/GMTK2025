extends Node2D


func get_sprite(shape) -> Sprite2D:
	match shape:
		Global.Shape.CIRCLE: return $ShapeCircle
		Global.Shape.TRIANGLE: return $ShapeTriangle
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
	#TODO : This can be optimized 
	var result = ""
	var index = 0
	if $ShapeCircle.visible:
		result += "circle_"
	if $ShapeTriangle.visible:
		result += "triangle_"
	if $ShapeCross.visible:
		result += "cross_"
	if $ShapeDiamond.visible:
		result += "diamond_"
	if $ShapeFunnel.visible:
		result += "funnel_"
	if $ShapeSquare.visible:		
		result += "square_"
	var formanted_result = result.left(result.length() - 1)
	return formanted_result

func _process(_delta: float) -> void:
	$DebugLabel.text = get_dial_code()
	pass
