defmodule RewarderWeb.PageController do
  use RewarderWeb, :controller

  alias Enum
  alias Rewarder.Accounts
  alias Rewarder.Transfer
  alias Rewarder.Repo

  def index(conn, _params) do
    data = Transfer.users_with_points()
    if conn.assigns.current_user do

    balance = conn.assigns.current_user.id
    |> Transfer.get_balance!()

    data = Transfer.users_with_points()
    |> Enum.sort_by(fn(p) -> p.user_id end)

    changeset = Transfer.create_changeset()
    render conn, "index.html", data: data, balance: balance, changeset: changeset
    else
    render conn, "index.html", data: data
    end
  end

  def transfer(conn, %{"exchange" => %{"taker_id" => taker_id, "quantity" => quantity}}) do
    Transfer.exchange_points(conn.assigns.current_user.id, String.to_integer(taker_id), String.to_integer(quantity))
    redirect(conn, to: Routes.page_path(conn, :index))
  end

end
