unit U_Cadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects, FMX.MultiView;

type
  TF_Cadastro = class(TForm)
    ToolBar1: TToolBar;
    bt_menu: TButton;
    bt_info: TButton;
    Label1: TLabel;
    Layout1: TLayout;
    Label2: TLabel;
    lb_nome: TLabel;
    lb_cpf: TLabel;
    lb_fone: TLabel;
    ed_nome: TEdit;
    ed_cpf: TEdit;
    ed_fone: TEdit;
    ToolBar2: TToolBar;
    bt_done: TButton;
    bt_back: TButton;
    Label3: TLabel;
    ed_senha: TEdit;
    FDQuery1: TFDQuery;
    FDQuery1MAX: TLargeintField;
    function putAspas(texto: String): String;
    procedure bt_backClick(Sender: TObject);
    procedure bt_doneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Cadastro: TF_Cadastro;

implementation

{$R *.fmx}

uses u_main;

procedure TF_Cadastro.bt_backClick(Sender: TObject);
begin
  F_Principal.Show;
end;

procedure TF_Cadastro.bt_doneClick(Sender: TObject);
var
  sql: String;
  max: integer;
begin
  FDQuery1.Close;
  FDQuery1.Open();
  max := StrToInt(FDQuery1MAX.AsString) + 1;
  sql := 'insert into cadCli ' + //
    ' (id_cadcli, ' + //
    ' nome_cli, ' + //
    ' cpf_cli, ' + //
    ' telefone_cli, ' + //
    ' id_Cidade, ' + //
    ' senhacli) ' + //
    ' values(' + //
    IntToStr(max) + ',' + //
    putAspas(ed_nome.text) + ',' + //
    putAspas(ed_cpf.text) + ',' + //
    putAspas(ed_fone.text) + ',' + //
    '1,' +//
    putAspas(ed_senha.text) + ');';
  //ShowMessage(sql);
  F_Principal.FDConnection1.ExecSQL(sql);
end;

function TF_Cadastro.putAspas(texto: String): String;
begin
  result := QuotedStr(texto);
end;

end.
