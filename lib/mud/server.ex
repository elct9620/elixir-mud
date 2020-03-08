require Logger

defmodule MUD.Server do
  use GenServer

  def start_link(port) do
    GenServer.start_link(__MODULE__, port, name: __MODULE__)
  end

  def init(port) do
    Tide.Worker.load("app")
    Logger.info("MUD Server is listen on 0.0.0.0:#{port}")
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    Task.Supervisor.start_child(MUD.TaskSupervisor, fn -> loop(socket) end)
  end

  defp loop(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(MUD.ConnectionSupervisor, MUD.Connection, :create, [client])
    :ok = :gen_tcp.controlling_process(client, pid)
    loop(socket)
  end
end
