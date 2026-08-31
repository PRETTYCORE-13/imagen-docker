defmodule CrmWeb.Router do
  use CrmWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CrmWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CrmWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/clientes", ClienteLive.Index, :index
    live "/clientes/new", ClienteLive.Form, :new
    live "/clientes/:id", ClienteLive.Show, :show
    live "/clientes/:id/edit", ClienteLive.Form, :edit

    live "/oportunidades", OportunidadLive.Index, :index
    live "/oportunidades/new", OportunidadLive.Form, :new
    live "/oportunidades/:id", OportunidadLive.Show, :show
    live "/oportunidades/:id/edit", OportunidadLive.Form, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", CrmWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:crm, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CrmWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
