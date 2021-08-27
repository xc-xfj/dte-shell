Name:       dte-shell

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    A nice homescreen for DTE experience
Version:    0.1
Release:    1
Group:      Applications/System
License:    BSD
URL:        https://github.com/zorowk/dte-shell
Source0:    %{name}-%{version}.tar.bz2

Requires:   qt5-qtdeclarative
Requires:   qt5-qtquickcontrols
Requires:   lipstick-qt5-devel
BuildRequires:  pkgconfig(sailfishapp)
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(lipstick-qt5)
BuildRequires:  desktop-file-utils

%description
A homescreen for DTE Table

%prep
%setup -q -n %{name}-%{version}

%build
%qtc_qmake5 

%qtc_make %{?_smp_mflags}

%install
rm -rf %{buildroot}

%qmake5_install

%files
%defattr(-,root,root,-)
%{_datadir}/%{name}/qml
%{_bindir}
