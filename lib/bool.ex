defmodule Shape.Bool do
  def validate(obj) do
    Kernel.is_boolean(obj)
  end

  def desc() do
    "boolean"
  end
end
