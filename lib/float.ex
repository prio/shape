defmodule Shape.Float do
  def validate(obj) do
    Kernel.is_float(obj)
  end

  def desc() do
    "float"
  end
end
