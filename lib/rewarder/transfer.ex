defmodule Rewarder.Transfer do
  @moduledoc """
  The Transfer context.
  """
  import Ecto
  import Ecto.Query, warn: false
  alias Rewarder.Repo

  alias Rewarder.Transfer.{Balance, Exchange}

  def create_changeset_exchange() do
    %Exchange{}
    |> Exchange.changeset()
  end

  def create_changeset_balance() do
    %Balance{}
    |> Balance.changeset()
  end


  def add_points(user) do

    changeset = user
    |> build_assoc(:balances)
    |> Balance.changeset(%{user_id: user.id})

    Repo.insert(changeset)

  end

  def users_with_points() do
    query = from b in "balances",
    inner_join: u in "users",
    where: b.user_id == u.id,
    select: %{points: b.gathered,points_left: b.to_give, email: u.email, user_id: u.id, role: u.role, name: u.name, surname: u.surname, month_points: b.month_points}
    Repo.all(query)
  end

  @doc """
  Returns the list of balances.

  ## Examples

      iex> list_balances()
      [%Balance{}, ...]

  """
  def list_balances() do
    Repo.all(Balance)
  end

  @doc """
  Gets a single balance.

  Raises `Ecto.NoResultsError` if the Balance does not exist.

  ## Examples

      iex> get_balance!(123)
      %Balance{}

      iex> get_balance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_balance!(id), do: Repo.get!(Balance, id)

  @doc """
  Creates a balance.

  ## Examples

      iex> create_balance(%{field: value})
      {:ok, %Balance{}}

      iex> create_balance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_balance(attrs \\ %{}) do
    %Balance{}
    |> Balance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a balance.

  ## Examples

      iex> update_balance(balance, %{field: new_value})
      {:ok, %Balance{}}

      iex> update_balance(balance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_balance(%Balance{} = balance, attrs) do
    balance
    |> Balance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a balance.

  ## Examples

      iex> delete_balance(balance)
      {:ok, %Balance{}}

      iex> delete_balance(balance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_balance(%Balance{} = balance) do
    Repo.delete(balance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking balance changes.

  ## Examples

      iex> change_balance(balance)
      %Ecto.Changeset{data: %Balance{}}

  """
  def change_balance(%Balance{} = balance, attrs \\ %{}) do
    Balance.changeset(balance, attrs)
  end

  alias Rewarder.Transfer.Exchange

  @doc """
  Returns the list of exchanges.

  ## Examples

      iex> list_exchanges()
      [%Exchange{}, ...]

  """
  def list_exchanges do
    Repo.all(Exchange)
  end

  @doc """
  Gets a single exchange.

  Raises `Ecto.NoResultsError` if the Exchange does not exist.

  ## Examples

      iex> get_exchange!(123)
      %Exchange{}

      iex> get_exchange!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exchange!(id), do: Repo.get!(Exchange, id)

  @doc """
  Creates a exchange.

  ## Examples

      iex> create_exchange(%{field: value})
      {:ok, %Exchange{}}

      iex> create_exchange(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exchange(attrs \\ %{}) do
    %Exchange{}
    |> Exchange.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a exchange.

  ## Examples

      iex> update_exchange(exchange, %{field: new_value})
      {:ok, %Exchange{}}

      iex> update_exchange(exchange, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exchange(%Exchange{} = exchange, attrs) do
    exchange
    |> Exchange.changeset(attrs)
    |> Repo.update()
  end


  @doc """
  Deletes a exchange.

  ## Examples

      iex> delete_exchange(exchange)
      {:ok, %Exchange{}}

      iex> delete_exchange(exchange)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exchange(%Exchange{} = exchange) do
    Repo.delete(exchange)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exchange changes.

  ## Examples

      iex> change_exchange(exchange)
      %Ecto.Changeset{data: %Exchange{}}

  """
  def change_exchange(%Exchange{} = exchange, attrs \\ %{}) do
    Exchange.changeset(exchange, attrs)
  end
end
