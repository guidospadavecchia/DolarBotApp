<p align="center">
  <img src="https://github.com/guidospadavecchia/DolarBotApp/blob/main/assets/images/logos/border/dolarbot_app.png" width="600px">
</p>

*** 
<p align="center">
  <i>La aplicación móvil oficial de DolarBot.</i>
</p>  

## Status
[![Release](https://img.shields.io/github/v/release/guidospadavecchia/DolarBot?&label=version&style=flat-square)](https://github.com/guidospadavecchia/DolarBotApp)
[![API](https://img.shields.io/github/package-json/v/guidospadavecchia/DolarBot-Api?color=teal&label=api&style=flat-square)](https://dolarbot-api.herokuapp.com/)
[![Discord](https://img.shields.io/discord/752312522769694780?color=7289DA&label=Support%20Server&style=flat-square)](https://discord.gg/tCkbjuM)
[![License](https://img.shields.io/github/license/guidospadavecchia/DolarBotApp?color=orange&style=flat-square)](https://github.com/guidospadavecchia/DolarBotApp/blob/main/LICENSE)

## Descripción  
**DolarBot App** es la aplicación móvil de [DolarBot](https://github.com/guidospadavecchia/DolarBot), el bot argentino de Discord para ver las cotizaciones del dólar, euro, real, indicadores y más.  
Esta aplicación está disponible para **Android**, y se distribuye en dos variedades: **DolarBot Lite** y **DolarBot Pro**.

## Características
La aplicación es **100% open-source**, y **gratuita** para la versión **Lite**. Sin embargo, se permite compilar e instalar la versión **Pro** por medios propios sin limitaciones a quien lo desee. Para ello, ver la sección [Compilación](https://github.com/guidospadavecchia/DolarBotApp/blob/main/README.md#compilaci%C3%B3n). A continuación se listan las características de cada versión:

| DolarBot | **Lite** | **Pro** |
| ------ | ------ | ------ |
| **Link** | [![Lite](https://github.com/guidospadavecchia/DolarBotApp/blob/main/assets/images/general/google-play-badge-small.png)](https://play.google.com/store/apps/details?id=ar.dolarbot) | [![Pro](https://github.com/guidospadavecchia/DolarBotApp/blob/main/assets/images/general/google-play-badge-small.png)](https://play.google.com/store/apps/details?id=ar.dolarbot.pro) |
| **Costo** | **Gratis** | **$0.99** |
| **Cotizaciones** | **Dólar**<br/>✔ Dólar Oficial<br/>✔ Dólar Ahorro<br/>✔ Dólar Blue<br/>✔ Dólar Bolsa<br/>✔ Dólar 'Contado con Liqui'<br/>✔ Dólar promedio<br/><br/>**Bancos Argentinos**<br/>❌ Dólar, Euro y Real<br/><br/>**Crypto**<br/>❌ Cotizaciones en pesos y dólares<br/><br/>**Metales**<br/>✔ Oro internacional<br/>✔ Plata<br/>✔ Cobre<br/><br/>**Indicadores**<br/>✔ Riesgo País<br/>✔ Reservas B.C.R.A.<br/>✔ Dinero en circulación<br/><br/>**Venezuela**<br/>✔ Dólar Promedio Bancario<br/>✔ Dólar Paralelo<br/>✔ Euro Promedio Bancario<br/>✔ Euro Paralelo<br/> | **Dólar**<br/>✔ Dólar Oficial<br/>✔ Dólar Ahorro<br/>✔ Dólar Blue<br/>✔ Dólar Bolsa<br/>✔ Dólar 'Contado con Liqui'<br/>✔ Dólar promedio<br/><br/>**Bancos Argentinos**<br/>✔ Dólar, Euro y Real<br/><br/>**Crypto**<br/>✔ Cotizaciones en pesos y dólares<br/><br/>**Metales**<br/>✔ Oro internacional<br/>✔ Plata<br/>✔ Cobre<br/><br/>**Indicadores**<br/>✔ Riesgo País<br/>✔ Reservas B.C.R.A.<br/>✔ Dinero en circulación<br/><br/>**Venezuela**<br/>✔ Dólar Promedio Bancario<br/>✔ Dólar Paralelo<br/>✔ Euro Promedio Bancario<br/>✔ Euro Paralelo<br/> |
| **Otras Características** | ✔ Modo oscuro<br/>✔ Calculadora de compra y venta<br/>✔ Formato de moneda AR/US<br/>✔ Favoritos<br/>✔ Compartir cotizaciones<br/>❌ Gráficos de evolución<br/> | ✔ Modo oscuro<br/>✔ Calculadora de compra y venta<br/>✔ Formato de moneda AR/US<br/>✔ Favoritos<br/>✔ Compartir cotizaciones<br/>✔ Gráficos de evolución<br/> |

## Información de terceros
**DolarBot** muestra y recopila información provista por terceros. Para más información al respecto, visitar el apartado de [Integraciones](https://github.com/guidospadavecchia/DolarBot-Api#integraciones) en [DolarBot-API](https://github.com/guidospadavecchia/DolarBot-Api).

## Compilación
1. Para compilar y correr la aplicación, será necesario correr por cuenta propia una instancia de [DolarBot-API](https://github.com/guidospadavecchia/DolarBot-Api). Para más información acerca de ello, ver la sección [Configuración](https://github.com/guidospadavecchia/DolarBot-Api#configuraci%C3%B3n) dentro del repositorio.
2. Clonar este repositorio.
3. Configurar el archivo `app_settings.json` a partir del `app_settings.json.template` incluído en este repositorio; colocando, entre otros parámetros, la `apiKey` configurada en **DolarBot-Api**.
4. Configurar la constante `_kbannerAdUnitId` dentro de `lib/classes/ad_state.dart` con el ID del Ad Unit de [AdMob](https://admob.google.com/home/). De lo contrario, es completamente factible modificar el código para utilizar otros proveedores de anuncios, o eliminar esta funcionalidad completamente.
5. Ejecutar `flutter pub get`.
6. Generar el *app bundle*:  
  6.1 Versión **Lite**: `flutter build appbundle --flavor lite -t lib/main_lite.dart --no-tree-shake-icons`  
  6.2 Versión **Pro**: `flutter build appbundle --flavor pro -t lib/main_pro.dart --no-tree-shake-icons`


## Contribuciones
Colaborá con el desarrollo de **DolarBot** enviando tu [pull request](https://github.com/guidospadavecchia/DolarBotApp/pulls). 

## Autores
- **Guido Spadavecchia** (Contacto: guido.spadavecchia@gmail.com).  
- **Juan Manuel Flecha** (Contacto: flechajm@gmail.com).  

## Licencia
**DolarBot** es *100% open-source*. Está licenciado bajo la [GNU General Public License v3.0](https://github.com/guidospadavecchia/DolarBotApp/blob/main/LICENSE).

## 

<p align="center">
  Hecho con 💙 en <b><a href="https://flutter.dev/">Flutter</a></b>
</p>
<p align="center">
  <img src="https://img.icons8.com/color/452/flutter.png" width="113px">
</p>
