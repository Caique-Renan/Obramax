defmodule Testeobramax.Core.OutputShippingItem do
  @derive Jason.Encoder
  defstruct method: "", valid: true, incompatibilities: []
  @type t :: %__MODULE__{method: String.t(), valid: boolean(), incompatibilities: [String.t()]}

  @spec build(method :: String.t(), incompatibilities :: [String.t()]) :: t()
  def build(method, incompatibilities) when length(incompatibilities) > 0,
    do: %__MODULE__{method: method, valid: false, incompatibilities: incompatibilities}

  def build(method, incompatibilities),
    do: %__MODULE__{method: method, valid: true, incompatibilities: incompatibilities}
end
