require Logger

defmodule RPG.Connection do
  def create(socket) do
    {:ok, pid} = RPG.State.start_link()
    recv({:ok, ""}, pid, socket) # Initialize MUD
    serve(socket, pid)
  end

  defp serve(socket, pid) do
    :gen_tcp.recv(socket, 0) |> recv(pid, socket)
  end

  defp recv({:error, reason}, _pid, _socket), do: Logger.warn("Connection error: #{reason}")
  defp recv({:ok, data}, pid, socket), do:  process(data |> String.trim, pid, socket)

  defp process("exit", _pid, socket), do: :gen_tcp.close(socket)
  defp process(data, pid, socket) do
    Task.async(fn -> input(data, pid, socket) end)
    serve(socket, pid)
  end

  defp input(action, pid, socket) do
    pid
    |> RPG.State.get
    |> Map.to_list
    |> RPG.Script.input(action)
    |> response(pid, socket)

    :gen_tcp.send(socket, "\r\n> ")
  end

  defp response({:error, reason}, _pid, socket), do: :gen_tcp.send(socket, "[!] #{reason}")
  defp response({:ok, actions}, pid, socket), do: actions |> Enum.each(fn [action | args] -> RPG.Response.handle(action, args, pid, socket) end)
end
