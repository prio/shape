defmodule Shape do
  @moduledoc """
  Shape is library that allows you to declaratively describe and validate
  your data structures.

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
  """

  defp merge_errors(coll) do
    errors = Enum.map(coll, fn x ->
      case x do
        :ok ->
          nil
        {:error, error} ->
          error
      end
    end) |>
    Enum.filter(fn x -> not(is_nil(x)) end)
    case Enum.count(errors) do
      0 ->
        :ok
      _ ->
        {:error, List.flatten(errors)}
    end

  end

  defp validate_list(shape, obj) do
    Enum.zip(Stream.cycle(shape), obj) |>
    Enum.map(fn {s, o} -> validate(s, o) end) |>
    merge_errors
  end

  defp validate_dict(shape, obj) do
    merge_errors([validate_list(Dict.keys(shape), Dict.keys(obj)),
                  validate_list(Dict.values(shape), Dict.values(obj))])
  end

  def validate(shape, obj) when is_list(shape) do
    # may be a keyword list, a dict in disguise
    try do
      validate_dict(shape, obj)
    rescue
      FunctionClauseError -> validate_list(shape, obj)
    end
  end

  def validate(shape, obj) when is_map(shape) do
    validate_dict(shape, obj)
  end

  def validate(shape, obj) do
    try do
      if shape.validate(obj) do
        :ok
      else
        {:error, "#{obj} is not a #{shape.desc}"}
      end
    rescue
      _ ->
        if shape == obj do
          :ok
        else
          {:error, "#{obj} is not equal to #{shape}"}
        end
    end
  end
end
