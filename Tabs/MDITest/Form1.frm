VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   Begin VB.CommandButton Command2 
      Caption         =   "Change Caption"
      Height          =   510
      Left            =   1710
      TabIndex        =   1
      Top             =   225
      Width           =   1590
   End
   Begin VB.CommandButton Command1 
      Caption         =   "New Child"
      Height          =   510
      Left            =   225
      TabIndex        =   0
      Top             =   225
      Width           =   1185
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
    Dim a As New Form1
    a.Show
End Sub

Private Sub Command2_Click()
    Caption = "Form - " & Format(Now, "ss")
End Sub
