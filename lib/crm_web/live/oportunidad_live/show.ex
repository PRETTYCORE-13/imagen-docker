defmodule CrmWeb.OportunidadLive.Show do
  use CrmWeb, :live_view

  alias Crm.Oportunidades

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Oportunidad {@oportunidad.id}
        <:subtitle>Detalle de la oportunidad.</:subtitle>
        <:actions>
          <.button navigate={~p"/oportunidades"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/oportunidades/#{@oportunidad}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Editar oportunidad
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Titulo">{@oportunidad.titulo}</:item>
        <:item title="Monto">{@oportunidad.monto}</:item>
        <:item title="Etapa">{@oportunidad.etapa}</:item>
        <:item title="Fecha cierre estimada">{@oportunidad.fecha_cierre_estimada}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Oportunidad")
     |> assign(:oportunidad, Oportunidades.get_oportunidad!(id))}
  end
end
