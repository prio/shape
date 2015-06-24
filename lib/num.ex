defmodule Shape.Num do
  def validate(obj) do
    Kernel.is_number(obj)
  end

  def desc() do
    "number"
  end
end
