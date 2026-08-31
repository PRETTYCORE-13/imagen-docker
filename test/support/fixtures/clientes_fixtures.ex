defmodule Crm.ClientesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Crm.Clientes` context.
  """

  @doc """
  Generate a cliente.
  """
  def cliente_fixture(attrs \\ %{}) do
    {:ok, cliente} =
      attrs
      |> Enum.into(%{
        email: "some email",
        empresa: "some empresa",
        nombre: "some nombre",
        notas: "some notas",
        telefono: "some telefono"
      })
      |> Crm.Clientes.create_cliente()

    cliente
  end
end
