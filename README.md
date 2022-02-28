# issue of wrapped strings in jsoo-react

Cloned jsoo-react-template and added a monaco module which has an external component which binds to `@monaco-editor/react`: [src/monaco.ml].

**Bug**: If you change the content of the editor, it crashes with a runtime error:

```log
Uncaught TypeError: s.toUtf16 is not a function
    at caml_jsstring_of_string (+mlBytes.js:815:10)
    at make (monaco.ml:3:5)
    at caml_call6 (dom_svg.ml:0:0)
    at make$0 (monaco.ml:3:31)
```

It tries to run `caml_jsstring_of_string` to a JavaScript string. Their definition is `function caml_jsstring_of_string(s){return s.toUtf16()`.

After preprocessing and removing everything that isn't `value` it gets summarized into:

```ocaml
module External =
  struct
    let make =
      let make_props
        : value:string -> unit ->
        < value: string Js_of_ocaml.Js.readonly_prop ; > Js_of_ocaml.Js.t
        =
        fun ~value -> fun () ->
          let open Js_of_ocaml.Js.Unsafe in
          obj [|("value", (inject (Js_of_ocaml.Js.string value)));|]
        in
        fun ~value -> fun () ->
          React.create_element (Js_of_ocaml.Js.Unsafe.js_expr "require(\"@monaco-editor/react\").default") (make_props ~value ())
  end

let make =
  let make_props : value:string -> unit -> < value: string Js_of_ocaml.Js.readonly_prop ; > Js_of_ocaml.Js.t
    =
    fun ~value -> fun () ->
      let open Js_of_ocaml.Js.Unsafe in
      obj [| ("value", (inject value))|] in
  let make = (fun ~value:(value : string) -> (External.make ~value () : React.element)) in
  ((let make
      (Props : < value: string Js_of_ocaml.Js.readonly_prop ; > Js_of_ocaml.Js.t)
      =
      make ~value:((fun (type res) ->
                   fun (type a0) ->
                     fun (a0 : a0 Js_of_ocaml.Js.t) ->
                       fun
                         (_ :
                           a0 -> < get: res   ;.. >  Js_of_ocaml.Js.gen_prop)
                         -> (Js_of_ocaml.Js.Unsafe.get a0 "value" : res))
                  (Props : < .. >  Js_of_ocaml.Js.t) (fun x -> x#value)) in
    fun ~value -> fun () -> React.create_element make (make_props ~value ())))
```
