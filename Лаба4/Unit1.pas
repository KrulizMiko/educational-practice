unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    FIsRunning: Boolean;
    procedure DrawSolarSystem;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  PI = 3.1415;
  EarthOrbitRadius = 100;  // Радиус орбиты Земли
  MoonOrbitRadius = 30;    // Радиус орбиты Луны
  SunRadius = 25;          // Радиус Солнца
  EarthRadius = 10;        // Радиус Земли
  MoonRadius = 5;          // Радиус Луны

  EarthSpeed = 2;          // Скорость Земли (h1)
  MoonSpeed = 25;          // Скорость Луны (h)

procedure TForm1.FormCreate(Sender: TObject);
begin
  FIsRunning := False;
  DoubleBuffered := True;  // Для уменьшения мерцания

end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  // Рисуем Солнце (неподвижное)
  Canvas.Brush.Color := clYellow;
  Canvas.Ellipse(
    ClientWidth div 2 - SunRadius,
    ClientHeight div 2 - SunRadius,
    ClientWidth div 2 + SunRadius,
    ClientHeight div 2 + SunRadius
  );
end;

procedure TForm1.DrawSolarSystem;
var
  EarthX, EarthY, MoonX, MoonY: Integer;
  EarthAngle, MoonAngle: Double;
  CenterX, CenterY: Integer;
begin
  CenterX := ClientWidth div 2;
  CenterY := ClientHeight div 2;
  
  EarthAngle := 0;
  MoonAngle := 0;

  while FIsRunning do
  begin
    // Вычисляем координаты Земли
    EarthX := CenterX + Round(EarthOrbitRadius * Sin(EarthAngle));
    EarthY := CenterY + Round(EarthOrbitRadius * Cos(EarthAngle));

    // Вычисляем координаты Луны относительно Земли
    MoonX := EarthX + Round(MoonOrbitRadius * Sin(MoonAngle));
    MoonY := EarthY + Round(MoonOrbitRadius * Cos(MoonAngle));

    // Очищаем предыдущие положения
    Canvas.Brush.Color := clBlack;
    Canvas.FillRect(ClientRect);

    // Рисуем Солнце
    Canvas.Brush.Color := clYellow;
    Canvas.Ellipse(
      CenterX - SunRadius,
      CenterY - SunRadius,
      CenterX + SunRadius,
      CenterY + SunRadius
    );

    // Рисуем орбиту Земли
    Canvas.Pen.Color := clGray;
    Canvas.Brush.Style := bsClear;
    Canvas.Ellipse(
      CenterX - EarthOrbitRadius,
      CenterY - EarthOrbitRadius,
      CenterX + EarthOrbitRadius,
      CenterY + EarthOrbitRadius
    );

    // Рисуем Землю
    Canvas.Brush.Color := clBlue;
    Canvas.Ellipse(
      EarthX - EarthRadius,
      EarthY - EarthRadius,
      EarthX + EarthRadius,
      EarthY + EarthRadius
    );

    // Рисуем орбиту Луны
    Canvas.Pen.Color := clSilver;
    Canvas.Ellipse(
      EarthX - MoonOrbitRadius,
      EarthY - MoonOrbitRadius,
      EarthX + MoonOrbitRadius,
      EarthY + MoonOrbitRadius
    );

    // Рисуем Луну
    Canvas.Brush.Color := clWhite;
    Canvas.Ellipse(
      MoonX - MoonRadius,
      MoonY - MoonRadius,
      MoonX + MoonRadius,
      MoonY + MoonRadius
    );

    // Обновляем углы
    EarthAngle := EarthAngle + 2 * PI * EarthSpeed / 360;
    MoonAngle := MoonAngle + 2 * PI * MoonSpeed / 360;

    // Задержка для анимации
    Sleep(50);
    Application.ProcessMessages;
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  if not FIsRunning then
  begin
    FIsRunning := True;
    DrawSolarSystem;
  end;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  FIsRunning := False;
  Refresh;  // Перерисовываем форму (останется только Солнце)
end;

end.
