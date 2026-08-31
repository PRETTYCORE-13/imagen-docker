defmodule Crm.OportunidadesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Crm.Oportunidades` context.
  """

  @doc """
  Generate a oportunidad.
  """
  def oportunidad_fixture(attrs \\ %{}) do
    {:ok, oportunidad} =
      attrs
      |> Enum.into(%{
        etapa: "some etapa",
        fecha_cierre_estimada: ~D[2026-08-30],
        monto: "120.5",
        titulo: "some titulo"
      })
      |> Crm.Oportunidades.create_oportunidad()

    oportunidad
  end
end
