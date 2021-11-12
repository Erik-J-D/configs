B='#28282899'  # blank
C='#fbf1c799'  # clear ish
D='#8ec07c'    # default
T='#fbf1c7'    # text
W='#cc2416'    # wrong
V='#83a598aa'  # verifying

i3lock -F -i ~/Pictures/Wallpapers/Beksinski/   \
--bshl-color=$W                                 \
--clock                                         \
--clock --force-clock                           \
--date-color=$T                                 \
--date-str ""                                   \
--greeter-align 1                               \
--greeter-color=$T                              \
--greeter-pos="ix-265:iy+12"                    \
--greeter-size=14                               \
--greeter-text "Type password to unlock..."     \
--ignore-empty-password                         \
--ind-pos="x+310:y+h-80"                        \
--indicator                                     \
--inside-color=$B                               \
--insidever-color=$C                            \
--insidewrong-color=$C                          \
--keyhl-color=$W                                \
--layout-align 1                                \
--layout-color=$T                               \
--layout-pos="ix-265:iy+32"                     \
--layout-size=12                                \
--line-color=$B                                 \
--line-uses-inside                              \
--modif-align 2                                 \
--modif-color=$B                                \
--modif-pos="ix+45:iy+43"                       \
--modif-size=12                                 \
--noinput-text=""                               \
--pass-media-keys                               \
--pass-power-keys                               \
--pass-screen-keys                              \
--pass-volume-keys                              \
--radius=25                                     \
--ring-color=$D                                 \
--ring-width=5                                  \
--ringver-color=$V                              \
--ringwrong-color=$W                            \
--separator-color=$D                            \
--slideshow-interval 30                         \
--slideshow-random-selection                    \
--time-align 1                                  \
--time-color=$T                                 \
--time-pos="ix-265:iy-10"                       \
--time-size=16                                  \
--time-str="%I:%M %p"                           \
--verif-align 2                                 \
--verif-color=$V                                \
--verif-pos="ix+35:iy-34"                       \
--verif-size=12                                 \
--verif-text="Verifying..."                     \
--wrong-align 2                                 \
--wrong-color=$W                                \
--wrong-pos="ix+24:iy-34"                       \
--wrong-size=12                                 \
--wrong-text="Failure!"
