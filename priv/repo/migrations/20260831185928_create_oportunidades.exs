defmodule Crm.Repo.Migrations.CreateOportunidades do
  use Ecto.Migration

  def change do
    create table(:oportunidades) do
      add :titulo, :string
      add :monto, :decimal
      add :etapa, :string
      add :fecha_cierre_estimada, :date
      add :cliente_id, references(:clientes, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:oportunidades, [:cliente_id])
  end
end
