unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    edt1: TEdit;
    Label1: TLabel;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn2Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  a, x, y, t, dt: Real;
  CenterX, CenterY: Integer;
begin

  // Получаем значение параметра a
  a := StrToFloat(edt1.Text);

  if a > 0 then
  begin
    // Определяем центр формы
    CenterX := ClientWidth div 2;
    CenterY := ClientHeight div 2;
    
    // Начальные параметры
    t := -5;
    dt := 0.01;
    
    // Рисуем оси координат
    Canvas.Pen.Color := clGray;
    Canvas.MoveTo(0, CenterY);
    Canvas.LineTo(ClientWidth, CenterY);
    Canvas.MoveTo(CenterX, 0);
    Canvas.LineTo(CenterX, ClientHeight);
    
    // Рисуем циклоиду
    Canvas.Pen.Color := clRed;

    // Первая точка
    x := a * (t - sin(t));
    y := a * (1 - cos(t));
    Canvas.MoveTo(CenterX + Round(x), CenterY - Round(y));
    
    while t <= 5 do
    begin
      x := a * (t - sin(t));  // Исправлено уравнение x
      y := a * (1 - cos(t));

      Canvas.LineTo(CenterX + Round(x), CenterY - Round(y));
      t := t + dt;
      
      // Небольшая задержка для визуализации процесса рисования
      Sleep(1);
      Application.ProcessMessages;
    end;
  end
  else
    ShowMessage('Параметр "a" должен быть больше 0!');
end;

end.
