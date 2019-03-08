defmodule CachexMemoize.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url_docs "http://hexdocs.pm/cachex_memoize"
  @url_github "https://github.com/edescourtis/cachex_memoize"

  def project do
    [
      app: :cachex_memoize,
      name: "CachexMemoize",
      description: "Memoization macros for Cachex",
      package: %{
        files: [
          "lib",
          "mix.exs",
          "LICENSE"
        ],
        licenses: ["MIT"],
        links: %{
          "Docs" => @url_docs,
          "GitHub" => @url_github
        },
        maintainers: ["Eric des Courtis"]
      },
      version: @version,
      test_coverage: [
        tool: ExCoveralls
      ],
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cachex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Testing dependencies
      { :cachex, ">= 3.0.0 and < 4.0.0"},
      { :excoveralls, "~> 0.8", optional: true, only: [ :cover, :test ] },
      # Linting dependencies
      { :credo, "~> 0.8", optional: true, only: [ :lint ] },
      # Documentation dependencies
      { :ex_doc, "~> 0.16", optional: true, only: [ :docs, :dev ] }
    ]
  end
end
