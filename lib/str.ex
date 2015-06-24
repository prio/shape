defmodule Shape.Str do
  def validate(obj) do
    Kernel.is_bitstring(obj)
  end

  def desc() do
    "string"
  end
end
