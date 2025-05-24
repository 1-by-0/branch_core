defmodule BranchCoreWeb.UserSkillLive.FormComponent do
  use BranchCoreWeb, :live_component

  alias BranchCore.KnowledgeBase
  alias BranchCore.Profile

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
      </.header>

      <.simple_form
        for={@form}
        id="user-skill-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <%= if @action == :new do %>
          <input
            type="text"
            name="query"
            as="query"
            phx-target={@myself}
            value={@query}
            phx-keyup="suggest-skill"
            phx-debounce="200"
            autocomplete="off"
            placeholder="Search skills..."
            class="border p-2 rounded w-full"
          />
          <%= if @suggestions != [] do %>
            <ul class="border bg-white mt-0 rounded shadow max-h-40 overflow-y-auto">
              <%= for skill <- @suggestions do %>
                <li
                  phx-click="select"
                  phx-target={@myself}
                  phx-value-id={skill.id}
                  class="px-4 py-2 hover:bg-blue-100 cursor-pointer"
                >
                  {skill.name}
                </li>
              <% end %>
            </ul>
          <% end %>
          <input type="hidden" name="user_skill[skill_id]" value={@selected_skill_id} />
        <% end %>
        <%= if @action == :edit do %>
          <h2 class="text-2xl font-semibold mb-4">Skill: <%= @user_skill.skill.name  %></h2>
          <input type="hidden" name="user_skill[skill_id]" value={@user_skill.skill.id} />
        <% end %>
        <.input
          field={@form[:level]}
          type="select"
          label="Level"
          options={[
            {"Beginner", "beginner"},
            {"Intermediate", "intermediate"},
            {"Advanced", "advanced"}
          ]}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Skill</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_skill: user_skill} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:suggestions, [])
     |> assign(:query, nil)
     |> assign(:selected_skill_id, nil)
     |> assign_new(:form, fn ->
       to_form(Profile.change_user_skill(user_skill))
     end)}
  end

  @impl true
  def handle_event("validate", %{"user_skill" => user_skill_params}, socket) do
    changeset = Profile.change_user_skill(socket.assigns.user_skill, user_skill_params)
    {:noreply, assign(socket, :form, to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"user_skill" => user_skill_params}, socket) do
    save_user_skill(socket, socket.assigns.action, user_skill_params)
  end

  def handle_event("suggest-skill", %{"key" => _, "value" => ""}, socket) do
    # IO.inspect(KnowledgeBase.list_similar_skills(params["value"]))
    {:noreply,
    socket
    |> assign(:suggestions, [])
    |> assign(:query, nil)
  }
  end

  def handle_event("suggest-skill", %{"key" => _, "value" => value}, socket) do
    # IO.inspect(KnowledgeBase.list_similar_skills(params["value"]))
    {:noreply,
    socket
    |> assign(:suggestions, KnowledgeBase.list_similar_skills(value))
    |> assign(:query, nil)}
  end

  def handle_event("select", %{"id" => skill_id, "value" => _value}, socket) do
    {:noreply,
     socket
     |> assign(:selected_skill_id, skill_id)
     |> assign(:query, KnowledgeBase.get_skill!(skill_id).name)
     |> assign(:suggestions, [])}
  end

  def save_user_skill(socket, :edit, user_skill_param) do
    case Profile.update_user_skill(socket.assigns.user_skill, user_skill_param) do
      {:ok, user_skill} ->
        notify_parent(user_skill)

        {:noreply,
         socket
         |> put_flash(:info, "Skill updated successfully")
         |> push_patch(to: socket.assigns.patch)}
    end
  end

  def save_user_skill(socket, :new, user_skill_params) do
    case Profile.create_user_skill(
           Map.put(user_skill_params, "user_id", socket.assigns.current_user.id)
         ) do
      {:ok, user_skill} ->
        notify_parent(user_skill)

        {:noreply,
         socket
         |> put_flash(:info, "Skill saved successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp notify_parent(msg) do
    send(self(), {__MODULE__, {:saved, msg}})
  end
end
