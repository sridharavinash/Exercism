defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  defstruct dir: :north, pos: {0, 0}

  defguard is_valid_position(pos) when is_tuple(pos) and tuple_size(pos) == 2
  defguard is_position(x, y) when is_number(x) and is_number(y)

  defguard is_valid_direction(dir)  when dir in [:north, :south, :east, :west]

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(d, _) when not is_valid_direction(d), do: {:error, "invalid direction"}
  def create(_, p) when not is_valid_position(p), do: {:error, "invalid position"}
  def create(_, {x, y}) when not is_position(x, y), do: {:error, "invalid position"}

  def create(direction, position)
      when is_valid_direction(direction) and is_valid_position(position) do
    %RobotSimulator{dir: direction, pos: position}
  end

  def create(), do: %RobotSimulator{}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.codepoints(instructions)
    |> Enum.reduce_while(robot, fn x, acc ->
      case acc do
        {:error, _} -> {:halt, acc}
        _ -> {:cont, do_sim(acc, x)}
      end
    end)
  end

  defp do_sim(robot, "L") do
    case robot.dir  do
      :north -> %{robot | dir: :west}
      :south -> %{robot | dir: :east}
      :east -> %{robot | dir: :north}
      :west -> %{robot | dir: :south}
    end
  end

  defp do_sim(robot, "R") do
    case robot.dir do
      :north -> %{robot | dir: :east}
      :south -> %{robot | dir: :west}
      :east -> %{robot | dir: :south}
      :west -> %{robot | dir: :north}
    end
  end

  defp do_sim(robot, "A") do
    {x, y} = robot.pos

    case robot.dir do
      :north -> %{robot | pos: {x, y + 1}}
      :south -> %{robot | pos: {x, y - 1}}
      :east -> %{robot | pos: {x + 1, y}}
      :west -> %{robot | pos: {x - 1, y}}
    end
  end

  defp do_sim(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.dir
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.pos
  end
end
