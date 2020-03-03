defmodule RPG.Response do
  def handle(:msg, message, _pid, socket), do: socket |> :gen_tcp.send(message)
  def handle(:next, [amount | _], pid, _socket), do: pid |> RPG.State.next(amount)
  def handle(:jmp, [index | _], pid, _socket), do: pid |> RPG.State.jump(index)
end
