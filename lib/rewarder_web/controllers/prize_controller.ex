defmodule RewarderWeb.PrizeController do
  use RewarderWeb, :controller

  alias Rewarder.Rewards
  alias Rewarder.Rewards.Prize
  alias Rewarder.Transfer

  def index(conn, _params) do

    prizes = list_of_prizes_sorted()
    balance = users_info(conn)
    conn = put_session(conn, :to_give, balance.to_give)
    conn = put_session(conn, :gathered, balance.gathered)
    render conn, "index.html", prizes: prizes

  end

  def admin_index(conn, _params) do
    prizes = list_of_prizes_sorted()
    render conn, "admin_index.html", prizes: prizes
  end

  def list_of_prizes_sorted() do
    Rewards.list_prizes()
    |> Enum.sort_by(fn(p) -> p.id end)
  end

  def users_info(conn) do
    conn.assigns.current_user.id
    |> Transfer.get_balance!()
  end

  def turn_prize_on(conn, %{"id" => id}) do
    prize = Rewards.get_prize!(id)
    case Rewards.update_prize(prize, %{"active" => true}) do
      {:ok, _prize} ->
        conn
        |> put_flash(:info, "Prized turned on, successfully")
        |> redirect(to: Routes.prize_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        redirect(conn, to: Routes.prize_path(conn, :index))
    end
  end

  def turn_prize_off(conn, %{"id" => id}) do
    prize = Rewards.get_prize!(id)
    case Rewards.update_prize(prize, %{"active" => false}) do
      {:ok, _prize} ->
        conn
        |> put_flash(:info, "Prized turned off, successfully")
        |> redirect(to: Routes.prize_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        redirect(conn, to: Routes.prize_path(conn, :index))
    end

    redirect(conn, to: Routes.prize_path(conn, :index))
  end

  def history(conn, _params) do
    data = Rewards.prizes_history(conn.assigns.current_user.id)

    render conn, "history.html", data: data
  end

  def history_by_month(conn, %{"prize_history" => %{"when" => %{"month" => month}}}) do
    data = Rewards.prizes_history_month(String.to_integer(month))
    changeset = Rewards.create_changeset_prize_history()
    render conn, "history_by_month.html", data: data, changeset: changeset
  end

  def history_by_month(conn, params) do
    data = Rewards.prizes_history_month(1)
    changeset = Rewards.create_changeset_prize_history()
    render conn, "history_by_month.html", data: data, changeset: changeset
  end

  def acquire(conn, %{"id" => id}) do
    case Rewards.add_prize(conn.assigns.current_user.id, id) do
      {:ok, _prize} ->
        conn
        |> put_flash(:info, "Congratulation, you got a reward!")
        |> redirect(to: Routes.prize_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

    redirect(conn, to: Routes.prize_path(conn, :index))
  end

  def new(conn, _params) do
    changeset = Rewards.change_prize(%Prize{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"prize" => prize_params}) do
    case Rewards.create_prize(prize_params) do
      {:ok, _prize} ->
        conn
        |> put_flash(:info, "Prize created successfully.")
        |> redirect(to: Routes.prize_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    prize = Rewards.get_prize!(id)
    render(conn, "show.html", prize: prize)
  end

  def edit(conn, %{"id" => id}) do
    prize = Rewards.get_prize!(id)
    changeset = Rewards.change_prize(prize)
    render(conn, "edit.html", prize: prize, changeset: changeset)
  end

  def update(conn, %{"id" => id, "prize" => prize_params}) do
    prize = Rewards.get_prize!(id)
    case Rewards.update_prize(prize, prize_params) do
      {:ok, prize} ->
        conn
        |> put_flash(:info, "Prize updated successfully.")
        |> redirect(to: Routes.prize_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", prize: prize, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    prize = Rewards.get_prize!(id)
    {:ok, _prize} = Rewards.delete_prize(prize)

    conn
    |> put_flash(:info, "Prize deleted successfully.")
    |> redirect(to: Routes.prize_path(conn, :index))
  end
end
