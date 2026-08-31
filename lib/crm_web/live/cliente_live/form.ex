defmodule CrmWeb.ClienteLive.Form do
  use CrmWeb, :live_view

  alias Crm.Clientes
  alias Crm.Clientes.Cliente

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Alta y edición de clientes.</:subtitle>
      </.header>

      <.form for={@form} id="cliente-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:nombre]} type="text" label="Nombre" />
        <.input field={@form[:empresa]} type="text" label="Empresa" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:telefono]} type="text" label="Telefono" />
        <.input field={@form[:notas]} type="textarea" label="Notas" />
        <footer>
          <.button phx-disable-with="Guardando..." variant="primary">Guardar</.button>
          <.button navigate={return_path(@return_to, @cliente)}>Cancelar</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    cliente = Clientes.get_cliente!(id)

    socket
    |> assign(:page_title, "Editar cliente")
    |> assign(:cliente, cliente)
    |> assign(:form, to_form(Clientes.change_cliente(cliente)))
  end

  defp apply_action(socket, :new, _params) do
    cliente = %Cliente{}

    socket
    |> assign(:page_title, "Nuevo cliente")
    |> assign(:cliente, cliente)
    |> assign(:form, to_form(Clientes.change_cliente(cliente)))
  end

  @impl true
  def handle_event("validate", %{"cliente" => cliente_params}, socket) do
    changeset = Clientes.change_cliente(socket.assigns.cliente, cliente_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"cliente" => cliente_params}, socket) do
    save_cliente(socket, socket.assigns.live_action, cliente_params)
  end

  defp save_cliente(socket, :edit, cliente_params) do
    case Clientes.update_cliente(socket.assigns.cliente, cliente_params) do
      {:ok, cliente} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cliente actualizado correctamente")
         |> push_navigate(to: return_path(socket.assigns.return_to, cliente))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_cliente(socket, :new, cliente_params) do
    case Clientes.create_cliente(cliente_params) do
      {:ok, cliente} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cliente creado correctamente")
         |> push_navigate(to: return_path(socket.assigns.return_to, cliente))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _cliente), do: ~p"/clientes"
  defp return_path("show", cliente), do: ~p"/clientes/#{cliente}"
end
