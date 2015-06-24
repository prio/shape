defmodule Shape.Int do
  def validate(obj) do
    Kernel.is_integer(obj)
  end

  def desc() do
    "integer"
  end
end
