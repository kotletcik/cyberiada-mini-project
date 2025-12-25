class_name InventoryManager
extends Node

static var instance: InventoryManager;

var itemCount: Array[int] = [];

func _ready() -> void:
	if(instance == null):
		instance = self;
		itemCount.resize(ITEM_TYPE.ENUM_LENGTH);
	else:
		print("More than one InventoryManager exists!!!");

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("use_item_1")):
		if(has_item(ITEM_TYPE.SERUM)):
			remove_item(ITEM_TYPE.SERUM, 1);
			print("serum count:", itemCount[ITEM_TYPE.SERUM]);
			PsycheManager.instance.take_serum();
	if(Input.is_action_just_pressed("use_item_2")):
		if(has_item(ITEM_TYPE.ROCK)):
			remove_item(ITEM_TYPE.ROCK, 1);
			print("rock count:", itemCount[ITEM_TYPE.ROCK]);
			

func add_item(index: int, count: int) -> void:
	if(index < 0 || index >= ITEM_TYPE.ENUM_LENGTH): return;
	itemCount[index] += count;

func remove_item(index: int, count: int) -> void:
	if(index < 0 || index >= ITEM_TYPE.ENUM_LENGTH): return;
	itemCount[index] -= count;

func has_item(index: int) -> bool:
	if(index < 0 || index >= ITEM_TYPE.ENUM_LENGTH): return false;
	return itemCount[index] > 0;
