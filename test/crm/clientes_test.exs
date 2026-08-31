defmodule Crm.ClientesTest do
  use Crm.DataCase

  alias Crm.Clientes

  describe "clientes" do
    alias Crm.Clientes.Cliente

    import Crm.ClientesFixtures

    @invalid_attrs %{nombre: nil, empresa: nil, email: nil, telefono: nil, notas: nil}

    test "list_clientes/0 returns all clientes" do
      cliente = cliente_fixture()
      assert Clientes.list_clientes() == [cliente]
    end

    test "get_cliente!/1 returns the cliente with given id" do
      cliente = cliente_fixture()
      assert Clientes.get_cliente!(cliente.id) == cliente
    end

    test "create_cliente/1 with valid data creates a cliente" do
      valid_attrs = %{nombre: "some nombre", empresa: "some empresa", email: "some email", telefono: "some telefono", notas: "some notas"}

      assert {:ok, %Cliente{} = cliente} = Clientes.create_cliente(valid_attrs)
      assert cliente.nombre == "some nombre"
      assert cliente.empresa == "some empresa"
      assert cliente.email == "some email"
      assert cliente.telefono == "some telefono"
      assert cliente.notas == "some notas"
    end

    test "create_cliente/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clientes.create_cliente(@invalid_attrs)
    end

    test "update_cliente/2 with valid data updates the cliente" do
      cliente = cliente_fixture()
      update_attrs = %{nombre: "some updated nombre", empresa: "some updated empresa", email: "some updated email", telefono: "some updated telefono", notas: "some updated notas"}

      assert {:ok, %Cliente{} = cliente} = Clientes.update_cliente(cliente, update_attrs)
      assert cliente.nombre == "some updated nombre"
      assert cliente.empresa == "some updated empresa"
      assert cliente.email == "some updated email"
      assert cliente.telefono == "some updated telefono"
      assert cliente.notas == "some updated notas"
    end

    test "update_cliente/2 with invalid data returns error changeset" do
      cliente = cliente_fixture()
      assert {:error, %Ecto.Changeset{}} = Clientes.update_cliente(cliente, @invalid_attrs)
      assert cliente == Clientes.get_cliente!(cliente.id)
    end

    test "delete_cliente/1 deletes the cliente" do
      cliente = cliente_fixture()
      assert {:ok, %Cliente{}} = Clientes.delete_cliente(cliente)
      assert_raise Ecto.NoResultsError, fn -> Clientes.get_cliente!(cliente.id) end
    end

    test "change_cliente/1 returns a cliente changeset" do
      cliente = cliente_fixture()
      assert %Ecto.Changeset{} = Clientes.change_cliente(cliente)
    end
  end
end
