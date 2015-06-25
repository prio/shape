defmodule Shape.Mixfile do
  use Mix.Project

  def project do
    [app: :shape,
     version: "0.0.2",
     elixir: "~> 1.0",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  defp package do
    [description: "A data validation library for Elixir based on Prismatoc Scheme",
    licenses: ["Apache 2.0"],
    contributors: ["Jonathan Harrington"],
    links: %{"GitHub" => "https://github.com/prio/shape"}]
  end
  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:inch_ex, only: :docs},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.7", only: :dev}]
  end
end
