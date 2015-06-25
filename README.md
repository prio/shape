Shape
=====

Shape is library that allows you to declaratively describe and validate your data structures.

To use add

[{:shape, "0.0.2"}]

to your mix dependencies.

Example Usage:
<pre>
  iex> alias Shape, as: S
  nil

  iex> S.validate(S.Num, 42)
  :ok

  iex> S.validate(S.Num, "42")
  {:error, "42 is not a number"}

  # Check list shape
  iex> S.validate([S.Atom, S.Str, S.Int], [:a, "b", 1])
  :ok

  iex> S.validate([S.Int], [1, 2, 3])
  :ok

  iex> S.validate([S.Str, S.Int, S.Int], [:a, "b", 1])
  {:error, ["a is not a string", "b is not a integer"]}

  # Check map shape
  iex> S.validate(%{S.Atom => S.Str}, %{o: "k"})
  :ok

  iex> S.validate(%{S.Atom => S.Int, S.Str => S.Int}, %{"o" => "k", "o" => :k})
  {:error, ["o is not a atom", "k is not a integer"]}

  # Check map key values rather than types
  iex> S.validate(%{:o => S.Str, "o" => S.Str}, %{:o => "k", "o" => "k"})
  :ok

  iex> S.validate(%{:b => S.Str, "o" => S.Str}, %{:o => "k", "o" => "k"})
  {:error, ["o is not equal to b"]}

  # check Keyword list shape
  iex> S.validate([o: S.Str, a: S.Str], [o: "k", a: "ok"])
  :ok

  iex> S.validate([o: S.Int, b: S.Str], [o: "k", a: "ok"])
  {:error, ["a is not equal to b", "k is not a integer"]}
</pre>
