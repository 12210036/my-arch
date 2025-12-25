/* 1. Mover el include al principio */
#include "pywal_colors.glsl"

/* Center line thickness (pixels) */
#define C_LINE 60
/* Width (in pixels) of each bar - LOOK MINECRAFT */
#define BAR_WIDTH 10
/* Width (in pixels) of each bar gap */
#define BAR_GAP 1
/* Outline color */
#define BAR_OUTLINE #262626
/* Outline width (en 0 para que sea sólido) */
#define BAR_OUTLINE_WIDTH 0
/* Amplify magnitude */
#define AMPLIFY 300
/* Alpha channel */
#define USE_ALPHA 0
/* How strong the gradient changes */
#define GRADIENT_POWER 12

/* 2. BAR COLOR: Cambiamos el #3366b2 por COLOR1 de Pywal */
#define GRADIENT (d / GRADIENT_POWER + 1)
#define COLOR (COLOR1 * GRADIENT)

/* Resto de la configuración */
#define DIRECTION 0
#define INVERT 0
#define FLIP 0
#define MIRROR_YX 0
