#define STM32L496xx

#include <linker_scripts/peripherals/stm32l4xx.h>

/* Main program. */
int main(void) {
  RCC->AHB2ENR |= RCC_AHB2ENR_GPIOBEN;
  GPIOB->MODER  &= ~(0x3 << (7*2));
  GPIOB->MODER  |=  (0x1 << (7*2));
  GPIOB->OTYPER &= ~(1 << 7);

  while (1) {
    GPIOB->ODR ^= (1 << 7);
  }
}
