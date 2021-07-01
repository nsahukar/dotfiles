# Language servers Installation

## Golang

Change to any directory that is both outside of your `GOPATH` and outside of a module (a temp directory is fine), and run:

```shell
GO111MODULE=on go get golang.org/x/tools/gopls@latest
```

```lua
require'lspconfig'.gopls.setup{}
```


## JavaScript

```shell
$ git clone --depth 1 https://github.com/theia-ide/typescript-language-server.git
$ npm i -g typescript typescript-language-server
```

```lua
require'lspconfig'.tsserver.setup{}
```


## HTML, CSS, JSON

```shell
$ git clone --depth 1 https://github.com/hrsh7th/vscode-langservers-extracted.git
$ npm i -g vscode-langservers-extracted
```

```lua
require'lspconfig'.html.setup{}
require'lspconfig'.cssls.setup{}
```
