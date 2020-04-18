extends Node

class_name HSVslider

var global_colour 
var colour
var hue 
var saturation 
var _value 


signal colour_changed

func _ready():
	hue = Color(global_colour).h
	saturation = Color(global_colour).s
	_value = Color(global_colour).v
	emit_signal("colour_changed")
	$PopupPanel/GridContainer/HueSlider.value = hue
	$PopupPanel/GridContainer/SaturationSlider.value = saturation
	$PopupPanel/GridContainer/ValueSlider.value = _value
	var style = StyleBoxFlat.new()
	$PopupPanel.add_stylebox_override("panel", style)
	style.bg_color = Color(Global.background_colour)
	style.set_border_width_all(1)
	style.border_color = Color(Global.sprite_colour)


func _on_HueSlider_value_changed(value: float) -> void:
	hue = value
	print(value)
	update_colour()


func _on_SaturationSlider_value_changed(value: float) -> void:
	saturation = value
	print(value)
	update_colour()


func _on_ValueSlider_value_changed(value: float) -> void:
	_value = value
	print(value)
	update_colour()


func update_colour():
	Global.set(colour, Color.from_hsv(hue, saturation, _value))
	Global.set(colour, Global.get(colour).to_html())
	print(Global.get(colour))
	emit_signal("colour_changed")
