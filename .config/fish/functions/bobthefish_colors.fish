function bobthefish_colors -S -d 'gruvbox-material'
      set -l bg           282828
      set -l current_line d4be98
      set -l selection    d4be98 
      set -l fg           282828 
      set -l comment      82aaff
      set -l cyan         89b482
      set -l green        a9b665
      set -l blue         7daea3
      set -l white        d4be98
      set -l magenta      d3869b
      set -l red          ea6962
      set -l yellow       e78a4e

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

      set -x color_vi_mode_default       $blue $bg --bold
      set -x color_vi_mode_insert        $green $bg --bold
      set -x color_vi_mode_visual        $magenta $bg --bold

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
