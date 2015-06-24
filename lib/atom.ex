defmodule Shape.Atom do
  def validate(obj) do
    Kernel.is_atom(obj)
  end

  def desc() do
    "atom"
  end
end
