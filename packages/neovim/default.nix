{
  makeWrapper,
  runCommandLocal,
  lib,
  pkgs,
}:
let
  packageName = "nvim-wrp";

  basePackage = pkgs.neovim-unwrapped;
  extraPackages = with pkgs; [ ];

  environmentArgs = {
    set = { };
    setDefault = {
      NVIM_APPNAME = "nvim-custom";
    };
    prefix = {
      # TEST = {
      #   seperator = ":";
      #   values = [
      #     "test1"
      #     "test2"
      #     "test3"
      #   ];
      # };
      # MAIN = {
      #   seperator = ":";
      #   values = [
      #     "main"
      #   ];
      # };
    };
    suffix = { };
    path = with pkgs; [
      bash-language-server
      lua-language-server
      marksman
      nil
      nixd
      nixfmt-rfc-style
      rust-analyzer
      tinymist
      harper
    ];
    unset = [ ];
  };

  wrapperFlags = {
    append = [ ];
    prepend = [
      "-u"
      "NORC"
      "--cmd"
    ];
    raw = "--add-flags \"'set packpath^=${packpath} | set runtimepath^=${packpath}'\"";
  };

  startPlugins = with pkgs.vimPlugins; [
    friendly-snippets
    iron-nvim
    mini-nvim
    nvim-lspconfig
    nvim-treesitter.withAllGrammars
  ];

  foldPlugins = builtins.foldl' (
    acc: next: acc ++ [ next ] ++ (foldPlugins (next.dependencies or [ ]))
  ) [ ];

  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ln -vsfT ${./src/ixnix} $out/pack/${packageName}/start/ixnix

    ${lib.concatMapStringsSep "\n" (
      plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}"
    ) startPluginsWithDeps}
  '';
in
pkgs.symlinkJoin {
  name = "neovim-custom";
  paths = [ basePackage ] ++ extraPackages;
  buildInputs = [ makeWrapper ];
  postBuild =
    let
      envArgs = {
        set = lib.flatten (
          map
            (args: [
              "--set"
              args
            ])
            (
              lib.mapAttrsToList (name: value: [
                name
                value
              ]) environmentArgs.set
            )
        );
        setDefault = lib.flatten (
          map
            (args: [
              "--set-default"
              args
            ])
            (
              lib.mapAttrsToList (name: value: [
                name
                value
              ]) environmentArgs.setDefault
            )
        );
        # TODO Prefix & Suffix can only hanlde string lists (-each)
        prefix = lib.flatten (
          map
            (
              args:
              (
                if builtins.length args <= 3 then
                  [
                    "--prefix"
                    args
                  ]
                else
                  [
                    "--prefix-each"
                    (lib.sublist 0 2 args)
                    (lib.strings.concatStringsSep " " (lib.sublist 2 ((builtins.length args) - 1) args))
                  ]
              )
            )
            (
              lib.mapAttrsToList (
                name: value:
                (lib.flatten [
                  name
                  (lib.mapAttrsToList (name: value: value) value)
                ])
              ) environmentArgs.prefix
            )
        );
        suffix = lib.flatten (
          map
            (
              args:
              (
                if builtins.length args <= 3 then
                  [
                    "--suffix"
                    args
                  ]
                else
                  [
                    "--suffix-each"
                    (lib.sublist 0 2 args)
                    (lib.strings.concatStringsSep " " (lib.sublist 2 ((builtins.length args) - 1) args))
                  ]
              )
            )
            (
              lib.mapAttrsToList (
                name: value:
                (lib.flatten [
                  name
                  (lib.mapAttrsToList (name: value: value) value)
                ])
              ) environmentArgs.suffix
            )
        );
        path = map (p: [
          "--prefix"
          "PATH"
          ":"
          "${p}/bin"
        ]) environmentArgs.path;
        unset = map (args: [
          "--unset"
          (lib.escapeShellArg args)
        ]) environmentArgs.unset;
      };
      flagArgs = {
        prependFlagArgs = map (args: [
          "--add-flags"
          (lib.escapeShellArg args)
        ]) wrapperFlags.prepend;
        appendFlagArgs = map (args: [
          "--append-flags"
          (lib.escapeShellArg args)
        ]) wrapperFlags.append;
      };
      allArgs = lib.flatten (
        envArgs.set
        ++ envArgs.setDefault
        ++ envArgs.prefix
        ++ envArgs.suffix
        ++ envArgs.path
        ++ envArgs.unset
        ++ flagArgs.prependFlagArgs
        ++ flagArgs.appendFlagArgs
      );
    in
    ''
      for file in "$out"/bin/*; do
        wrapProgram \
          "$file" \
          ${lib.escapeShellArgs allArgs} \
          ${wrapperFlags.raw}
        done
    '';

  passthru = { inherit packpath; };
}
