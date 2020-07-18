function bobthefish_colors -S -d 'palenight'
      set -l bg           292d3e
      set -l current_line ffcc00
      set -l selection    607c8b
      set -l fg           959dcb
      set -l comment      82aaff
      set -l cyan         89ddff
      set -l green        c3e88d
      set -l blue         82aaff
      set -l white        d0d0d0
      set -l magenta      c792ea
      set -l red          f07178
      set -l yellow       ffcb6b

      set -x color_initial_segment_exit  $fg $red  --bold
      set -x color_initial_segment_su    $fg $magenta --bold
      set -x color_initial_segment_jobs  $fg $comment --bold

      set -x color_path                  $selection $fg
      set -x color_path_basename         $selection $fg --bold
      set -x color_path_nowrite          $selection $red
      set -x color_path_nowrite_basename $selection $red --bold

      set -x color_repo                  $green $bg
      set -x color_repo_work_tree        $selection $fg --bold
      set -x color_repo_dirty            $red $bg
      set -x color_repo_staged           $yellow $bg

      set -x color_vi_mode_default       $bg $yellow --bold
      set -x color_vi_mode_insert        $green $bg --bold
      set -x color_vi_mode_visual        $yellow $bg --bold

      set -x color_vagrant               $blue $bg --bold
      set -x color_k8s                   $green $fg --bold
      set -x color_username              $selection $cyan --bold
      set -x color_hostname              $selection $cyan
      set -x color_rvm                   $red $bg --bold
      set -x color_nvm                   $green $bg --bold
      set -x color_virtualfish           $comment $bg --bold
      set -x color_virtualgo             $cyan $bg --bold
      set -x color_desk                  $comment $bg --bold
      set -x color_nix                   $cyan $bg --bold
end
