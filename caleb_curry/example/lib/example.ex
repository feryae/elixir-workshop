# Contains our main code

defmodule Example do
  alias UUID
  # defining variables on module level, similar to const
  @x 5

  @moduledoc """
  Documentation for `Example`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Example.hello()
      :world

  """
  def hello do
    # Print
    IO.puts(:world)
  end

  # Persist hello world on mix run by start()
  use Application
  # Underscore because we dont use the parameters
  def start(_type, _args) do
    # IO.puts(:"Hello world")
    # IO.puts(Example.hello())

    # IO.puts(UUID.uuid4())

    Example.main()

    Supervisor.start_link([], strategy: :one_for_one)
  end

  def main do
    # IO.puts("example output")

    # Variable assignment or binding
    x = 5
    # can be rebinded
    x = 10
    IO.puts(x)

    # Const
    IO.puts(@x)

    # Atoms
    IO.puts(:hello)
    # Same as
    IO.puts("hello")
    # Performance wise it is recommended to use atoms for static values
    # This works as well
    IO.puts(:"hello world")

    name = "Caleb"
    # status = :silver
    # random
    status = Enum.random([:gold, :silver, :bronze, :"not a member"])

    # Conditionals (if)
    if status === :gold do
      IO.puts("Welcome to the fancy lounge, #{name}")
    else
      IO.puts("Get lost")
    end

    # Conditional (case)
    case status do
      :gold -> IO.puts("Welcome to the fancy lounge, #{name}")
      :"not a member" -> IO.puts("Get subscribed")
      _ -> IO.puts("Get out bruh")
    end

    # Escape characters
    IO.puts("This\nis\na\nmessage\n")
    IO.puts("After")
    IO.puts("Interpolation looks like \#{}")
    # Codepoint in hex (unicode)
    IO.puts(?a)
    IO.puts(?b)

    # Numbers
    a = 10
    b = 3.0
    c = 3

    # Operations (Integer + Floating point)
    IO.puts(a + b)
    # Operations (Integer + Integer)
    IO.puts(a + c)

    a = a + 5.0
    IO.puts(a)
    # Division (always floating point)
    IO.puts(a / b)
  end
end

# This is ran on compile time since its outside.
# Example.hello()
# IO.puts("Compile time!@!@")
