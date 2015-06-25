defmodule Shape.Int do
  @moduledoc """
  Uses is_integer to detect if the item is an integer.
  """
  def validate(obj) do
    Kernel.is_integer(obj)
  end

  def desc() do
    "integer"
  end
end
