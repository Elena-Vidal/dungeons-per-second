using Godot;
using System;
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
			GD.Print("desvio");
			collision.SetDeferred("DisableMode", true);
			Thread.Sleep(1000);
			collision.SetDeferred("DisabledMode", false);
		}

		Velocity = velocity;
		MoveAndSlide();
	}
}
