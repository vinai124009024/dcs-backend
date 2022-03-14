defmodule AuthWeb.AccountsLive do
  use AuthWeb, :live_view
  alias Auth.Accounts

  def mount(_params, session, socket) do
    socket = assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(session["user_token"]) end)
    socket = assign_new(socket, :users, fn -> Accounts.get_all_users() end)
    {:ok, socket}
  end

  def handle_event("make_admin", value, socket) do
    u = Enum.find(socket.assigns.users, fn map -> Map.from_struct(map).id == value["value"] end)
    {:ok, _struct} = Accounts.change_user_admin(u)
    {:noreply, redirect(socket, to: "/accounts")}
  end

end
