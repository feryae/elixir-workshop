# Contains our main code

# Structs
defmodule Membership do
  defstruct [:type, :price]
end

defmodule User do
  defstruct [:name, :membership]
end

defmodule Example do
  require Integer
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

  def sum_and_average(numbers) do
    sum = Enum.sum(numbers)
    average = sum / Enum.count(numbers)
    # Return
    {sum, average}
  end

  def print_numbers(numbers) do
    numbers |> Enum.join(" ") |> IO.puts()
  end

  def get_numbers_from_user do
    IO.puts("Enter numbers separated by spaces:")
    user_input = IO.gets("") |> String.trim()
    String.split(user_input, " ") |> Enum.map(&String.to_integer/1)
  end

  def main do
    # IO.puts("example output")

    # Variable assignment or binding
    _x = 5
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

    # Number 0.1 cannot be represented perfectly because of how binary works
    :io.format("~.20f\n", [0.1])
    # So use integer if you can

    # Ceiling with one point after decimal
    IO.puts(Float.ceil(0.5, 1))
    # Round a whole number
    IO.puts(Float.ceil(0.5))
    # Rounding 0.1
    IO.puts(Float.ceil(0.1, 1))

    # Greatest common divisor
    IO.puts(Integer.gcd(25, 10))

    # Compound types
    # Time
    time = Time.new!(16, 30, 0, 0)
    # Since time is a compound value you can use inspect to get a better representation
    IO.inspect(time)
    # Date
    date = Date.new!(2025, 1, 1)
    IO.inspect(date)
    # DateTime -> new! represents warning it could cause an error
    datetime = DateTime.new!(date, time, "Etc/UTC")
    IO.inspect(datetime)
    IO.puts(datetime.year)

    # Application to calculate new year
    time = DateTime.new!(Date.new!(2027, 1, 1), Time.new!(0, 0, 0, 0), "Etc/UTC")
    time_till = DateTime.diff(time, DateTime.utc_now())
    # in seconds
    IO.puts(time_till)
    # division
    rem_days = div(time_till, 86400)
    IO.puts(rem_days)
    # rem() -> remaining
    # 86_400 = 86400 but readable
    rem_hours = div(rem(time_till, 86_400), 60 * 60)
    IO.puts(rem_hours)
    # remaining minutes
    rem_mins = div(rem(time_till, 3600), 60)
    IO.puts(rem_mins)
    # remaining seconds
    rem_seconds = rem(time_till, 60)
    IO.puts(rem_seconds)

    IO.puts(
      "Time until new year: #{rem_days} days, #{rem_hours} hours, #{rem_mins} minutes, #{rem_seconds} seconds."
    )

    # Tuples
    memberships = {:bronze, :silver}
    memberships = Tuple.append(memberships, :gold)
    IO.inspect(memberships)

    prices = {5, 10, 15}
    # calculate tuples
    avg = Tuple.sum(prices) / tuple_size(prices)
    IO.puts(avg)

    # accessing tuples
    IO.puts(
      "Average price for #{elem(memberships, 0)} #{elem(memberships, 1)} #{elem(memberships, 2)} is #{avg}"
    )

    # Mixing types
    user1 = {"Caleb", :gold}
    user2 = {"Kayla", :gold}
    user3 = {"Carrie", :silver}

    # access tuple by destructuring
    {name, membership} = user1
    # If match two item tuple than it would be a successful match
    IO.puts("#{name} has a #{membership} membership.")

    {name, membership} = user2
    IO.puts("#{name} has a #{membership} membership.")
    {name, membership} = user3
    IO.puts("#{name} has a #{membership} membership.")

    # List and loop
    users = [{"Caleb", :gold}, {"Kayla", :gold}, {"Carrie", :silver}, {"John", :bronze}]

    Enum.each(users, fn {name, membership} ->
      IO.puts("#{name} has a #{membership} membership.")
    end)

    # Maps
    # memberships = %{
    #   gold: 3,
    #   silver: 2,
    #   bronze: 1,
    #   none: 0
    # }

    memberships = %{
      gold: :gold,
      silver: :silver,
      bronze: :bronze,
      none: :none
    }

    prices = %{
      gold: 25,
      silver: 20,
      bronze: 15,
      none: 0
    }

    users = [
      {"Caleb", memberships.gold},
      {"Kayla", memberships.gold},
      {"Carrie", memberships.silver},
      {"John", memberships.bronze}
    ]

    Enum.each(users, fn {name, membership} ->
      IO.puts("#{name} has a #{membership} membership paying #{prices[membership]}.")
    end)

    # Structs
    gold_membership = %Membership{type: :gold, price: 25}
    silver_membership = %Membership{type: :silver, price: 20}
    bronze_membership = %Membership{type: :bronze, price: 15}
    _none_membership = %Membership{type: :none, price: 0}

    users = [
      %User{name: "Caleb", membership: gold_membership},
      %User{name: "Kayla", membership: gold_membership},
      %User{name: "Carrie", membership: silver_membership},
      %User{name: "John", membership: bronze_membership}
    ]

    Enum.each(users, fn %User{name: name, membership: membership} ->
      IO.puts("#{name} has a #{membership.type} membership paying #{membership.price}.")
    end)

    # Guessing Game
    # 0 to 10
    correct = :rand.uniform(11) - 1
    IO.puts(correct)
    # Piped output through String.trim() to remove any spaces
    guess = IO.gets("Guess a number between 0 and 10: ") |> String.trim() |> Integer.parse()
    # IO.inspect(guess)
    # IO.puts(elem(guess, 0))

    # if String.to_integer(guess) == correct do
    #   IO.puts("You win!")
    # else
    #   IO.puts("You lose!")
    # end

    case guess do
      {result, _} ->
        IO.puts("parse successful #{result}")

        if result === correct do
          IO.puts("You win")
        else
          IO.puts("You lose!")
        end

      # {result, other} ->
      #   IO.puts("parse partially successful #{result} and #{other}")

      :error ->
        IO.puts("Something went wrong")
    end

    # List comprehensions
    grades = [25, 50, 75, 100]
    for n <- grades, do: IO.puts(n)

    # Modify data
    new = for n <- grades, do: n + 5
    IO.inspect(new)

    # Put elements at the end
    new = new ++ [125]
    new = new ++ [150, 175]
    # Put elements at the beginning
    new = [5 | new]
    IO.inspect(new)

    # Comprehension with a condition
    # even = for n <- new, rem(n, 2) == 0, do: n
    even = for n <- new, Integer.is_even(n), do: n
    IO.inspect(even)

    # Functional programming
    # numbers = [1, 2, 3, 4, 5]
    # Enum.each(numbers, fn num -> IO.puts(num) end)
    # numbers = ["1", "2", "3", "4", "5"]
    numbers = get_numbers_from_user()
    # result = Enum.map(numbers, &String.to_integer/1)
    # IO.inspect(result)
    print_numbers(numbers)
    IO.inspect(sum_and_average(numbers))
    {sum, average} = sum_and_average(numbers)
    IO.puts("Sum #{sum}, average: #{average}")
    # Our own function
  end
end

# This is ran on compile time since its outside.
# Example.hello()
# IO.puts("Compile time!@!@")
