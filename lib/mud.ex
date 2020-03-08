require Logger

defmodule MUD do
  use Application

  @moduledoc """
  Documentation for `MUD`.
  """

  def start(_type, _args) do
    Logger.info("MUD Server is starting...")

    port = System.get_env("PORT") || 6666

    children = [
      {Tide.Worker, :code.priv_dir(:mud) |> Path.join("ruby") },
      {Task.Supervisor, name: MUD.TaskSupervisor},
      {Task.Supervisor, name: MUD.ConnectionSupervisor},
      {MUD.Server, port},
    ]
    options = [strategy: :one_for_one, name: MUD.Supervisor]

    Supervisor.start_link(children, options)
  end
end
