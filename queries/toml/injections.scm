;; extends
(pair
  [
   (bare_key) @_key
   (dotted_key
    (bare_key)
    (bare_key) @_key
    )]
  (string) @injection.content
  (#any-of? @_key "run" "script" "before_script" "after_script" "cmd" "command" "shell" "exec" "interpreter")
  (#match? @injection.content "^['\"]{3}")
  (#set! injection.language "bash")
  (#offset! @injection.content 0 3 0 3))

(pair
  [
   (bare_key) @_key
   (dotted_key
    (bare_key)
    (bare_key) @_key
    )]
  (string) @injection.content
  (#any-of? @_key "run" "script" "before_script" "after_script" "cmd" "command" "shell" "exec" "interpreter")
  (#set! injection.language "bash")
  (#offset! @injection.content 0 1 0 1))

(table
  (dotted_key) @_key
  (pair
    (string) @injection.content
    ) 
(#match? @_key "(^|\\.)env$")
(#set! injection.language "bash")
)

(pair
  (dotted_key) @_key
  (string) @injection.content
(#match? @_key "(^|\\.)env\\.")
(#set! injection.language "bash")
)
