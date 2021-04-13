//
//  AppDelegate.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 18/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


var html = """
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es"><head>
  <title>UNAM / DGAE / SIAE ~ Sistema Integral de Administración Escolar</title>
  <meta name="description" content="UNAM DGAE SIAE - Sistema Integral de Administración Escolar, Servicios Escolares">
  <meta name="keywords" content="UNAM,DGAE,SIAE,academica,academico,escolar,servicios,trámites,historial academico">
  <meta name="author" content="DGAE/SSRE/SIAE">
  <meta name="copyright" content="© 1998-2021 UNAM/DGAE/SSRE/SIAE">
  <meta name="robot" content="index,follow">
  <meta http-equiv="X-UA-Compatible" content="IE=9">
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta http-equiv="Page-Exit" content="blendTrans(Duration=0.5)">
  <script async="" src="https://www.google-analytics.com/analytics.js"></script><script type="text/javascript">AC_FL_RunContent=0;</script>
  <script type="text/javascript">var page='/fmt_cons_cab.php';</script>
<link rel="stylesheet" type="text/css" href="/css/pack/siae-general.pack.css?1578962067">
<link rel="stylesheet" type="text/css" href="/css/pack/www_try.pack.css?1568761465">
<script type="text/javascript" src="/lib/js/pack/siae-general.pack.js?1578962057"></script>
<script type="text/javascript" src="/lib/js/pack/www_try.pack.js?1568318292"></script></head>
<body background="/img/mnu/bkg_body.jpg">

<table width="650" border="0" cellspacing="0" cellpadding="0" align="center">
  <tbody><tr>
    <td>
    <!-- Cabecera con Logos -->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
      <tbody><tr>
        <td width="112" align="left"><img src="/img/mnu/esc_unam.jpg" alt="UNAM" width="100" height="100" border="0"></td>
        <td align="center">
          <b>UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO</b><br>
          SECRETARIA GENERAL<br>
          DIRECCION GENERAL DE ADMINISTRACION ESCOLAR<br>SUBDIRECCION DE SISTEMAS DE REGISTRO ESCOLAR</td>
        <td width="112" align="right"><img src="/img/mnu/esc_siae.jpg" alt="SIAE" width="120" height="100" border="0"></td>
      </tr>
    </tbody></table>
    </td>
  </tr>
  <tr>
    <td>
      <!-- Aqui comienza el Cuerpo -->
      <table align="center"><tbody><tr><td class="TxtSdw"><font size="+1">Trayectoria Académica</font></td></tr></tbody></table><br>


<script type="text/javascript">

  $(document).ready(function() {

    $(".btn-slide").click(function(){
      $("#panel").slideToggle("slow");
      $(this).toggleClass("active");
      return false;
    });

  });

</script>

      <form action="/www_try.php" method="get" name="frmSIAE" id="frmSIAE">

      <input type="hidden" name="cta" value="099321956">
    
      <table border="0" cellspacing="0" cellpadding="0" align="center">
        <tbody><tr><td colspan="4" align="right"><font size="1">11 Abril 2021</font><br><br></td></tr>
        <tr valign="bottom">
                    <td align="left" width="15%"><img class="foto_alumno" src="data:image/jpeg;base64,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" border="1" width="100" align="left"></td>
                    <td align="left" width="30%">
                                    <table class="TblBlk" cellspacing="0" cellpadding="2">
              <tbody><tr>
                <th class="CellTit"> CUENTA </th>
                <td class="CellDat"> 099321956 </td>
              </tr>
              <tr>
                <th class="CellTit"> NOMBRE </th>
                <td class="CellDat"> TREJO FLORES JOSE ANTONIO </td>
              </tr>
            </tbody></table><br>
          </td>
          <td align="center" valign="bottom" width="224">
            <p class="slide"><a style="color: #fff;" href="#" class="btn-slide">Ecosistema UNAM</a></p>

            <div id="panel">

              <a href="/www_try.php?acc=dep&amp;cta=099321956" alt="Deportes" title="Deportes"><img class="ico-eco" src="img/grl/logo_DGDU_small.gif" width="50" height="54" border="0"></a>

              <a href="/www_try.php?acc=idi&amp;cta=099321956" alt="Idiomas" title="Idiomas"><img class="ico-eco" src="img/grl/logo_CELE_small.gif" width="50" height="54" border="0"></a>

              <a href="/www_try.php?acc=soc&amp;cta=099321956" alt="Servicio Social" title="Servicio Social"><img class="ico-eco" src="img/grl/logo_DGOAE_small.gif" width="50" height="54" border="0"></a>

              <a href="/www_try.php?acc=bibm&amp;cta=099321956" alt="Bibliotecas" title="Bibliotecas"><img class="ico-eco" src="img/grl/logo_DGB_small.gif" width="50" height="54" border="0"></a>

              <!--a href="/www_try.php?acc=bec&cta=099321956" alt="Becas" title="Becas"><img class="ico-eco" src="img/grl/logo_DGOAE_small.gif" width="50" height="54" border="0"></a-->

            </div>

          </td>
          <td align="right" valign="bottom" width="16%">
                                  </td>
        </tr>
        <tr>
          <td colspan="4">
            <table class="TblBlk" cellspacing="0" cellpadding="1" align="center" width="100%">
              <tbody><tr align="center">
                <td class="CellTit">#</td>
                <td class="CellTit">PLANTEL</td>
                <td class="CellTit">CARRERA</td>
                <td class="CellTit">TURNO</td>
                <td class="CellTit">PLAN DE<br>ESTUDIO</td>
                <td class="CellTit">NOMBRE DEL PLAN DE ESTUDIO</td>
                <td class="CellTit">GENERACION</td>
                <td class="CellTit">INGRESO</td>
                <td class="CellTit">TERMINO</td>
                <td class="CellTit">APLICACION<br><a class="LnkTry" href="/acerca/normatividad.html#6">ART. 22</a></td>
                <td class="CellSti">NO APLICA<br><a class="LnkTry" href="/acerca/normatividad.html#Art24">ART. 24</a></td>
                <td class="CellTit">APLICACION<br><a class="LnkTry" href="/acerca/normatividad.html#Art21RG1">ART. 21</a></td>
              </tr>

              <tr><td class="CellSpa" align="center" colspan="12">NIVEL: BACHILLERATO</td></tr>

              <tr align="center">
                <td class="CellIco"><input type="radio" name="llave" value="502%2C472%2CB%2CE%2C27%2CP%2C199%2C52%2C34%2CE.N.P.+7+%22EZEQUIEL+A.+CHAVEZ%22"></td>
                <td class="CellDat"><span class="TitNfo" title="E.N.P. 7 &quot;EZEQUIEL A. CHAVEZ&quot;">0027</span></td>
                <td class="CellDat">&nbsp;</td>
                <td class="CellDat">03</td>
                <td class="CellDat">0472</td>
                <td class="CellDat" align="left">ENP AREA I FISICO-MAT Y LAS ING </td>
                <td class="CellDat">1999</td>
                <td class="CellDat">52</td>
                <td class="CellDat">34</td>
                <td class="CellDat">2004-0</td>
                <td class="CellTxt">2006-0</td>
                <td class="CellDat">2003-0</td>
              </tr>

              <tr><td class="CellSpa" align="center" colspan="12">CARRERA: [107] - INGENIERIA CIVIL</td></tr>

              <tr align="center">
                <td class="CellIco"><input type="radio" name="llave" value="107%2C365%2CL%2CE%2C11%2CP%2C202%2C54%2C36%2CFACULTAD+DE+INGENIERIA"></td>
                <td class="CellDat"><span class="TitNfo" title="FACULTAD DE INGENIERIA">0011</span></td>
                <td class="CellDat">107</td>
                <td class="CellDat">&nbsp;</td>
                <td class="CellDat">0365</td>
                <td class="CellDat" align="left">ING CIVIL </td>
                <td class="CellDat">2002</td>
                <td class="CellDat">54</td>
                <td class="CellDat">36</td>
                <td class="CellDat">2009-2</td>
                <td class="CellTxt">2012-1</td>
                <td class="CellDat">2007-1</td>
              </tr>

              <tr><td class="CellSpa" align="center" colspan="12">CARRERA: [110] - INGENIERIA EN COMPUTACION</td></tr>

              <tr align="center">
                <td class="CellIco"><input type="radio" name="llave" value="110%2C1194%2CL%2CE%2C11%2CP%2C202%2C68%2C11%2CFACULTAD+DE+INGENIERIA" checked=""></td>
                <td class="CellDat"><span class="TitNfo" title="FACULTAD DE INGENIERIA">0011</span></td>
                <td class="CellDat">110</td>
                <td class="CellDat">&nbsp;</td>
                <td class="CellDat">1194</td>
                <td class="CellDat" align="left">ING EN COMPUTACION-INGENIERIA DE SOFTWARE </td>
                <td class="CellDat">2002</td>
                <td class="CellDat">68</td>
                <td class="CellDat">11</td>
                <td class="CellDat">2010-1</td>
                <td class="CellTxt">2012-1</td>
                <td class="CellDat">2007-2</td>
              </tr>

              <tr><td class="CellTxt" colspan="12">
               INGRESO [52]: INGRESO A BACHILLERATO (ENP / CCH) (CONCURSO DE SELECCION)
              <br> TÉRMINO [34]: CONCLUYO BACHILLERATO (Y REALIZO PASE REGLAMENTADO)
              <br> INGRESO [54]: INGRESO A LICENCIATURA (PASE REGLAMENTADO)
              <br> TÉRMINO [36]: TERMINO POR CAMBIO DE PLANTEL Y/O CARRERA
              <br> INGRESO [68]: INGRESO POR CAMBIO INTERNO DE CARRERA
              <br> TÉRMINO [11]: TERMINACION DE ESTUDIOS (100% DE AVANCE EN CREDITOS)
              </td></tr>
                <tr>
                  <td class="CellCtr" colspan="12" align="left">
                    <select name="acc" id="acc">
                                            
                      <option value="hsac">Historia Académica Completa</option>
                      <option value="hsa" selected="">Historia Académica</option>
                      <option value="ins">Inscripción</option>
                      <option value="tit">Datos de Titulación</option>
                      <option value="mov">Registro de Movimientos</option>
                      <option value="amo">Movilidad Estudiantil</option>
                    </select>
                    <input class="boton" type="submit" value="Consultar">
                  </td>
                </tr>
              </tbody></table>
              
            </td>
          </tr>
        </tbody></table><br>

      <div class="no-print">

      <p>&nbsp;</p>
      <a href="javascript:history.back()" onmouseout="MM_swapImgRestore(); window.status=''; return true" onmouseover="MM_swapImage('flecha','','/img/mnu/icn_fdor.gif',1); window.status='Regresar'; return true"> &nbsp; <img src="/img/mnu/icn_fpla.gif" alt="Regresar" name="flecha" id="flecha" width="22" height="20" border="0"></a><br>
    </div>
    <!-- Aqui termina el Cuerpo -->
    </form></td>
  </tr>
</tbody></table>
  
  <p>&nbsp;</p>
    
  <script type="text/javascript">

    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-3632565-1', 'auto');
    ga('send', 'pageview');

  </script>


    <div id="facebox" style="display:none;">       <div class="popup">         <table>           <tbody>             <tr>               <td class="tl"></td><td class="b"></td><td class="tr"></td>             </tr>             <tr>               <td class="b"></td>               <td class="body">                 <div class="content">                 </div>                 <div class="footer">                   <a href="#" class="close">                     <img src="/img/ui/facebox/closelabel.gif" title="Cerrar" class="close_image">                   </a>                 </div>               </td>               <td class="b"></td>             </tr>             <tr>               <td class="bl"></td><td class="b"></td><td class="br"></td>             </tr>           </tbody>         </table>       </div>     </div></body></html>
"""
