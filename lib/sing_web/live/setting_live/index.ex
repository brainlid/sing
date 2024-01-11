defmodule SingWeb.SettingLive.Index do
  use SingWeb, :live_view

  @value_range 1..5

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:value, 3)
     |> assign_sounds()
     |> assign_value_up_sound()
     |> assign_value_down_sound()}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Settings")
  end

  defp assign_sounds(socket) do
    json =
      # https://opengameart.org/content/16-button-clicks
      Jason.encode!(%{
        # "button02" - edited version
        click: ~p"/audio/button-click.mp3",
        # "clic03" - edited, took (2nd part)
        donk: ~p"/audio/button-no-click.mp3",
        # https://opengameart.org/content/fantasy-sound-effects-library
        win: ~p"/audio/Jingle_Win_00.mp3"
      })

    assign(socket, :sounds, json)
  end

  defp assign_value_up_sound(socket) do
    if socket.assigns.value >= Enum.max(@value_range) do
      assign(socket, :value_up_sound, "donk")
    else
      assign(socket, :value_up_sound, "click")
    end
  end

  defp assign_value_down_sound(socket) do
    if socket.assigns.value <= Enum.min(@value_range) do
      assign(socket, :value_down_sound, "donk")
    else
      assign(socket, :value_down_sound, "click")
    end
  end

  @impl true
  def handle_event("value-change", %{"by" => change}, socket) do
    current_value = socket.assigns.value
    new_value = current_value + change

    socket =
      if new_value not in @value_range do
        # keep the current value
        socket
      else
        assign(socket, :value, new_value)
      end

    {:noreply,
     socket
     |> assign_value_up_sound()
     |> assign_value_down_sound()}
  end

  def handle_event("delayed-server-sound", _params, socket) do
    Process.send_after(self(), {:push_sound, "win"}, 1_000)
    {:noreply, socket}
  end

  @impl true
  def handle_info({:push_sound, sound_name}, socket) do
    {:noreply, socket |> push_event("play-sound", %{name: sound_name})}
  end
end
