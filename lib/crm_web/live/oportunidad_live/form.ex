defmodule CrmWeb.OportunidadLive.Form do
  use CrmWeb, :live_view

  alias Crm.Oportunidades
  alias Crm.Oportunidades.Oportunidad

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage oportunidad records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="oportunidad-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:titulo]} type="text" label="Titulo" />
        <.input field={@form[:monto]} type="number" label="Monto" step="any" />
        <.input field={@form[:etapa]} type="text" label="Etapa" />
        <.input field={@form[:fecha_cierre_estimada]} type="date" label="Fecha cierre estimada" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Oportunidad</.button>
          <.button navigate={return_path(@return_to, @oportunidad)}>Cancel</.button>
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
    oportunidad = Oportunidades.get_oportunidad!(id)

    socket
    |> assign(:page_title, "Edit Oportunidad")
    |> assign(:oportunidad, oportunidad)
    |> assign(:form, to_form(Oportunidades.change_oportunidad(oportunidad)))
  end

  defp apply_action(socket, :new, _params) do
    oportunidad = %Oportunidad{}

    socket
    |> assign(:page_title, "New Oportunidad")
    |> assign(:oportunidad, oportunidad)
    |> assign(:form, to_form(Oportunidades.change_oportunidad(oportunidad)))
  end

  @impl true
  def handle_event("validate", %{"oportunidad" => oportunidad_params}, socket) do
    changeset = Oportunidades.change_oportunidad(socket.assigns.oportunidad, oportunidad_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"oportunidad" => oportunidad_params}, socket) do
    save_oportunidad(socket, socket.assigns.live_action, oportunidad_params)
  end

  defp save_oportunidad(socket, :edit, oportunidad_params) do
    case Oportunidades.update_oportunidad(socket.assigns.oportunidad, oportunidad_params) do
      {:ok, oportunidad} ->
        {:noreply,
         socket
         |> put_flash(:info, "Oportunidad updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, oportunidad))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_oportunidad(socket, :new, oportunidad_params) do
    case Oportunidades.create_oportunidad(oportunidad_params) do
      {:ok, oportunidad} ->
        {:noreply,
         socket
         |> put_flash(:info, "Oportunidad created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, oportunidad))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _oportunidad), do: ~p"/oportunidades"
  defp return_path("show", oportunidad), do: ~p"/oportunidades/#{oportunidad}"
end
