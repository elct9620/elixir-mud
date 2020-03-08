require Logger

defmodule MUD.Connection do
  def create(socket) do
    {:ok, agent} = Tide.Agent.start_link()
    Task.async(fn -> output(agent, socket) end)
    initialize_state(agent |> Tide.Agent.state)
    recv({:ok, ""}, agent, socket) # Initialize MUD
    serve(socket, agent)
  end

  defp serve(socket, agent), do: :gen_tcp.recv(socket, 0) |> recv(agent, socket)

  defp recv({:error, reason}, _pid, _socket), do: Logger.warn("Connection error: #{reason}")
  defp recv({:ok, data}, agent, socket), do:  process(data |> String.trim, agent, socket)

  defp process("exit", _pid, socket), do: :gen_tcp.close(socket)
  defp process(data, agent, socket) do
    Task.async(fn -> input(agent, data) end)
    serve(socket, agent)
  end

  defp input(agent, action), do: agent |> Tide.Agent.emit("input", [action])
  defp output(agent, socket), do: agent |> Tide.Agent.reaction |> Tide.Reaction.next |> response(agent, socket)

  defp response({action, args}, agent, socket) do
    action |> MUD.Response.handle(args, agent |> Tide.Agent.state, socket)
    output(agent, socket)
  end
  defp response(nil, agent, socket), do: agent |> output(socket)

  defp initialize_state(state) do
    state |> Tide.State.put(:chapter, 1)
    state |> Tide.State.put(:dialog, 0)
  end
end
