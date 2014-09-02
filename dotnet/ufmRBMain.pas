unit ufmRBMain;

interface

uses
  System.Drawing, System.Collections, System.ComponentModel,
  System.Windows.Forms, System.Data;

type
  TWinForm = class(System.Windows.Forms.Form)
  {$REGION 'Designer Managed Code'}
  strict private
    /// <summary>
    /// Required designer variable.
    /// </summary>
    Components: System.ComponentModel.Container;
    Panel1: System.Windows.Forms.Panel;
    pnlPayoffs: System.Windows.Forms.Panel;
    pnlRegions: System.Windows.Forms.Panel;
    Label1: System.Windows.Forms.Label;
    lbRegions: System.Windows.Forms.ListBox;
    TabControl1: System.Windows.Forms.TabControl;
    tpNortheast: System.Windows.Forms.TabPage;
    tpSoutheast: System.Windows.Forms.TabPage;
    tpNorthCentral: System.Windows.Forms.TabPage;
    tpSouthCentral: System.Windows.Forms.TabPage;
    tpPlains: System.Windows.Forms.TabPage;
    tpNorthwest: System.Windows.Forms.TabPage;
    tpSouthwest: System.Windows.Forms.TabPage;
    Label2: System.Windows.Forms.Label;
    lbNortheast: System.Windows.Forms.ListBox;
    Label3: System.Windows.Forms.Label;
    lbSoutheast: System.Windows.Forms.ListBox;
    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    procedure InitializeComponent;
  {$ENDREGION}
  strict protected
    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    procedure Dispose(Disposing: Boolean); override;
  private
    //fCities: TStringList;
  public
    constructor Create;
  end;

  [assembly: RuntimeRequiredAttribute(TypeOf(TWinForm))]


implementation

{$AUTOBOX ON}

{$REGION 'Windows Form Designer generated code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWinForm.InitializeComponent;
type
  TArrayOfSystem_Object = array of System.Object;
begin
  Self.Panel1 := System.Windows.Forms.Panel.Create;
  Self.pnlPayoffs := System.Windows.Forms.Panel.Create;
  Self.pnlRegions := System.Windows.Forms.Panel.Create;
  Self.Label1 := System.Windows.Forms.Label.Create;
  Self.lbRegions := System.Windows.Forms.ListBox.Create;
  Self.TabControl1 := System.Windows.Forms.TabControl.Create;
  Self.tpNortheast := System.Windows.Forms.TabPage.Create;
  Self.tpSoutheast := System.Windows.Forms.TabPage.Create;
  Self.tpNorthCentral := System.Windows.Forms.TabPage.Create;
  Self.tpSouthCentral := System.Windows.Forms.TabPage.Create;
  Self.tpPlains := System.Windows.Forms.TabPage.Create;
  Self.tpNorthwest := System.Windows.Forms.TabPage.Create;
  Self.tpSouthwest := System.Windows.Forms.TabPage.Create;
  Self.Label2 := System.Windows.Forms.Label.Create;
  Self.lbNortheast := System.Windows.Forms.ListBox.Create;
  Self.Label3 := System.Windows.Forms.Label.Create;
  Self.lbSoutheast := System.Windows.Forms.ListBox.Create;
  Self.Panel1.SuspendLayout;
  Self.pnlRegions.SuspendLayout;
  Self.TabControl1.SuspendLayout;
  Self.tpNortheast.SuspendLayout;
  Self.tpSoutheast.SuspendLayout;
  Self.SuspendLayout;
  // 
  // Panel1
  // 
  Self.Panel1.Controls.Add(Self.TabControl1);
  Self.Panel1.Controls.Add(Self.pnlRegions);
  Self.Panel1.Dock := System.Windows.Forms.DockStyle.Left;
  Self.Panel1.Location := System.Drawing.Point.Create(0, 0);
  Self.Panel1.Name := 'Panel1';
  Self.Panel1.Size := System.Drawing.Size.Create(224, 493);
  Self.Panel1.TabIndex := 0;
  // 
  // pnlPayoffs
  // 
  Self.pnlPayoffs.Dock := System.Windows.Forms.DockStyle.Fill;
  Self.pnlPayoffs.Location := System.Drawing.Point.Create(224, 0);
  Self.pnlPayoffs.Name := 'pnlPayoffs';
  Self.pnlPayoffs.Size := System.Drawing.Size.Create(528, 493);
  Self.pnlPayoffs.TabIndex := 1;
  // 
  // pnlRegions
  // 
  Self.pnlRegions.Controls.Add(Self.lbRegions);
  Self.pnlRegions.Controls.Add(Self.Label1);
  Self.pnlRegions.Dock := System.Windows.Forms.DockStyle.Top;
  Self.pnlRegions.Location := System.Drawing.Point.Create(0, 0);
  Self.pnlRegions.Name := 'pnlRegions';
  Self.pnlRegions.Size := System.Drawing.Size.Create(224, 192);
  Self.pnlRegions.TabIndex := 0;
  // 
  // Label1
  // 
  Self.Label1.Dock := System.Windows.Forms.DockStyle.Top;
  Self.Label1.Location := System.Drawing.Point.Create(0, 0);
  Self.Label1.Name := 'Label1';
  Self.Label1.Size := System.Drawing.Size.Create(224, 16);
  Self.Label1.TabIndex := 0;
  Self.Label1.Text := 'Regions';
  Self.Label1.TextAlign := System.Drawing.ContentAlignment.MiddleCenter;
  // 
  // lbRegions
  // 
  Self.lbRegions.Dock := System.Windows.Forms.DockStyle.Fill;
  Self.lbRegions.Items.AddRange(TArrayOfSystem_Object.Create('Plains', 'Sout' +
        'heast', 'Southeast', 'Southeast', 'North Central', 'North Central', 
          'Northeast', 'Northeast', 'Northeast', 'Northeast', 'Northeast', 'S' +
        'outhwest', 'South Central', 'South Central', 'South Central', 'Sout' +
        'hwest', 'Southwest', 'Plains', 'Northwest', 'Northwest', 'Plains', 'N' +
        'orthwest'));
  Self.lbRegions.Location := System.Drawing.Point.Create(0, 16);
  Self.lbRegions.MultiColumn := True;
  Self.lbRegions.Name := 'lbRegions';
  Self.lbRegions.Size := System.Drawing.Size.Create(224, 173);
  Self.lbRegions.TabIndex := 1;
  // 
  // TabControl1
  // 
  Self.TabControl1.Controls.Add(Self.tpNortheast);
  Self.TabControl1.Controls.Add(Self.tpSoutheast);
  Self.TabControl1.Controls.Add(Self.tpNorthCentral);
  Self.TabControl1.Controls.Add(Self.tpSouthCentral);
  Self.TabControl1.Controls.Add(Self.tpPlains);
  Self.TabControl1.Controls.Add(Self.tpNorthwest);
  Self.TabControl1.Controls.Add(Self.tpSouthwest);
  Self.TabControl1.Dock := System.Windows.Forms.DockStyle.Top;
  Self.TabControl1.Location := System.Drawing.Point.Create(0, 192);
  Self.TabControl1.Name := 'TabControl1';
  Self.TabControl1.SelectedIndex := 0;
  Self.TabControl1.Size := System.Drawing.Size.Create(224, 224);
  Self.TabControl1.TabIndex := 1;
  // 
  // tpNortheast
  // 
  Self.tpNortheast.Controls.Add(Self.lbNortheast);
  Self.tpNortheast.Controls.Add(Self.Label2);
  Self.tpNortheast.Location := System.Drawing.Point.Create(4, 22);
  Self.tpNortheast.Name := 'tpNortheast';
  Self.tpNortheast.Size := System.Drawing.Size.Create(216, 198);
  Self.tpNortheast.TabIndex := 0;
  Self.tpNortheast.Text := 'Northeast';
  // 
  // tpSoutheast
  // 
  Self.tpSoutheast.Controls.Add(Self.lbSoutheast);
  Self.tpSoutheast.Controls.Add(Self.Label3);
  Self.tpSoutheast.Location := System.Drawing.Point.Create(4, 22);
  Self.tpSoutheast.Name := 'tpSoutheast';
  Self.tpSoutheast.Size := System.Drawing.Size.Create(216, 198);
  Self.tpSoutheast.TabIndex := 1;
  Self.tpSoutheast.Text := 'Southeast';
  // 
  // tpNorthCentral
  // 
  Self.tpNorthCentral.Location := System.Drawing.Point.Create(4, 22);
  Self.tpNorthCentral.Name := 'tpNorthCentral';
  Self.tpNorthCentral.Size := System.Drawing.Size.Create(216, 198);
  Self.tpNorthCentral.TabIndex := 2;
  Self.tpNorthCentral.Text := 'North Central';
  // 
  // tpSouthCentral
  // 
  Self.tpSouthCentral.Location := System.Drawing.Point.Create(4, 22);
  Self.tpSouthCentral.Name := 'tpSouthCentral';
  Self.tpSouthCentral.Size := System.Drawing.Size.Create(184, 102);
  Self.tpSouthCentral.TabIndex := 3;
  Self.tpSouthCentral.Text := 'South Central';
  // 
  // tpPlains
  // 
  Self.tpPlains.Location := System.Drawing.Point.Create(4, 22);
  Self.tpPlains.Name := 'tpPlains';
  Self.tpPlains.Size := System.Drawing.Size.Create(184, 102);
  Self.tpPlains.TabIndex := 4;
  Self.tpPlains.Text := 'Plains';
  // 
  // tpNorthwest
  // 
  Self.tpNorthwest.Location := System.Drawing.Point.Create(4, 22);
  Self.tpNorthwest.Name := 'tpNorthwest';
  Self.tpNorthwest.Size := System.Drawing.Size.Create(184, 102);
  Self.tpNorthwest.TabIndex := 5;
  Self.tpNorthwest.Text := 'Northwest';
  // 
  // tpSouthwest
  // 
  Self.tpSouthwest.Location := System.Drawing.Point.Create(4, 22);
  Self.tpSouthwest.Name := 'tpSouthwest';
  Self.tpSouthwest.Size := System.Drawing.Size.Create(184, 102);
  Self.tpSouthwest.TabIndex := 6;
  Self.tpSouthwest.Text := 'Southwest';
  // 
  // Label2
  // 
  Self.Label2.Dock := System.Windows.Forms.DockStyle.Top;
  Self.Label2.Location := System.Drawing.Point.Create(0, 0);
  Self.Label2.Name := 'Label2';
  Self.Label2.Size := System.Drawing.Size.Create(216, 16);
  Self.Label2.TabIndex := 0;
  Self.Label2.Text := 'Northeast';
  Self.Label2.TextAlign := System.Drawing.ContentAlignment.MiddleCenter;
  // 
  // lbNortheast
  // 
  Self.lbNortheast.Dock := System.Windows.Forms.DockStyle.Fill;
  Self.lbNortheast.Items.AddRange(TArrayOfSystem_Object.Create('New York', 'N' +
        'ew York', 'New York', 'Albany', 'Boston', 'Buffalo', 'Boston', 'Por' +
        'tland', 'New York', 'New York', 'New York', 'New York', 'Washington', 
          'Pittsburgh', 'Pittsburgh', 'Philadelphia', 'Washington', 'Philade' +
        'lphia', 'Baltimore', 'Baltimore', 'Baltimore', 'New York'));
  Self.lbNortheast.Location := System.Drawing.Point.Create(0, 16);
  Self.lbNortheast.MultiColumn := True;
  Self.lbNortheast.Name := 'lbNortheast';
  Self.lbNortheast.Size := System.Drawing.Size.Create(216, 173);
  Self.lbNortheast.TabIndex := 1;
  // 
  // Label3
  // 
  Self.Label3.Dock := System.Windows.Forms.DockStyle.Top;
  Self.Label3.Location := System.Drawing.Point.Create(0, 0);
  Self.Label3.Name := 'Label3';
  Self.Label3.Size := System.Drawing.Size.Create(216, 16);
  Self.Label3.TabIndex := 0;
  Self.Label3.Text := 'Southeast';
  Self.Label3.TextAlign := System.Drawing.ContentAlignment.MiddleCenter;
  // 
  // lbSoutheast
  // 
  Self.lbSoutheast.Dock := System.Windows.Forms.DockStyle.Fill;
  Self.lbSoutheast.Items.AddRange(TArrayOfSystem_Object.Create('Charlotte', 'C' +
        'harlotte', 'Chattanooga', 'Atlanta', 'Atlanta', 'Atlanta', 'Richmon' +
        'd', 'Knoxville', 'Mobile', 'Knoxville', 'Mobile', 'Norfolk', 'Norfo' +
        'lk', 'Norfolk', 'Charleston', 'Miami', 'Jacksonville', 'Miami', 'Ta' +
        'mpa', 'Tampa', 'Mobile', 'Norfolk'));
  Self.lbSoutheast.Location := System.Drawing.Point.Create(0, 16);
  Self.lbSoutheast.MultiColumn := True;
  Self.lbSoutheast.Name := 'lbSoutheast';
  Self.lbSoutheast.Size := System.Drawing.Size.Create(216, 173);
  Self.lbSoutheast.TabIndex := 1;
  // 
  // TWinForm
  // 
  Self.AutoScaleBaseSize := System.Drawing.Size.Create(5, 13);
  Self.ClientSize := System.Drawing.Size.Create(752, 493);
  Self.Controls.Add(Self.pnlPayoffs);
  Self.Controls.Add(Self.Panel1);
  Self.Name := 'TWinForm';
  Self.Text := 'WinForm';
  Self.Panel1.ResumeLayout(False);
  Self.pnlRegions.ResumeLayout(False);
  Self.TabControl1.ResumeLayout(False);
  Self.tpNortheast.ResumeLayout(False);
  Self.tpSoutheast.ResumeLayout(False);
  Self.ResumeLayout(False);
end;
{$ENDREGION}

procedure TWinForm.Dispose(Disposing: Boolean);
begin
  if Disposing then
  begin
    if Components <> nil then
      Components.Dispose();
  end;
  inherited Dispose(Disposing);
end;

constructor TWinForm.Create;
begin
  inherited Create;
  //
  // Required for Windows Form Designer support
  //
  InitializeComponent;
  //
  // TODO: Add any constructor code after InitializeComponent call
  //
end;

end.
