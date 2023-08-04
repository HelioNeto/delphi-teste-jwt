program TesteJWT;

uses
  Vcl.Forms,
  uPrincipal in '..\JWTToken\uPrincipal.pas' {frmPrincipal},
  Api.Classes in '..\JWTToken\Classes\Api.Classes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
