module External =
  struct
    external%component make : language:string -> height:string -> value:string -> onChange:(string -> unit) -> React.element
      = "require(\"@monaco-editor/react\").default"
  end

let%component make ~value:(value : string) ~onChange =
  External.make ~value:value ~onChange:onChange ~height:"400px" ~language:"html" ()
