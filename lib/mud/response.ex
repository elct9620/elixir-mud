defmodule MUD.Response do
  # Socket
  def handle(:input, _args, _pid, socket), do: socket |> :gen_tcp.send("> ")
  def handle(:msg, message, _pid, socket), do: socket |> :gen_tcp.send("#{message}\r\n")
  def handle(:exit, _args, _pid, socket), do: socket |> :gen_tcp.close

  # State
  def handle(:next, [amount | _], pid, _socket), do: pid |> MUD.State.next(amount)
  def handle(:jmp, [index | _], pid, _socket), do: pid |> MUD.State.jump(index)
end
