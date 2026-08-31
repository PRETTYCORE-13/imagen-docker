defmodule Crm.Repo.Migrations.CreateClientes do
  use Ecto.Migration

  def change do
    create table(:clientes) do
      add :nombre, :string
      add :empresa, :string
      add :email, :string
      add :telefono, :string
      add :notas, :text

      timestamps(type: :utc_datetime)
    end
  end
end
