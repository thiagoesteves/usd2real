defmodule Usd2real.MixProject do
  use Mix.Project

  def project do
    [
      app: :usd2real,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  defp escript do
    [
      main_module: Usd2real,
      path: "bin/usd2real"
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
      {:tesla, "~> 1.4.0"},

      # optional, but recommended adapter
      {:hackney, "~> 1.6.0"},

      # optional, required by JSON middleware
      {:jason, ">= 1.0.0"},

      # html parser
      {:floki, "~> 0.30.0"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},

      # static analysis
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
    ]
  end
end
