defmodule Crm.Oportunidades do
  @moduledoc """
  The Oportunidades context.
  """

  import Ecto.Query, warn: false
  alias Crm.Repo

  alias Crm.Oportunidades.Oportunidad

  @doc """
  Returns the list of oportunidades.

  ## Examples

      iex> list_oportunidades()
      [%Oportunidad{}, ...]

  """
  def list_oportunidades do
    Repo.all(Oportunidad)
  end

  @doc """
  Gets a single oportunidad.

  Raises `Ecto.NoResultsError` if the Oportunidad does not exist.

  ## Examples

      iex> get_oportunidad!(123)
      %Oportunidad{}

      iex> get_oportunidad!(456)
      ** (Ecto.NoResultsError)

  """
  def get_oportunidad!(id), do: Repo.get!(Oportunidad, id)

  @doc """
  Creates a oportunidad.

  ## Examples

      iex> create_oportunidad(%{field: value})
      {:ok, %Oportunidad{}}

      iex> create_oportunidad(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_oportunidad(attrs) do
    %Oportunidad{}
    |> Oportunidad.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a oportunidad.

  ## Examples

      iex> update_oportunidad(oportunidad, %{field: new_value})
      {:ok, %Oportunidad{}}

      iex> update_oportunidad(oportunidad, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_oportunidad(%Oportunidad{} = oportunidad, attrs) do
    oportunidad
    |> Oportunidad.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a oportunidad.

  ## Examples

      iex> delete_oportunidad(oportunidad)
      {:ok, %Oportunidad{}}

      iex> delete_oportunidad(oportunidad)
      {:error, %Ecto.Changeset{}}

  """
  def delete_oportunidad(%Oportunidad{} = oportunidad) do
    Repo.delete(oportunidad)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking oportunidad changes.

  ## Examples

      iex> change_oportunidad(oportunidad)
      %Ecto.Changeset{data: %Oportunidad{}}

  """
  def change_oportunidad(%Oportunidad{} = oportunidad, attrs \\ %{}) do
    Oportunidad.changeset(oportunidad, attrs)
  end
end
