defmodule RewarderWeb.PageController do
  use RewarderWeb, :controller
  alias Enum
  alias Rewarder.Accounts
  alias Rewarder.Transfer
  def index(conn, _params) do

    balance = conn.assigns.current_user.id
    |> Transfer.get_balance!()

    data = Transfer.users_with_points()
    IO.puts("++")
    IO.inspect(balance)
    IO.puts("++")
    render conn, "index.html", data: data, balance: balance
  end
end
