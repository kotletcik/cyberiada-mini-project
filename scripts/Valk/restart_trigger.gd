extends Area3D

func _on_body_entered(body) -> void:
    print(body.name);
    if(body.name == "Player"):
        print("meow");
        GameManager.instance.restart_scene();
