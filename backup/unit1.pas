unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

  Initial_amount : real;
  Monthly_deposit : real;
  term : integer;
  annual_rate : real;
  inflation_rate : real;
  portfolio_value : real;


implementation

{$R *.lfm}

{ Процедура полного расчета стоимости портфеля по
  истечению срока в term лет с учетом того, что каждый год
  портфель увеличивается на annual_rate процентов и это увеличение
  реинвестируется (идет обратно в портфель на покупку акций). Плюс
  учитываются ежемесячные платежи в Monthly_deposit рублей }
procedure Calculation;
var month : integer;
    number_of_months : integer;
    monthly_rate : real;
    monthly_increase : real;
begin
   // начальная сумма
   if ( Form1.Edit1.Text <> '' ) then
      Initial_amount := StrToFloat(Form1.Edit1.Text)
   else Initial_amount := 0;
   // ежемесячный взнос
   if ( Form1.Edit2.Text <> '' ) then
         Monthly_deposit := StrToFloat(Form1.Edit2.Text)
   else Monthly_deposit := 0;
   // срок в годах
   if ( Form1.Edit3.Text <> '' ) then
      term := StrToInt(Form1.Edit3.Text)
   else term := 0;
   // годовой рост в %
   if ( Form1.Edit4.Text <> '' ) then
      annual_rate := StrToFloat(Form1.Edit4.Text)
   else annual_rate := 0;
   // среднегодовой коэффициент инфляции в %
   if ( Form1.Edit5.Text <> '' ) then
      inflation_rate := StrToFloat(Form1.Edit5.Text)
   else inflation_rate := 0;

   // стартовая сумма (накопления, которые есть на начальном этапе)
   portfolio_value := Initial_amount;
   // считаем количество месяцев за весь срок инвестирования
   number_of_months := 12 * term;
   // считаем рост за месяц (приближенно линейно) в %
   monthly_rate := annual_rate / 12;
   // оценка стоимости портфеля через term лет:
   for month := 1 to number_of_months do
      begin
          //Учет ежемесячного прироста портфеля из-за роста рынка
          monthly_increase := (0.01 * monthly_rate) * portfolio_value;
          portfolio_value := portfolio_value + monthly_increase;
          //Учет прироста портфеля за счет поступление ежемесячных вложений
          portfolio_value := portfolio_value + Monthly_deposit;
          //учет инфляции и среднее обесценивание портфеля за месяц
          //(очень приближенно и упрощенно, но достаточно для прогнозирования)
          portfolio_value := (1 - 0.01 * (inflation_rate / 12))* portfolio_value;
      end;

   //Обновления поля капитала на форме
   Form1.Label6.Caption := IntToStr(Round(portfolio_value))+ ' руб';
end;

{ TForm1 }


{ Обновления расчетов при изменениях полей }
procedure TForm1.Edit1Change(Sender: TObject);
begin
  Calculation;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  Calculation;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
  Calculation;
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
  Calculation;
end;

procedure TForm1.Edit5Change(Sender: TObject);
begin
   Calculation;
end;

{ Создание формы }
procedure TForm1.FormCreate(Sender: TObject);
begin
   Calculation;
end;





end.




















