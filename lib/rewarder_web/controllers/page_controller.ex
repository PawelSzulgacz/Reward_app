defmodule RewarderWeb.PageController do
  use RewarderWeb, :controller

  alias Enum
  alias Rewarder.Transfer

  def index(conn, _params) do
    data = Transfer.users_with_points()
    if conn.assigns.current_user do

    data = Transfer.users_with_points()
    |> Enum.sort_by(fn(p) -> p.user_id end)

    balance = conn.assigns.current_user.id
    |> Transfer.get_balance!()

    conn = put_session(conn, :to_give, balance.to_give)
    conn = put_session(conn, :gathered, balance.gathered)

    changeset = Transfer.create_changeset_exchange()

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
