require Logger

defmodule RPG do
  use Application

  @moduledoc """
  Documentation for `RPG`.
  """

  def start(_type, _args) do
    Logger.info("RPG Server is starting...")

    port = System.get_env("PORT") || 6666

    children = [
      {RPG.Script, "lib/scripts"},
      {Task.Supervisor, name: RPG.TaskSupervisor},
      {RPG.Server, port},
    ]
    options = [strategy: :one_for_one, name: RPG.Supervisor]

    Supervisor.start_link(children, options)
  end
end
