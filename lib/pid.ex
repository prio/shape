defmodule Shape.Pid do
  def validate(obj) do
    Kernel.is_pid(obj)
  end

  def desc() do
    "pid"
  end
end
