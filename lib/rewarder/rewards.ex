defmodule Rewarder.Rewards do
  @moduledoc """
  The Rewards context.
  """
  import Ecto
  import Ecto.Query, warn: false
  alias Rewarder.Repo
  alias Rewarder.Transfer
  alias Rewarder.Rewards.{Prize, Prize_history}

  def add_prize(user_id, reward_id) do
    %Prize_history{}
    |> Prize_history.changeset(%{reward_id: reward_id, user_id: user_id})
    |> Repo.insert()

    points = get_prize!(reward_id)
    Transfer.edit_points_gathered(user_id, -points.cost)
  end


  def prizes_history(id) do
    query = from h in "prize_histories",
    inner_join: p in "prizes",
    where: h.reward_id == p.id and ^id == h.user_id,
    select: %{description: p.description, cost: p.cost, when: h.inserted_at}
    Repo.all(query)
  end

  def prizes_history_month(month) do
    query = from h in "prize_histories",
    inner_join: p in "prizes",
    where: h.reward_id == p.id and fragment("date_part('month', ?)",h.inserted_at) == ^month,
    select: %{description: p.description, cost: p.cost, when: h.inserted_at}
    Repo.all(query)
  end

  def create_changeset_prize_history() do
    %Prize_history{}
    |> Prize_history.changeset()
  end

  @doc """
  Returns the list of prizes.

  ## Examples

      iex> list_prizes()
      [%Prize{}, ...]

  """
  def list_prizes do
    Repo.all(Prize)
  end

  @doc """
  Gets a single prize.

  Raises `Ecto.NoResultsError` if the Prize does not exist.

  ## Examples

      iex> get_prize!(123)
      %Prize{}

      iex> get_prize!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prize!(id), do: Repo.get!(Prize, id)

  @doc """
  Creates a prize.

  ## Examples

      iex> create_prize(%{field: value})
      {:ok, %Prize{}}

      iex> create_prize(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prize(attrs \\ %{}) do
    %Prize{}
    |> Prize.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a prize.

  ## Examples

      iex> update_prize(prize, %{field: new_value})
      {:ok, %Prize{}}

      iex> update_prize(prize, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prize(%Prize{} = prize, attrs) do
    prize
    |> Prize.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a prize.

  ## Examples

      iex> delete_prize(prize)
      {:ok, %Prize{}}

      iex> delete_prize(prize)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prize(%Prize{} = prize) do
    Repo.delete(prize)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prize changes.

  ## Examples

      iex> change_prize(prize)
      %Ecto.Changeset{data: %Prize{}}

  """
  def change_prize(%Prize{} = prize, attrs \\ %{}) do
    Prize.changeset(prize, attrs)
  end

  alias Rewarder.Rewards.Prize_history

  @doc """
  Returns the list of prize_histories.

  ## Examples

      iex> list_prize_histories()
      [%Prize_history{}, ...]

  """
  def list_prize_histories do
    Repo.all(Prize_history)
  end

  @doc """
  Gets a single prize_history.

  Raises `Ecto.NoResultsError` if the Prize history does not exist.

  ## Examples

      iex> get_prize_history!(123)
      %Prize_history{}

      iex> get_prize_history!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prize_history!(id), do: Repo.get!(Prize_history, id)

  @doc """
  Creates a prize_history.

  ## Examples

      iex> create_prize_history(%{field: value})
      {:ok, %Prize_history{}}

      iex> create_prize_history(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prize_history(attrs \\ %{}) do
    %Prize_history{}
    |> Prize_history.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a prize_history.

  ## Examples

      iex> update_prize_history(prize_history, %{field: new_value})
      {:ok, %Prize_history{}}

      iex> update_prize_history(prize_history, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prize_history(%Prize_history{} = prize_history, attrs) do
    prize_history
    |> Prize_history.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a prize_history.

  ## Examples

      iex> delete_prize_history(prize_history)
      {:ok, %Prize_history{}}

      iex> delete_prize_history(prize_history)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prize_history(%Prize_history{} = prize_history) do
    Repo.delete(prize_history)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prize_history changes.

  ## Examples

      iex> change_prize_history(prize_history)
      %Ecto.Changeset{data: %Prize_history{}}

  """
  def change_prize_history(%Prize_history{} = prize_history, attrs \\ %{}) do
    Prize_history.changeset(prize_history, attrs)
  end
end
