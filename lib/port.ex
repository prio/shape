defmodule Shape.Port do
  def validate(obj) do
    Kernel.is_port(obj)
  end

  def desc() do
    "port"
  end
end
