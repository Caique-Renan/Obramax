defmodule TesteobramaxWeb.PageController do
  use TesteobramaxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
