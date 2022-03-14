defmodule AuthWeb.PageLive do
  use AuthWeb, :live_view
  alias Auth.Accounts

  def mount(_params, session, socket) do
    socket = assign(socket, :movie_name, "")
    socket = assign(socket, :edit_review, "")
    socket = assign(socket, :review_input, "")
    socket = assign(socket, :movie_tile, nil)
    socket = assign(socket, :movie_tile_toggle, false)
    socket = assign(socket, :movie_list, Accounts.get_movies())
    socket = assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(session["user_token"]) end)
    {:ok, socket}
  end

  def handle_event("movie_input", value, socket) do
    socket = assign(socket, :movie_name, value["value"])
    {:noreply, socket}
  end

  def handle_event("add_movie", _value, socket) do
    Accounts.add_movie(%{name: socket.assigns.movie_name, author: socket.assigns.current_user.email})
    socket = assign(socket, :movie_list, Accounts.get_movies())
    {:noreply, socket}
  end

  def handle_event("delete_movie", _value, socket) do
    {:ok, _struct} = Accounts.del_movie(socket.assigns.movie_tile)
    socket = assign(socket, :movie_list, Accounts.get_movies())
    socket = assign(socket, :movie_tile_toggle, false)
    {:noreply, socket}
  end

  def handle_event("review_input", value, socket) do
    socket = assign(socket, :review_input, value["value"])
    {:noreply, socket}
  end

  def handle_event("add_review", _value, socket) do
    l = if socket.assigns.movie_tile.reviews == nil do
      [%{"review" => socket.assigns.review_input, "author" => socket.assigns.current_user.email}]
    else
      [%{"review" => socket.assigns.review_input, "author" => socket.assigns.current_user.email}] ++ socket.assigns.movie_tile.reviews
    end
    {:ok, struct} = Accounts.add_review(socket.assigns.movie_tile, l)
    socket = assign(socket, :movie_tile, struct)
    socket = assign(socket, :movie_list, Accounts.get_movies())
    {:noreply, socket}
  end

  def handle_event("edit_review", value, socket) do
    socket = assign(socket, :edit_review, value["value"])
    {:noreply, socket}
  end

  def handle_event("save_review", value, socket) do
    l = Enum.filter(socket.assigns.movie_tile.reviews, fn r -> r != %{"review" => value["value"], "author" => value["gau"]} end)
    l = [%{"review" => socket.assigns.review_input, "author" => socket.assigns.current_user.email}] ++ l
    {:ok, struct} = Accounts.add_review(socket.assigns.movie_tile, l)
    socket = assign(socket, :movie_tile, struct)
    socket = assign(socket, :movie_list, Accounts.get_movies())
    {:noreply, socket}
  end


  def handle_event("delete_review", value, socket) do
    l = Enum.filter(socket.assigns.movie_tile.reviews, fn r -> r != %{"review" => value["value"], "author" => value["gau"]} end)
    {:ok, struct} = Accounts.add_review(socket.assigns.movie_tile, l)
    socket = assign(socket, :movie_tile, struct)
    socket = assign(socket, :movie_list, Accounts.get_movies())
    {:noreply, socket}
  end

  def handle_event("open_movie_tile", value, socket) do
    m = Enum.filter(socket.assigns.movie_list, fn m -> m.id == value["gid"] end)
    socket = assign(socket, :movie_tile, Enum.at(m, 0))
    socket = assign(socket, :movie_tile_toggle, true)
    {:noreply, socket}
  end

  def handle_event("close_movie_tile", _value, socket) do
    socket = assign(socket, :movie_tile_toggle, false)
    {:noreply, socket}
  end

end
