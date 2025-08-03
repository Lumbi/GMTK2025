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

func reset():
	var shapes = find_children("Shape*")
	for shape in shapes:
		shape.visible = false
	$Hint.visible = true

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

	if formanted_result != "":
		$Hint.visible = false
	else:
		$Hint.visible = true
	return formanted_result

func _process(_delta: float) -> void:
	pass

func set_hint_text(input_text: String):
	$Hint.text = input_text
