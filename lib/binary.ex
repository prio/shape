defmodule Shape.Binary do
  def validate(obj) do
    Kernel.is_binary(obj)
  end

  def desc() do
    "binary"
  end
end
