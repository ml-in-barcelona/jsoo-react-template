(lang dune 2.9)

(name jsoo-react-template)

(source
 (github ml-in-barcelona/jsoo-react-template))

(license MIT)

(authors "davesnx" "jchavarri")

(maintainers "davesnx" "jchavarri")

(generate_opam_files true)

(package
 (name jsoo-react-template)
 (synopsis "Project template for jsoo-react")
 (description
  "Template for a minimal jsoo-react project")
 (depends
  (ocaml
   (>= 4.10.2))
  (dune
   (>= 2.0))
  (jsoo-react :dev)
  (ocaml-lsp-server :dev)))
