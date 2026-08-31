defmodule Crm.Clientes.Cliente do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clientes" do
    field :nombre, :string
    field :empresa, :string
    field :email, :string
    field :telefono, :string
    field :notas, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cliente, attrs) do
    cliente
    |> cast(attrs, [:nombre, :empresa, :email, :telefono, :notas])
    |> validate_required([:nombre, :empresa, :email, :telefono, :notas])
  end
end
