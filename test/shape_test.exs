defmodule ShapeTest do
  use ExUnit.Case
  alias Shape, as: S
  doctest Shape  

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

  test "a single item list shape applies to all obj items (ok)" do
    assert :ok == S.validate([S.Atom], [:a, :b, :c])

  end

  test "a single item list shape applies to all obj items (errors)" do
    {:error, errors} = S.validate([S.Int], [0, :a, "b", 1])
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

  test "a map keys values are checked (ok)" do
    assert :ok == S.validate(%{:o => S.Str, "o" => S.Str}, %{:o => "k", "o" => "k"})
  end

  test "a maps keys are checked (errors)" do
    {:error, errors} = S.validate(%{:b => S.Str, "o" => S.Str}, %{:o => "k", "o" => "k"})
    assert 1 == Enum.count(errors)
  end

  test "a keyword list is checked (ok)" do
    assert :ok == S.validate([o: S.Str, a: S.Str], [o: "k", a: "ok"])
  end

  test "a keyword list is checked (errors)" do
    {:error, errors} = S.validate([o: S.Int, b: S.Str], [o: "k", a: "ok"])
    assert 2 == Enum.count(errors)
  end
end
