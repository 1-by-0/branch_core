defmodule BranchCoreWeb.Dashboard.ShowMoreComponent do
  use BranchCoreWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="pt-4 mt-4 border-t border-gray-100 text-center">
      <.link patch={@route}>
        <p class="text-sm text-primary font-medium cursor-pointer hover:underline transition">
          {@show_text}
        </p>
      </.link>
    </div>
    """
  end
end
