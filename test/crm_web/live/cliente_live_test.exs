defmodule CrmWeb.ClienteLiveTest do
  use CrmWeb.ConnCase

  import Phoenix.LiveViewTest
  import Crm.ClientesFixtures

  @create_attrs %{nombre: "some nombre", empresa: "some empresa", email: "some email", telefono: "some telefono", notas: "some notas"}
  @update_attrs %{nombre: "some updated nombre", empresa: "some updated empresa", email: "some updated email", telefono: "some updated telefono", notas: "some updated notas"}
  @invalid_attrs %{nombre: nil, empresa: nil, email: nil, telefono: nil, notas: nil}
  defp create_cliente(_) do
    cliente = cliente_fixture()

    %{cliente: cliente}
  end

  describe "Index" do
    setup [:create_cliente]

    test "lists all clientes", %{conn: conn, cliente: cliente} do
      {:ok, _index_live, html} = live(conn, ~p"/clientes")

      assert html =~ "Listing Clientes"
      assert html =~ cliente.nombre
    end

    test "saves new cliente", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/clientes")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Cliente")
               |> render_click()
               |> follow_redirect(conn, ~p"/clientes/new")

      assert render(form_live) =~ "New Cliente"

      assert form_live
             |> form("#cliente-form", cliente: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#cliente-form", cliente: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/clientes")

      html = render(index_live)
      assert html =~ "Cliente created successfully"
      assert html =~ "some nombre"
    end

    test "updates cliente in listing", %{conn: conn, cliente: cliente} do
      {:ok, index_live, _html} = live(conn, ~p"/clientes")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#clientes-#{cliente.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/clientes/#{cliente}/edit")

      assert render(form_live) =~ "Edit Cliente"

      assert form_live
             |> form("#cliente-form", cliente: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#cliente-form", cliente: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/clientes")

      html = render(index_live)
      assert html =~ "Cliente updated successfully"
      assert html =~ "some updated nombre"
    end

    test "deletes cliente in listing", %{conn: conn, cliente: cliente} do
      {:ok, index_live, _html} = live(conn, ~p"/clientes")

      assert index_live |> element("#clientes-#{cliente.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#clientes-#{cliente.id}")
    end
  end

  describe "Show" do
    setup [:create_cliente]

    test "displays cliente", %{conn: conn, cliente: cliente} do
      {:ok, _show_live, html} = live(conn, ~p"/clientes/#{cliente}")

      assert html =~ "Show Cliente"
      assert html =~ cliente.nombre
    end

    test "updates cliente and returns to show", %{conn: conn, cliente: cliente} do
      {:ok, show_live, _html} = live(conn, ~p"/clientes/#{cliente}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/clientes/#{cliente}/edit?return_to=show")

      assert render(form_live) =~ "Edit Cliente"

      assert form_live
             |> form("#cliente-form", cliente: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#cliente-form", cliente: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/clientes/#{cliente}")

      html = render(show_live)
      assert html =~ "Cliente updated successfully"
      assert html =~ "some updated nombre"
    end
  end
end
