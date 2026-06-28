' S.H.A.N.E. Floating Widget - Arc Reactor Edition
Set fso = CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
tempPS = WshShell.ExpandEnvironmentStrings("%TEMP%") & "\jarvis_widget.ps1"

' Write PowerShell widget script to temp
Set f = fso.CreateTextFile(tempPS, True)
f.WriteLine "# Shane Arc Reactor Widget"
f.WriteLine "Add-Type -AssemblyName PresentationFramework"
f.WriteLine "Add-Type -AssemblyName PresentationCore"
f.WriteLine "Add-Type -AssemblyName WindowsBase"
f.WriteLine ""
f.WriteLine "Add-Type -MemberDefinition '"
f.WriteLine "[DllImport(""user32.dll"")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);'  -Name W -Namespace U"
f.WriteLine ""
f.WriteLine "Add-Type -MemberDefinition '"
f.WriteLine "[DllImport(""user32.dll"")] public static extern IntPtr FindWindow(string c, string t);' -Name F -Namespace U"
f.WriteLine ""
f.WriteLine "Add-Type -MemberDefinition '"
f.WriteLine "[DllImport(""user32.dll"")] public static extern bool SetForegroundWindow(IntPtr hWnd);' -Name S -Namespace U"
f.WriteLine ""
f.WriteLine "$xaml = @"""
f.WriteLine "<Window xmlns=""http://schemas.microsoft.com/winfx/2006/xaml/presentation"""
f.WriteLine "  xmlns:x=""http://schemas.microsoft.com/winfx/2006/xaml"""
f.WriteLine "  WindowStyle=""None"" AllowsTransparency=""True"" Background=""Transparent"""
f.WriteLine "  Topmost=""True"" Width=""80"" Height=""80"" ShowInTaskbar=""False"""
f.WriteLine "  ResizeMode=""NoResize"" Left=""15"">"
f.WriteLine "  <Window.Resources>"
f.WriteLine "    <Storyboard x:Key=""spin"">"
f.WriteLine "      <DoubleAnimation Storyboard.TargetName=""ring1rot"" Storyboard.TargetProperty=""Angle"" From=""0"" To=""360"" Duration=""0:0:6"" RepeatBehavior=""Forever""/>"
f.WriteLine "      <DoubleAnimation Storyboard.TargetName=""ring2rot"" Storyboard.TargetProperty=""Angle"" From=""360"" To=""0"" Duration=""0:0:4"" RepeatBehavior=""Forever""/>"
f.WriteLine "      <DoubleAnimation Storyboard.TargetName=""ring3rot"" Storyboard.TargetProperty=""Angle"" From=""0"" To=""360"" Duration=""0:0:10"" RepeatBehavior=""Forever""/>"
f.WriteLine "    </Storyboard>"
f.WriteLine "    <Storyboard x:Key=""pulse"">"
f.WriteLine "      <DoubleAnimation Storyboard.TargetName=""glow"" Storyboard.TargetProperty=""Opacity"" From=""0.3"" To=""0.8"" Duration=""0:0:1.5"" AutoReverse=""True"" RepeatBehavior=""Forever""/>"
f.WriteLine "      <DoubleAnimation Storyboard.TargetName=""coreGlow"" Storyboard.TargetProperty=""BlurRadius"" From=""10"" To=""25"" Duration=""0:0:1.5"" AutoReverse=""True"" RepeatBehavior=""Forever""/>"
f.WriteLine "      <ColorAnimation Storyboard.TargetName=""coreBorder"" Storyboard.TargetProperty=""Color"" From=""#6600D4FF"" To=""#CC00D4FF"" Duration=""0:0:1.5"" AutoReverse=""True"" RepeatBehavior=""Forever""/>"
f.WriteLine "    </Storyboard>"
f.WriteLine "  </Window.Resources>"
f.WriteLine "  <Window.Triggers>"
f.WriteLine "    <EventTrigger RoutedEvent=""Window.Loaded"">"
f.WriteLine "      <BeginStoryboard Storyboard=""{StaticResource spin}""/>"
f.WriteLine "      <BeginStoryboard Storyboard=""{StaticResource pulse}""/>"
f.WriteLine "    </EventTrigger>"
f.WriteLine "  </Window.Triggers>"
f.WriteLine "  <Canvas x:Name=""main"" Width=""80"" Height=""80"" Cursor=""Hand"">"
f.WriteLine "    <!-- Outer glow -->"
f.WriteLine "    <Ellipse x:Name=""glow"" Width=""76"" Height=""76"" Canvas.Left=""2"" Canvas.Top=""2"" Opacity=""0.3"">"
f.WriteLine "      <Ellipse.Fill><RadialGradientBrush><GradientStop Color=""#4000D4FF"" Offset=""0.5""/><GradientStop Color=""#0000D4FF"" Offset=""1""/></RadialGradientBrush></Ellipse.Fill>"
f.WriteLine "    </Ellipse>"
f.WriteLine "    <!-- Ring 3 outer -->"
f.WriteLine "    <Ellipse Width=""72"" Height=""72"" Canvas.Left=""4"" Canvas.Top=""4"" StrokeThickness=""1"" Fill=""Transparent"" StrokeDashArray=""1 2"">"
f.WriteLine "      <Ellipse.Stroke><SolidColorBrush Color=""#5000D4FF""/></Ellipse.Stroke>"
f.WriteLine "      <Ellipse.RenderTransform><RotateTransform x:Name=""ring3rot"" CenterX=""36"" CenterY=""36""/></Ellipse.RenderTransform>"
f.WriteLine "    </Ellipse>"
f.WriteLine "    <!-- Ring 1 -->"
f.WriteLine "    <Ellipse Width=""62"" Height=""62"" Canvas.Left=""9"" Canvas.Top=""9"" StrokeThickness=""1.5"" Fill=""Transparent"" StrokeDashArray=""4 3"">"
f.WriteLine "      <Ellipse.Stroke><SolidColorBrush Color=""#8800D4FF""/></Ellipse.Stroke>"
f.WriteLine "      <Ellipse.RenderTransform><RotateTransform x:Name=""ring1rot"" CenterX=""31"" CenterY=""31""/></Ellipse.RenderTransform>"
f.WriteLine "    </Ellipse>"
f.WriteLine "    <!-- Ring 2 -->"
f.WriteLine "    <Ellipse Width=""50"" Height=""50"" Canvas.Left=""15"" Canvas.Top=""15"" StrokeThickness=""1"" Fill=""Transparent"" StrokeDashArray=""2 4"">"
f.WriteLine "      <Ellipse.Stroke><SolidColorBrush Color=""#7700FF88""/></Ellipse.Stroke>"
f.WriteLine "      <Ellipse.RenderTransform><RotateTransform x:Name=""ring2rot"" CenterX=""25"" CenterY=""25""/></Ellipse.RenderTransform>"
f.WriteLine "    </Ellipse>"
f.WriteLine "    <!-- Core circle -->"
f.WriteLine "    <Ellipse Width=""38"" Height=""38"" Canvas.Left=""21"" Canvas.Top=""21"" StrokeThickness=""2"">"
f.WriteLine "      <Ellipse.Fill><RadialGradientBrush><GradientStop Color=""#3000D4FF"" Offset=""0""/><GradientStop Color=""#10050510"" Offset=""1""/></RadialGradientBrush></Ellipse.Fill>"
f.WriteLine "      <Ellipse.Stroke><SolidColorBrush x:Name=""coreBorder"" Color=""#6600D4FF""/></Ellipse.Stroke>"
f.WriteLine "      <Ellipse.Effect><DropShadowEffect x:Name=""coreGlow"" Color=""#00D4FF"" ShadowDepth=""0"" BlurRadius=""10"" Opacity=""0.6""/></Ellipse.Effect>"
f.WriteLine "    </Ellipse>"
f.WriteLine "    <!-- J letter -->"
f.WriteLine "    <TextBlock Text=""S"" Foreground=""#00D4FF"" FontSize=""16"" FontWeight=""Bold"" FontFamily=""Segoe UI"""
f.WriteLine "      Canvas.Left=""33"" Canvas.Top=""27"">"
f.WriteLine "      <TextBlock.Effect><DropShadowEffect Color=""#00D4FF"" ShadowDepth=""0"" BlurRadius=""8"" Opacity=""0.8""/></TextBlock.Effect>"
f.WriteLine "    </TextBlock>"
f.WriteLine "  </Canvas>"
f.WriteLine "</Window>"
f.WriteLine """@"
f.WriteLine ""
f.WriteLine "$w = [Windows.Markup.XamlReader]::Parse($xaml)"
f.WriteLine "$main = $w.FindName('main')"
f.WriteLine "$screen = [System.Windows.SystemParameters]::PrimaryScreenHeight"
f.WriteLine "$w.Top = ($screen / 2) - 40"
f.WriteLine ""
f.WriteLine "# Drag logic"
f.WriteLine "$script:dragging = $false"
f.WriteLine "$script:dragStart = $null"
f.WriteLine "$script:winStart = $null"
f.WriteLine "$script:clickTime = [DateTime]::Now"
f.WriteLine ""
f.WriteLine "$main.Add_MouseLeftButtonDown({"
f.WriteLine "  $script:dragging = $true"
f.WriteLine "  $script:dragStart = [System.Windows.Input.Mouse]::GetPosition($w)"
f.WriteLine "  $script:winStart = New-Object System.Windows.Point($w.Left, $w.Top)"
f.WriteLine "  $script:clickTime = [DateTime]::Now"
f.WriteLine "  $main.CaptureMouse()"
f.WriteLine "})"
f.WriteLine ""
f.WriteLine "$main.Add_MouseMove({"
f.WriteLine "  if ($script:dragging) {"
f.WriteLine "    $pos = [System.Windows.Input.Mouse]::GetPosition($w)"
f.WriteLine "    $dx = $pos.X - $script:dragStart.X"
f.WriteLine "    $dy = $pos.Y - $script:dragStart.Y"
f.WriteLine "    if ([Math]::Abs($dx) + [Math]::Abs($dy) -gt 3) {"
f.WriteLine "      $w.Left = $script:winStart.X + $dx"
f.WriteLine "      $w.Top = $script:winStart.Y + $dy"
f.WriteLine "    }"
f.WriteLine "  }"
f.WriteLine "})"
f.WriteLine ""
f.WriteLine "$main.Add_MouseLeftButtonUp({"
f.WriteLine "  $main.ReleaseMouseCapture()"
f.WriteLine "  $elapsed = ([DateTime]::Now - $script:clickTime).TotalMilliseconds"
f.WriteLine "  $pos = [System.Windows.Input.Mouse]::GetPosition($w)"
f.WriteLine "  $dx = [Math]::Abs($pos.X - $script:dragStart.X)"
f.WriteLine "  $dy = [Math]::Abs($pos.Y - $script:dragStart.Y)"
f.WriteLine "  $script:dragging = $false"
f.WriteLine "  if ($dx + $dy -lt 5 -and $elapsed -lt 500) {"
f.WriteLine "    $h = [U.F]::FindWindow([NullString]::Value, 'S.H.A.N.E.')"
f.WriteLine "    if ($h -ne [IntPtr]::Zero) {"
f.WriteLine "      [U.W]::ShowWindow($h, 9)"
f.WriteLine "      [U.S]::SetForegroundWindow($h)"
f.WriteLine "    } else {"
f.WriteLine "      Start-Process 'http://localhost:8080/jarvis.html'"
f.WriteLine "    }"
f.WriteLine "  }"
f.WriteLine "})"
f.WriteLine ""
f.WriteLine "$main.Add_MouseRightButtonUp({"
f.WriteLine "  $h = [U.F]::FindWindow([NullString]::Value, 'S.H.A.N.E.')"
f.WriteLine "  if ($h -ne [IntPtr]::Zero) { [U.W]::ShowWindow($h, 6) }"
f.WriteLine "})"
f.WriteLine ""
f.WriteLine "# Hover scale effect"
f.WriteLine "$main.Add_MouseEnter({"
f.WriteLine "  $scale = New-Object System.Windows.Media.ScaleTransform(1.15, 1.15, 40, 40)"
f.WriteLine "  $main.RenderTransform = $scale"
f.WriteLine "})"
f.WriteLine "$main.Add_MouseLeave({"
f.WriteLine "  $scale = New-Object System.Windows.Media.ScaleTransform(1, 1, 40, 40)"
f.WriteLine "  $main.RenderTransform = $scale"
f.WriteLine "})"
f.WriteLine ""
f.WriteLine "$w.ShowDialog()"
f.Close

' Start web server silently
WshShell.Run "powershell -WindowStyle Hidden -Command """ & _
    "$l=New-Object Net.HttpListener;" & _
    "$l.Prefixes.Add('http://localhost:8080/');" & _
    "$l.Start();" & _
    "while($l.IsListening){" & _
    "  $c=$l.GetContext();" & _
    "  $p=$c.Request.Url.LocalPath.TrimStart('/');" & _
    "  if($p -eq ''){$p='jarvis.html'};" & _
    "  $f=Join-Path '" & scriptDir & "' $p;" & _
    "  if(Test-Path $f){" & _
    "    $b=[IO.File]::ReadAllBytes($f);" & _
    "    $ext=[IO.Path]::GetExtension($f);" & _
    "    $mime='text/html';" & _
    "    if($ext -eq '.js'){$mime='application/javascript'};" & _
    "    if($ext -eq '.css'){$mime='text/css'};" & _
    "    $c.Response.ContentType=$mime+'; charset=utf-8';" & _
    "    $c.Response.ContentLength64=$b.Length;" & _
    "    $c.Response.OutputStream.Write($b,0,$b.Length)" & _
    "  }else{$c.Response.StatusCode=404};" & _
    "  $c.Response.Close()" & _
    "}""", 0, False

WScript.Sleep 1500

' Launch the widget
WshShell.Run "powershell -WindowStyle Hidden -Command ""iex (gc '" & tempPS & "' -Raw)""", 0, False
