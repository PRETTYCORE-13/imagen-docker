defmodule Crm.OportunidadesTest do
  use Crm.DataCase

  alias Crm.Oportunidades

  describe "oportunidades" do
    alias Crm.Oportunidades.Oportunidad

    import Crm.OportunidadesFixtures

    @invalid_attrs %{titulo: nil, monto: nil, etapa: nil, fecha_cierre_estimada: nil}

    test "list_oportunidades/0 returns all oportunidades" do
      oportunidad = oportunidad_fixture()
      assert Oportunidades.list_oportunidades() == [oportunidad]
    end

    test "get_oportunidad!/1 returns the oportunidad with given id" do
      oportunidad = oportunidad_fixture()
      assert Oportunidades.get_oportunidad!(oportunidad.id) == oportunidad
    end

    test "create_oportunidad/1 with valid data creates a oportunidad" do
      valid_attrs = %{titulo: "some titulo", monto: "120.5", etapa: "some etapa", fecha_cierre_estimada: ~D[2026-08-30]}

      assert {:ok, %Oportunidad{} = oportunidad} = Oportunidades.create_oportunidad(valid_attrs)
      assert oportunidad.titulo == "some titulo"
      assert oportunidad.monto == Decimal.new("120.5")
      assert oportunidad.etapa == "some etapa"
      assert oportunidad.fecha_cierre_estimada == ~D[2026-08-30]
    end

    test "create_oportunidad/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Oportunidades.create_oportunidad(@invalid_attrs)
    end

    test "update_oportunidad/2 with valid data updates the oportunidad" do
      oportunidad = oportunidad_fixture()
      update_attrs = %{titulo: "some updated titulo", monto: "456.7", etapa: "some updated etapa", fecha_cierre_estimada: ~D[2026-08-31]}

      assert {:ok, %Oportunidad{} = oportunidad} = Oportunidades.update_oportunidad(oportunidad, update_attrs)
      assert oportunidad.titulo == "some updated titulo"
      assert oportunidad.monto == Decimal.new("456.7")
      assert oportunidad.etapa == "some updated etapa"
      assert oportunidad.fecha_cierre_estimada == ~D[2026-08-31]
    end

    test "update_oportunidad/2 with invalid data returns error changeset" do
      oportunidad = oportunidad_fixture()
      assert {:error, %Ecto.Changeset{}} = Oportunidades.update_oportunidad(oportunidad, @invalid_attrs)
      assert oportunidad == Oportunidades.get_oportunidad!(oportunidad.id)
    end

    test "delete_oportunidad/1 deletes the oportunidad" do
      oportunidad = oportunidad_fixture()
      assert {:ok, %Oportunidad{}} = Oportunidades.delete_oportunidad(oportunidad)
      assert_raise Ecto.NoResultsError, fn -> Oportunidades.get_oportunidad!(oportunidad.id) end
    end

    test "change_oportunidad/1 returns a oportunidad changeset" do
      oportunidad = oportunidad_fixture()
      assert %Ecto.Changeset{} = Oportunidades.change_oportunidad(oportunidad)
    end
  end
end
