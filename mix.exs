defmodule Arena3dBridge.Mixfile do
  use Mix.Project

  def project do
    [
      app: :arena_3d_bridge,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:path_finder, git: "https://github.com/nanaki04/PathFinder.git"},
      {:life_bloom, git: "https://github.com/nanaki04/LifeBloom.git"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.16", only: [:dev], runtime: false},
    ]
  end
end
