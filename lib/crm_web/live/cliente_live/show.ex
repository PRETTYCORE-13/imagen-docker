defmodule CrmWeb.ClienteLive.Show do
  use CrmWeb, :live_view

  alias Crm.Clientes

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Cliente {@cliente.id}
        <:subtitle>Detalle del cliente.</:subtitle>
        <:actions>
          <.button navigate={~p"/clientes"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/clientes/#{@cliente}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Editar cliente
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Nombre">{@cliente.nombre}</:item>
        <:item title="Empresa">{@cliente.empresa}</:item>
        <:item title="Email">{@cliente.email}</:item>
        <:item title="Telefono">{@cliente.telefono}</:item>
        <:item title="Notas">{@cliente.notas}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Cliente")
     |> assign(:cliente, Clientes.get_cliente!(id))}
  end
end
