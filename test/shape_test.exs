defmodule ShapeTest do
  use ExUnit.Case
  alias Shape, as: S

  test "a number can be validated" do
    assert :ok == S.validate(S.Num, 42)
  end

  test "a string is not a number" do
    {:error, _} = S.validate(S.Num, "42")
  end

  test "a string can be validated" do
    assert :ok == S.validate(S.Str, "42")
  end

  test "a number is not a string" do
    {:error, _} = S.validate(S.Str, 42)
  end

  test "an atom can be validatess" do
    assert :ok == S.validate(S.Atom, :atom)
  end

  test "a list can be validated" do
    assert :ok == S.validate([S.Atom, S.Str, S.Int], [:a, "b", 1])
  end

  test "list errors are grouped" do
    {:error, errors} = S.validate([S.Str, S.Int, S.Int], [:a, "b", 1])
    assert 2 == Enum.count(errors)
  end

  test "a map can be validated" do
    assert :ok == S.validate(%{S.Atom => S.Str}, %{o: "k"})
  end

  test "map errors are grouped" do
    {:error, errors} = S.validate(%{S.Atom => S.Int, S.Str => S.Int},
                                  %{"o" => "k", "o" => :k})
    assert 2 == Enum.count(errors)
  end

end
