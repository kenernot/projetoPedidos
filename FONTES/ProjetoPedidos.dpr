program ProjetoPedidos;

uses
  System.StartUpCopy,
  FMX.Forms,
  u_main in 'u_main.pas' {F_Principal},
  U_Cadastro in 'U_Cadastro.pas' {F_Cadastro},
  u_Pedido in 'u_Pedido.pas' {F_Pedido};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_Principal, F_Principal);
  Application.CreateForm(TF_Cadastro, F_Cadastro);
  Application.CreateForm(TF_Pedido, F_Pedido);
  Application.Run;
end.
