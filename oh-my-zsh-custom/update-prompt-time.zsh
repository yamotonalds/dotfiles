
# http://d.hatena.ne.jp/NeoCat/20120820/1345479303
zmodload zsh/datetime # $EPOCHSECONDS, strftime等を利用可能に
reset_tmout() { TMOUT=$[60-EPOCHSECONDS%60] }
precmd_functions=($precmd_functions reset_tmout) # プロンプト表示時に更新までの時間を再計算
redraw_tmout() { zle reset-prompt; reset_tmout } # 時刻を更新
TRAPALRM() { redraw_tmout }

