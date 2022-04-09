defmodule RewarderWeb.PageController do
  use RewarderWeb, :controller

  alias Enum
  alias Rewarder.Transfer

  def index(conn, _params) do
    data = data_about_users_sorted()
    cond do
      conn.assigns.current_user ->
        balance = user_points(conn)
        changeset = Transfer.create_changeset_exchange()
        conn = put_session(conn, :to_give, balance.to_give)
        conn = put_session(conn, :gathered, balance.gathered)

        render conn, "index.html", data: data, balance: balance, changeset: changeset

      true -> render conn, "index.html", data: data
    end
  end

  def admin_index(conn, _params) do
    data = data_about_users_sorted()
    changeset = Transfer.create_changeset_balance()
    render conn, "admin_index.html", data: data, changeset: changeset
  end

  def data_about_users_sorted() do
    Transfer.users_with_points()
    |> Enum.sort_by(fn(p) -> p.user_id end)
  end

  def user_points(conn) do
    conn.assigns.current_user.id
    |> Transfer.get_balance!()
  end


  def transfer(conn, %{"exchange" => %{"taker_id" => taker_id, "quantity" => quantity}}) do
    Transfer.exchange_points(conn.assigns.current_user.id, String.to_integer(taker_id), String.to_integer(quantity))
    redirect(conn, to: Routes.page_path(conn, :index))
  end

  def update(conn, %{"balance" => %{"user_id" => user_id, "month_base" => points_by_month}}) do
    transfer = Transfer.get_balance!(user_id)
    IO.puts("+++")
    IO.inspect(user_id)
    IO.puts("++++++++++++++++++")
    case Transfer.update_balance(transfer, %{"month_points" => points_by_month}) do
      {:ok, _balance} ->
        conn
        |> put_flash(:info, "Base points updated successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Something went wrong")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
