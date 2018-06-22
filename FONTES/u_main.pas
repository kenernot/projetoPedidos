unit u_main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.MultiView, FMX.Objects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  System.IOUtils;

type
  TF_Principal = class(TForm)
    ToolBar1: TToolBar;
    bt_menu: TButton;
    bt_info: TButton;
    Layout1: TLayout;
    Label1: TLabel;
    MultiView1: TMultiView;
    Label2: TLabel;
    ToolBar2: TToolBar;
    Rectangle1: TRectangle;
    Label3: TLabel;
    Rectangle2: TRectangle;
    Label4: TLabel;
    Rectangle3: TRectangle;
    Label5: TLabel;
    Rectangle4: TRectangle;
    Label6: TLabel;
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    Button1: TButton;
    procedure Label6Click(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Principal: TF_Principal;

implementation

{$R *.fmx}

uses U_Cadastro, u_Pedido;

procedure TF_Principal.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: String;
begin


    strSQL := EmptyStr;
    strSQL := //

    'CREATE TABLE IF NOT EXISTS Estado ( 								' + //
    '       id_Estado int not null primary key,			' + //
    '       Nome_Estado varchar(25),					' + //
    '       SiglaUF char(2)								' + //
    ');													' + //
    '';
    FDConnection1.ExecSQL(strSQL);
    strSQL := EmptyStr;

    strSQL := //

    'CREATE TABLE IF NOT EXISTS Cidade (											' + //
    '       id_Cidade int not null primary key,						' + //
    '       Nome_Cidade varchar(45),								' + //
    '       id_Estado int not null,									' + //
    '        foreign key(id_Estado) references Estado(id_Estado)	' + //
    ');																' + //
    '';
    FDConnection1.ExecSQL(strSQL);
    strSQL := EmptyStr;

    strSQL := //
    'CREATE TABLE IF NOT EXISTS Grupo_Produto (									' + //
    '       id_Grupo_Produto int not null primary key,				' + //
    '       Nome_Grupo varchar(25),									' + //
    '       interno boolean											' + //
    ');																' + //
    '';
    FDConnection1.ExecSQL(strSQL);
    strSQL := EmptyStr;

    strSQL := //
    'CREATE TABLE IF NOT EXISTS "CadCli" (										' + //
    '       id_CadCli int not null primary key,						' + //
    '       Nome_Cli varchar(60),									' + //
    '       CPF_Cli varchar(14),									' + //
    '       Telefone_Cli varchar(14),								' + //
    '       Endereco_Cli varchar(60),								' + //
    '       id_Cidade int not null, senhaCli VARCHAR(20),       	' + //
    '       foreign key(id_Cidade) references Cidade(id_Cidade)		' + //
    ');																' + //
    '';
    FDConnection1.ExecSQL(strSQL);
    strSQL := EmptyStr;

    strSQL := //
    'CREATE TABLE IF NOT EXISTS Pedido (											' + //
    '       id_Pedido int not null primary key,						' + //
    '       id_Cliente int not null,								' + //
    '       Data_Pedido date,										' + //
    '       Hora_Pedido time,										' + //
    '       Valor_Pedido numeric(8,2),								' + //
    '       Obs_Pedido varchar(60),									' + //
    '       foreign key (id_Cliente) references CadCli(id_CadCli)	' + //
    ');																' + //
    '';
    FDConnection1.ExecSQL(strSQL);
    strSQL := EmptyStr;

    strSQL := //
    'CREATE TABLE IF NOT EXISTS Produto (															' + //
    '  id_Produto int not null primary key,											' + //
    '  Nome_Produto varchar(30),													' + //
    '  Descricao_Produto varchar(60),												' + //
    '  Valor_Produto numeric(8,2),													' + //
    '  Imagem_Produto blob,															' + //
    '  Status_Produto boolean,														' + //
    '  Data_Cadastro date,															' + //
    '  id_Grupo_Produto int not null,												' + //
    '  foreign key (id_Grupo_Produto) references Grupo_Produto(id_Grupo_Produto)	'
    + //
    ');																				' + //
    '';
    FDConnection1.ExecSQL(strSQL);
    strSQL := EmptyStr;

    strSQL := //

    'CREATE TABLE IF NOT EXISTS Item_Pedido (														' + //
    '       id_Item_Pedido int not null primary key,								' + //
    '       id_Pedido int not null,													' + //
    '       id_Produto int not null,												' + //
    '       Qte_Item_Pedido numeric(8,2),											' + //
    '       Valor_Item_Pedido numeric(8,2),											' + //
    '       foreign key (id_Pedido) references Pedido(id_Pedido),					' + //
    '       foreign key (id_Produto) references Produto(id_Produto)					' +
    //
    ');																				' + //
    '';
    FDConnection1.ExecSQL(strSQL);
    strSQL := EmptyStr;

    strSQL := //

    'CREATE TABLE IF NOT EXISTS Adicional_Item (													' + //
    '       id_Adicionais int not null primary key,									' + //
    '       id_Item_Pedido int not null,											' + //
    '       id_Produto int not null,												' + //
    '       foreign key (id_Item_Pedido) references Item_Pedido(id_Item_Pedido),	'
    + //
    '       foreign key (id_Produto) references Produto(id_Produto)					' +
    //

    ');																				' + //
    '';
    FDConnection1.ExecSQL(strSQL);
    strSQL := EmptyStr;

end;

procedure TF_Principal.FDConnection1BeforeConnect(Sender: TObject);
var
  strPath: String;
  strSQL: String;
begin

{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine('C:\Documentos\ProjetoPedidos\BD',
    'banco.db');
{$ENDIF}
{$IF DEFINED (iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
    'banco.db');
{$ENDIF}
  FDConnection1.Params.Values['DATABASE'] := strPath;
  // FDConnection1.Connected := true;

end;

procedure TF_Principal.Label6Click(Sender: TObject);
begin
  F_Cadastro.Show;
end;

procedure TF_Principal.Rectangle3Click(Sender: TObject);
begin
  F_Pedido.Show;
end;

procedure TF_Principal.Rectangle4Click(Sender: TObject);
begin
  F_Cadastro.Show;
end;

end.
