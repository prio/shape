defmodule Shape.Str do
  @moduledoc """
  Uses is_bitstring to detect if the item is a string.
  """
  def validate(obj) do
    Kernel.is_bitstring(obj)
  end

  def desc() do
    "string"
  end
end
