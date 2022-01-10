defmodule Testeobramax.Repo do
  use Ecto.Repo,
    otp_app: :testeobramax,
    adapter: Ecto.Adapters.Postgres
end
