defmodule Rewarder.Repo do
  use Ecto.Repo,
    otp_app: :rewarder,
    adapter: Ecto.Adapters.Postgres
end
