defmodule Arena.Bridge.Harmony do

  defmacro __using__(_opts) do
    quote do
      import Arena.Bridge.Mark

      def verifyprogressevent(event) do
        %{
          type: :harmonize,
          harmonized_mark: event["Progress"],
          mark: mark(event["Id"]),
        }
      end

    end
  end

end
