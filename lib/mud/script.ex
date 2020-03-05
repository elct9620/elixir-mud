require Logger

defmodule MUD.Script do
  use GenServer
  use Export.Ruby

  def start_link(path), do: GenServer.start_link(__MODULE__, path, name: __MODULE__)

  def init(path), do: Ruby.start_link(ruby_lib: Path.expand(path)) |> setup
  def setup({:ok, ruby}), do: ruby |> Ruby.call("main", "MUD::create", [self(), ruby])

  def handle_cast({:input, {reaction, state}, action}, ruby) do
    ruby |> :ruby.cast({reaction, state |> MUD.State.get, action})
    {:noreply, ruby}
  end

  def handle_info({:error, reason}, ruby) do
    Logger.error(reason)
    {:noreply, ruby}
  end

  def input(handler, action), do: GenServer.cast(__MODULE__, {:input, handler, action})
end
