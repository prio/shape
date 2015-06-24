defmodule Shape.Ref do
  def validate(obj) do
    Kernel.is_reference(obj)
  end

  def desc() do
    "reference"
  end
end
