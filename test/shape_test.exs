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

  test "nested map" do
    shape = %{a: %{b: S.Str, c: S.Int},
              d: [%{e: S.Atom, f: [S.Num]}]}
    obj = %{a: %{b: "abc", c: 123},
            d: [%{e: :bc, f: [12.2, 13, 100]},
                %{e: :bc, f: [-1]}]}
    assert :ok == S.validate(shape, obj)
    data = %{a: %{b: 123, c: "ABC"}}

    # :d missing-required-key
    {:error, errors} = S.validate(shape, data)
    assert 2 == Enum.count(errors)
  end

  test "validate a tuple" do
    assert :ok == S.validate({S.Int, {S.Str, S.Float}}, {1, {"2", 3.0, "4", 5.0}})
  end

  test "shapes are just data" do
    string_list = [S.Str]
    string_scores = %{S.Str => S.Float}
    string_score_map = [S.Int, string_scores]

    assert :ok == S.validate(string_score_map, [1, %{"2" => 3.0, "3" => 5.0}])
  end
end
