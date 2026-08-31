defmodule CrmWeb.OportunidadLiveTest do
  use CrmWeb.ConnCase

  import Phoenix.LiveViewTest
  import Crm.OportunidadesFixtures

  @create_attrs %{titulo: "some titulo", monto: "120.5", etapa: "some etapa", fecha_cierre_estimada: "2026-08-30"}
  @update_attrs %{titulo: "some updated titulo", monto: "456.7", etapa: "some updated etapa", fecha_cierre_estimada: "2026-08-31"}
  @invalid_attrs %{titulo: nil, monto: nil, etapa: nil, fecha_cierre_estimada: nil}
  defp create_oportunidad(_) do
    oportunidad = oportunidad_fixture()

    %{oportunidad: oportunidad}
  end

  describe "Index" do
    setup [:create_oportunidad]

    test "lists all oportunidades", %{conn: conn, oportunidad: oportunidad} do
      {:ok, _index_live, html} = live(conn, ~p"/oportunidades")

      assert html =~ "Oportunidades"
      assert html =~ oportunidad.titulo
    end

    test "saves new oportunidad", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/oportunidades")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "Nueva oportunidad")
               |> render_click()
               |> follow_redirect(conn, ~p"/oportunidades/new")

      assert render(form_live) =~ "Nueva oportunidad"

      assert form_live
             |> form("#oportunidad-form", oportunidad: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#oportunidad-form", oportunidad: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/oportunidades")

      html = render(index_live)
      assert html =~ "Oportunidad creada correctamente"
      assert html =~ "some titulo"
    end

    test "updates oportunidad in listing", %{conn: conn, oportunidad: oportunidad} do
      {:ok, index_live, _html} = live(conn, ~p"/oportunidades")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#oportunidades-#{oportunidad.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/oportunidades/#{oportunidad}/edit")

      assert render(form_live) =~ "Editar oportunidad"

      assert form_live
             |> form("#oportunidad-form", oportunidad: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#oportunidad-form", oportunidad: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/oportunidades")

      html = render(index_live)
      assert html =~ "Oportunidad actualizada correctamente"
      assert html =~ "some updated titulo"
    end

    test "deletes oportunidad in listing", %{conn: conn, oportunidad: oportunidad} do
      {:ok, index_live, _html} = live(conn, ~p"/oportunidades")

      assert index_live |> element("#oportunidades-#{oportunidad.id} a", "Eliminar") |> render_click()
      refute has_element?(index_live, "#oportunidades-#{oportunidad.id}")
    end
  end

  describe "Show" do
    setup [:create_oportunidad]

    test "displays oportunidad", %{conn: conn, oportunidad: oportunidad} do
      {:ok, _show_live, html} = live(conn, ~p"/oportunidades/#{oportunidad}")

      assert html =~ "Oportunidad #{oportunidad.id}"
      assert html =~ oportunidad.titulo
    end

    test "updates oportunidad and returns to show", %{conn: conn, oportunidad: oportunidad} do
      {:ok, show_live, _html} = live(conn, ~p"/oportunidades/#{oportunidad}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/oportunidades/#{oportunidad}/edit?return_to=show")

      assert render(form_live) =~ "Editar oportunidad"

      assert form_live
             |> form("#oportunidad-form", oportunidad: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#oportunidad-form", oportunidad: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/oportunidades/#{oportunidad}")

      html = render(show_live)
      assert html =~ "Oportunidad actualizada correctamente"
      assert html =~ "some updated titulo"
    end
  end
end
