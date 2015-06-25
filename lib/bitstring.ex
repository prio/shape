defmodule Shape.Bitstring do
  @moduledoc """
  Uses is_bitstring to detect if the item is a bitstring.
  """
  def validate(obj) do
    Kernel.is_bitstring(obj)
  end

  def desc() do
    "bitstring"
  end
end
