# Used by "mix format"
[
  import_deps: [:phoenix],
  plugins: [TailwindFormatter, Phoenix.LiveView.HTMLFormatter],
  inputs: [
    "{mix,.formatter}.exs",
    "{config,lib,test}/**/*.{ex,exs}",
    "demo_app/{config,lib,test}/**/*.{ex,exs}",
    "installer/{config,lib,test}/**/*.{ex,exs}"
  ],
  line_length: 150
]
