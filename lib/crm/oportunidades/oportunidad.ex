defmodule Crm.Oportunidades.Oportunidad do
  use Ecto.Schema
  import Ecto.Changeset

  schema "oportunidades" do
    field :titulo, :string
    field :monto, :decimal
    field :etapa, :string
    field :fecha_cierre_estimada, :date
    field :cliente_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(oportunidad, attrs) do
    oportunidad
    |> cast(attrs, [:titulo, :monto, :etapa, :fecha_cierre_estimada])
    |> validate_required([:titulo, :monto, :etapa, :fecha_cierre_estimada])
  end
end
