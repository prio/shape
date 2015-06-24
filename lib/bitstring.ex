defmodule Shape.Bitstring do
  def validate(obj) do
    Kernel.is_bitstring(obj)
  end

  def desc() do
    "bitstring"
  end
end
