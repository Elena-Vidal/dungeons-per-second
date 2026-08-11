using Godot;
using System;
using System.Security.Cryptography.X509Certificates;
using System.Threading;

public partial class PlayerBody : CharacterBody2D
{
	public const float Speed = 600.0f;

	public override void _PhysicsProcess(double delta)
	{
		CollisionShape2D collision = GetNode<CollisionShape2D>("playerCollision");
		Vector2 velocity = Velocity;

		Vector2 direction = Input.GetVector("moveLeft", "moveRight", "moveUp", "moveDown");
		if (direction != Vector2.Zero)
		{
			velocity.X = direction.X * Speed;
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
		}
		if (direction != Vector2.Zero)
		{
			velocity.Y = direction.Y * Speed;
		}
		else
		{
			velocity.Y = Mathf.MoveToward(Velocity.Y, 0, Speed);
		}

		if (Input.IsActionJustPressed("attack"))
		{
			GD.Print("ataque");
		}
		if (Input.IsActionJustPressed("dodge"))
		{
			GD.Print("desliga");
			collision.SetDeferred("DisableMode", true);
			//DodgeCooldown();
			GD.Print("liga");
			collision.SetDeferred("DisableMode", false);
		}

		Velocity = velocity;
		MoveAndSlide();
	}/*
	public async void DodgeCooldown()
	{
		SceneTreeTimer timer = GetTree().CreateTimer(2.0);
		Connect(ToSignal(timer, SceneTreeTimer.SignalName.Timeout), DodgeSequence);
	}
	publicvoid DodgeSequence()
		{
		
		}*/
}
