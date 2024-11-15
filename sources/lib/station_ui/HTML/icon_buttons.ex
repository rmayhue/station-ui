defmodule StationUI.HTML.IconButtons do
  use Phoenix.Component

  import StationUI.HTML.Icons, only: [icon: 1]

  @button_base [
    "bg-skin-btn text-skin-btn rounded-full border border-skin-btn whitespace-nowrap inline-flex justify-center items-center gap-x-1.5 lg:gap-x-2",
    "hover:bg-skin-btn-hover active:bg-skin-btn-active hover:text-skin-btn-hover active:text-skin-btn-active hover:border-skin-btn-hover active:border-skin-btn-active focus-visible:ring-purple-500 focus-visible:ring-offset-4 focus-visible:ring-2 focus-visible:outline-none"
  ]

  @destructive_classes "!border-skin-btn-destructive !bg-skin-btn-destructive text-skin-btn-destructive hover:!bg-skin-btn-destructive-hover hover:!border-skin-btn-destructive-hover hover:!text-skin-btn-destructive active:!bg-skin-btn-destructive-active active:!border-skin-btn-destructive-active active:!text-skin-btn-destructive"

  attr :rest, :global
  attr :flavor, :string, default: "primary"
  attr :destructive, :boolean, default: false
  attr :size, :string, default: "md"
  attr :responsive, :boolean, default: true
  attr :pill, :boolean, default: false
  attr :class, :string, default: nil
  attr :icon, :string, required: true
  attr :chevron, :boolean, default: nil
  # We need to require one or the other of these to exist:
  attr :text, :string, default: ""
  attr :label, :string, default: ""

  def icon_btn(assigns) do
    if assigns.text == "" and assigns.label == "",
      do: raise("buttons without text require a label")

    ~H"""
    <button
      class={[
        button_flavor(@flavor, @destructive),
        button_base(),
        button_size(@size, @responsive, @chevron, @text),
        @class
      ]}
      aria-label={@label}
      {@rest}
    >
      <div class="grid justify-items-center">
        <.icon :if={@icon} name={@icon} class={icon_classes(@size, @responsive)} />
        <span :if={@text}><%= @text %></span>
      </div>
      <.icon :if={@chevron} name="hero-chevron-down-solid" class={chevron_classes(@size, @responsive)} />
    </button>
    """
  end

  defp button_base, do: @button_base

  # Button flavor specific classes classes

  defp button_flavor("primary", destructive) do
    if destructive, do: "btn-primary  #{@destructive_classes}", else: "btn-primary"
  end

  defp button_flavor("secondary", destructive) do
    if destructive, do: "btn-secondary  #{@destructive_classes}", else: "btn-secondary"
  end

  defp button_flavor("tertiary", _), do: "btn-tertiary"

  # Size variant specific classes classes
  # button_size(size, responsive, chevron, text)

  ## xl without label
  defp button_size("xl", true, nil, ""), do: "lg:focus-visible:ring-4 p-[18px]"
  defp button_size("xl", false, nil, ""), do: "text-base lg:focus-visible:ring-4 p-[18px]"
  defp button_size("xl", true, _, ""), do: "lg:focus-visible:ring-4 py-[18px] pl-[22px] pr-[18px]"

  defp button_size("xl", false, _, ""),
    do: "text-base lg:focus-visible:ring-4 py-[18px] pl-[22px] pr-[18px]"

  ## xl with label
  defp button_size("xl", true, nil, _), do: "lg:focus-visible:ring-4 py-3 px-6"
  defp button_size("xl", false, nil, _), do: "text-base lg:focus-visible:ring-4 py-3 px-6"
  defp button_size("xl", true, _, _), do: "lg:focus-visible:ring-4 py-3 pl-7 pr-6"
  defp button_size("xl", false, _, _), do: "text-base lg:focus-visible:ring-4 py-3 pl-7 pr-6"

  ## lg without label
  defp button_size("lg", true, nil, ""), do: "text-base p-3.5"
  defp button_size("lg", false, nil, ""), do: "text-base p-3.5"
  defp button_size("lg", true, _, ""), do: "text-base py-3.5 pl-[18px] pr-3.5"
  defp button_size("lg", false, _, ""), do: "text-base py-3.5 pl-[18px] pr-3.5"

  ## lg with label
  defp button_size("lg", true, nil, _), do: "text-base py-2.5 px-5"
  defp button_size("lg", false, nil, _), do: "text-base py-2.5 px-5"
  defp button_size("lg", true, _, _), do: "text-base py-2.5 pl-6 pr-5"
  defp button_size("lg", false, _, _), do: "text-base py-2.5 pl-6 pr-5"

  ## md without label
  defp button_size("md", true, nil, ""), do: "text-sm p-2.5"
  defp button_size("md", false, nil, ""), do: "text-sm p-2.5"
  defp button_size("md", true, _, ""), do: "text-sm py-2.5 pl-3.5 pr-2.5"
  defp button_size("md", false, _, ""), do: "text-sm py-2.5 pl-3.5 pr-2.5"

  ## md with label
  defp button_size("md", true, nil, _), do: "text-sm py-2 px-3.5"
  defp button_size("md", false, nil, _), do: "text-sm py-2 px-3.5"
  defp button_size("md", true, _, _), do: "text-sm py-2 pl-[22px] pr-[18px]"
  defp button_size("md", false, _, _), do: "text-sm py-2 pl-[22px] pr-[18px]"

  ## sm without label
  defp button_size("sm", true, nil, ""), do: "text-xs p-2"
  defp button_size("sm", false, nil, ""), do: "text-xs p-2"
  defp button_size("sm", true, _, ""), do: "text-xs py-2 pl-3 pr-2"
  defp button_size("sm", false, _, ""), do: "text-xs py-2 pl-3 pr-2"

  ## sm with label
  defp button_size("sm", true, nil, _), do: "text-xs py-1.5 px-3"
  defp button_size("sm", false, nil, _), do: "text-xs py-1.5 px-3"
  defp button_size("sm", true, _, _), do: "text-xs py-1.5 pl-[18px] pr-3.5"
  defp button_size("sm", false, _, _), do: "text-xs py-1.5 pl-[18px] pr-3.5"

  # Icon classes

  defp icon_classes("xl", true), do: "w-10 h-10 lg:w-12 lg:h-12"
  defp icon_classes("xl", false), do: "w-12 h-12"

  defp icon_classes("lg", true), do: "w-8 h-8 lg:w-[38px] lg:h-[38px]"
  defp icon_classes("lg", false), do: "w-[38px] h-[38px]"

  defp icon_classes("md", true), do: "w-6 h-6 lg:w-8 lg:h-8"
  defp icon_classes("md", false), do: "w-8 h-8"

  defp icon_classes("sm", true), do: "w-6 h-6"
  defp icon_classes("sm", false), do: "w-6 h-6"

  # Chevron classes

  defp chevron_classes("xl", true), do: "w-6 h-6 lg:w-7 lg:h-7"
  defp chevron_classes("xl", false), do: "w-7 h-7"

  defp chevron_classes("lg", true), do: "w-6 h-6 lg:w-7 lg:h-7"
  defp chevron_classes("lg", false), do: "w-7 h-7"

  defp chevron_classes("md", true), do: "w-5 h-5 lg:w-6 lg:h-6"
  defp chevron_classes("md", false), do: "stroke stroke-white w-6 h-6"

  defp chevron_classes("sm", true), do: "w-4 h-4"
  defp chevron_classes("sm", false), do: "w-4 h-4"
end
