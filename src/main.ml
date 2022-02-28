let%component make () =
  let (value, setValue) = React.use_state(fun () -> "wat") in
  let onChange value = setValue(fun _ -> value) in
  Monaco.make ~value ~onChange ()
