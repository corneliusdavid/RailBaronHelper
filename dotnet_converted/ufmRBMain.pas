unit ufmRBMain;

interface

uses
  SysUtils, Forms, Dialogs, Types, Classes, ComCtrls, StdCtrls,
  Buttons, Controls, ExtCtrls, Graphics;

type
  TfrmRBMain = class(TForm)
    pnlPayoffs: TPanel;
    lblPayoffs: TLabel;
    tvCity1: TTreeView;
    tvCity2: TTreeView;
    pnlRight: TPanel;
    lbPayoffs: TListBox;
    Panel1: TPanel;
    pnlRegions: TPanel;
    lblRegions: TLabel;
    lbRegions: TListBox;
    pnlSouthwest: TPanel;
    Label7: TLabel;
    lbSouthwest: TListBox;
    pnlNorthwest: TPanel;
    Label6: TLabel;
    lbNorthwest: TListBox;
    pnlPlains: TPanel;
    Label5: TLabel;
    lbPlains: TListBox;
    pnlSouthCentral: TPanel;
    Label4: TLabel;
    lbSouthCentral: TListBox;
    pnlNorthCentral: TPanel;
    Label3: TLabel;
    lbNorthCentral: TListBox;
    btnRollRegion: TBitBtn;
    edtRegionOddEven: TEdit;
    edtCity1: TEdit;
    edtCity2: TEdit;
    edtRegion1: TEdit;
    edtRegion2: TEdit;
    edtCityOddEven: TEdit;
    btnRollCity: TBitBtn;
    pgcRegions: TPageControl;
    shtNorthEast: TTabSheet;
    shtSouthEast: TTabSheet;
    shtNortnCentral: TTabSheet;
    shtSouthCentral: TTabSheet;
    shtPlains: TTabSheet;
    pnlNortheast: TPanel;
    Label1: TLabel;
    lbNortheast: TListBox;
    pnlSoutheast: TPanel;
    Label2: TLabel;
    lbSoutheast: TListBox;
    shtNorthWest: TTabSheet;
    shtSouthWest: TTabSheet;
    pnlPayoffBottom: TPanel;
    btnGeneratePayoff: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure btnRollRegionClick(Sender: TObject);
    procedure btnRollCityClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGeneratePayoffClick(Sender: TObject);
    procedure lbRegionsDblClick(Sender: TObject);
  private
    fCities: TStringList;
    CityName1, CityName2: string;
    Payoff: Single;
    procedure PickRegion;
    procedure ClearCities;
    procedure PickCityFromRegion;
    procedure BringSelectedRegionPanelToFront;
  end;

var
  frmRBMain: TfrmRBMain;


implementation

uses
  Math;

{$R *.dfm}

procedure TfrmRBMain.PickRegion;
var
  RegionOddEven, Region1, Region2, RegionOffset: Integer;
begin
  lbRegions.SetFocus;

  // randomly pick a region
  RegionOddEven := Random(6) + 1;
  Region1 := Random(6) + 1;
  Region2 := Random(6) + 1;

  // show the "rolled dice"
  edtRegionOddEven.Text := IntToStr(RegionOddEven);
  edtRegion1.Text := IntToStr(Region1);
  edtRegion2.Text := IntToStr(Region2);

  // show selected region
  RegionOffset := Region1 + Region2 - 2;
  if not Odd(RegionOddEven) then
    Inc(RegionOffset, 11);
  lbRegions.ItemIndex := RegionOffset;

  BringSelectedRegionPanelToFront;
end;

procedure TfrmRBMain.ClearCities;
begin
  lbNortheast.ItemIndex := -1;
  lbSoutheast.ItemIndex := -1;
  lbNorthCentral.ItemIndex := -1;
  lbSouthCentral.ItemIndex := -1;
  lbPlains.ItemIndex := -1;
  lbNorthwest.ItemIndex := -1;
  lbSouthwest.ItemIndex := -1;
end;

procedure TfrmRBMain.PickCityFromRegion;
var
  CityOddEven, City1, City2, CityOffset: Integer;
  RegionStr: string;
  CityListBox: TListBox;
begin
  // select listbox from region
  RegionStr := lbRegions.Items[lbRegions.ItemIndex];
  while Pos(' ', RegionStr) > 0 do
    Delete(RegionStr, Pos(' ', RegionStr), 1);
  CityListBox := FindComponent('lb' + RegionStr) as TListBox;

  CityOddEven := Random(6) + 1;
  City1 := Random(6) + 1;
  City2 := Random(6) + 1;

  edtCityOddEven.Text := IntToStr(CityOddEven);
  edtCity1.Text := IntToStr(city1);
  edtCity2.Text := IntTostr(city2);

  // set city within region
  CityOffset := City1 + City2 - 2;
  if not Odd(CityOffset) then
    Inc(CityOffset, 11);
  CityListBox.ItemIndex := CityOffset;

  pgcRegions.ActivePageIndex := Integer(CityListBox.Tag);
  CityListBox.SetFocus;
end;

procedure TfrmRBMain.btnRollRegionClick(Sender: TObject);
begin
  Randomize;

  ClearCities;
  PickRegion;
end;

procedure TfrmRBMain.btnRollCityClick(Sender: TObject);
begin
  BringSelectedRegionPanelToFront;
  ClearCities;
  PickCityFromRegion;
end;

procedure TfrmRBMain.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  fCities := TStringList.Create;
  for i := 0 to tvCity1.Items.Count - 1 do
    if not tvCity1.Items[i].HasChildren then
      fCities.Add(tvCity1.Items[i].Text);
end;

procedure TfrmRBMain.FormDestroy(Sender: TObject);
begin
  fCities.Free;
end;

procedure TfrmRBMain.btnGeneratePayoffClick(Sender: TObject);
const
  Northeast: array[1..67, 1..9] of Single = (
    {Albany}       (0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Baltimore}    (3.5, 0, 0, 0, 0, 0, 0, 0, 0),
    {Boston}       (2, 4, 0, 0, 0, 0, 0, 0, 0),
    {Buffalo}      (3, 4, 5, 0, 0, 0, 0, 0, 0),
    {New York}     (1.5, 2, 2.5, 4, 0, 0, 0, 0, 0),
    {Philadelphia} (2.5, 1, 3, 4, 1, 0, 0, 0, 0),
    {Pittsburgh}   (5.5, 3.5, 6.5, 2.5, 4.5, 3.5, 0, 0, 0),
    {Porland, Me.} (3, 5.5, 1, 6, 3.5, 4.5, 8, 0, 0),
    {Washington}   (3.5, 5, 4.5, 4.5, 2, 1.5, 3, 5.5, 0),
    {Atlanta}      (10, 7, 11, 9.5, 8.5, 7.5, 8, 12, 6.5),
    {Charleson}    (9.5, 5.5, 9.5, 9.5, 7.5, 8, 8, 11, 5),
    {Charlotte}    (7.5, 4, 8.5, 8, 6, 5, 6, 9.5, 4),
    {Chattanooga}  (10, 6.5, 11.5, 8, 8.5, 7.5, 7, 12, 6),
    {Jacksonville} (11, 8, 12, 12, 10, 9, 10.5, 13, 6),
    {Knoxville}    (8.5, 5.5, 9.5, 7.5, 7.5, 6.5, 6, 10.5, 5),
    {Miami}        (15, 11.5, 16, 15.5, 13.5, 12.5, 14, 17, 11),
    {Mobile}       (13.5, 10.5, 14.5, 12, 12, 11, 10.5, 14.5, 10),
    {Norfolk}      (6, 2.5, 7, 6.5, 4.5, 3.5, 5, 8, 2.5),
    {Richmond}     (5, 1.5, 5.5, 5.5, 3.5, 2.5, 4, 7, 1),
    {Tampa}        (13.5, 10, 14, 14, 12, 11, 12.5, 15, 9.5),
    {Chicago}      (8, 8, 10, 5, 9, 8, 4.5, 11.5, 7.5),
    {Cincinnati}   (7, 6, 9.5, 4.5, 7.5, 6.5, 3, 10.5, 5.5),
    {Cleveland}    (5, 4.5, 7, 2, 5.5, 5, 1.5, 8, 4.5),
    {Columbus}     (6, 5, 8, 3, 6.5, 5.5, 2, 9.5, 5),
    {Detroit}      (5.5, 6, 7.5, 2.5, 6.5, 6.5, 3, 8.5, 6),
    {Indianapolis} (7.5, 7, 9.5, 4.5, 8, 7, 3.5, 10.5, 6.5),
    {Milwaukie}    (9, 8, 11, 6, 10, 9, 5.5, 12, 8.5),
    {St. Louis}    (10, 9, 12, 7, 10.5, 9.5, 6, 13, 9),
    {Birmingham}   (11, 8, 12, 9, 10, 9, 8, 13.5, 7.5),
    {Dallas}       (17, 14.5, 18.5, 14, 16, 15.5, 13, 19.5, 14),
    {Fort Worth}   (17, 14.5, 19.5, 14, 16.5, 15.5, 13, 20.5, 14),
    {Houston}      (18.5, 15, 19.5, 15.5, 17, 16, 14.5, 20.5, 15),
    {Little Rock}  (13.5, 11, 15, 10.5, 13, 12, 9.5, 18, 10.5),
    {Louisville}   (8.5, 7, 10.5, 5.5, 8.5, 8, 4.5, 11.5, 6.5),
    {Memphis}      (12.5, 9.5, 14, 9.5, 11.5, 10.5, 8, 15, 9.5),
    {Nashville}    (10.5, 7.5, 12, 7.5, 9.5, 8.5, 6, 13, 7),
    {New Orleans}  (15, 11.5, 15.5, 13, 13.5, 12.5, 11.5, 16.5, 11),
    {San Antonio}  (19.5, 17, 21, 16.5, 19, 18, 15.5, 22.5, 17),
    {Shreveport}   (13, 12.5, 16.5, 14, 15.5, 13.5, 12, 18, 12),
    {Denver}       (18.5, 18, 20.5, 15.5, 19.5, 18.5, 15, 21.5, 18),
    {Des Moines}   (12, 11.5, 14, 9, 12.5, 11.5, 8.5, 15, 11),
    {Fargo}        (14.5, 14.5, 16.5, 11.5, 15.5, 14.5, 11, 17.5, 14),
    {Kansas City}  (12.5, 12, 14.5, 9.5, 13.5, 12, 9, 16, 11.5),
    {Minneapolis}  (12.5, 12, 14, 9, 13, 12, 8.5, 15.5, 11.5),
    {Oklahoma City}(15.5, 14.5, 17.5, 12.5, 16, 15, 11.5, 18.5, 14),
    {Omaha}        (13, 13, 15, 10, 14, 13, 9.5, 16, 12.5),
    {Pueblo}       (18.5, 18, 21, 15.5, 19.5, 18.5, 15, 22, 18),
    {St. Paul}     (12, 12, 14, 9, 13, 12, 8.5, 15.5, 11.5),
    {Billings}     (21, 21, 23, 18, 22, 21, 17.5, 24, 20.5),
    {Butte}        (23.5, 23, 25.5, 20.5, 24, 23.5, 20, 26.5, 22.5),
    {Casper}       (18, 18, 20, 15, 19, 18, 14.5, 21.5, 17.5),
    {Pocatello}    (23.5, 23.5, 25.5, 20.5, 24.5, 23.5, 20, 27, 23),
    {Portland,Ore.}(30, 30.5, 32, 27, 31, 30, 26.5, 33.5, 30),
    {Rapid City}   (17, 17, 20.5, 14, 18, 17, 13.5, 21.5, 18),
    {Salt Lk City} (23.5, 23, 25.5, 20.5, 24, 23.5, 20, 26.5, 23),
    {Seattle}      (31.5, 29.5, 31.5, 26.5, 30.5, 29.5, 26, 32.5, 29),
    {Spokane}      (26.5, 26.5, 28.5, 23.5, 27.5, 26.5, 23, 29.5, 26),
    {El Paso}      (22, 21, 24, 19, 23, 22, 18.5, 25.5, 20.5),
    {Las Vegas}    (28, 27.5, 30, 25, 28, 28, 24.5, 26, 27.5),
    {Los Angeles}  (30.5, 29, 32.5, 27.5, 31, 30, 26.5, 33.5, 29),
    {Oakland}      (31, 30.5, 33, 28, 31.5, 31, 27.5, 34, 30.5),
    {Phoenix}      (27.5, 27, 29.5, 24.5, 28, 27, 23.5, 30.5, 26.5),
    {Reno}         (25.5, 28.5, 30.5, 25.5, 29.5, 28.5, 25, 31.5, 28),
    {Sacramento}   (27, 30, 32, 27, 31, 30, 26.5, 33.5, 29.5),
    {San Diego}    (31.5, 28.5, 32.5, 27, 30.5, 29.5, 26, 33.5, 28.5),
    {San Francisco}(31, 30.5, 33, 28, 31.5, 31, 27.5, 34, 30.5),
    {Tucumcari}    (18.5, 18.5, 21, 16.5, 20, 19, 15.5, 22, 18));
  Southeast: array[10..67, 10..20] of Single = (
    {Atlanta}      (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Charleston}   (3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Charlotte}    (2.5, 2.5, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Chattanooga}  (1.5, 4.5, 4, 0, 0, 0, 0, 0, 0, 0, 0),
    {Jacksonville} (3.5, 2.5, 4, 5, 0, 0, 0, 0, 0, 0, 0),
    {Knoxville}    (2, 4, 2.5, 1, 5.5, 0, 0, 0, 0, 0, 0),
    {Miami}        (7, 6, 7.5, 8.5, 3, 9, 0, 0, 0, 0, 0),
    {Mobile}       (3.5, 6, 6, 5, 4, 5.5, 8.5, 0, 0, 0, 0),
    {Norfolk}      (5.5, 4.5, 4, 6.5, 6, 5.5, 9.5, 9.5, 0, 0, 0),
    {Richmond}     (6, 4, 3.5, 6, 6.5, 5, 10, 9.5, 1, 0, 0),
    {Tampa}        (5.5, 4.5, 6, 2, 2, 7, 2, 6.5, 8, 8.5, 0),
    {Chicago}      (7.5, 10, 8.5, 6, 11, 5.5, 14.5, 8.5, 9.5, 8.5, 12.5),
    {Cincinnati}   (5, 7, 5.5, 3.5, 8.5, 3, 12, 7.5, 7, 6, 10),
    {Cleveland}    (7.5, 9.5, 6.5, 6, 11, 5.5, 14.5, 10, 6.5, 5.5, 12.5),
    {Columbus}     (6, 8.5, 6, 4.5, 9.5, 4, 13, 8, 7, 5.5, 11.5),
    {Detroit}      (7.5, 10, 8, 6, 11, 5, 14.5, 10, 8, 7, 12.5),
    {Indianapolis} (6, 8, 6.5, 4.5, 9.5, 4, 13, 8, 8, 7, 11),
    {Milwaukie}    (8, 11, 9.5, 7, 11.5, 6.5, 15.5, 9, 10.5, 9.5, 13.5),
    {St. Louis}    (6, 9, 8, 4.5, 9, 5.5, 13, 6.5, 10, 9, 11),
    {Birmingham}   (1.5, 5, 4, 1.5, 4.5, 2.5, 8, 3, 7, 7.5, 6),
    {Dallas}       (8, 11.5, 11, 9, 11, 9, 14.5, 6, 14, 14, 12.5),
    {Fort Worth}   (8, 11.5, 11, 9, 11, 9, 14.5, 6, 14, 14, 12.5),
    {Houston}      (8.5, 11.5, 11, 8.5, 9.5, 9.5, 13.5, 5, 14.5, 14.5, 11.5),
    {Little Rock}  (5.5, 8.5, 8.5, 5.5, 8, 5.5, 11.5, 5, 11, 10.5, 9.5),
    {Louisville}   (4.5, 7, 5.5, 3, 8, 3, 12, 5.5, 8, 7, 10),
    {Memphis}      (4, 7.5, 7, 4, 7, 4, 10.5, 3.5, 9.5, 9, 8.5),
    {Nashville}    (3, 6, 5, 1.5, 6.5, 2, 10, 5, 8, 7, 8),
    {New Orleans}  (5, 7.5, 7.5, 6.5, 6, 6, 10, 1.5, 10, 10.5, 8),
    {San Antonio}  (10.5, 13.5, 13.5, 10.5, 12, 11.5, 15.5, 7, 16, 16.5, 13.5),
    {Shreveport}   (6.5, 9.5, 9, 7, 9, 8, 12.5, 4.5, 12, 12, 11),
    {Denver}       (15.5, 18.5, 18, 14, 18, 14.5, 22, 15, 19, 18.5, 20),
    {Des Moines}   (9.5, 13, 11.5, 8, 13, 9, 16.5, 10, 13, 12, 14.5),
    {Fargo}        (13.5, 16.5, 15, 12.5, 7, 12, 21, 14.5, 16, 15, 19),
    {Kansas City}  (9, 12, 11, 7.5, 11.5, 8, 15.5, 8.5, 13, 12, 13.5),
    {Minneapolis}  (11.5, 14, 12.5, 10, 15, 9.5, 18.5, 12.5, 13.5, 12.5, 16.5),
    {Oklahoma City}(9, 12, 11.5, 9, 12, 9, 15.5, 8, 15, 14, 13.5),
    {Omaha}        (10, 13.5, 12.5, 9, 13.5, 9.5, 17, 10.5, 14, 13.5, 15),
    {Pueblo}       (15, 18.5, 18, 14, 18, 14.5, 21.5, 14, 19, 18.5, 20),
    {St. Paul}     (11.5, 14, 12.5, 10, 15, 9.5, 18.5, 12.5, 13.5, 12.5, 16.5),
    {Billings}     (19, 22.5, 21, 18, 22.5, 18.5, 26, 19, 22, 21.5, 24),
    {Butte}        (21.5, 26, 17.5, 14, 24.5, 21, 28.5, 21, 25, 23.5, 26.5),
    {Casper}       (25.5, 19, 17.5, 14, 18.5, 14.5, 22, 15.5, 19, 18.5, 15),
    {Pocatello}    (21, 24, 23, 21.5, 23.5, 20.5, 27.5, 22.5, 24.5, 24, 23.5),
    {Portland,Ore.}(28, 31, 30.5, 26.5, 31.5, 27.5, 35, 28.5, 32, 31, 33),
    {Rapid City}   (16, 19, 18, 14.5, 19, 15, 22.5, 16, 19.5, 19, 20.5),
    {Salt Lk City} (20.5, 23.5, 22.5, 20.5, 23.5, 20, 27, 19.5, 24.5, 23.5, 25),
    {Seattle}      (28, 31.5, 30, 27, 31.5, 27, 35, 28, 31, 30, 33),
    {Spokane}      (28, 28, 27, 18.5, 28, 24, 32, 25, 28, 27, 30),
    {El Paso}      (14.5, 19, 17.5, 15.5, 17.5, 15.5, 21.5, 13, 21, 20.5, 19.5),
    {Las Vegas}    (23, 26.5, 26, 24, 26, 24.5, 30, 21.5, 29, 28, 28.5),
    {Los Angeles}  (23, 26, 25.5, 23.5, 26, 23.5, 29.5, 21, 29.5, 28.5, 27.5),
    {Oakland}      (27, 30.5, 30, 27, 30, 27, 33.5, 26, 32, 31, 31.5),
    {Phoenix}      (19, 22.5, 24, 19, 22, 21.5, 26, 17.5, 26.5, 26.5, 24),
    {Reno}         (26, 29.5, 27.5, 24.5, 27.5, 25, 33, 25, 28.5, 28, 31),
    {Sacramento}   (27, 31, 29, 26, 29, 26.5, 33.5, 26, 31, 30.5, 31.5),
    {San Diego}    (22.5, 26, 25.5, 23.5, 25.5, 23.5, 29, 21, 28, 28.5, 27),
    {San Francisco}(27, 30.5, 30, 27, 30, 27, 33.5, 26, 32, 31, 31.5),
    {Tucumcari}    (13, 16, 15.5, 13, 16, 13, 19.5, 11.5, 18.5, 18, 17.5));
  NorthCentral: array[21..67, 21..28] of Single = (
    {Chicago}      (0, 0, 0, 0, 0, 0, 0, 0),
    {Cincinnati}   (3, 0, 0, 0, 0, 0, 0, 0),
    {Cleveland}    (3.5, 2.5, 0, 0, 0, 0, 0, 0),
    {Columbus}     (3.5, 1, 1.5, 0, 0, 0, 0, 0),
    {Detroit}      (2.5, 2.5, 1.5, 2, 0, 0, 0, 0),
    {Indianapolis} (2, 1, 3, 1.5, 3, 0, 0, 0),
    {Milwaukie}    (1, 3.5, 4, 4, 3.5, 2.5, 0, 0),
    {St. Louis}    (3, 3.5, 5, 4, 5, 2.5, 3.5, 0),
    {Birmingham}   (6.5, 5, 7.5, 6, 7.5, 5, 7.5, 5),
    {Dallas}       (9.5, 9.5, 12.5, 11, 12, 9.5, 10.5, 7),
    {Fort Worth}   (9.5, 9.5, 12.5, 11, 12, 9.5, 10.5, 7),
    {Houston}      (12, 12.5, 13.5, 13, 13.5, 11, 11, 9),
    {Little Rock}  (6.5, 6.5, 9, 6.5, 9, 5, 7.5, 3.5),
    {Louisville}   (3, 1, 3.5, 2.5, 3.5, 1, 4, 2.5),
    {Memphis}      (5.5, 5, 7, 6, 7.5, 5, 6, 3),
    {Nashville}    (4.5, 3, 5.5, 4, 5.5, 3, 5.5, 3),
    {New Orleans}  (9, 8.5, 11, 9.5, 11, 8.5, 10, 7),
    {San Antonio}  (12, 12.5, 14.5, 13.5, 14, 11.5, 13, 9),
    {Shreveport}   (8.5, 8.5, 11, 11.5, 10.5, 9, 8.5, 8.5),
    {Denver}       (10.5, 12.5, 13.5, 13, 13, 11.5, 10.5, 9),
    {Des Moines}   (3.5, 6.5, 7, 7, 6.5, 5.5, 3.5, 3.5),
    {Fargo}        (6.5, 9, 10, 9.5, 9, 8, 5.5, 8),
    {Kansas City}  (4.5, 6, 8, 6.5, 7, 5, 5.5, 3),
    {Minneapolis}  (4, 7, 7.5, 7.5, 6.5, 6, 3.5, 5.5),
    {Oklahoma City}(8, 9, 10.5, 10, 10.5, 7.8, 8.5, 5.5),
    {Omaha}        (5, 7.5, 8.5, 8, 7.5, 6.5, 5, 4),
    {Pueblo}       (10.5, 12.5, 13.5, 13, 13, 11.5, 11.5, 9),
    {St. Paul}     (4, 7, 7.5, 7.5, 6.5, 6, 3.5, 5.5),
    {Billings}     (13, 15.5, 16, 16, 15.5, 14.5, 12, 13),
    {Butte}        (15, 18, 18.5, 18.5, 18, 17, 14.5, 15.5),
    {Casper}       (10, 12.5, 13.5, 13, 12.5, 11.5, 10, 10),
    {Pocatello}    (15, 18, 19, 18.5, 18, 17, 15.5, 14.5),
    {Portland,Ore.}(22, 24.5, 25.5, 25.5, 25, 24.5, 21.5, 22),
    {Rapid City}   (9, 12, 12.5, 13.5, 13, 11, 9, 9.5),
    {Salt Lk City} (15, 18, 18.5, 18, 18, 17, 15, 14.5),
    {Seattle}      (21.5, 24, 25, 25, 24, 23, 21, 22),
    {Spokane}      (18.5, 21, 21.5, 21.5, 21, 20, 18, 19),
    {El Paso}      (14, 15.5, 17.5, 17, 16.5, 15, 14.5, 12),
    {Las Vegas}    (19.5, 22.5, 23, 22.5, 22.5, 21.5, 19.5, 19),
    {Los Angeles}  (22.5, 23.5, 25.5, 24, 25, 22.5, 22.5, 20.5),
    {Oakland}      (22.5, 25.5, 26, 26.5, 25.5, 24.5, 22.5, 22),
    {Phoenix}      (19.5, 21, 22.5, 21.5, 22, 20, 19.5, 18),
    {Reno}         (20, 23, 23.5, 23.5, 23, 22, 20.5, 20.5),
    {Sacramento}   (22, 24.5, 25, 25, 24.5, 23.5, 22, 21),
    {San Diego}    (22, 23.5, 25, 24, 24.5, 22.5, 23, 20),
    {San Francisco}(22.5, 25.5, 26, 26.5, 25.5, 24.5, 22.5, 22),
    {Tucumcari}    (11, 12.5, 14.5, 14, 14, 11.5, 11, 9.5));
  SouthCentral: array[29..67, 29..39] of Single = (
    {Birmingham}   (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Dallas}       (6.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Fort Worth}   (6.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Houston}      (7, 2.5, 2.5, 0, 0, 0, 0, 0, 0, 0, 0),
    {Little Rock}  (4, 3.5, 4, 4, 0, 0, 0, 0, 0, 0, 0),
    {Louisville}   (4, 8.5, 8.5, 10, 5, 0, 0, 0, 0, 0, 0),
    {Memphis}      (2.5, 9, 9, 6, 1.5, 4, 0, 0, 0, 0, 0),
    {Nashville}    (2, 7, 7, 8.5, 3.5, 2, 2.5, 0, 0, 0, 0),
    {New Orleans}  (3.5, 5, 5, 3.5, 4.5, 7.5, 4, 5.5, 0, 0, 0),
    {San Antonio}  (9.5, 2.5, 2.5, 2.5, 6, 11, 7.5, 10, 5.5, 0, 0),
    {Shreveport}   (4.5, 2, 2, 2.5, 2, 8, 4, 6.5, 3, 5, 0),
    {Denver}       (13.5, 8.5, 8.5, 11, 11, 12, 11, 12.5, 13.5, 11, 10),
    {Des Moines}   (8, 7.5, 7.5, 10, 7, 6, 6.5, 6.5, 10.5, 10, 8),
    {Fargo}        (13, 12.5, 12.5, 15, 12, 9.5, 11, 11, 15, 15, 13),
    {Kansas City}  (7.5, 5, 5, 8, 5, 5.5, 5, 6, 8.5, 8, 5.5),
    {Minneapolis}  (10.5, 10, 10, 12.5, 9.5, 7, 9, 8.5, 12.5, 12.5, 8),
    {Oklahoma City}(7.5, 2.5, 2.5, 5, 3.5, 8.5, 5, 7.5, 7.5, 5, 10.5),
    {Omaha}        (9, 7, 7, 9.5, 7, 7, 6.5, 7.5, 10.5, 10, 7.5),
    {Pueblo}       (13.5, 7.5, 7.5, 10, 10, 12, 11, 12.5, 13.5, 9.5, 10),
    {St. Paul}     (10.5, 10, 10, 12.5, 9.5, 7, 9, 8.5, 12.5, 12.5, 8),
    {Billings}     (18, 15, 15, 17.5, 15.5, 16, 15.5, 16.5, 19, 17.5, 16),
    {Butte}        (20, 17.5, 17.5, 20, 18, 18, 17.5, 18.5, 21.5, 19.5, 18.5),
    {Casper}       (14, 11.5, 11.5, 14.5, 11.5, 12, 12, 12.5, 15.5, 14, 12.5),
    {Pocatello}    (20.5, 15, 15, 17.5, 16, 17.5, 17, 19, 18.5, 17.5, 15.5),
    {Portland,Ore.}(26.5, 22.5, 22.5, 25, 24.5, 24.5, 25, 25, 27.5, 25, 24),
    {Rapid City}   (14.5, 12.5, 12.5, 15.5, 12.5, 12.5, 12.5, 13, 15.5, 15, 13),
    {Salt Lk City} (19, 13.5, 13.5, 16, 16, 17, 16.5, 19, 18.5, 16, 15),
    {Seattle}      (27, 24, 24, 26.5, 26.5, 25, 24.5, 25.5, 29, 26.5, 26),
    {Spokane}      (24, 21, 21, 23.5, 23, 22, 21.5, 22.5, 26, 23.5, 22.5),
    {El Paso}      (13, 6.5, 6.5, 8.5, 10, 15, 11.5, 13.5, 11.5, 6, 8.5),
    {Las Vegas}    (23.5, 16, 16, 17, 19, 21.5, 21, 22, 20, 14.5, 17),
    {Los Angeles}  (21, 14.5, 14.5, 16.5, 18.5, 23, 19.5, 22, 19.5, 14.5, 16.5),
    {Oakland}      (25.5, 19.5, 19.5, 21, 21.5, 24.5, 23, 25.5, 24.5, 19, 21.5),
    {Phoenix}      (17.5, 11, 11, 13, 16, 22.5, 17.5, 19.5, 16, 10.5, 13),
    {Reno}         (23, 19, 19, 22, 21.5, 22.5, 20.5, 23, 22, 20, 21),
    {Sacramento}   (24, 19.5, 19.5, 21, 21.5, 24, 22, 24.5, 23.5, 19, 21.5),
    {San Diego}    (21, 14.5, 14.5, 16, 18, 22.5, 19, 21.5, 19.5, 17, 16.5),
    {San Francisco}(25.5, 19.5, 19.5, 21, 21.5, 24.5, 23, 25.5, 24.5, 19, 21.5),
    {Tucumcari}    (11.5, 5, 5, 8, 7.5, 12, 8.5, 11, 10, 7, 6.5));
  Plains: array[40..67, 40..48] of Single = (
    {Denver}       (0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Des Moines}   (7, 0, 0, 0, 0, 0, 0, 0, 0),
    {Fargo}        (11.5, 5, 0, 0, 0, 0, 0, 0, 0),
    {Kansas City}  (6.5, 2, 7, 0, 0, 0, 0, 0, 0),
    {Minneapolis}  (9, 2.5, 2.5, 5, 0, 0, 0, 0, 0),
    {Oklahoma City}(7.5, 5.5, 10.5, 3.5, 8, 0, 0, 0, 0),
    {Omaha}        (5.5, 1.5, 6, 2, 3.5, 5.5, 0, 0, 0),
    {Pueblo}       (1, 7, 12.5, 6, 9.5, 7, 5.5, 0, 0),
    {St. Paul}     (9, 2.5, 2.5, 5, 0, 8, 3.5, 9.5, 0),
    {Billings}     (6.5, 10.5, 6.5, 10.5, 9, 14, 9, 7.5, 9),
    {Butte}        (9, 14, 9, 13, 11, 16.5, 11.5, 10, 11),
    {Casper}       (3.5, 6.5, 7.5, 7, 8, 10.5, 5, 4.5, 8),
    {Pocatello}    (6, 12, 13.5, 12.5, 13.5, 12.5, 10.5, 7.5, 13.5),
    {Portland,Ore.}(13.5, 19, 16, 19.5, 18, 21.5, 17.5, 14.5, 18),
    {Rapid City}   (5.5, 7, 4.5, 7.5, 5, 9, 5.5, 6.5, 5),
    {Salt Lk City} (5.5, 11.5, 13, 12, 13.5, 12.5, 10.5, 6.5, 13.5),
    {Seattle}      (15.5, 19.5, 15, 19.5, 17.5, 23, 18, 16, 17.5),
    {Spokane}      (12.5, 16.5, 12, 16.5, 14.5, 20, 15, 13, 14.5),
    {El Paso}      (7.5, 11.5, 16.5, 9.5, 14, 7, 11.5, 6, 14),
    {Las Vegas}    (10, 16, 17.5, 16.5, 18, 15.5, 15, 11, 18),
    {Los Angeles}  (13.5, 19.5, 21, 17.5, 21.5, 15, 18, 13.5, 21.5),
    {Oakland}      (13.5, 19, 20.5, 19.5, 21, 18, 17.5, 14, 21),
    {Phoenix}      (10.5, 17, 22, 15, 19.5, 12.5, 16, 9.5, 19.5),
    {Reno}         (11.5, 17, 15, 17.5, 19, 16, 15.5, 12, 19),
    {Sacramento}   (13, 18, 20, 19, 20.5, 17.5, 17, 13.5, 20.5),
    {San Diego}    (14.5, 20.5, 22, 17.5, 22.5, 14.5, 19, 13.5, 22.5),
    {San Francisco}(13.5, 19, 20.5, 19.5, 21, 18, 17.5, 14, 21),
    {Tucumcari}    (4.5, 9, 14, 6.5, 11.5, 4, 8.5, 3.5, 11));
  Northwest: array[49..67, 49..57] of Single = (
    {Billings}     (0,   0, 0, 0, 0, 0, 0, 0, 0),
    {Butte}        (2.5, 0, 0, 0, 0, 0, 0, 0, 0),
    {Casper}       (3.5, 5.5, 0, 0, 0, 0, 0, 0, 0),
    {Pocatello}    (5, 2.5, 7.5, 0, 0, 0, 0, 0, 0),
    {Portland,Ore.}(9.5, 7, 13, 7, 0, 0, 0, 0, 0),
    {Rapid City}   (5, 7.5, 3, 10, 14.5, 0, 0, 0, 0),
    {Salt Lk City} (6.5, 4.5, 7.5, 1.5, 9, 9.5, 0, 0, 0),
    {Seattle}      (9, 6.5, 12.5, 9, 2, 14, 10.5, 0, 0),
    {Spokane}      (6, 3.5, 9, 6, 3.5, 11, 8, 3, 0),
    {El Paso}      (14, 16, 9.5, 13.5, 20, 13, 12.5, 22, 20),
    {Las Vegas}    (11, 9, 12, 6, 13.5, 14, 4.5, 15, 17),
    {Los Angeles}  (14.5, 12, 15, 9, 12, 17.5, 8, 13.5, 15.5),
    {Oakland}      (14, 12, 15, 9, 7, 17.5, 8, 9, 11),
    {Phoenix}      (19, 16.5, 14, 14, 16, 16, 12, 18, 20),
    {Reno}         (12, 9.5, 12.5, 7, 7.5, 15.5, 5.5, 9.5, 11),
    {Sacramento}   (13.5, 11, 14, 8.5, 6.5, 17, 7, 8.5, 10),
    {San Diego}    (15.5, 13, 16.5, 11, 13, 18.5, 9, 15, 17),
    {San Francisco}(14, 12, 15, 9, 7, 17.5, 8, 9, 11),
    {Tucumcari}    (11, 13.5, 8, 11, 18.5, 11, 9.5, 20.5, 17.5));
  Southwest: array[58..67, 58..67] of Single = (
    {El Paso}      (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Las Vegas}    (13, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    {Los Angeles}  (8, 3, 0, 0, 0, 0, 0, 0, 0, 0),
    {Oakland}      (13, 6.5, 4.5, 0, 0, 0, 0, 0, 0, 0),
    {Phoenix}      (4.5, 7.5, 4.5, 9, 0, 0, 0, 0, 0, 0),
    {Reno}         (10.5, 8, 6, 2.5, 10.5, 0, 0, 0, 0, 0),
    {Sacramento}   (12, 6.5, 5, 1, 9, 1.5, 0, 0, 0, 0),
    {San Diego}    (8, 4.5, 1.5, 6, 4, 8.5, 6.5, 0, 0, 0),
    {San Francisco}(13, 6.5, 4.5, 0, 9, 2.5, 1, 6, 0, 0),
    {Tucumcari}    (3.5, 9.5, 11.5, 14.5, 8.5, 15.5, 14.5, 11, 14.5, 0));
var
  City1, City2: Integer;
begin
  if (tvCity1.Selected = nil) or (tvCity2.Selected = nil) then begin
    MessageDlg('Please choose a city from each list.', mtWarning, [mbOK], 0);
    Exit;
  end;

  CityName1 := tvCity1.Selected.Text;
  CityName2 := tvCity2.Selected.Text;

  City1 := Min(fCities.IndexOf(tvCity1.Selected.Text), fCities.IndexOf(tvCity2.Selected.Text)) + 1;
  City2 := Max(fCities.IndexOf(tvCity1.Selected.Text), fCities.IndexOf(tvCity2.Selected.Text)) + 1;

  if City1 in [1..9] then
    Payoff := Northeast[City2, City1]
  else if City1 in [10..20] then
    Payoff := Southeast[City2, City1]
  else if City1 in [21..28] then
    Payoff := NorthCentral[City2, City1]
  else if City1 in [29..39] then
    Payoff := SouthCentral[City2, City1]
  else if City1 in [40..48] then
    Payoff := Plains[City2, City1]
  else if City1 in [49..57] then
    Payoff := Northwest[City2, City1]
  else if City1 in [58..67] then
    Payoff := Southwest[City2, City1];

  lbPayoffs.Items.Insert(0, CityName1 + ', ' + CityName2 + ' = ' +
       FormatFloat('$#,0', PayOff * 1000.0));

  lbPayoffs.SetFocus;
  lbPayoffs.ItemIndex := 0;
end;

procedure TfrmRBMain.BringSelectedRegionPanelToFront;
var
  RegionPanel: TPanel;
  RegionStr: string;
begin
  RegionStr := lbRegions.Items[lbRegions.ItemIndex];
  while Pos(' ', RegionStr) > 0 do
    Delete(RegionStr, Pos(' ', RegionStr), 1); // remove spaces from name
  RegionPanel := FindComponent('pnl' + RegionStr) as TPanel;
  if Assigned(RegionPanel) then
    RegionPanel.BringToFront;
end;

procedure TfrmRBMain.lbRegionsDblClick(Sender: TObject);
begin
  BringSelectedRegionPanelToFront;
  ClearCities;
end;

procedure TfrmRBMain.FormActivate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to pgcRegions.PageCount - 1 do
    pgcRegions.Pages[i].TabVisible := False;

  pgcRegions.ActivePageIndex := 0;
end;

end.
