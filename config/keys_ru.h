/*
 * Коды для раскладки «Russian – PC» на хосте (на macOS «Russian – PC», на Windows и Linux стандартная русская).
 * Значения взяты из заголовка zmk-locale-generator, собранного по Unicode CLDR
 * keyboards/windows/ru-t-k0-windows.xml. Здесь только то, что нужно слою SymRu.
 */
#pragma once
#include <dt-bindings/zmk/keys.h>

#define RU_EXCL     LS(N1)     // !
#define RU_DQT      LS(N2)     // "
#define RU_SEMI     LS(N4)     // ;
#define RU_PRCNT    LS(N5)     // %
#define RU_COLON    LS(N6)     // :
#define RU_QUESTION LS(N7)     // ?
#define RU_STAR     LS(N8)     // *
#define RU_LPAR     LS(N9)     // (
#define RU_RPAR     LS(N0)     // )
#define RU_MINUS    MINUS      // -
#define RU_UNDER    LS(MINUS)  // _
#define RU_EQUAL    EQUAL      // =
#define RU_PLUS     LS(EQUAL)  // +
#define RU_BSLH     BSLH       // обратная косая черта
#define RU_SLASH    LS(BSLH)   // /
#define RU_PERIOD   FSLH       // .
#define RU_COMMA    LS(FSLH)   // ,
