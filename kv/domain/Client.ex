defmodule Client do
  Use Agent

  def get_something(agent) do
    Agent.get(agent, fn state -> do_something_expensive(state) end)
  end

  # Compute in the agent/client
  def get_something(agent) do
    Agent.get(agent, & &1) |> do_something_expensive()
  end

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value 0, name: Client)
  end

  def value do
    Agent.get(Client, & &1)
  end

  def increment do
    Agent.update(Client, &(&1+1))
  end
end
