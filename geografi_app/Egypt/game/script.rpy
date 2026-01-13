#Define characters
define N = Character(None, what_italic=True)
define y = Character("Y/N", color = "grey")
define S = Character("Sharifa (شريفة)", color = "#e88345")
image Sharifa = im.Scale("Sharifa.png",380,900)
image bg cairo = im.Scale("bg cairo.jpg", 1920,1080)

# The game starts here.
label start:
    scene bg cairo

    N "You just landed in the busteling streets of Cairo"
    N "A faint siluette if a winab walks towards you"
    N "Her eyes are glistening and piercing yours with an amber yellow, she looks fierce, intimidating and... Gorgeous."

    show Sharifa
    S "Ahlan! Are you Y/N?"
    S "My father told me so much about you, let me show you around! "

    show Sharifa at right
    S "We are currently in The Old Town of Cairo."
    S "This market is cakked Khan El Kalili Market"

    # This ends the game.

    return
