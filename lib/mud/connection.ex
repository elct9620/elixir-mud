require Logger

defmodule MUD.Connection do
  def create(socket) do
    {:ok, state} = MUD.State.start_link()
    {:ok, reaction} = MUD.Reaction.start_link()
    Task.async(fn -> output({reaction, state}, socket) end)
    recv({:ok, ""}, {reaction, state}, socket) # Initialize MUD
    serve(socket, {reaction, state})
  end

  defp serve(socket, handler), do: :gen_tcp.recv(socket, 0) |> recv(handler, socket)

  defp recv({:error, reason}, _pid, _socket), do: Logger.warn("Connection error: #{reason}")
  defp recv({:ok, data}, handler, socket), do:  process(data |> String.trim, handler, socket)

  defp process("exit", _pid, socket), do: :gen_tcp.close(socket)
  defp process(data, handler, socket) do
    Task.async(fn -> input(handler, data) end)
    serve(socket, handler)
  end

  defp input(handler, action), do: handler |> MUD.Script.input(action)
  defp output({reactions, state}, socket), do: reactions |> MUD.Reaction.next |> response({reactions, state}, socket)

  defp response({action, args}, {reactions, state}, socket) do
    action |> MUD.Response.handle(args, state, socket)
    output({reactions, state}, socket)
  end
  defp response(nil, handler, socket), do: handler |> output(socket)
end
