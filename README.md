# jsoo-react-template

Minimal template project for [jsoo-react](https://github.com/ml-in-barcelona/jsoo-react).

## Getting started

To build the project, you will need [opam](https://opam.ocaml.org/doc/Install.html) and [Yarn](https://yarnpkg.com/getting-started/install).

After installing both package managers:

1. Run:

    ```bash
    make create-switch
    ```

This will create an opam [local switch](https://opam.ocaml.org/blog/opam-local-switches/).

2. Install dependencies with:

    ```bash
    make init
    ```


2. Now run `make build` to build the project, and `make start` to start the local development server. You should be able to access the rendered site in http://localhost:8000/.
