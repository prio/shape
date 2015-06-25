defmodule Shape.Atom do
  @moduledoc """
  Uses is_atom to detect if the item is an atom.
  """
  def validate(obj) do
    Kernel.is_atom(obj)
  end

  def desc() do
    "atom"
  end
end
