defmodule CrmWeb.OportunidadLive.Index do
  use CrmWeb, :live_view

  alias Crm.Oportunidades

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Oportunidades
        <:actions>
          <.button variant="primary" navigate={~p"/oportunidades/new"}>
            <.icon name="hero-plus" /> Nueva oportunidad
          </.button>
        </:actions>
      </.header>

      <.table
        id="oportunidades"
        rows={@streams.oportunidades}
        row_click={fn {_id, oportunidad} -> JS.navigate(~p"/oportunidades/#{oportunidad}") end}
      >
        <:col :let={{_id, oportunidad}} label="Titulo">{oportunidad.titulo}</:col>
        <:col :let={{_id, oportunidad}} label="Monto">{oportunidad.monto}</:col>
        <:col :let={{_id, oportunidad}} label="Etapa">{oportunidad.etapa}</:col>
        <:col :let={{_id, oportunidad}} label="Fecha cierre estimada">{oportunidad.fecha_cierre_estimada}</:col>
        <:action :let={{_id, oportunidad}}>
          <div class="sr-only">
            <.link navigate={~p"/oportunidades/#{oportunidad}"}>Ver</.link>
          </div>
          <.link navigate={~p"/oportunidades/#{oportunidad}/edit"}>Editar</.link>
        </:action>
        <:action :let={{id, oportunidad}}>
          <.link
            phx-click={JS.push("delete", value: %{id: oportunidad.id}) |> hide("##{id}")}
            data-confirm="¿Estás seguro?"
          >
            Eliminar
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Oportunidades")
     |> stream(:oportunidades, list_oportunidades())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    oportunidad = Oportunidades.get_oportunidad!(id)
    {:ok, _} = Oportunidades.delete_oportunidad(oportunidad)

    {:noreply, stream_delete(socket, :oportunidades, oportunidad)}
  end

  defp list_oportunidades() do
    Oportunidades.list_oportunidades()
  end
end
