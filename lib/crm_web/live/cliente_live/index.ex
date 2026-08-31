defmodule CrmWeb.ClienteLive.Index do
  use CrmWeb, :live_view

  alias Crm.Clientes

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Clientes
        <:actions>
          <.button variant="primary" navigate={~p"/clientes/new"}>
            <.icon name="hero-plus" /> Nuevo cliente
          </.button>
        </:actions>
      </.header>

      <.table
        id="clientes"
        rows={@streams.clientes}
        row_click={fn {_id, cliente} -> JS.navigate(~p"/clientes/#{cliente}") end}
      >
        <:col :let={{_id, cliente}} label="Nombre">{cliente.nombre}</:col>
        <:col :let={{_id, cliente}} label="Empresa">{cliente.empresa}</:col>
        <:col :let={{_id, cliente}} label="Email">{cliente.email}</:col>
        <:col :let={{_id, cliente}} label="Telefono">{cliente.telefono}</:col>
        <:col :let={{_id, cliente}} label="Notas">{cliente.notas}</:col>
        <:action :let={{_id, cliente}}>
          <div class="sr-only">
            <.link navigate={~p"/clientes/#{cliente}"}>Ver</.link>
          </div>
          <.link navigate={~p"/clientes/#{cliente}/edit"}>Editar</.link>
        </:action>
        <:action :let={{id, cliente}}>
          <.link
            phx-click={JS.push("delete", value: %{id: cliente.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Clientes")
     |> stream(:clientes, list_clientes())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cliente = Clientes.get_cliente!(id)
    {:ok, _} = Clientes.delete_cliente(cliente)

    {:noreply, stream_delete(socket, :clientes, cliente)}
  end

  defp list_clientes() do
    Clientes.list_clientes()
  end
end
