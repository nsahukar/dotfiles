function fish_right_prompt
  set modified_color_fst 333
  printf (__batman_color_dim)(date +%H(set_color $modified_color_fst):(__batman_color_dim)%M(set_color $modified_color_fst):(__batman_color_dim)%S)(__batman_color_off)" "
end
