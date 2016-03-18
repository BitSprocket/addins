Attribute VB_Name = "YingYang_Module"
' #VBIDEUtils#************************************************************
' * Programmer Name  : Thomas Detoux
' * Web Site         : http://www.vbasic.org/
' * E-Mail           : Detoux@hol.Fr
' * Date             : 8/12/98
' * Time             : 14:41
' * Module Name      : YingYang_Module
' * Module Filename  : YingYang.bas
' **********************************************************************
' * Comments         : CREATION DE FEUILLES EN FORME DE YING ET DE YANG
' *  Sample of call
' *    Call YingYang(Me)
' *
' *
' **********************************************************************

Option Explicit

'Cr�� une region en forme de rectangle entre les points (X1,Y1) et (X2,Y2)
Private Declare Function CreateRectRgn Lib "gdi32" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long

'Cr�� une r�gion en forme d'�llipse entre les points (X1,Y1) et (X2,Y2)
Private Declare Function CreateEllipticRgn Lib "gdi32" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long

'Combine deux r�gions pour en cr�er unr troisi�me selon le mode nCombineMode
Private Declare Function CombineRgn Lib "gdi32" (ByVal hDestRgn As Long, ByVal hSrcRgn1 As Long, ByVal hSrcRgn2 As Long, ByVal nCombineMode As Long) As Long

'Supprime un objet et lib�re de la m�moire
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long

'Cr�� une feuille ayant la forme d'une r�gion
Private Declare Function SetWindowRgn Lib "user32" (ByVal hWnd As Long, ByVal hRgn As Long, ByVal bRedraw As Boolean) As Long

'Constantes pour CombineRgn
Private Const RGN_AND = 1        'Intersection des deux r�gions
Private Const RGN_OR = 2         'Addition des deux r�gions
Private Const RGN_XOR = 3        'Difficile � d�crire ... essayez
'En fait, c'est un XOR : l'addition des 2 r�gions
'en retirant les parties communes aux 2 r�gions
Private Const RGN_DIFF = 4       'Soustraction de la r�gion 2 � la r�gion 1
Private Const RGN_COPY = 5       'Copie la r�gion 1

Private YY              As Long

Public Sub YingYang(obj As Form)
   ' #VBIDEUtils#************************************************************
   ' * Programmer Name  : removed
   ' * Web Site         : http://www.ppreview.net
   ' * E-Mail           : removed
   ' * Date             : 04/11/1999
   ' * Time             : 16:53
   ' * Module Name      : YingYang_Module
   ' * Module Filename  : YingYang.bas
   ' * Procedure Name   : YingYang
   ' * Parameters       :
   ' *                    obj As Form
   ' **********************************************************************
   ' * Comments         :
   ' *
   ' *
   ' **********************************************************************

   'D�claration des diff�rents "handles" des diff�rentes "r�gions" de la feuille, qui, r�unies, formeront le Ying Yang
   Dim Cercle           As Long
   Dim RECT             As Long
   Dim PCercleH         As Long
   Dim PCercleB         As Long
   Dim HCercle          As Long
   Dim Cadre            As Long
   Dim TrouB            As Long
   Dim TrouH            As Long
   Dim CercleBis        As Long
   Dim HCercleBis       As Long
   Dim CercleBisBis     As Long
   Dim Ying_Yang        As Long
   Dim YYang            As Long

   Dim h                As Long
   Dim l                As Long
   Dim HBord            As Long
   Dim LBord            As Long
   Dim HT               As Long
   Dim lT               As Long

   h = obj.Height / Screen.TwipsPerPixelY
   l = obj.Width / Screen.TwipsPerPixelX

   HBord = Int(h / 100)
   LBord = Int(l / 100)

   HT = Int(h / 10)
   lT = Int(l / 10)

   'Cr�ation des diff�rentes "r�gions", et combinaisons entre elles
   'Attention : pour r�aliser une combinaison, la variable-r�gion de destination
   'doit d�j� avoir �t� intialis�e en lui affectant une r�gion auparavant.

   HCercle = CreateEllipticRgn(((l - (2 * LBord)) / 4) + LBord, ((h - (2 * HBord)) / 2) + HBord, 3 * (((l - (2 * LBord)) / 4) + LBord), (h - HBord))
   Cercle = CreateEllipticRgn(LBord, HBord, l - LBord, h - HBord)
   RECT = CreateRectRgn(l / 2, 0, l, h)
   CombineRgn HCercle, Cercle, RECT, RGN_DIFF

   HCercleBis = CreateEllipticRgn(LBord, HBord, l - LBord, h - HBord)
   PCercleB = CreateEllipticRgn(((l - (2 * LBord)) / 4) + LBord, ((h - (2 * HBord)) / 2) + HBord, 3 * (((l - (2 * LBord)) / 4) + LBord), (h - HBord))
   CombineRgn HCercleBis, HCercle, PCercleB, RGN_DIFF

   CercleBis = CreateEllipticRgn(LBord, HBord, l - LBord, h - HBord)
   PCercleH = CreateEllipticRgn(((l - (2 * LBord)) / 4) + LBord, HBord, 3 * (((l - (2 * LBord)) / 4) + LBord), ((h - (2 * HBord)) / 2) + HBord)
   CombineRgn CercleBis, Cercle, PCercleH, RGN_DIFF

   CercleBisBis = CreateEllipticRgn(LBord, HBord, l - LBord, h - HBord)
   HCercle = CreateEllipticRgn(0, 0, l, h)
   CombineRgn CercleBisBis, CercleBis, HCercleBis, RGN_DIFF

   Ying_Yang = CreateEllipticRgn(0, 0, l, h)
   Cadre = CreateEllipticRgn(0, 0, l, h)
   CombineRgn Ying_Yang, Cadre, CercleBisBis, RGN_DIFF

   YYang = CreateEllipticRgn(0, 0, l, h)
   TrouB = CreateEllipticRgn(((l - (2 * LBord)) / 2) + LBord - (lT / 2), ((3 * (h - (2 * HBord)) / 4)) + HBord - (HT / 2), ((l - (2 * LBord)) / 2) + LBord + (lT / 2), ((3 * (h - (2 * HBord)) / 4)) + HBord + (HT / 2))
   CombineRgn YYang, Ying_Yang, TrouB, RGN_OR

   YY = CreateEllipticRgn(0, 0, l, h)
   TrouH = CreateEllipticRgn(((l - (2 * LBord)) / 2) + LBord - (lT / 2), ((h - (2 * HBord)) / 4) + HBord - (HT / 2), ((l - (2 * LBord)) / 2) + LBord + (lT / 2), ((h - (2 * HBord)) / 4) + HBord + (HT / 2))
   CombineRgn YY, YYang, TrouH, RGN_DIFF

   SetWindowRgn obj.hWnd, YY, True 'Applique la r�gion finale � la feuille

   'Suppression des r�gions
   DeleteObject Cercle
   DeleteObject RECT
   DeleteObject PCercleH
   DeleteObject PCercleB
   DeleteObject HCercle
   DeleteObject Cadre
   DeleteObject TrouB
   DeleteObject TrouH
   DeleteObject CercleBis
   DeleteObject HCercleBis
   DeleteObject CercleBisBis
   DeleteObject Ying_Yang
   DeleteObject YYang

End Sub
